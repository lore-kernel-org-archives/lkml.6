Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24174C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E624D21736
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfBSPCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:02:09 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:37994 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727529AbfBSPCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:02:09 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 767A4532B6EDDFDD2A84;
        Tue, 19 Feb 2019 23:02:04 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Feb 2019
 23:01:58 +0800
Subject: Re: [PATCH -next] scsi: hisi_sas: remove duplicated code
To:     YueHaibing <yuehaibing@huawei.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
References: <20190219144038.26384-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a7b5b2a5-bfbb-0551-2ec5-fa666031b430@huawei.com>
Date:   Tue, 19 Feb 2019 15:01:54 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190219144038.26384-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2019 14:40, YueHaibing wrote:
> move some functions to hisi_sas_main.c,
> which can eliminate redundant code.
>

main.c is for core driver, and does not access hw directly - We have hw 
module - like hisi_sas_v1_hw.c - for this. You're moving hw accessors to 
main.c now.

I don't think that this small amount of duplicated code is a big deal 
anyway.

More below.

Thanks

> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/scsi/hisi_sas/hisi_sas.h       |  6 ++++++
>  drivers/scsi/hisi_sas/hisi_sas_main.c  | 37 +++++++++++++++++++++++++++++++++
>  drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 38 ----------------------------------
>  drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 37 ---------------------------------
>  drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 37 ---------------------------------
>  5 files changed, 43 insertions(+), 112 deletions(-)
>
> diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
> index 6c87bd3..3b00bf6 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas.h
> +++ b/drivers/scsi/hisi_sas/hisi_sas.h
> @@ -561,4 +561,10 @@ extern void hisi_sas_controller_reset_done(struct hisi_hba *hisi_hba);
>  extern void hisi_sas_debugfs_init(struct hisi_hba *hisi_hba);
>  extern void hisi_sas_debugfs_exit(struct hisi_hba *hisi_hba);
>  extern void hisi_sas_debugfs_work_handler(struct work_struct *work);
> +u32 hisi_sas_read32(struct hisi_hba *hisi_hba, u32 off);
> +u32 hisi_sas_read32_relaxed(struct hisi_hba *hisi_hba, u32 off);
> +void hisi_sas_write32(struct hisi_hba *hisi_hba, u32 off, u32 val);
> +void hisi_sas_phy_write32(struct hisi_hba *hisi_hba, int phy_no,
> +			  u32 off, u32 val);
> +u32 hisi_sas_phy_read32(struct hisi_hba *hisi_hba, int phy_no, u32 off);
>  #endif
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
> index 9232966..56e98fc 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_main.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
> @@ -28,6 +28,43 @@ static void hisi_sas_release_task(struct hisi_hba *hisi_hba,
>  				  struct domain_device *device);
>  static void hisi_sas_dev_gone(struct domain_device *device);
>
> +u32 hisi_sas_read32(struct hisi_hba *hisi_hba, u32 off)
> +{
> +	void __iomem *regs = hisi_hba->regs + off;
> +
> +	return readl(regs);
> +}
> +
> +u32 hisi_sas_read32_relaxed(struct hisi_hba *hisi_hba, u32 off)
> +{
> +	void __iomem *regs = hisi_hba->regs + off;
> +
> +	return readl_relaxed(regs);
> +}
> +
> +void hisi_sas_write32(struct hisi_hba *hisi_hba, u32 off, u32 val)
> +{
> +	void __iomem *regs = hisi_hba->regs + off;
> +
> +	writel(val, regs);
> +}
> +
> +void hisi_sas_phy_write32(struct hisi_hba *hisi_hba, int phy_no,
> +			  u32 off, u32 val)
> +{
> +	void __iomem *regs = hisi_hba->regs + (0x400 * phy_no) + off;
> +
> +	writel(val, regs);
> +}
> +
> +u32 hisi_sas_phy_read32(struct hisi_hba *hisi_hba,
> +			int phy_no, u32 off)
> +{
> +	void __iomem *regs = hisi_hba->regs + (0x400 * phy_no) + off;
> +
> +	return readl(regs);
> +}

Did you compile this driver as a module, as I don't see how this will 
link? You're not exporting the symbols.

