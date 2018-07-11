Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C24C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E36208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E36208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732449AbeGKK4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:56:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:60454 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbeGKK4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:56:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2018 03:52:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,338,1526367600"; 
   d="scan'208";a="215118828"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by orsmga004.jf.intel.com with ESMTP; 11 Jul 2018 03:52:23 -0700
Subject: Re: [PATCH v1 4/9] scsi: ufs: add option to change default UFS power
 management level
To:     Asutosh Das <asutoshd@codeaurora.org>, subhashj@codeaurora.org,
        cang@codeaurora.org, vivek.gautam@codeaurora.org,
        rnayak@codeaurora.org, vinholikatti@gmail.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Malaterre <malat@debian.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1530880006.git.asutoshd@codeaurora.org>
 <ff2b648007a400c60ba804a0c5cab0166bd268e7.1530880006.git.asutoshd@codeaurora.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <0673f807-bc3c-e401-ae12-07bfafb55bf7@intel.com>
Date:   Wed, 11 Jul 2018 13:50:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <ff2b648007a400c60ba804a0c5cab0166bd268e7.1530880006.git.asutoshd@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/18 15:30, Asutosh Das wrote:
> From: Subhash Jadavani <subhashj@codeaurora.org>
> 
> UFS device and link can be put in multiple different low power modes hence
> UFS driver supports multiple different low power modes. By default UFS
> driver selects the default (optimal) low power mode (which gives moderate
> power savings and have relatively less enter and exit latencies) but
> we might have to tune this default power mode for different chipset
> platforms to meet the low power requirements/goals. Hence this patch
> adds option to change default UFS low power mode (level).
> 
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> Signed-off-by: Can Guo <cang@codeaurora.org>
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> ---
>  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      | 11 ++++++++
>  drivers/scsi/ufs/ufshcd-pltfrm.c                   | 14 +++++++++++
>  drivers/scsi/ufs/ufshcd.c                          | 29 +++++++++++++++-------
>  drivers/scsi/ufs/ufshcd.h                          |  4 +--
>  4 files changed, 47 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> index c39dfef..f564d9a 100644
> --- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> +++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> @@ -38,6 +38,15 @@ Optional properties:
>  			  defined or a value in the array is "0" then it is assumed
>  			  that the frequency is set by the parent clock or a
>  			  fixed rate clock source.
> +- rpm-level		: UFS Runtime power management level. Following PM levels are supported:
> +			  0 - Both UFS device and Link in active state (Highest power consumption)
> +			  1 - UFS device in active state but Link in Hibern8 state
> +			  2 - UFS device in Sleep state but Link in active state
> +			  3 - UFS device in Sleep state and Link in hibern8 state (default PM level)
> +			  4 - UFS device in Power-down state and Link in Hibern8 state
> +			  5 - UFS device in Power-down state and Link in OFF state (Lowest power consumption)
> +- spm-level		: UFS System power management level. Allowed PM levels are same as rpm-level.
> +
>  -lanes-per-direction	: number of lanes available per direction - either 1 or 2.
>  			  Note that it is assume same number of lanes is used both
>  			  directions at once. If not specified, default is 2 lanes per direction.
> @@ -66,4 +75,6 @@ Example:
>  		freq-table-hz = <100000000 200000000>, <0 0>, <0 0>;
>  		phys = <&ufsphy1>;
>  		phy-names = "ufsphy";
> +		rpm-level = <3>;
> +		spm-level = <5>;
>  	};
> diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
> index e82bde0..7dba799 100644
> --- a/drivers/scsi/ufs/ufshcd-pltfrm.c
> +++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
> @@ -221,6 +221,19 @@ static int ufshcd_parse_regulator_info(struct ufs_hba *hba)
>  	return err;
>  }
>  
> +static void ufshcd_parse_pm_levels(struct ufs_hba *hba)
> +{
> +	struct device *dev = hba->dev;
> +	struct device_node *np = dev->of_node;
> +
> +	if (np) {
> +		if (of_property_read_u32(np, "rpm-level", &hba->rpm_lvl))
> +			hba->rpm_lvl = -1;
> +		if (of_property_read_u32(np, "spm-level", &hba->spm_lvl))
> +			hba->spm_lvl = -1;

These are generically useful to all UFSHC drivers, so they should be
device_property_read_u32() and they should be read for all drivers not just
pltfrm i.e. move this code into ufshcd.c

> +	}
> +}
> +
>  #ifdef CONFIG_PM
>  /**
>   * ufshcd_pltfrm_suspend - suspend power management function
> @@ -340,6 +353,7 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
>  		goto dealloc_host;
>  	}
>  
> +	ufshcd_parse_pm_levels(hba);
>  	pm_runtime_set_active(&pdev->dev);
>  	pm_runtime_enable(&pdev->dev);
>  
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index b03f3ea..e950204 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -192,6 +192,14 @@ struct ufs_pm_lvl_states ufs_pm_lvl_states[] = {
>  	return UFS_PM_LVL_0;
>  }
>  
> +static inline bool ufshcd_is_valid_pm_lvl(int lvl)
> +{
> +	if (lvl >= 0 && lvl < ARRAY_SIZE(ufs_pm_lvl_states))
> +		return true;
> +	else
> +		return false;
> +}
> +
>  static struct ufs_dev_fix ufs_fixups[] = {
>  	/* UFS cards deviations table */
>  	UFS_FIX(UFS_VENDOR_SAMSUNG, UFS_ANY_MODEL,
> @@ -8051,16 +8059,19 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
>  	}
>  
>  	/*
> -	 * Set the default power management level for runtime and system PM.
> -	 * Default power saving mode is to keep UFS link in Hibern8 state
> -	 * and UFS device in sleep state.
> +	 * If rpm_lvl and and spm_lvl are not already set to valid levels,
> +	 * set the default power management level for UFS runtime and system
> +	 * suspend. Default power saving mode selected is keeping UFS link in
> +	 * Hibern8 state and UFS device in sleep state.
>  	 */
> -	hba->rpm_lvl = ufs_get_desired_pm_lvl_for_dev_link_state(
> -						UFS_SLEEP_PWR_MODE,
> -						UIC_LINK_HIBERN8_STATE);
> -	hba->spm_lvl = ufs_get_desired_pm_lvl_for_dev_link_state(
> -						UFS_SLEEP_PWR_MODE,
> -						UIC_LINK_HIBERN8_STATE);
> +	if (!ufshcd_is_valid_pm_lvl(hba->rpm_lvl))
> +		hba->rpm_lvl = ufs_get_desired_pm_lvl_for_dev_link_state(
> +							UFS_SLEEP_PWR_MODE,
> +							UIC_LINK_HIBERN8_STATE);
> +	if (!ufshcd_is_valid_pm_lvl(hba->spm_lvl))
> +		hba->spm_lvl = ufs_get_desired_pm_lvl_for_dev_link_state(
> +							UFS_SLEEP_PWR_MODE,
> +							UIC_LINK_HIBERN8_STATE);
>  
>  	/* Set the default auto-hiberate idle timer value to 150 ms */
>  	if (hba->capabilities & MASK_AUTO_HIBERN8_SUPPORT) {
> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> index e996a08..a2e1d5c 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -526,9 +526,9 @@ struct ufs_hba {
>  	enum ufs_dev_pwr_mode curr_dev_pwr_mode;
>  	enum uic_link_state uic_link_state;
>  	/* Desired UFS power management level during runtime PM */
> -	enum ufs_pm_level rpm_lvl;
> +	int rpm_lvl;
>  	/* Desired UFS power management level during system PM */
> -	enum ufs_pm_level spm_lvl;
> +	int spm_lvl;
>  	struct device_attribute rpm_lvl_attr;
>  	struct device_attribute spm_lvl_attr;
>  	int pm_op_in_progress;
> 

