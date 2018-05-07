Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752879AbeEGWCy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 18:02:54 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34181 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752550AbeEGWCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 18:02:53 -0400
X-Google-Smtp-Source: AB8JxZq1OPgtVyi4x3IcjdK1OBkv78UFsjkFIZ7CbXOIkpqckZu+7vsjIdEEHilqqiQSEAq1N5BNyQ==
Date: Mon, 7 May 2018 16:02:49 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, robert.walker@arm.com, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, sudeep.holla@arm.com,
        frowand.list@gmail.com, robh@kernel.org, john.horley@arm.com
Subject: Re: [PATCH v2 19/27] coresight: catu: Plug in CATU as a backend for
 ETR buffer
Message-ID: <20180507220249.GA22194@xps15>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-20-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525165857-11096-20-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 10:10:49AM +0100, Suzuki K Poulose wrote:
> Now that we can use a CATU with a scatter gather table, add support
> for the TMC ETR to make use of the connected CATU in translate mode.
> This is done by adding CATU as new buffer mode. CATU's SLADDR must
> always be 4K aligned. Thus the INADDR (base VA) is always 1M aligned
> and we adjust the DBA for the ETR to align to the "offset" within
> the 1MB page.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-catu.c    | 189 +++++++++++++++++++++++-
>  drivers/hwtracing/coresight/coresight-catu.h    |  30 ++++
>  drivers/hwtracing/coresight/coresight-tmc-etr.c |  23 ++-
>  drivers/hwtracing/coresight/coresight-tmc.h     |   1 +
>  4 files changed, 235 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> index 4cc2928..a4792fa 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.c
> +++ b/drivers/hwtracing/coresight/coresight-catu.c
> @@ -22,6 +22,21 @@
>  	dev_get_drvdata(csdev->dev.parent)
>  
>  /*
> + * catu_etr_buf		- CATU buffer descriptor
> + * @catu_table		- SG table for the CATU
> + * @sladdr		- Table base address for CATU
> + * @start_offset	- Current offset where the ETR starts writing
> + *			  within the buffer.
> + * @cur_size		- Current size used by the ETR.
> + */
> +struct catu_etr_buf {
> +	struct tmc_sg_table	*catu_table;
> +	u64			sladdr;
> +	u64			start_offset;
> +	u64			cur_size;
> +};
> +
> +/*
>   * CATU uses a page size of 4KB for page tables as well as data pages.
>   * Each 64bit entry in the table has the following format.
>   *
> @@ -87,6 +102,9 @@ typedef u64 cate_t;
>  	(((cate_t)(addr) & CATU_ADDR_MASK) | CATU_ENTRY_VALID)
>  #define CATU_ENTRY_ADDR(entry)	((cate_t)(entry) & ~((cate_t)CATU_ENTRY_VALID))
>  
> +/* CATU expects the INADDR to be aligned to 1M. */
> +#define CATU_DEFAULT_INADDR	(1ULL << 20)
> +
>  /*
>   * Index into the CATU entry pointing to the page within
>   * the table. Each table entry can point to a 4KB page, with
> @@ -401,7 +419,7 @@ catu_populate_table(struct tmc_sg_table *catu_table)
>  	}
>  }
>  
> -static struct tmc_sg_table __maybe_unused *
> +static struct tmc_sg_table *
>  catu_init_sg_table(struct device *catu_dev, int node,
>  		   ssize_t size, void **pages)
>  {
> @@ -429,6 +447,149 @@ catu_init_sg_table(struct device *catu_dev, int node,
>  	return catu_table;
>  }
>  
> +static void catu_free_etr_buf(struct etr_buf *etr_buf)
> +{
> +	struct catu_etr_buf *catu_buf;
> +
> +	if (!etr_buf || etr_buf->mode != ETR_MODE_CATU || !etr_buf->private)
> +		return;
> +	catu_buf = etr_buf->private;
> +	tmc_free_sg_table(catu_buf->catu_table);
> +	kfree(catu_buf);
> +}
> +
> +static ssize_t catu_get_data_etr_buf(struct etr_buf *etr_buf, u64 offset,
> +				     size_t len, char **bufpp)
> +{
> +	struct catu_etr_buf *catu_buf = etr_buf->private;
> +
> +	return tmc_sg_table_get_data(catu_buf->catu_table, offset, len, bufpp);
> +}
> +
> +static void catu_sync_etr_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
> +{
> +	struct catu_etr_buf *catu_buf = etr_buf->private;
> +	s64 r_offset, w_offset;
> +	unsigned long buf_size = tmc_sg_table_buf_size(catu_buf->catu_table);
> +
> +	/*
> +	 * ETR started off at etr_buf->hwaddr which corresponds to
> +	 * start_offset within the trace buffer. Convert the RRP/RWP
> +	 * offsets within the trace buffer.
> +	 */
> +	r_offset = (s64)rrp - etr_buf->hwaddr + catu_buf->start_offset;
> +	r_offset -= (r_offset > buf_size) ? buf_size : 0;
> +
> +	w_offset = (s64)rwp - etr_buf->hwaddr + catu_buf->start_offset;
> +	w_offset -= (w_offset > buf_size) ? buf_size : 0;
> +
> +	if (!etr_buf->full) {
> +		etr_buf->len = w_offset - r_offset;
> +		if (w_offset < r_offset)
> +			etr_buf->len += buf_size;
> +	} else {
> +		etr_buf->len = etr_buf->size;
> +	}
> +
> +	etr_buf->offset = r_offset;
> +	tmc_sg_table_sync_data_range(catu_buf->catu_table,
> +				     r_offset, etr_buf->len);
> +}
> +
> +static inline void catu_set_etr_buf(struct etr_buf *etr_buf, u64 base, u64 size)
> +{
> +	struct catu_etr_buf *catu_buf = etr_buf->private;
> +
> +	catu_buf->start_offset = base;
> +	catu_buf->cur_size = size;
> +
> +	/*
> +	 * CATU always maps 1MB aligned addresses. ETR should start at
> +	 * the offset within the first table.
> +	 */
> +	etr_buf->hwaddr = CATU_DEFAULT_INADDR + (base & (SZ_1M - 1));
> +	etr_buf->size = size;
> +	etr_buf->rwp = etr_buf->rrp = etr_buf->hwaddr;
> +}
> +
> +static int catu_restore_etr_buf(struct etr_buf *etr_buf,
> +				unsigned long r_offset,
> +				unsigned long w_offset,
> +				unsigned long size,
> +				u32 status,
> +				bool has_save_restore)
> +{
> +	struct catu_etr_buf *catu_buf = etr_buf->private;
> +	u64 end = w_offset + size;
> +	u64 cur_end = catu_buf->start_offset + catu_buf->cur_size;
> +
> +	/*
> +	 * We cannot support rotation without a full table
> +	 * at the end. i.e, the buffer size should be aligned
> +	 * to 1MB.
> +	 */
> +	if (tmc_sg_table_buf_size(catu_buf->catu_table) & (SZ_1M - 1))
> +		return -EINVAL;
> +
> +	/*
> +	 * We don't have to make any changes to the table if the
> +	 * current (start, end) and the new (start, end) are in the
> +	 * same pages respectively.
> +	 */
> +	if ((w_offset ^ catu_buf->start_offset) & ~(CATU_PAGE_SIZE - 1) ||
> +	    (end ^ cur_end) & ~(CATU_PAGE_SIZE - 1)) {
> +		catu_reset_table(catu_buf->catu_table, catu_buf->start_offset,
> +				 catu_buf->cur_size);
> +		catu_buf->sladdr = catu_set_table(catu_buf->catu_table,
> +						  w_offset, size);
> +	}
> +
> +	catu_set_etr_buf(etr_buf, w_offset, size);
> +
> +	return 0;
> +}
> +
> +static int catu_alloc_etr_buf(struct tmc_drvdata *tmc_drvdata,
> +			      struct etr_buf *etr_buf, int node, void **pages)
> +{
> +	struct coresight_device *csdev;
> +	struct device *catu_dev;
> +	struct tmc_sg_table *catu_table;
> +	struct catu_etr_buf *catu_buf;
> +
> +	csdev = tmc_etr_get_catu_device(tmc_drvdata);
> +	if (!csdev)
> +		return -ENODEV;
> +	catu_dev = csdev->dev.parent;
> +	catu_buf = kzalloc(sizeof(*catu_buf), GFP_KERNEL);
> +	if (!catu_buf)
> +		return -ENOMEM;
> +
> +	catu_table = catu_init_sg_table(catu_dev, node, etr_buf->size, pages);
> +	if (IS_ERR(catu_table)) {
> +		kfree(catu_buf);
> +		return PTR_ERR(catu_table);
> +	}
> +
> +	etr_buf->mode = ETR_MODE_CATU;
> +	etr_buf->private = catu_buf;
> +	catu_buf->catu_table = catu_table;
> +
> +	/* By default make the buffer linear from 0 with full size */
> +	catu_set_etr_buf(etr_buf, 0, etr_buf->size);
> +	catu_dump_table(catu_table);
> +
> +	return 0;
> +}
> +
> +const struct etr_buf_operations etr_catu_buf_ops = {
> +	.alloc = catu_alloc_etr_buf,
> +	.free = catu_free_etr_buf,
> +	.sync = catu_sync_etr_buf,
> +	.get_data = catu_get_data_etr_buf,
> +	.restore = catu_restore_etr_buf,
> +};
> +
>  coresight_simple_reg32(struct catu_drvdata, control, CATU_CONTROL);
>  coresight_simple_reg32(struct catu_drvdata, status, CATU_STATUS);
>  coresight_simple_reg32(struct catu_drvdata, mode, CATU_MODE);
> @@ -467,9 +628,11 @@ static inline int catu_wait_for_ready(struct catu_drvdata *drvdata)
>  				 CATU_STATUS, CATU_STATUS_READY, 1);
>  }
>  
> -static int catu_enable_hw(struct catu_drvdata *drvdata, void *__unused)
> +static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
>  {
>  	u32 control;
> +	u32 mode;
> +	struct etr_buf *etr_buf = data;
>  
>  	if (catu_wait_for_ready(drvdata))
>  		dev_warn(drvdata->dev, "Timeout while waiting for READY\n");
> @@ -481,9 +644,27 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, void *__unused)
>  	}
>  
>  	control |= BIT(CATU_CONTROL_ENABLE);
> -	catu_write_mode(drvdata, CATU_MODE_PASS_THROUGH);
> +
> +	if (etr_buf && etr_buf->mode == ETR_MODE_CATU) {
> +		struct catu_etr_buf *catu_buf = etr_buf->private;
> +
> +		mode = CATU_MODE_TRANSLATE;
> +		catu_write_axictrl(drvdata, CATU_OS_AXICTRL);
> +		catu_write_sladdr(drvdata, catu_buf->sladdr);
> +		catu_write_inaddr(drvdata, CATU_DEFAULT_INADDR);
> +	} else {
> +		mode = CATU_MODE_PASS_THROUGH;
> +		catu_write_sladdr(drvdata, 0);
> +		catu_write_inaddr(drvdata, 0);
> +	}
> +
> +	catu_write_irqen(drvdata, 0);
> +	catu_write_mode(drvdata, mode);
>  	catu_write_control(drvdata, control);
> -	dev_dbg(drvdata->dev, "Enabled in Pass through mode\n");
> +	dev_dbg(drvdata->dev, "Enabled in %s mode\n",
> +		(mode == CATU_MODE_PASS_THROUGH) ?
> +		"Pass through" :
> +		"Translate");
>  	return 0;
>  }
>  
> diff --git a/drivers/hwtracing/coresight/coresight-catu.h b/drivers/hwtracing/coresight/coresight-catu.h
> index cd58d6f..b673a73 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.h
> +++ b/drivers/hwtracing/coresight/coresight-catu.h
> @@ -29,6 +29,32 @@
>  #define CATU_MODE_PASS_THROUGH	0U
>  #define CATU_MODE_TRANSLATE	1U
>  
> +#define CATU_AXICTRL_ARCACHE_SHIFT	4
> +#define CATU_AXICTRL_ARCACHE_MASK	0xf
> +#define CATU_AXICTRL_ARPROT_MASK	0x3
> +#define CATU_AXICTRL_ARCACHE(arcache)		\
> +	(((arcache) & CATU_AXICTRL_ARCACHE_MASK) << CATU_AXICTRL_ARCACHE_SHIFT)
> +
> +#define CATU_AXICTRL_VAL(arcache, arprot)	\
> +	(CATU_AXICTRL_ARCACHE(arcache) | ((arprot) & CATU_AXICTRL_ARPROT_MASK))
> +
> +#define AXI3_AxCACHE_WB_READ_ALLOC	0x7
> +/*
> + * AXI - ARPROT bits:
> + * See AMBA AXI & ACE Protocol specification (ARM IHI 0022E)
> + * sectionA4.7 Access Permissions.
> + *
> + * Bit 0: 0 - Unprivileged access, 1 - Privileged access
> + * Bit 1: 0 - Secure access, 1 - Non-secure access.
> + * Bit 2: 0 - Data access, 1 - instruction access.
> + *
> + * CATU AXICTRL:ARPROT[2] is res0 as we always access data.
> + */
> +#define CATU_OS_ARPROT			0x2
> +
> +#define CATU_OS_AXICTRL		\
> +	CATU_AXICTRL_VAL(AXI3_AxCACHE_WB_READ_ALLOC, CATU_OS_ARPROT)
> +
>  #define CATU_STATUS_READY	8
>  #define CATU_STATUS_ADRERR	0
>  #define CATU_STATUS_AXIERR	4
> @@ -71,6 +97,8 @@ catu_write_##name(struct catu_drvdata *drvdata, u64 val)		\
>  
>  CATU_REG32(control, CATU_CONTROL);
>  CATU_REG32(mode, CATU_MODE);
> +CATU_REG32(irqen, CATU_IRQEN);
> +CATU_REG32(axictrl, CATU_AXICTRL);
>  CATU_REG_PAIR(sladdr, CATU_SLADDRLO, CATU_SLADDRHI)
>  CATU_REG_PAIR(inaddr, CATU_INADDRLO, CATU_INADDRHI)
>  
> @@ -86,4 +114,6 @@ static inline bool coresight_is_catu_device(struct coresight_device *csdev)
>  	       subtype == CORESIGHT_DEV_SUBTYPE_HELPER_CATU;
>  }
>  
> +extern const struct etr_buf_operations etr_catu_buf_ops;
> +
>  #endif
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 25e7feb..41dde0a 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -941,6 +941,9 @@ static const struct etr_buf_operations etr_sg_buf_ops = {
>  static const struct etr_buf_operations *etr_buf_ops[] = {
>  	[ETR_MODE_FLAT] = &etr_flat_buf_ops,
>  	[ETR_MODE_ETR_SG] = &etr_sg_buf_ops,
> +#ifdef CONFIG_CORESIGHT_CATU
> +	[ETR_MODE_CATU] = &etr_catu_buf_ops,
> +#endif
>  };
>  
>  static inline int tmc_etr_mode_alloc_buf(int mode,
> @@ -953,6 +956,9 @@ static inline int tmc_etr_mode_alloc_buf(int mode,
>  	switch (mode) {
>  	case ETR_MODE_FLAT:
>  	case ETR_MODE_ETR_SG:
> +#ifdef CONFIG_CORESIGHT_CATU
> +	case ETR_MODE_CATU:
> +#endif

I really wish we could avoid doing something like this (and the above) but every
alternate solution I come up with is either uglier or on par with it...
Unless someone comes up with a bright idea we'll simply have to let it be.

While looking for a solution I noticed that tmc_etr_get_catu_device()
could be moved to coresight-catu.h.  That way we wouldn't have to include
coresight-catu.h every time coresight-tmc.h is present in a file.  

>  		rc = etr_buf_ops[mode]->alloc(drvdata, etr_buf, node, pages);
>  		if (!rc)
>  			etr_buf->ops = etr_buf_ops[mode];
> @@ -977,11 +983,15 @@ static struct etr_buf *tmc_alloc_etr_buf(struct tmc_drvdata *drvdata,
>  	int rc = -ENOMEM;
>  	bool has_etr_sg, has_iommu;
>  	bool has_flat, has_save_restore;
> +	bool has_sg, has_catu;
>  	struct etr_buf *etr_buf;
>  
>  	has_etr_sg = tmc_etr_has_cap(drvdata, TMC_ETR_SG);
>  	has_iommu = iommu_get_domain_for_dev(drvdata->dev);
>  	has_save_restore = tmc_etr_has_cap(drvdata, TMC_ETR_SAVE_RESTORE);
> +	has_catu = !!tmc_etr_get_catu_device(drvdata);
> +
> +	has_sg = has_catu || has_etr_sg;
>  
>  	/*
>  	 * We can normally use flat DMA buffer provided that the buffer
> @@ -1006,7 +1016,7 @@ static struct etr_buf *tmc_alloc_etr_buf(struct tmc_drvdata *drvdata,
>  	if ((flags & ETR_BUF_F_RESTORE_STATUS) && !has_save_restore)
>  		return ERR_PTR(-EINVAL);
>  
> -	if (!has_flat && !has_etr_sg) {
> +	if (!has_flat && !has_sg) {
>  		dev_dbg(drvdata->dev,
>  			"No available backends for ETR buffer with flags %x\n",
>  			flags);
> @@ -1032,17 +1042,22 @@ static struct etr_buf *tmc_alloc_etr_buf(struct tmc_drvdata *drvdata,
>  	 *
>  	 */
>  	if (!pages && has_flat &&
> -	    (!has_etr_sg || has_iommu || size < SZ_1M))
> +	    (!has_sg || has_iommu || size < SZ_1M))
>  		rc = tmc_etr_mode_alloc_buf(ETR_MODE_FLAT, drvdata,
>  					    etr_buf, node, pages);
>  	if (rc && has_etr_sg)
>  		rc = tmc_etr_mode_alloc_buf(ETR_MODE_ETR_SG, drvdata,
>  					    etr_buf, node, pages);
> +	if (rc && has_catu)
> +		rc = tmc_etr_mode_alloc_buf(ETR_MODE_CATU, drvdata,
> +					    etr_buf, node, pages);
>  	if (rc) {
>  		kfree(etr_buf);
>  		return ERR_PTR(rc);
>  	}
>  
> +	dev_dbg(drvdata->dev, "allocated buffer of size %ldKB in mode %d\n",
> +		(unsigned long)size >> 10, etr_buf->mode);
>  	return etr_buf;
>  }
>  
> @@ -1136,7 +1151,7 @@ static inline void tmc_etr_enable_catu(struct tmc_drvdata *drvdata)
>  	struct coresight_device *catu = tmc_etr_get_catu_device(drvdata);
>  
>  	if (catu && helper_ops(catu)->enable)
> -		helper_ops(catu)->enable(catu, NULL);
> +		helper_ops(catu)->enable(catu, drvdata->etr_buf);
>  }
>  
>  static inline void tmc_etr_disable_catu(struct tmc_drvdata *drvdata)
> @@ -1144,7 +1159,7 @@ static inline void tmc_etr_disable_catu(struct tmc_drvdata *drvdata)
>  	struct coresight_device *catu = tmc_etr_get_catu_device(drvdata);
>  
>  	if (catu && helper_ops(catu)->disable)
> -		helper_ops(catu)->disable(catu, NULL);
> +		helper_ops(catu)->disable(catu, drvdata->etr_buf);
>  }
>  
>  static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index 1bdfb38..1f6aa49 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -139,6 +139,7 @@ enum tmc_mem_intf_width {
>  enum etr_mode {
>  	ETR_MODE_FLAT,		/* Uses contiguous flat buffer */
>  	ETR_MODE_ETR_SG,	/* Uses in-built TMC ETR SG mechanism */
> +	ETR_MODE_CATU,		/* Use SG mechanism in CATU */
>  };
>  
>  /* ETR buffer should support save-restore */
> -- 
> 2.7.4
> 
