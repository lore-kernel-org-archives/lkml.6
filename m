Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754054AbeDPLf3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 07:35:29 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:12900 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752058AbeDPLf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 07:35:27 -0400
Subject: Re: [PATCH v2] mtd: onenand: omap2: Disable DMA for HIGHMEM buffers
To: Ladislav Michl <ladis@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
CC: Boris Brezillon <boris.brezillon@free-electrons.com>,
        Roger Quadros <rogerq@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Andreas Kemnade <andreas@kemnade.info>
References: <20180416065256.GA24455@lenoch>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <8b073dce-2a9e-5068-6499-a36915f5ed90@ti.com>
Date: Mon, 16 Apr 2018 14:34:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180416065256.GA24455@lenoch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-04-16 09:52, Ladislav Michl wrote:
> dma_map_single doesn't get the proper DMA address for vmalloced area,

Which is not a big surprise as vmalloc will allocate contiguous virtual
memory (which might corresponds to non-contiguous physical memory). Even
if you somehow get the physical address of the start of the vmalloced
buffer, you don't really know how long that chunk is and where the
buffer continues in physical memory.

Creating sg_list of the vmalloced buffer should be possible also by
walking the virt memory and get the pages with vmalloc_to_page().
I don't think there is a generic vmalloc_to_sg(), one can be implemented.

> so disable DMA in this case.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> Reported-by: "H. Nikolaus Schaller" <hns@goldelico.com>
> Tested-by: "H. Nikolaus Schaller" <hns@goldelico.com>
> ---
>  Changes:
>  -v2: Added Tested-by tag, based on v4.17-rc1 (no change in patch itself)
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
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
