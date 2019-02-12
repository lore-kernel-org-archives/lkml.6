Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241A6C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09C620821
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfBLJqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:46:24 -0500
Received: from mga18.intel.com ([134.134.136.126]:50240 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728059AbfBLJqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:46:24 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 01:46:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,361,1544515200"; 
   d="scan'208";a="142713593"
Received: from genxfsim-desktop.iind.intel.com (HELO genxfsim-desktop) ([10.223.26.105])
  by fmsmga002.fm.intel.com with ESMTP; 12 Feb 2019 01:46:20 -0800
Date:   Tue, 12 Feb 2019 15:13:19 +0530
From:   Anshuman Gupta <anshuman.gupta@intel.com>
To:     Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Cc:     platform-driver-x86@vger.kernel.org, dvhart@infradead.org,
        andy@infradead.org, linux-kernel@vger.kernel.org,
        "David E. Box" <david.e.box@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 08/10] platform/x86: intel_pmc_core: Add ICL platform
 support
Message-ID: <20190212094318.GA8062@genxfsim-desktop>
References: <20190201073234.13280-1-rajneesh.bhardwaj@linux.intel.com>
 <20190201073234.13280-9-rajneesh.bhardwaj@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201073234.13280-9-rajneesh.bhardwaj@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 01:02:32PM +0530, Rajneesh Bhardwaj wrote:
> Icelake can resue most of the CNL PCH IPs as they are mostly similar.
> This patch enables the PMC Core driver for ICL family.
> 
> It also addresses few other minor issues like upper case conversions and
> some tab alignments.
> 
> Cc: "David E. Box" <david.e.box@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
  Acked-and-tested-by: <anshuman.gupta@intel.com> 
