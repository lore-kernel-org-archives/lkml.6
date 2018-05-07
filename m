Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752701AbeEGRUT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 13:20:19 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33728 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752624AbeEGRUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 13:20:18 -0400
X-Google-Smtp-Source: AB8JxZqpII10sdBvM9Zi789ni8qGO9VOKxIkKhHYTbxEB94x+3WEuWbNeNzOjmCyCK3M1oR2z6ABnw==
Date: Mon, 7 May 2018 11:20:13 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, robert.walker@arm.com, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, sudeep.holla@arm.com,
        frowand.list@gmail.com, robh@kernel.org, john.horley@arm.com
Subject: Re: [PATCH v2 16/27] coresight: tmc-etr: Add transparent buffer
 management
Message-ID: <20180507172013.GA32594@xps15>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-17-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525165857-11096-17-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 10:10:46AM +0100, Suzuki K Poulose wrote:
> At the moment we always use contiguous memory for TMC ETR tracing
> when used from sysfs. The size of the buffer is fixed at boot time
> and can only be changed by modifiying the DT. With the introduction
> of SG support we could support really large buffers in that mode.
> This patch abstracts the buffer used for ETR to switch between a
> contiguous buffer or a SG table depending on the availability of
> the memory.
> 
> This also enables the sysfs mode to use the ETR in SG mode depending
> on configured the trace buffer size. Also, since ETR will use the
> new infrastructure to manage the buffer, we can get rid of some
> of the members in the tmc_drvdata and clean up the fields a bit.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 451 +++++++++++++++++++-----
>  drivers/hwtracing/coresight/coresight-tmc.h     |  57 ++-
>  2 files changed, 418 insertions(+), 90 deletions(-)

Good work on cleanly dealing with the different modes of operation from sysFS.
It is that kind of kitchen work I was too lazy to do when first worked on this
driver.

One a side note this patch doesn't apply on my CS next branch due to some
refactoring in tmc_enable_etr_sink_sysfs().  No need to worry about it for this
iteration though.

> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index d18043d..fde3fa6 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -23,6 +23,13 @@
>  #include "coresight-priv.h"
>  #include "coresight-tmc.h"
>  
> +struct etr_flat_buf {
> +	struct device	*dev;
> +	dma_addr_t	daddr;
> +	void		*vaddr;
> +	size_t		size;
> +};
> +
>  /*
>   * The TMC ETR SG has a page size of 4K. The SG table contains pointers
>   * to 4KB buffers. However, the OS may use a PAGE_SIZE different from
> @@ -666,7 +673,7 @@ tmc_etr_sg_table_rotate(struct etr_sg_table *etr_table,
>   * @size	- Total size of the data buffer
>   * @pages	- Optional list of page virtual address
>   */
> -static struct etr_sg_table __maybe_unused *
> +static struct etr_sg_table *
>  tmc_init_etr_sg_table(struct device *dev, int node,
>  		  unsigned long size, void **pages)
>  {
> @@ -702,6 +709,296 @@ tmc_init_etr_sg_table(struct device *dev, int node,
>  	return etr_table;
>  }
>  
> +/*
> + * tmc_etr_alloc_flat_buf: Allocate a contiguous DMA buffer.
> + */
> +static int tmc_etr_alloc_flat_buf(struct tmc_drvdata *drvdata,
> +				  struct etr_buf *etr_buf, int node,
> +				  void **pages)
> +{
> +	struct etr_flat_buf *flat_buf;
> +
> +	/* We cannot reuse existing pages for flat buf */
> +	if (pages)
> +		return -EINVAL;
> +
> +	flat_buf = kzalloc(sizeof(*flat_buf), GFP_KERNEL);
> +	if (!flat_buf)
> +		return -ENOMEM;
> +
> +	flat_buf->vaddr = dma_alloc_coherent(drvdata->dev, etr_buf->size,
> +					   &flat_buf->daddr, GFP_KERNEL);
> +	if (!flat_buf->vaddr) {
> +		kfree(flat_buf);
> +		return -ENOMEM;
> +	}
> +
> +	flat_buf->size = etr_buf->size;
> +	flat_buf->dev = drvdata->dev;
> +	etr_buf->hwaddr = flat_buf->daddr;
> +	etr_buf->mode = ETR_MODE_FLAT;
> +	etr_buf->private = flat_buf;
> +	return 0;
> +}
> +
> +static void tmc_etr_free_flat_buf(struct etr_buf *etr_buf)
> +{
> +	struct etr_flat_buf *flat_buf = etr_buf->private;
> +
> +	if (flat_buf && flat_buf->daddr)
> +		dma_free_coherent(flat_buf->dev, flat_buf->size,
> +				  flat_buf->vaddr, flat_buf->daddr);
> +	kfree(flat_buf);
> +}
> +
> +static void tmc_etr_sync_flat_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
> +{
> +	/*
> +	 * Adjust the buffer to point to the beginning of the trace data
> +	 * and update the available trace data.
> +	 */
> +	etr_buf->offset = rrp - etr_buf->hwaddr;
> +	if (etr_buf->full)
> +		etr_buf->len = etr_buf->size;
> +	else
> +		etr_buf->len = rwp - rrp;
> +}
> +
> +static ssize_t tmc_etr_get_data_flat_buf(struct etr_buf *etr_buf,
> +					 u64 offset, size_t len, char **bufpp)
> +{
> +	struct etr_flat_buf *flat_buf = etr_buf->private;
> +
> +	*bufpp = (char *)flat_buf->vaddr + offset;
> +	/*
> +	 * tmc_etr_buf_get_data already adjusts the length to handle
> +	 * buffer wrapping around.
> +	 */
> +	return len;
> +}
> +
> +static const struct etr_buf_operations etr_flat_buf_ops = {
> +	.alloc = tmc_etr_alloc_flat_buf,
> +	.free = tmc_etr_free_flat_buf,
> +	.sync = tmc_etr_sync_flat_buf,
> +	.get_data = tmc_etr_get_data_flat_buf,
> +};
> +
> +/*
> + * tmc_etr_alloc_sg_buf: Allocate an SG buf @etr_buf. Setup the parameters
> + * appropriately.
> + */
> +static int tmc_etr_alloc_sg_buf(struct tmc_drvdata *drvdata,
> +				struct etr_buf *etr_buf, int node,
> +				void **pages)
> +{
> +	struct etr_sg_table *etr_table;
> +
> +	etr_table = tmc_init_etr_sg_table(drvdata->dev, node,
> +					  etr_buf->size, pages);
> +	if (IS_ERR(etr_table))
> +		return -ENOMEM;
> +	etr_buf->hwaddr = etr_table->hwaddr;
> +	etr_buf->mode = ETR_MODE_ETR_SG;
> +	etr_buf->private = etr_table;
> +	return 0;
> +}
> +
> +static void tmc_etr_free_sg_buf(struct etr_buf *etr_buf)
> +{
> +	struct etr_sg_table *etr_table = etr_buf->private;
> +
> +	if (etr_table) {
> +		tmc_free_sg_table(etr_table->sg_table);
> +		kfree(etr_table);
> +	}
> +}
> +
> +static ssize_t tmc_etr_get_data_sg_buf(struct etr_buf *etr_buf, u64 offset,
> +				       size_t len, char **bufpp)
> +{
> +	struct etr_sg_table *etr_table = etr_buf->private;
> +
> +	return tmc_sg_table_get_data(etr_table->sg_table, offset, len, bufpp);
> +}
> +
> +static void tmc_etr_sync_sg_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
> +{
> +	long r_offset, w_offset;
> +	struct etr_sg_table *etr_table = etr_buf->private;
> +	struct tmc_sg_table *table = etr_table->sg_table;
> +
> +	/* Convert hw address to offset in the buffer */
> +	r_offset = tmc_sg_get_data_page_offset(table, rrp);
> +	if (r_offset < 0) {
> +		dev_warn(table->dev,
> +			 "Unable to map RRP %llx to offset\n", rrp);
> +		etr_buf->len = 0;
> +		return;
> +	}
> +
> +	w_offset = tmc_sg_get_data_page_offset(table, rwp);
> +	if (w_offset < 0) {
> +		dev_warn(table->dev,
> +			 "Unable to map RWP %llx to offset\n", rwp);
> +		etr_buf->len = 0;
> +		return;
> +	}
> +
> +	etr_buf->offset = r_offset;
> +	if (etr_buf->full)
> +		etr_buf->len = etr_buf->size;
> +	else
> +		etr_buf->len = ((w_offset < r_offset) ? etr_buf->size : 0) +
> +				w_offset - r_offset;
> +	tmc_sg_table_sync_data_range(table, r_offset, etr_buf->len);
> +}
> +
> +static const struct etr_buf_operations etr_sg_buf_ops = {
> +	.alloc = tmc_etr_alloc_sg_buf,
> +	.free = tmc_etr_free_sg_buf,
> +	.sync = tmc_etr_sync_sg_buf,
> +	.get_data = tmc_etr_get_data_sg_buf,
> +};
> +
> +static const struct etr_buf_operations *etr_buf_ops[] = {
> +	[ETR_MODE_FLAT] = &etr_flat_buf_ops,
> +	[ETR_MODE_ETR_SG] = &etr_sg_buf_ops,
> +};
> +
> +static inline int tmc_etr_mode_alloc_buf(int mode,
> +					 struct tmc_drvdata *drvdata,
> +					 struct etr_buf *etr_buf, int node,
> +					 void **pages)
> +{
> +	int rc;
> +
> +	switch (mode) {
> +	case ETR_MODE_FLAT:
> +	case ETR_MODE_ETR_SG:
> +		rc = etr_buf_ops[mode]->alloc(drvdata, etr_buf, node, pages);
> +		if (!rc)
> +			etr_buf->ops = etr_buf_ops[mode];
> +		return rc;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +/*
> + * tmc_alloc_etr_buf: Allocate a buffer use by ETR.
> + * @drvdata	: ETR device details.
> + * @size	: size of the requested buffer.
> + * @flags	: Required properties for the buffer.
> + * @node	: Node for memory allocations.
> + * @pages	: An optional list of pages.
> + */
> +static struct etr_buf *tmc_alloc_etr_buf(struct tmc_drvdata *drvdata,
> +					 ssize_t size, int flags,
> +					 int node, void **pages)
> +{
> +	int rc = -ENOMEM;
> +	bool has_etr_sg, has_iommu;
> +	struct etr_buf *etr_buf;
> +
> +	has_etr_sg = tmc_etr_has_cap(drvdata, TMC_ETR_SG);
> +	has_iommu = iommu_get_domain_for_dev(drvdata->dev);
> +
> +	etr_buf = kzalloc(sizeof(*etr_buf), GFP_KERNEL);
> +	if (!etr_buf)
> +		return ERR_PTR(-ENOMEM);
> +
> +	etr_buf->size = size;
> +
> +	/*
> +	 * If we have to use an existing list of pages, we cannot reliably
> +	 * use a contiguous DMA memory (even if we have an IOMMU). Otherwise,
> +	 * we use the contiguous DMA memory if at least one of the following
> +	 * conditions is true:
> +	 *  a) The ETR cannot use Scatter-Gather.
> +	 *  b) we have a backing IOMMU
> +	 *  c) The requested memory size is smaller (< 1M).
> +	 *
> +	 * Fallback to available mechanisms.
> +	 *
> +	 */
> +	if (!pages &&
> +	    (!has_etr_sg || has_iommu || size < SZ_1M))
> +		rc = tmc_etr_mode_alloc_buf(ETR_MODE_FLAT, drvdata,
> +					    etr_buf, node, pages);
> +	if (rc && has_etr_sg)
> +		rc = tmc_etr_mode_alloc_buf(ETR_MODE_ETR_SG, drvdata,
> +					    etr_buf, node, pages);
> +	if (rc) {
> +		kfree(etr_buf);
> +		return ERR_PTR(rc);
> +	}
> +
> +	return etr_buf;
> +}
> +
> +static void tmc_free_etr_buf(struct etr_buf *etr_buf)
> +{
> +	WARN_ON(!etr_buf->ops || !etr_buf->ops->free);
> +	etr_buf->ops->free(etr_buf);
> +	kfree(etr_buf);
> +}
> +
> +/*
> + * tmc_etr_buf_get_data: Get the pointer the trace data at @offset
> + * with a maximum of @len bytes.
> + * Returns: The size of the linear data available @pos, with *bufpp
> + * updated to point to the buffer.
> + */
> +static ssize_t tmc_etr_buf_get_data(struct etr_buf *etr_buf,
> +				    u64 offset, size_t len, char **bufpp)
> +{
> +	/* Adjust the length to limit this transaction to end of buffer */
> +	len = (len < (etr_buf->size - offset)) ? len : etr_buf->size - offset;
> +
> +	return etr_buf->ops->get_data(etr_buf, (u64)offset, len, bufpp);
> +}
> +
> +static inline s64
> +tmc_etr_buf_insert_barrier_packet(struct etr_buf *etr_buf, u64 offset)
> +{
> +	ssize_t len;
> +	char *bufp;
> +
> +	len = tmc_etr_buf_get_data(etr_buf, offset,
> +				   CORESIGHT_BARRIER_PKT_SIZE, &bufp);
> +	if (WARN_ON(len <= CORESIGHT_BARRIER_PKT_SIZE))
> +		return -EINVAL;
> +	coresight_insert_barrier_packet(bufp);
> +	return offset + CORESIGHT_BARRIER_PKT_SIZE;
> +}
> +
> +/*
> + * tmc_sync_etr_buf: Sync the trace buffer availability with drvdata.
> + * Makes sure the trace data is synced to the memory for consumption.
> + * @etr_buf->offset will hold the offset to the beginning of the trace data
> + * within the buffer, with @etr_buf->len bytes to consume.
> + */
> +static void tmc_sync_etr_buf(struct tmc_drvdata *drvdata)
> +{
> +	struct etr_buf *etr_buf = drvdata->etr_buf;
> +	u64 rrp, rwp;
> +	u32 status;
> +
> +	rrp = tmc_read_rrp(drvdata);
> +	rwp = tmc_read_rwp(drvdata);
> +	status = readl_relaxed(drvdata->base + TMC_STS);
> +	etr_buf->full = status & TMC_STS_FULL;
> +
> +	WARN_ON(!etr_buf->ops || !etr_buf->ops->sync);
> +
> +	etr_buf->ops->sync(etr_buf, rrp, rwp);
> +
> +	/* Insert barrier packets at the beginning, if there was an overflow */
> +	if (etr_buf->full)
> +		tmc_etr_buf_insert_barrier_packet(etr_buf, etr_buf->offset);
> +}
> +
>  static inline void tmc_etr_enable_catu(struct tmc_drvdata *drvdata)
>  {
>  	struct coresight_device *catu = tmc_etr_get_catu_device(drvdata);
> @@ -721,6 +1018,7 @@ static inline void tmc_etr_disable_catu(struct tmc_drvdata *drvdata)
>  static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
>  {
>  	u32 axictl, sts;
> +	struct etr_buf *etr_buf = drvdata->etr_buf;
>  
>  	/*
>  	 * If this ETR is connected to a CATU, enable it before we turn
> @@ -733,7 +1031,7 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
>  	/* Wait for TMCSReady bit to be set */
>  	tmc_wait_for_tmcready(drvdata);
>  
> -	writel_relaxed(drvdata->size / 4, drvdata->base + TMC_RSZ);
> +	writel_relaxed(etr_buf->size / 4, drvdata->base + TMC_RSZ);
>  	writel_relaxed(TMC_MODE_CIRCULAR_BUFFER, drvdata->base + TMC_MODE);
>  
>  	axictl = readl_relaxed(drvdata->base + TMC_AXICTL);
> @@ -746,16 +1044,22 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
>  		axictl |= TMC_AXICTL_ARCACHE_OS;
>  	}
>  
> +	if (etr_buf->mode == ETR_MODE_ETR_SG) {
> +		if (WARN_ON(!tmc_etr_has_cap(drvdata, TMC_ETR_SG)))
> +			return;
> +		axictl |= TMC_AXICTL_SCT_GAT_MODE;
> +	}
> +
>  	writel_relaxed(axictl, drvdata->base + TMC_AXICTL);
> -	tmc_write_dba(drvdata, drvdata->paddr);
> +	tmc_write_dba(drvdata, etr_buf->hwaddr);
>  	/*
>  	 * If the TMC pointers must be programmed before the session,
>  	 * we have to set it properly (i.e, RRP/RWP to base address and
>  	 * STS to "not full").
>  	 */
>  	if (tmc_etr_has_cap(drvdata, TMC_ETR_SAVE_RESTORE)) {
> -		tmc_write_rrp(drvdata, drvdata->paddr);
> -		tmc_write_rwp(drvdata, drvdata->paddr);
> +		tmc_write_rrp(drvdata, etr_buf->hwaddr);
> +		tmc_write_rwp(drvdata, etr_buf->hwaddr);
>  		sts = readl_relaxed(drvdata->base + TMC_STS) & ~TMC_STS_FULL;
>  		writel_relaxed(sts, drvdata->base + TMC_STS);
>  	}
> @@ -771,63 +1075,53 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
>  }
>  
>  /*
> - * Return the available trace data in the buffer @pos, with a maximum
> - * limit of @len, also updating the @bufpp on where to find it.
> + * Return the available trace data in the buffer (starts at etr_buf->offset,
> + * limited by etr_buf->len) from @pos, with a maximum limit of @len,
> + * also updating the @bufpp on where to find it. Since the trace data
> + * starts at anywhere in the buffer, depending on the RRP, we adjust the
> + * @len returned to handle buffer wrapping around.
>   */
>  ssize_t tmc_etr_get_sysfs_trace(struct tmc_drvdata *drvdata,
> -			    loff_t pos, size_t len, char **bufpp)
> +				loff_t pos, size_t len, char **bufpp)
>  {
> +	s64 offset;
>  	ssize_t actual = len;
> -	char *bufp = drvdata->buf + pos;
> -	char *bufend = (char *)(drvdata->vaddr + drvdata->size);
> -
> -	/* Adjust the len to available size @pos */
> -	if (pos + actual > drvdata->len)
> -		actual = drvdata->len - pos;
> +	struct etr_buf *etr_buf = drvdata->etr_buf;
>  
> +	if (pos + actual > etr_buf->len)
> +		actual = etr_buf->len - pos;
>  	if (actual <= 0)
>  		return actual;
>  
> -	/*
> -	 * Since we use a circular buffer, with trace data starting
> -	 * @drvdata->buf, possibly anywhere in the buffer @drvdata->vaddr,
> -	 * wrap the current @pos to within the buffer.
> -	 */
> -	if (bufp >= bufend)
> -		bufp -= drvdata->size;
> -	/*
> -	 * For simplicity, avoid copying over a wrapped around buffer.
> -	 */
> -	if ((bufp + actual) > bufend)
> -		actual = bufend - bufp;
> -	*bufpp = bufp;
> -	return actual;
> +	/* Compute the offset from which we read the data */
> +	offset = etr_buf->offset + pos;
> +	if (offset >= etr_buf->size)
> +		offset -= etr_buf->size;
> +	return tmc_etr_buf_get_data(etr_buf, offset, actual, bufpp);
>  }
>  
> -static void tmc_etr_dump_hw(struct tmc_drvdata *drvdata)
> +static struct etr_buf *
> +tmc_etr_setup_sysfs_buf(struct tmc_drvdata *drvdata)
>  {
> -	u32 val;
> -	u64 rwp;
> +	return tmc_alloc_etr_buf(drvdata, drvdata->size,
> +				 0, cpu_to_node(0), NULL);
> +}
>  
> -	rwp = tmc_read_rwp(drvdata);
> -	val = readl_relaxed(drvdata->base + TMC_STS);
> +static void
> +tmc_etr_free_sysfs_buf(struct etr_buf *buf)
> +{
> +	if (buf)
> +		tmc_free_etr_buf(buf);
> +}
>  
> -	/*
> -	 * Adjust the buffer to point to the beginning of the trace data
> -	 * and update the available trace data.
> -	 */
> -	if (val & TMC_STS_FULL) {
> -		drvdata->buf = drvdata->vaddr + rwp - drvdata->paddr;
> -		drvdata->len = drvdata->size;
> -		coresight_insert_barrier_packet(drvdata->buf);
> -	} else {
> -		drvdata->buf = drvdata->vaddr;
> -		drvdata->len = rwp - drvdata->paddr;
> -	}
> +static void tmc_etr_sync_sysfs_buf(struct tmc_drvdata *drvdata)
> +{
> +	tmc_sync_etr_buf(drvdata);
>  }
>  
>  static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
>  {
> +
>  	CS_UNLOCK(drvdata->base);
>  
>  	tmc_flush_and_stop(drvdata);
> @@ -836,7 +1130,8 @@ static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
>  	 * read before the TMC is disabled.
>  	 */
>  	if (drvdata->mode == CS_MODE_SYSFS)
> -		tmc_etr_dump_hw(drvdata);
> +		tmc_etr_sync_sysfs_buf(drvdata);
> +
>  	tmc_disable_hw(drvdata);
>  
>  	CS_LOCK(drvdata->base);
> @@ -850,34 +1145,31 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
>  	int ret = 0;
>  	bool used = false;
>  	unsigned long flags;
> -	void __iomem *vaddr = NULL;
> -	dma_addr_t paddr;
>  	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	struct etr_buf *new_buf = NULL, *free_buf = NULL;
>  
>  
>  	/*
> -	 * If we don't have a buffer release the lock and allocate memory.
> -	 * Otherwise keep the lock and move along.
> +	 * If we are enabling the ETR from disabled state, we need to make
> +	 * sure we have a buffer with the right size. The etr_buf is not reset
> +	 * immediately after we stop the tracing in SYSFS mode as we wait for
> +	 * the user to collect the data. We may be able to reuse the existing
> +	 * buffer, provided the size matches. Any allocation has to be done
> +	 * with the lock released.
>  	 */
>  	spin_lock_irqsave(&drvdata->spinlock, flags);
> -	if (!drvdata->vaddr) {
> +	if (!drvdata->etr_buf || (drvdata->etr_buf->size != drvdata->size)) {
>  		spin_unlock_irqrestore(&drvdata->spinlock, flags);
> -
> -		/*
> -		 * Contiguous  memory can't be allocated while a spinlock is
> -		 * held.  As such allocate memory here and free it if a buffer
> -		 * has already been allocated (from a previous session).
> -		 */
> -		vaddr = dma_alloc_coherent(drvdata->dev, drvdata->size,
> -					   &paddr, GFP_KERNEL);
> -		if (!vaddr)
> -			return -ENOMEM;
> +		/* Allocate memory with the spinlock released */
> +		free_buf = new_buf = tmc_etr_setup_sysfs_buf(drvdata);
> +		if (IS_ERR(new_buf))
> +			return PTR_ERR(new_buf);
>  
>  		/* Let's try again */
>  		spin_lock_irqsave(&drvdata->spinlock, flags);
>  	}
>  
> -	if (drvdata->reading) {
> +	if (drvdata->reading || drvdata->mode == CS_MODE_PERF) {
>  		ret = -EBUSY;
>  		goto out;
>  	}
> @@ -885,21 +1177,20 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
>  	/*
>  	 * In sysFS mode we can have multiple writers per sink.  Since this
>  	 * sink is already enabled no memory is needed and the HW need not be
> -	 * touched.
> +	 * touched, even if the buffer size has changed.
>  	 */
>  	if (drvdata->mode == CS_MODE_SYSFS)
>  		goto out;
>  
>  	/*
> -	 * If drvdata::buf == NULL, use the memory allocated above.
> -	 * Otherwise a buffer still exists from a previous session, so
> -	 * simply use that.
> +	 * If we don't have a buffer or it doesn't match the requested size,
> +	 * use the memory allocated above. Otherwise reuse it.
>  	 */
> -	if (drvdata->buf == NULL) {
> +	if (!drvdata->etr_buf ||
> +	    (new_buf && drvdata->etr_buf->size != new_buf->size)) {
>  		used = true;
> -		drvdata->vaddr = vaddr;
> -		drvdata->paddr = paddr;
> -		drvdata->buf = drvdata->vaddr;
> +		free_buf = drvdata->etr_buf;
> +		drvdata->etr_buf = new_buf;
>  	}
>  
>  	drvdata->mode = CS_MODE_SYSFS;
> @@ -908,8 +1199,8 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  
>  	/* Free memory outside the spinlock if need be */
> -	if (!used && vaddr)
> -		dma_free_coherent(drvdata->dev, drvdata->size, vaddr, paddr);
> +	if (free_buf)
> +		tmc_etr_free_sysfs_buf(free_buf);
>  
>  	if (!ret)
>  		dev_info(drvdata->dev, "TMC-ETR enabled\n");
> @@ -988,8 +1279,8 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
>  		goto out;
>  	}
>  
> -	/* If drvdata::buf is NULL the trace data has been read already */
> -	if (drvdata->buf == NULL) {
> +	/* If drvdata::etr_buf is NULL the trace data has been read already */
> +	if (drvdata->etr_buf == NULL) {
>  		ret = -EINVAL;
>  		goto out;
>  	}
> @@ -1008,8 +1299,7 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
>  int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
>  {
>  	unsigned long flags;
> -	dma_addr_t paddr;
> -	void __iomem *vaddr = NULL;
> +	struct etr_buf *etr_buf = NULL;
>  
>  	/* config types are set a boot time and never change */
>  	if (WARN_ON_ONCE(drvdata->config_type != TMC_CONFIG_TYPE_ETR))
> @@ -1030,17 +1320,16 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
>  		 * The ETR is not tracing and the buffer was just read.
>  		 * As such prepare to free the trace buffer.
>  		 */
> -		vaddr = drvdata->vaddr;
> -		paddr = drvdata->paddr;
> -		drvdata->buf = drvdata->vaddr = NULL;
> +		etr_buf =  drvdata->etr_buf;
> +		drvdata->etr_buf = NULL;
>  	}
>  
>  	drvdata->reading = false;
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  
>  	/* Free allocated memory out side of the spinlock */
> -	if (vaddr)
> -		dma_free_coherent(drvdata->dev, drvdata->size, vaddr, paddr);
> +	if (etr_buf)
> +		tmc_free_etr_buf(etr_buf);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index 74d8f24..6f7bec7 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -56,6 +56,7 @@
>  #define TMC_STS_TMCREADY_BIT	2
>  #define TMC_STS_FULL		BIT(0)
>  #define TMC_STS_TRIGGERED	BIT(1)
> +
>  /*
>   * TMC_AXICTL - 0x110
>   *
> @@ -135,6 +136,35 @@ enum tmc_mem_intf_width {
>  #define CORESIGHT_SOC_600_ETR_CAPS	\
>  	(TMC_ETR_SAVE_RESTORE | TMC_ETR_AXI_ARCACHE)
>  
> +enum etr_mode {
> +	ETR_MODE_FLAT,		/* Uses contiguous flat buffer */
> +	ETR_MODE_ETR_SG,	/* Uses in-built TMC ETR SG mechanism */
> +};
> +
> +struct etr_buf_operations;
> +
> +/**
> + * struct etr_buf - Details of the buffer used by ETR
> + * @mode	: Mode of the ETR buffer, contiguous, Scatter Gather etc.
> + * @full	: Trace data overflow
> + * @size	: Size of the buffer.
> + * @hwaddr	: Address to be programmed in the TMC:DBA{LO,HI}
> + * @offset	: Offset of the trace data in the buffer for consumption.
> + * @len		: Available trace data @buf (may round up to the beginning).
> + * @ops		: ETR buffer operations for the mode.
> + * @private	: Backend specific information for the buf
> + */
> +struct etr_buf {
> +	enum etr_mode			mode;
> +	bool				full;
> +	ssize_t				size;
> +	dma_addr_t			hwaddr;
> +	unsigned long			offset;
> +	s64				len;
> +	const struct etr_buf_operations	*ops;
> +	void				*private;
> +};
> +
>  /**
>   * struct tmc_drvdata - specifics associated to an TMC component
>   * @base:	memory mapped base address for this component.
> @@ -142,11 +172,10 @@ enum tmc_mem_intf_width {
>   * @csdev:	component vitals needed by the framework.
>   * @miscdev:	specifics to handle "/dev/xyz.tmc" entry.
>   * @spinlock:	only one at a time pls.
> - * @buf:	area of memory where trace data get sent.
> - * @paddr:	DMA start location in RAM.
> - * @vaddr:	virtual representation of @paddr.
> - * @size:	trace buffer size.
> - * @len:	size of the available trace.
> + * @buf:	Snapshot of the trace data for ETF/ETB.
> + * @etr_buf:	details of buffer used in TMC-ETR
> + * @len:	size of the available trace for ETF/ETB.
> + * @size:	trace buffer size for this TMC (common for all modes).
>   * @mode:	how this TMC is being used.
>   * @config_type: TMC variant, must be of type @tmc_config_type.
>   * @memwidth:	width of the memory interface databus, in bytes.
> @@ -161,11 +190,12 @@ struct tmc_drvdata {
>  	struct miscdevice	miscdev;
>  	spinlock_t		spinlock;
>  	bool			reading;
> -	char			*buf;
> -	dma_addr_t		paddr;
> -	void __iomem		*vaddr;
> -	u32			size;
> +	union {
> +		char		*buf;		/* TMC ETB */
> +		struct etr_buf	*etr_buf;	/* TMC ETR */
> +	};
>  	u32			len;
> +	u32			size;
>  	u32			mode;
>  	enum tmc_config_type	config_type;
>  	enum tmc_mem_intf_width	memwidth;
> @@ -173,6 +203,15 @@ struct tmc_drvdata {
>  	u32			etr_caps;
>  };
>  
> +struct etr_buf_operations {
> +	int (*alloc)(struct tmc_drvdata *drvdata, struct etr_buf *etr_buf,
> +			int node, void **pages);
> +	void (*sync)(struct etr_buf *etr_buf, u64 rrp, u64 rwp);
> +	ssize_t (*get_data)(struct etr_buf *etr_buf, u64 offset, size_t len,
> +				char **bufpp);
> +	void (*free)(struct etr_buf *etr_buf);
> +};
> +
>  /**
>   * struct tmc_pages - Collection of pages used for SG.
>   * @nr_pages:		Number of pages in the list.
> -- 
> 2.7.4
> 