> +
>  u8 hisi_sas_get_ata_protocol(struct host_to_dev_fis *fis, int direction)
>  {
>  	switch (fis->command) {
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
> index 2938074..41671b2 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
> @@ -416,44 +416,6 @@ enum {
>  	(HISI_SAS_PHY_MAX_INT_NR + HISI_SAS_CQ_MAX_INT_NR +\
>  	HISI_SAS_FATAL_INT_NR)
>
> -static u32 hisi_sas_read32(struct hisi_hba *hisi_hba, u32 off)
> -{
> -	void __iomem *regs = hisi_hba->regs + off;
> -
> -	return readl(regs);
> -}
> -
> -static u32 hisi_sas_read32_relaxed(struct hisi_hba *hisi_hba, u32 off)
> -{
> -	void __iomem *regs = hisi_hba->regs + off;
> -
> -	return readl_relaxed(regs);
> -}
> -
> -static void hisi_sas_write32(struct hisi_hba *hisi_hba,
> -				    u32 off, u32 val)
> -{
> -	void __iomem *regs = hisi_hba->regs + off;
> -
> -	writel(val, regs);
> -}
> -
> -static void hisi_sas_phy_write32(struct hisi_hba *hisi_hba,
> -					int phy_no, u32 off, u32 val)
> -{
> -	void __iomem *regs = hisi_hba->regs + (0x400 * phy_no) + off;
> -
> -	writel(val, regs);
> -}
> -
> -static u32 hisi_sas_phy_read32(struct hisi_hba *hisi_hba,
> -				      int phy_no, u32 off)
> -{
> -	void __iomem *regs = hisi_hba->regs + (0x400 * phy_no) + off;
> -
> -	return readl(regs);
> -}
> -
>  static void config_phy_opt_mode_v1_hw(struct hisi_hba *hisi_hba, int phy_no)
>  {
>  	u32 cfg = hisi_sas_phy_read32(hisi_hba, phy_no, PHY_CFG);
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> index e40cc6b..3827d11 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> @@ -731,43 +731,6 @@ enum {
>
>  static void link_timeout_disable_link(struct timer_list *t);
>
> -static u32 hisi_sas_read32(struct hisi_hba *hisi_hba, u32 off)
> -{
> -	void __iomem *regs = hisi_hba->regs + off;
> -
> -	return readl(regs);
> -}
> -
> -static u32 hisi_sas_read32_relaxed(struct hisi_hba *hisi_hba, u32 off)
> -{
> -	void __iomem *regs = hisi_hba->regs + off;
> -
> -	return readl_relaxed(regs);
> -}
> -
> -static void hisi_sas_write32(struct hisi_hba *hisi_hba, u32 off, u32 val)
> -{
> -	void __iomem *regs = hisi_hba->regs + off;
> -
> -	writel(val, regs);
> -}
> -
> -static void hisi_sas_phy_write32(struct hisi_hba *hisi_hba, int phy_no,
> -				 u32 off, u32 val)
> -{
> -	void __iomem *regs = hisi_hba->regs + (0x400 * phy_no) + off;
> -
> -	writel(val, regs);
> -}
> -
> -static u32 hisi_sas_phy_read32(struct hisi_hba *hisi_hba,
> -				      int phy_no, u32 off)
> -{
> -	void __iomem *regs = hisi_hba->regs + (0x400 * phy_no) + off;
> -
> -	return readl(regs);
> -}
> -
>  /* This function needs to be protected from pre-emption. */
>  static int
>  slot_index_alloc_quirk_v2_hw(struct hisi_hba *hisi_hba,
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> index 0420df2..4f30eda 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> @@ -418,43 +418,6 @@ module_param(auto_affine_msi_experimental, bool, 0444);
>  MODULE_PARM_DESC(auto_affine_msi_experimental, "Enable auto-affinity of MSI IRQs as experimental:\n"
>  		 "default is off");
>
> -static u32 hisi_sas_read32(struct hisi_hba *hisi_hba, u32 off)
> -{
> -	void __iomem *regs = hisi_hba->regs + off;
> -
> -	return readl(regs);
> -}
> -
> -static u32 hisi_sas_read32_relaxed(struct hisi_hba *hisi_hba, u32 off)
> -{
> -	void __iomem *regs = hisi_hba->regs + off;
> -
> -	return readl_relaxed(regs);
> -}
> -
> -static void hisi_sas_write32(struct hisi_hba *hisi_hba, u32 off, u32 val)
> -{
> -	void __iomem *regs = hisi_hba->regs + off;
> -
> -	writel(val, regs);
> -}
> -
> -static void hisi_sas_phy_write32(struct hisi_hba *hisi_hba, int phy_no,
> -				 u32 off, u32 val)
> -{
> -	void __iomem *regs = hisi_hba->regs + (0x400 * phy_no) + off;
> -
> -	writel(val, regs);
> -}
> -
> -static u32 hisi_sas_phy_read32(struct hisi_hba *hisi_hba,
> -				      int phy_no, u32 off)
> -{
> -	void __iomem *regs = hisi_hba->regs + (0x400 * phy_no) + off;
> -
> -	return readl(regs);
> -}
> -
>  #define hisi_sas_read32_poll_timeout(off, val, cond, delay_us,		\
>  				     timeout_us)			\
>  ({									\
>


