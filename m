Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751582AbeFDVWV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 17:22:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751213AbeFDVWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 17:22:19 -0400
Date: Mon, 4 Jun 2018 14:22:18 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>
Cc: "Vinayak Holikatti <vinholikatti@gmail.com>; \"James E.J. Bottomley\"
        <jejb@linux.vnet.ibm.com>; \"Martin K. Petersen\""
        <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org,
        "linux-scsi@vger.kernel.org; Manjunath M Bettegowda
        <manjumb@synopsys.com>; Prabu Thangamuthu <prabut@synopsys.com>; Tejas
        Joglekar <joglekar@synopsys.com>; Joao Pinto"
        <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH 5/5] scsi: ufs: Add hooks in UFS HC driver for crypto
 support
Message-ID: <20180604212218.GB72668@jaegeuk-macbookpro.roam.corp.google.com>
References: <51bd1b68-1ab2-af04-99f4-07e08852c401@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51bd1b68-1ab2-af04-99f4-07e08852c401@synopsys.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ladvine,

On 05/28, Ladvine D Almeida wrote:
> 
> This patch adds the crypto support in the UFS Host Controller
> driver like allocation of the crypto resources, registration of
> crypto algorithm, preparing UTRD requests for inline encryption job,
> freeing the resources during exit stage.
> The crypto support is enabled in the UFS Host Controller driver only if the
> crypto capability is detected in the hardware during the init stage.
> The changes done for the UFS HC crypto support are guarded with
> CONFIG_SCSI_UFSHCD_INLINE_ENCRYPTION.
> 
> Signed-off-by: Ladvine D Almeida <ladvine@synopsys.com>
> ---
>  drivers/scsi/ufs/ufshcd.c | 63 ++++++++++++++++++++++++++++++++++++++++++-----
>  drivers/scsi/ufs/ufshcd.h | 29 ++++++++++++++++++++++
>  2 files changed, 86 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 00e7905..7bac5a3 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -1839,6 +1839,10 @@ static inline void ufshcd_hba_capabilities(struct ufs_hba *hba)
>  	hba->nutrs = (hba->capabilities & MASK_TRANSFER_REQUESTS_SLOTS) + 1;
>  	hba->nutmrs =
>  	((hba->capabilities & MASK_TASK_MANAGEMENT_REQUEST_SLOTS) >> 16) + 1;
> +#ifdef CONFIG_SCSI_UFSHCD_INLINE_ENCRYPTION
> +	/* read crypto capabilities of host controller */
> +	ufshcd_read_crypto_capabilities(hba);
> +#endif
>  }
>  
>  /**
> @@ -2076,7 +2080,7 @@ static void ufshcd_prepare_req_desc_hdr(struct ufshcd_lrb *lrbp,
>  {
>  	struct utp_transfer_req_desc *req_desc = lrbp->utr_descriptor_ptr;
>  	u32 data_direction;
> -	u32 dword_0;
> +	u32 dword_0 = 0;
>  
>  	if (cmd_dir == DMA_FROM_DEVICE) {
>  		data_direction = UTP_DEVICE_TO_HOST;
> @@ -2094,10 +2098,22 @@ static void ufshcd_prepare_req_desc_hdr(struct ufshcd_lrb *lrbp,
>  	if (lrbp->intr_cmd)
>  		dword_0 |= UTP_REQ_DESC_INT_CMD;
>  
> +#ifdef CONFIG_SCSI_UFSHCD_INLINE_ENCRYPTION
>  	/* Transfer request descriptor header fields */
> -	req_desc->header.dword_0 = cpu_to_le32(dword_0);
> -	/* dword_1 is reserved, hence it is set to 0 */
> +	if (lrbp->ccfg_idx >= 0) {
> +		dword_0 |= (UTP_REQ_CRYPT_EN_CMD | (lrbp->ccfg_idx & 0xff));
> +		req_desc->header.dword_1 = lrbp->lba & 0xffffffff;
> +		req_desc->header.dword_3 = (lrbp->lba >> 32) & 0xffffffff;

Please assign a logical value to DUN. (e.g., inode_number << 32 | page->offset)
Otherwise upper layers like F2FS won't be able to move any block from one LBA to
another LBA without the key. We couldn't do upstream tho, it'd be doable to add
one DUN value in bio structure and manage its sequentiality by disallowing bio
merges, which looks like requiring to modify ufshcd_prepare_for_crypto().

Thanks,

> +	} else {
> +		req_desc->header.dword_1 = 0;
> +		req_desc->header.dword_3 = 0;
> +	}
> +#else
>  	req_desc->header.dword_1 = 0;
> +	req_desc->header.dword_3 = 0;
> +#endif
> +	req_desc->header.dword_0 = cpu_to_le32(dword_0);
> +
>  	/*
>  	 * assigning invalid value for command status. Controller
>  	 * updates OCS on command completion, with the command
> @@ -2105,8 +2121,6 @@ static void ufshcd_prepare_req_desc_hdr(struct ufshcd_lrb *lrbp,
>  	 */
>  	req_desc->header.dword_2 =
>  		cpu_to_le32(OCS_INVALID_COMMAND_STATUS);
> -	/* dword_3 is reserved, hence it is set to 0 */
> -	req_desc->header.dword_3 = 0;
>  
>  	req_desc->prd_table_length = 0;
>  }
> @@ -2355,6 +2369,12 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
>  	lrbp->lun = ufshcd_scsi_to_upiu_lun(cmd->device->lun);
>  	lrbp->intr_cmd = !ufshcd_is_intr_aggr_allowed(hba) ? true : false;
>  	lrbp->req_abort_skip = false;
> +#ifdef CONFIG_SCSI_UFSHCD_INLINE_ENCRYPTION
> +	lrbp->lba = 0;
> +	lrbp->ccfg_idx = -1;
> +	/* prepare block for crypto */
> +	ufshcd_prepare_for_crypto(hba, lrbp);
> +#endif
>  
>  	ufshcd_comp_scsi_upiu(hba, lrbp);
>  
> @@ -3215,6 +3235,7 @@ static inline int ufshcd_read_unit_desc_param(struct ufs_hba *hba,
>  static int ufshcd_memory_alloc(struct ufs_hba *hba)
>  {
>  	size_t utmrdl_size, utrdl_size, ucdl_size;
> +	int ret = 0;
>  
>  	/* Allocate memory for UTP command descriptors */
>  	ucdl_size = (sizeof(struct utp_transfer_cmd_desc) * hba->nutrs);
> @@ -3233,6 +3254,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
>  	    WARN_ON(hba->ucdl_dma_addr & (PAGE_SIZE - 1))) {
>  		dev_err(hba->dev,
>  			"Command Descriptor Memory allocation failed\n");
> +		ret = -ENOMEM;
>  		goto out;
>  	}
>  
> @@ -3249,6 +3271,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
>  	    WARN_ON(hba->utrdl_dma_addr & (PAGE_SIZE - 1))) {
>  		dev_err(hba->dev,
>  			"Transfer Descriptor Memory allocation failed\n");
> +		ret = -ENOMEM;
>  		goto out;
>  	}
>  
> @@ -3265,6 +3288,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
>  	    WARN_ON(hba->utmrdl_dma_addr & (PAGE_SIZE - 1))) {
>  		dev_err(hba->dev,
>  		"Task Management Descriptor Memory allocation failed\n");
> +		ret = -ENOMEM;
>  		goto out;
>  	}
>  
> @@ -3274,11 +3298,21 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
>  				GFP_KERNEL);
>  	if (!hba->lrb) {
>  		dev_err(hba->dev, "LRB Memory allocation failed\n");
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +#ifdef CONFIG_SCSI_UFSHCD_INLINE_ENCRYPTION
> +	/* Allocate memory for crypto operations */
> +	if (ufshcd_is_encryption_supported(hba))
> +		ret = ufshcd_crypto_memory_alloc(hba);
> +	if (ret != 0) {
> +		dev_err(hba->dev, "Crypto Memory allocation failed\n");
>  		goto out;
>  	}
> +#endif
>  	return 0;
>  out:
> -	return -ENOMEM;
> +	return ret;
>  }
>  
>  /**
> @@ -4208,6 +4242,19 @@ static int ufshcd_link_startup(struct ufs_hba *hba)
>  		goto out;
>  
>  	ret = ufshcd_make_hba_operational(hba);
> +	if (ret)
> +		goto out;
> +
> +#ifdef CONFIG_SCSI_UFSHCD_INLINE_ENCRYPTION
> +	/* Enable algorithm if crypto capability is present */
> +	if (ufshcd_is_encryption_supported(hba))
> +		ret = ufshcd_enable_crypt_alg(hba);
> +	if (ret) {
> +		dev_err(hba->dev, "Crypto setup failed (%d)\n",
> +			ret);
> +		ret = 0;
> +	}
> +#endif
>  out:
>  	if (ret) {
>  		dev_err(hba->dev, "link startup failed %d\n", ret);
> @@ -7661,6 +7708,10 @@ EXPORT_SYMBOL(ufshcd_shutdown);
>   */
>  void ufshcd_remove(struct ufs_hba *hba)
>  {
> +#ifdef CONFIG_SCSI_UFSHCD_INLINE_ENCRYPTION
> +	ufshcd_disable_crypt_alg(hba);
> +	ufshcd_remove_crypto_memory(hba);
> +#endif
>  	ufs_sysfs_remove_nodes(hba->dev);
>  	scsi_remove_host(hba->host);
>  	/* disable interrupts */
> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> index 8110dcd..b1356ca 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -68,6 +68,9 @@
>  
>  #include "ufs.h"
>  #include "ufshci.h"
> +#ifdef CONFIG_SCSI_UFSHCD_INLINE_ENCRYPTION
> +	#include "ufshcd-crypto.h"
> +#endif
>  
>  #define UFSHCD "ufshcd"
>  #define UFSHCD_DRIVER_VERSION "0.2"
> @@ -168,6 +171,8 @@ struct ufs_pm_lvl_states {
>   * @issue_time_stamp: time stamp for debug purposes
>   * @compl_time_stamp: time stamp for statistics
>   * @req_abort_skip: skip request abort task flag
> + * @lba: LBA value for crypto engine
> + * @ccfg_idx: key configuration index for crypto engine
>   */
>  struct ufshcd_lrb {
>  	struct utp_transfer_req_desc *utr_descriptor_ptr;
> @@ -193,6 +198,10 @@ struct ufshcd_lrb {
>  	ktime_t compl_time_stamp;
>  
>  	bool req_abort_skip;
> +#ifdef CONFIG_SCSI_UFSHCD_INLINE_ENCRYPTION
> +	u64 lba;
> +	int ccfg_idx;
> +#endif
>  };
>  
>  /**
> @@ -499,6 +508,8 @@ struct ufs_stats {
>   * @urgent_bkops_lvl: keeps track of urgent bkops level for device
>   * @is_urgent_bkops_lvl_checked: keeps track if the urgent bkops level for
>   *  device is known or not.
> + * @cc: stores the crypto capability information.
> + * @ccxp: stores the crypto configuration information.
>   */
>  struct ufs_hba {
>  	void __iomem *mmio_base;
> @@ -683,6 +694,17 @@ struct ufs_hba {
>  
>  	struct rw_semaphore clk_scaling_lock;
>  	struct ufs_desc_size desc_size;
> +
> +#ifdef CONFIG_SCSI_UFSHCD_INLINE_ENCRYPTION
> +	/*
> +	 * Thus capability allows the host controller to perform
> +	 * inline encryption once it is configured.
> +	 */
> +#define UFSHCD_CAP_INLINE_ENCRYPTION (1 << 6)
> +
> +	struct ufshcd_ccap cc;
> +	struct ufshcd_x_crypto_cap *ccxp;
> +#endif
>  };
>  
>  /* Returns true if clocks can be gated. Otherwise false */
> @@ -717,6 +739,13 @@ return true;
>  #endif
>  }
>  
> +#ifdef CONFIG_SCSI_UFSHCD_INLINE_ENCRYPTION
> +static inline int ufshcd_is_encryption_supported(struct ufs_hba *hba)
> +{
> +	return hba->caps & UFSHCD_CAP_INLINE_ENCRYPTION;
> +}
> +#endif
> +
>  #define ufshcd_writel(hba, val, reg)	\
>  	writel((val), (hba)->mmio_base + (reg))
>  #define ufshcd_readl(hba, reg)	\
> -- 
> 2.7.4