> ---
>  drivers/platform/x86/intel_pmc_core.c | 59 +++++++++++++++++++++------
>  drivers/platform/x86/intel_pmc_core.h |  4 ++
>  2 files changed, 50 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index d3752d75075b..400946b7a3b5 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -166,25 +166,26 @@ static const struct pmc_bit_map cnp_pfear_map[] = {
>  	{"SDX",                 BIT(4)},
>  	{"SPE",                 BIT(5)},
>  	{"Fuse",                BIT(6)},
> -	{"Res_23",              BIT(7)},
> +	/* Reserved for Cannonlake but valid for Icelake */
> +	{"SBR8",		BIT(7)},
>  
>  	{"CSME_FSC",            BIT(0)},
>  	{"USB3_OTG",            BIT(1)},
>  	{"EXI",                 BIT(2)},
>  	{"CSE",                 BIT(3)},
> -	{"csme_kvm",            BIT(4)},
> -	{"csme_pmt",            BIT(5)},
> -	{"csme_clink",          BIT(6)},
> -	{"csme_ptio",           BIT(7)},
> -
> -	{"csme_usbr",           BIT(0)},
> -	{"csme_susram",         BIT(1)},
> -	{"csme_smt1",           BIT(2)},
> +	{"CSME_KVM",            BIT(4)},
> +	{"CSME_PMT",            BIT(5)},
> +	{"CSME_CLINK",          BIT(6)},
> +	{"CSME_PTIO",           BIT(7)},
> +
> +	{"CSME_USBR",           BIT(0)},
> +	{"CSME_SUSRAM",         BIT(1)},
> +	{"CSME_SMT1",           BIT(2)},
>  	{"CSME_SMT4",           BIT(3)},
> -	{"csme_sms2",           BIT(4)},
> -	{"csme_sms1",           BIT(5)},
> -	{"csme_rtc",            BIT(6)},
> -	{"csme_psf",            BIT(7)},
> +	{"CSME_SMS2",           BIT(4)},
> +	{"CSME_SMS1",           BIT(5)},
> +	{"CSME_RTC",            BIT(6)},
> +	{"CSME_PSF",            BIT(7)},
>  
>  	{"SBR0",                BIT(0)},
>  	{"SBR1",                BIT(1)},
> @@ -209,6 +210,20 @@ static const struct pmc_bit_map cnp_pfear_map[] = {
>  	{"HDA_PGD4",            BIT(2)},
>  	{"HDA_PGD5",            BIT(3)},
>  	{"HDA_PGD6",            BIT(4)},
> +	/* Reserved for Cannonlake but valid for Icelake */
> +	{"PSF6",		BIT(5)},
> +	{"PSF7",		BIT(6)},
> +	{"PSF8",		BIT(7)},
> +
> +	/* Icelake generation onwards only */
> +	{"RES_65",		BIT(0)},
> +	{"RES_66",		BIT(1)},
> +	{"RES_67",		BIT(2)},
> +	{"TAM",			BIT(3)},
> +	{"GBETSN",		BIT(4)},
> +	{"TBTLSX",		BIT(5)},
> +	{"RES_71",		BIT(6)},
> +	{"RES_72",		BIT(7)},
>  	{}
>  };
>  
> @@ -290,6 +305,8 @@ static const struct pmc_bit_map cnp_ltr_show_map[] = {
>  	{"ISH",			CNP_PMC_LTR_ISH},
>  	{"UFSX2",		CNP_PMC_LTR_UFSX2},
>  	{"EMMC",		CNP_PMC_LTR_EMMC},
> +	/* Reserved for Cannonlake but valid for Icelake */
> +	{"WIGIG",		ICL_PMC_LTR_WIGIG},
>  	/* Below two cannot be used for LTR_IGNORE */
>  	{"CURRENT_PLATFORM",	CNP_PMC_LTR_CUR_PLT},
>  	{"AGGREGATED_SYSTEM",	CNP_PMC_LTR_CUR_ASLT},
> @@ -311,6 +328,21 @@ static const struct pmc_reg_map cnp_reg_map = {
>  	.ltr_ignore_max = CNP_NUM_IP_IGN_ALLOWED,
>  };
>  
> +static const struct pmc_reg_map icl_reg_map = {
> +	.pfear_sts = cnp_pfear_map,
> +	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
> +	.slps0_dbg_maps = cnp_slps0_dbg_maps,
> +	.ltr_show_sts = cnp_ltr_show_map,
> +	.slps0_dbg_offset = CNP_PMC_SLPS0_DBG_OFFSET,
> +	.ltr_ignore_offset = CNP_PMC_LTR_IGNORE_OFFSET,
> +	.regmap_length = CNP_PMC_MMIO_REG_LEN,
> +	.ppfear0_offset = CNP_PMC_HOST_PPFEAR0A,
> +	.ppfear_buckets = ICL_PPFEAR_NUM_ENTRIES,
> +	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
> +	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
> +	.ltr_ignore_max = ICL_NUM_IP_IGN_ALLOWED,
> +};
> +
>  static inline u8 pmc_core_reg_read_byte(struct pmc_dev *pmcdev, int offset)
>  {
>  	return readb(pmcdev->regbase + offset);
> @@ -740,6 +772,7 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
>  	INTEL_CPU_FAM6(KABYLAKE_MOBILE, spt_reg_map),
>  	INTEL_CPU_FAM6(KABYLAKE_DESKTOP, spt_reg_map),
>  	INTEL_CPU_FAM6(CANNONLAKE_MOBILE, cnp_reg_map),
> +	INTEL_CPU_FAM6(ICELAKE_MOBILE, icl_reg_map),
>  	{}
>  };
>  
> diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
> index 0680ca397b57..78dd4229489d 100644
> --- a/drivers/platform/x86/intel_pmc_core.h
> +++ b/drivers/platform/x86/intel_pmc_core.h
> @@ -178,6 +178,10 @@ enum ppfear_regs {
>  #define LTR_REQ_SNOOP				BIT(15)
>  #define LTR_REQ_NONSNOOP			BIT(31)
>  
> +#define ICL_PPFEAR_NUM_ENTRIES			9
> +#define ICL_NUM_IP_IGN_ALLOWED			20
> +#define ICL_PMC_LTR_WIGIG			0x1BFC
> +
>  struct pmc_bit_map {
>  	const char *name;
>  	u32 bit_mask;
> -- 
> 2.17.1
> 

-- 
