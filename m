Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751152AbeECIUA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 04:20:00 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45190 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750781AbeECITz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 04:19:55 -0400
Date: Thu, 3 May 2018 10:19:42 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v3] mtd: onenand: omap2: Disable DMA for HIGHMEM buffers
Message-ID: <20180503101942.6851a4fc@bbrezillon>
In-Reply-To: <20180502104132.GA12979@lenoch>
References: <20180502104132.GA12979@lenoch>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 May 2018 12:41:32 +0200
Ladislav Michl <ladis@linux-mips.org> wrote:

> dma_map_single does not work for vmalloc-ed buffers,
> so disable DMA in this case.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> Reported-by: "H. Nikolaus Schaller" <hns@goldelico.com>
> Tested-by: "H. Nikolaus Schaller" <hns@goldelico.com>

Applied to mtd/master. Will be part of the next fixes PR I'll send
later this week.

Thanks,

Boris

> ---
>  Changes:
>   -v2: Added Tested-by tag, based on v4.17-rc1 (no change in patch itself)
>   -v3: Reworded commit log
> 
>  drivers/mtd/nand/onenand/omap2.c | 105 +++++++++++--------------------
>  1 file changed, 38 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/mtd/nand/onenand/omap2.c b/drivers/mtd/nand/onenand/omap2.c
> index 9c159f0dd9a6..321137158ff3 100644
> --- a/drivers/mtd/nand/onenand/omap2.c
> +++ b/drivers/mtd/nand/onenand/omap2.c
> @@ -375,56 +375,42 @@ static int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
>  {
>  	struct omap2_onenand *c = container_of(mtd, struct omap2_onenand, mtd);
>  	struct onenand_chip *this = mtd->priv;
> -	dma_addr_t dma_src, dma_dst;
> -	int bram_offset;
> +	struct device *dev = &c->pdev->dev;
>  	void *buf = (void *)buffer;
> +	dma_addr_t dma_src, dma_dst;
> +	int bram_offset, err;
>  	size_t xtra;
> -	int ret;
>  
>  	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
> -	if (bram_offset & 3 || (size_t)buf & 3 || count < 384)
> -		goto out_copy;
> -
> -	/* panic_write() may be in an interrupt context */
> -	if (in_interrupt() || oops_in_progress)
> +	/*
> +	 * If the buffer address is not DMA-able, len is not long enough to make
> +	 * DMA transfers profitable or panic_write() may be in an interrupt
> +	 * context fallback to PIO mode.
> +	 */
> +	if (!virt_addr_valid(buf) || bram_offset & 3 || (size_t)buf & 3 ||
> +	    count < 384 || in_interrupt() || oops_in_progress )
>  		goto out_copy;
>  
> -	if (buf >= high_memory) {
> -		struct page *p1;
> -
> -		if (((size_t)buf & PAGE_MASK) !=
> -		    ((size_t)(buf + count - 1) & PAGE_MASK))
> -			goto out_copy;
> -		p1 = vmalloc_to_page(buf);
> -		if (!p1)
> -			goto out_copy;
> -		buf = page_address(p1) + ((size_t)buf & ~PAGE_MASK);
> -	}
> -
>  	xtra = count & 3;
>  	if (xtra) {
>  		count -= xtra;
>  		memcpy(buf + count, this->base + bram_offset + count, xtra);
>  	}
>  
> +	dma_dst = dma_map_single(dev, buf, count, DMA_FROM_DEVICE);
>  	dma_src = c->phys_base + bram_offset;
> -	dma_dst = dma_map_single(&c->pdev->dev, buf, count, DMA_FROM_DEVICE);
> -	if (dma_mapping_error(&c->pdev->dev, dma_dst)) {
> -		dev_err(&c->pdev->dev,
> -			"Couldn't DMA map a %d byte buffer\n",
> -			count);
> -		goto out_copy;
> -	}
>  
> -	ret = omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
> -	dma_unmap_single(&c->pdev->dev, dma_dst, count, DMA_FROM_DEVICE);
> -
> -	if (ret) {
> -		dev_err(&c->pdev->dev, "timeout waiting for DMA\n");
> +	if (dma_mapping_error(dev, dma_dst)) {
> +		dev_err(dev, "Couldn't DMA map a %d byte buffer\n", count);
>  		goto out_copy;
>  	}
>  
> -	return 0;
> +	err = omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
> +	dma_unmap_single(dev, dma_dst, count, DMA_FROM_DEVICE);
> +	if (!err)
> +		return 0;
> +
> +	dev_err(dev, "timeout waiting for DMA\n");
>  
>  out_copy:
>  	memcpy(buf, this->base + bram_offset, count);
> @@ -437,49 +423,34 @@ static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
>  {
>  	struct omap2_onenand *c = container_of(mtd, struct omap2_onenand, mtd);
>  	struct onenand_chip *this = mtd->priv;
> -	dma_addr_t dma_src, dma_dst;
> -	int bram_offset;
> +	struct device *dev = &c->pdev->dev;
>  	void *buf = (void *)buffer;
> -	int ret;
> +	dma_addr_t dma_src, dma_dst;
> +	int bram_offset, err;
>  
>  	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
> -	if (bram_offset & 3 || (size_t)buf & 3 || count < 384)
> -		goto out_copy;
> -
> -	/* panic_write() may be in an interrupt context */
> -	if (in_interrupt() || oops_in_progress)
> +	/*
> +	 * If the buffer address is not DMA-able, len is not long enough to make
> +	 * DMA transfers profitable or panic_write() may be in an interrupt
> +	 * context fallback to PIO mode.
> +	 */
> +	if (!virt_addr_valid(buf) || bram_offset & 3 || (size_t)buf & 3 ||
> +	    count < 384 || in_interrupt() || oops_in_progress )
>  		goto out_copy;
>  
> -	if (buf >= high_memory) {
> -		struct page *p1;
> -
> -		if (((size_t)buf & PAGE_MASK) !=
> -		    ((size_t)(buf + count - 1) & PAGE_MASK))
> -			goto out_copy;
> -		p1 = vmalloc_to_page(buf);
> -		if (!p1)
> -			goto out_copy;
> -		buf = page_address(p1) + ((size_t)buf & ~PAGE_MASK);
> -	}
> -
> -	dma_src = dma_map_single(&c->pdev->dev, buf, count, DMA_TO_DEVICE);
> +	dma_src = dma_map_single(dev, buf, count, DMA_TO_DEVICE);
>  	dma_dst = c->phys_base + bram_offset;
> -	if (dma_mapping_error(&c->pdev->dev, dma_src)) {
> -		dev_err(&c->pdev->dev,
> -			"Couldn't DMA map a %d byte buffer\n",
> -			count);
> -		return -1;
> -	}
> -
> -	ret = omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
> -	dma_unmap_single(&c->pdev->dev, dma_src, count, DMA_TO_DEVICE);
> -
> -	if (ret) {
> -		dev_err(&c->pdev->dev, "timeout waiting for DMA\n");
> +	if (dma_mapping_error(dev, dma_src)) {
> +		dev_err(dev, "Couldn't DMA map a %d byte buffer\n", count);
>  		goto out_copy;
>  	}
>  
> -	return 0;
> +	err = omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
> +	dma_unmap_page(dev, dma_src, count, DMA_TO_DEVICE);
> +	if (!err)
> +		return 0;
> +
> +	dev_err(dev, "timeout waiting for DMA\n");
>  
>  out_copy:
>  	memcpy(this->base + bram_offset, buf, count);
