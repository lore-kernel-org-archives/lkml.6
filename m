Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752607AbeEGRsQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 13:48:16 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:46571 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752494AbeEGRsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 13:48:14 -0400
X-Google-Smtp-Source: AB8JxZpCOhd0ieBce0mr6USxn25YvWsMk5uQn4Cuf+o5I9/k2nNWS/X5nONObRbxQgh2+YymSVFPUQ==
Date: Mon, 7 May 2018 11:48:10 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, robert.walker@arm.com, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, sudeep.holla@arm.com,
        frowand.list@gmail.com, robh@kernel.org, john.horley@arm.com
Subject: Re: [PATCH v2 17/27] coresight: etr: Add support for save restore
 buffers
Message-ID: <20180507174810.GB32594@xps15>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-18-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525165857-11096-18-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 10:10:47AM +0100, Suzuki K Poulose wrote:
> Add support for creating buffers which can be used in save-restore
> mode (e.g, for use by perf). If the TMC-ETR supports save-restore
> feature, we could support the mode in all buffer backends. However,
> if it doesn't, we should fall back to using in built SG mechanism,
> where we can rotate the SG table by making some adjustments in the
> page table.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 142 +++++++++++++++++++++++-
>  drivers/hwtracing/coresight/coresight-tmc.h     |  16 +++
>  2 files changed, 153 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index fde3fa6..25e7feb 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -604,7 +604,7 @@ tmc_etr_sg_table_index_to_daddr(struct tmc_sg_table *sg_table, u32 index)
>   *    which starts @base_offset.
>   * 2) Mark the page at the base_offset + size as LAST.
>   */
> -static int __maybe_unused
> +static int
>  tmc_etr_sg_table_rotate(struct etr_sg_table *etr_table,
>  			unsigned long base_offset, unsigned long size)
>  {
> @@ -736,6 +736,9 @@ static int tmc_etr_alloc_flat_buf(struct tmc_drvdata *drvdata,
>  	flat_buf->size = etr_buf->size;
>  	flat_buf->dev = drvdata->dev;
>  	etr_buf->hwaddr = flat_buf->daddr;
> +	etr_buf->rrp = flat_buf->daddr;
> +	etr_buf->rwp = flat_buf->daddr;
> +	etr_buf->status = 0;
>  	etr_buf->mode = ETR_MODE_FLAT;
>  	etr_buf->private = flat_buf;
>  	return 0;
> @@ -777,11 +780,36 @@ static ssize_t tmc_etr_get_data_flat_buf(struct etr_buf *etr_buf,
>  	return len;
>  }
>  
> +/*
> + * tmc_etr_restore_flat_buf: Restore the flat buffer pointers.
> + * This is only possible with in-built ETR capability to save-restore
> + * the pointers. The DBA will still point to the original start of the
> + * buffer.
> + */
> +static int tmc_etr_restore_flat_buf(struct etr_buf *etr_buf,
> +				    unsigned long r_offset,
> +				    unsigned long w_offset,
> +				    unsigned long size,
> +				    u32 status,
> +				    bool has_save_restore)
> +{
> +	struct etr_flat_buf *flat_buf = etr_buf->private;
> +
> +	if (!has_save_restore || !flat_buf || size > flat_buf->size)
> +		return -EINVAL;
> +	etr_buf->rrp = flat_buf->daddr + (r_offset % flat_buf->size);
> +	etr_buf->rwp = flat_buf->daddr + (w_offset % flat_buf->size);
> +	etr_buf->size = size;
> +	etr_buf->status = status;
> +	return 0;
> +}
> +
>  static const struct etr_buf_operations etr_flat_buf_ops = {
>  	.alloc = tmc_etr_alloc_flat_buf,
>  	.free = tmc_etr_free_flat_buf,
>  	.sync = tmc_etr_sync_flat_buf,
>  	.get_data = tmc_etr_get_data_flat_buf,
> +	.restore = tmc_etr_restore_flat_buf,
>  };
>  
>  /*
> @@ -799,6 +827,7 @@ static int tmc_etr_alloc_sg_buf(struct tmc_drvdata *drvdata,
>  	if (IS_ERR(etr_table))
>  		return -ENOMEM;
>  	etr_buf->hwaddr = etr_table->hwaddr;
> +	etr_buf->status = 0;
>  	etr_buf->mode = ETR_MODE_ETR_SG;
>  	etr_buf->private = etr_table;
>  	return 0;
> @@ -825,9 +854,11 @@ static ssize_t tmc_etr_get_data_sg_buf(struct etr_buf *etr_buf, u64 offset,
>  static void tmc_etr_sync_sg_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
>  {
>  	long r_offset, w_offset;
> +	unsigned long buf_size;
>  	struct etr_sg_table *etr_table = etr_buf->private;
>  	struct tmc_sg_table *table = etr_table->sg_table;
>  
> +	buf_size = tmc_sg_table_buf_size(table);
>  	/* Convert hw address to offset in the buffer */
>  	r_offset = tmc_sg_get_data_page_offset(table, rrp);
>  	if (r_offset < 0) {
> @@ -849,16 +880,62 @@ static void tmc_etr_sync_sg_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
>  	if (etr_buf->full)
>  		etr_buf->len = etr_buf->size;
>  	else
> -		etr_buf->len = ((w_offset < r_offset) ? etr_buf->size : 0) +
> +		etr_buf->len = ((w_offset < r_offset) ? buf_size : 0) +
>  				w_offset - r_offset;
>  	tmc_sg_table_sync_data_range(table, r_offset, etr_buf->len);
>  }
>  
> +static int tmc_etr_restore_sg_buf(struct etr_buf *etr_buf,
> +				  unsigned long r_offset,
> +				  unsigned long w_offset,
> +				  unsigned long size,
> +				  u32 __always_unused status,
> +				  bool has_save_restore)
> +{
> +	int rc;
> +	struct etr_sg_table *etr_table = etr_buf->private;
> +	struct device *dev = etr_table->sg_table->dev;
> +
> +	/*
> +	 * It is highly unlikely that we have an ETR with in-built SG and
> +	 * Save-Restore capability and we are not sure if the PTRs will
> +	 * be updated.
> +	 */
> +	if (has_save_restore) {
> +		dev_warn_once(dev,
> +		"Unexpected feature combination of SG and save-restore\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Since we cannot program RRP/RWP different from DBAL, the offsets
> +	 * should match.
> +	 */
> +	if (r_offset != w_offset) {
> +		dev_dbg(dev, "Mismatched RRP/RWP offsets\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Make sure the size is aligned */
> +	size &= ~(ETR_SG_PAGE_SIZE - 1);
> +
> +	rc = tmc_etr_sg_table_rotate(etr_table, w_offset, size);
> +	if (!rc) {
> +		etr_buf->hwaddr = etr_table->hwaddr;
> +		etr_buf->rrp = etr_table->hwaddr;
> +		etr_buf->rwp = etr_table->hwaddr;
> +		etr_buf->size = size;
> +	}
> +
> +	return rc;
> +}
> +
>  static const struct etr_buf_operations etr_sg_buf_ops = {
>  	.alloc = tmc_etr_alloc_sg_buf,
>  	.free = tmc_etr_free_sg_buf,
>  	.sync = tmc_etr_sync_sg_buf,
>  	.get_data = tmc_etr_get_data_sg_buf,
> +	.restore = tmc_etr_restore_sg_buf,
>  };
>  
>  static const struct etr_buf_operations *etr_buf_ops[] = {
> @@ -899,10 +976,42 @@ static struct etr_buf *tmc_alloc_etr_buf(struct tmc_drvdata *drvdata,
>  {
>  	int rc = -ENOMEM;
>  	bool has_etr_sg, has_iommu;
> +	bool has_flat, has_save_restore;
>  	struct etr_buf *etr_buf;
>  
>  	has_etr_sg = tmc_etr_has_cap(drvdata, TMC_ETR_SG);
>  	has_iommu = iommu_get_domain_for_dev(drvdata->dev);
> +	has_save_restore = tmc_etr_has_cap(drvdata, TMC_ETR_SAVE_RESTORE);
> +
> +	/*
> +	 * We can normally use flat DMA buffer provided that the buffer
> +	 * is not used in save restore fashion without hardware support.
> +	 */
> +	has_flat = !(flags & ETR_BUF_F_RESTORE_PTRS) || has_save_restore;
> +
> +	/*
> +	 * To support save-restore on a given ETR we have the following
> +	 * conditions:
> +	 *  1) If the buffer requires save-restore of a pointers as well
> +	 *     as the Status bit, we require ETR support for it and we coul

/coul/could

> +	 *     support all the backends.
> +	 *  2) If the buffer requires only save-restore of pointers, then
> +	 *     we could exploit a circular ETR SG list. None of the other
> +	 *     backends can support it without the ETR feature.
> +	 *
> +	 * If the buffer will be used in a save-restore mode without
> +	 * the ETR support for SAVE_RESTORE, we can only support TMC
> +	 * ETR in-built SG tables which can be rotated to make it work.
> +	 */
> +	if ((flags & ETR_BUF_F_RESTORE_STATUS) && !has_save_restore)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!has_flat && !has_etr_sg) {
> +		dev_dbg(drvdata->dev,
> +			"No available backends for ETR buffer with flags %x\n",
> +			flags);
> +		return ERR_PTR(-EINVAL);
> +	}
>  
>  	etr_buf = kzalloc(sizeof(*etr_buf), GFP_KERNEL);
>  	if (!etr_buf)
> @@ -922,7 +1031,7 @@ static struct etr_buf *tmc_alloc_etr_buf(struct tmc_drvdata *drvdata,
>  	 * Fallback to available mechanisms.
>  	 *
>  	 */
> -	if (!pages &&
> +	if (!pages && has_flat &&
>  	    (!has_etr_sg || has_iommu || size < SZ_1M))
>  		rc = tmc_etr_mode_alloc_buf(ETR_MODE_FLAT, drvdata,
>  					    etr_buf, node, pages);
> @@ -999,6 +1108,29 @@ static void tmc_sync_etr_buf(struct tmc_drvdata *drvdata)
>  		tmc_etr_buf_insert_barrier_packet(etr_buf, etr_buf->offset);
>  }
>  
> +static int __maybe_unused
> +tmc_restore_etr_buf(struct tmc_drvdata *drvdata, struct etr_buf *etr_buf,
> +		    unsigned long r_offset, unsigned long w_offset,
> +		    unsigned long size, u32 status)
> +{
> +	bool has_save_restore = tmc_etr_has_cap(drvdata, TMC_ETR_SAVE_RESTORE);
> +
> +	if (WARN_ON_ONCE(!has_save_restore && etr_buf->mode != ETR_MODE_ETR_SG))
> +		return -EINVAL;
> +	/*
> +	 * If we use a circular SG list without ETR support, we can't
> +	 * support restoring "Full" bit.
> +	 */
> +	if (WARN_ON_ONCE(!has_save_restore && status))
> +		return -EINVAL;
> +	if (status & ~TMC_STS_FULL)
> +		return -EINVAL;
> +	if (etr_buf->ops->restore)
> +		return etr_buf->ops->restore(etr_buf, r_offset, w_offset, size,
> +					      status, has_save_restore);
> +	return -EINVAL;
> +}
> +
>  static inline void tmc_etr_enable_catu(struct tmc_drvdata *drvdata)
>  {
>  	struct coresight_device *catu = tmc_etr_get_catu_device(drvdata);
> @@ -1058,8 +1190,8 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
>  	 * STS to "not full").
>  	 */
>  	if (tmc_etr_has_cap(drvdata, TMC_ETR_SAVE_RESTORE)) {
> -		tmc_write_rrp(drvdata, etr_buf->hwaddr);
> -		tmc_write_rwp(drvdata, etr_buf->hwaddr);
> +		tmc_write_rrp(drvdata, etr_buf->rrp);
> +		tmc_write_rwp(drvdata, etr_buf->rwp);
>  		sts = readl_relaxed(drvdata->base + TMC_STS) & ~TMC_STS_FULL;
>  		writel_relaxed(sts, drvdata->base + TMC_STS);
>  	}
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index 6f7bec7..1bdfb38 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -141,12 +141,22 @@ enum etr_mode {
>  	ETR_MODE_ETR_SG,	/* Uses in-built TMC ETR SG mechanism */
>  };
>  
> +/* ETR buffer should support save-restore */
> +#define ETR_BUF_F_RESTORE_PTRS		0x1
> +#define ETR_BUF_F_RESTORE_STATUS	0x2
> +
> +#define ETR_BUF_F_RESTORE_MINIMAL	ETR_BUF_F_RESTORE_PTRS
> +#define ETR_BUF_F_RESTORE_FULL		(ETR_BUF_F_RESTORE_PTRS |\
> +					 ETR_BUF_F_RESTORE_STATUS)
>  struct etr_buf_operations;
>  
>  /**
>   * struct etr_buf - Details of the buffer used by ETR
>   * @mode	: Mode of the ETR buffer, contiguous, Scatter Gather etc.
>   * @full	: Trace data overflow
> + * @status	: Value for STATUS if the ETR supports save-restore.
> + * @rrp		: Value for RRP{LO:HI} if the ETR supports save-restore
> + * @rwp		: Value for RWP{LO:HI} if the ETR supports save-restore
>   * @size	: Size of the buffer.
>   * @hwaddr	: Address to be programmed in the TMC:DBA{LO,HI}
>   * @offset	: Offset of the trace data in the buffer for consumption.
> @@ -157,6 +167,9 @@ struct etr_buf_operations;
>  struct etr_buf {
>  	enum etr_mode			mode;
>  	bool				full;
> +	u32				status;
> +	dma_addr_t			rrp;
> +	dma_addr_t			rwp;
>  	ssize_t				size;
>  	dma_addr_t			hwaddr;
>  	unsigned long			offset;
> @@ -207,6 +220,9 @@ struct etr_buf_operations {
>  	int (*alloc)(struct tmc_drvdata *drvdata, struct etr_buf *etr_buf,
>  			int node, void **pages);
>  	void (*sync)(struct etr_buf *etr_buf, u64 rrp, u64 rwp);
> +	int (*restore)(struct etr_buf *etr_buf, unsigned long r_offset,
> +		       unsigned long w_offset, unsigned long size,
> +		       u32 status, bool has_save_restore);
>  	ssize_t (*get_data)(struct etr_buf *etr_buf, u64 offset, size_t len,
>  				char **bufpp);
>  	void (*free)(struct etr_buf *etr_buf);
> -- 
> 2.7.4
> 
