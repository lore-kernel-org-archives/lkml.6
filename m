Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753385AbeDVRUf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 13:20:35 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46365 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751296AbeDVRUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 13:20:32 -0400
Date: Sun, 22 Apr 2018 19:20:19 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Vignesh R <vigneshr@ti.com>
Cc: Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] mtd: spi-nor: cadence-quadspi: Add DMA support for
 direct mode reads
Message-ID: <20180422192019.132091d5@bbrezillon>
In-Reply-To: <20180410081910.858-1-vigneshr@ti.com>
References: <20180410081910.858-1-vigneshr@ti.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2018 13:49:10 +0530
Vignesh R <vigneshr@ti.com> wrote:

> Add support to use DMA over memory mapped reads in direct mode. This
> helps in reducing CPU usage from ~100% to ~10% when reading data from
> flash. For non-DMA'able/vmalloc'd buffers, driver just falls back to CPU
> based memcpy.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>

Applied to spi-nor/next.

Thanks,

Boris

> ---
>  drivers/mtd/spi-nor/cadence-quadspi.c | 96 ++++++++++++++++++++++++++-
>  1 file changed, 94 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
> index 4b8e9183489a..2f3a4d4232b3 100644
> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
> @@ -18,6 +18,8 @@
>  #include <linux/clk.h>
>  #include <linux/completion.h>
>  #include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
>  #include <linux/interrupt.h>
> @@ -73,6 +75,10 @@ struct cqspi_st {
>  	struct completion	transfer_complete;
>  	struct mutex		bus_mutex;
>  
> +	struct dma_chan		*rx_chan;
> +	struct completion	rx_dma_complete;
> +	dma_addr_t		mmap_phys_base;
> +
>  	int			current_cs;
>  	int			current_page_size;
>  	int			current_erase_size;
> @@ -915,11 +921,75 @@ static ssize_t cqspi_write(struct spi_nor *nor, loff_t to,
>  	return len;
>  }
>  
> +static void cqspi_rx_dma_callback(void *param)
> +{
> +	struct cqspi_st *cqspi = param;
> +
> +	complete(&cqspi->rx_dma_complete);
> +}
> +
> +static int cqspi_direct_read_execute(struct spi_nor *nor, u_char *buf,
> +				     loff_t from, size_t len)
> +{
> +	struct cqspi_flash_pdata *f_pdata = nor->priv;
> +	struct cqspi_st *cqspi = f_pdata->cqspi;
> +	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
> +	dma_addr_t dma_src = (dma_addr_t)cqspi->mmap_phys_base + from;
> +	int ret = 0;
> +	struct dma_async_tx_descriptor *tx;
> +	dma_cookie_t cookie;
> +	dma_addr_t dma_dst;
> +
> +	if (!cqspi->rx_chan || !virt_addr_valid(buf)) {
> +		memcpy_fromio(buf, cqspi->ahb_base + from, len);
> +		return 0;
> +	}
> +
> +	dma_dst = dma_map_single(nor->dev, buf, len, DMA_DEV_TO_MEM);
> +	if (dma_mapping_error(nor->dev, dma_dst)) {
> +		dev_err(nor->dev, "dma mapping failed\n");
> +		return -ENOMEM;
> +	}
> +	tx = dmaengine_prep_dma_memcpy(cqspi->rx_chan, dma_dst, dma_src,
> +				       len, flags);
> +	if (!tx) {
> +		dev_err(nor->dev, "device_prep_dma_memcpy error\n");
> +		ret = -EIO;
> +		goto err_unmap;
> +	}
> +
> +	tx->callback = cqspi_rx_dma_callback;
> +	tx->callback_param = cqspi;
> +	cookie = tx->tx_submit(tx);
> +	reinit_completion(&cqspi->rx_dma_complete);
> +
> +	ret = dma_submit_error(cookie);
> +	if (ret) {
> +		dev_err(nor->dev, "dma_submit_error %d\n", cookie);
> +		ret = -EIO;
> +		goto err_unmap;
> +	}
> +
> +	dma_async_issue_pending(cqspi->rx_chan);
> +	ret = wait_for_completion_timeout(&cqspi->rx_dma_complete,
> +					  msecs_to_jiffies(len));
> +	if (ret <= 0) {
> +		dmaengine_terminate_sync(cqspi->rx_chan);
> +		dev_err(nor->dev, "DMA wait_for_completion_timeout\n");
> +		ret = -ETIMEDOUT;
> +		goto err_unmap;
> +	}
> +
> +err_unmap:
> +	dma_unmap_single(nor->dev, dma_dst, len, DMA_DEV_TO_MEM);
> +
> +	return 0;
> +}
> +
>  static ssize_t cqspi_read(struct spi_nor *nor, loff_t from,
>  			  size_t len, u_char *buf)
>  {
>  	struct cqspi_flash_pdata *f_pdata = nor->priv;
> -	struct cqspi_st *cqspi = f_pdata->cqspi;
>  	int ret;
>  
>  	ret = cqspi_set_protocol(nor, 1);
> @@ -931,7 +1001,7 @@ static ssize_t cqspi_read(struct spi_nor *nor, loff_t from,
>  		return ret;
>  
>  	if (f_pdata->use_direct_mode)
> -		memcpy_fromio(buf, cqspi->ahb_base + from, len);
> +		ret = cqspi_direct_read_execute(nor, buf, from, len);
>  	else
>  		ret = cqspi_indirect_read_execute(nor, buf, from, len);
>  	if (ret)
> @@ -1100,6 +1170,21 @@ static void cqspi_controller_init(struct cqspi_st *cqspi)
>  	cqspi_controller_enable(cqspi, 1);
>  }
>  
> +static void cqspi_request_mmap_dma(struct cqspi_st *cqspi)
> +{
> +	dma_cap_mask_t mask;
> +
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_MEMCPY, mask);
> +
> +	cqspi->rx_chan = dma_request_chan_by_mask(&mask);
> +	if (IS_ERR(cqspi->rx_chan)) {
> +		dev_err(&cqspi->pdev->dev, "No Rx DMA available\n");
> +		cqspi->rx_chan = NULL;
> +	}
> +	init_completion(&cqspi->rx_dma_complete);
> +}
> +
>  static int cqspi_setup_flash(struct cqspi_st *cqspi, struct device_node *np)
>  {
>  	const struct spi_nor_hwcaps hwcaps = {
> @@ -1177,6 +1262,9 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi, struct device_node *np)
>  			f_pdata->use_direct_mode = true;
>  			dev_dbg(nor->dev, "using direct mode for %s\n",
>  				mtd->name);
> +
> +			if (!cqspi->rx_chan)
> +				cqspi_request_mmap_dma(cqspi);
>  		}
>  	}
>  
> @@ -1237,6 +1325,7 @@ static int cqspi_probe(struct platform_device *pdev)
>  		dev_err(dev, "Cannot remap AHB address.\n");
>  		return PTR_ERR(cqspi->ahb_base);
>  	}
> +	cqspi->mmap_phys_base = (dma_addr_t)res_ahb->start;
>  	cqspi->ahb_size = resource_size(res_ahb);
>  
>  	init_completion(&cqspi->transfer_complete);
> @@ -1307,6 +1396,9 @@ static int cqspi_remove(struct platform_device *pdev)
>  
>  	cqspi_controller_enable(cqspi, 0);
>  
> +	if (cqspi->rx_chan)
> +		dma_release_channel(cqspi->rx_chan);
> +
>  	clk_disable_unprepare(cqspi->clk);
>  
>  	pm_runtime_put_sync(&pdev->dev);
