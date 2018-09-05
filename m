Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B99C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4722B20857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4722B20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeIEPOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:14:04 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57734 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbeIEPOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:14:04 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EJeh4eubudYf; Wed,  5 Sep 2018 12:44:06 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCBB900329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:b900:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3AFF71EC02AE;
        Wed,  5 Sep 2018 12:44:06 +0200 (CEST)
Date:   Wed, 5 Sep 2018 12:44:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com,
        mchehab@kernel.org, mikhail.jin@gmail.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v5 15/16] driver/edac: enable Hygon support to AMD64 EDAC
 driver
Message-ID: <20180905104405.GG2237@zn.tnic>
References: <cover.1535459012.git.puwen@hygon.cn>
 <47e08d8bab1cef667be3955941e7eedc23187ae1.1535459013.git.puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <47e08d8bab1cef667be3955941e7eedc23187ae1.1535459013.git.puwen@hygon.cn>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject should be:

EDAC, amd64: Add Hygon Dhyana support

On Wed, Aug 29, 2018 at 08:45:45PM +0800, Pu Wen wrote:
> To make AMD64 EDAC and MCE drivers working on Hygon platforms, add
> support for Hygon by using the code path of AMD family 0x17.
> 
> As Hygon will negotiate with AMD to make sure that only Hygon will
> use family 0x18, under this consideration try to minimize code
> modifications and share most codes with AMD.
> 
> Also Hygon PCI Device ID DF_F0/DF_F6(0x1460/0x1466) of Host bridges
> is needed for edac driver.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  drivers/edac/amd64_edac.c | 20 +++++++++++++++++++-
>  drivers/edac/amd64_edac.h |  4 ++++
>  drivers/edac/mce_amd.c    |  4 +++-
>  3 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 18aeabb..d8b4b0e 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -211,7 +211,7 @@ static int __set_scrub_rate(struct amd64_pvt *pvt, u32 new_bw, u32 min_rate)
>  
>  	scrubval = scrubrates[i].scrubval;
>  
> -	if (pvt->fam == 0x17) {
> +	if (pvt->fam == 0x17 || pvt->fam == 0x18) {
>  		__f17h_set_scrubval(pvt, scrubval);
>  	} else if (pvt->fam == 0x15 && pvt->model == 0x60) {
>  		f15h_select_dct(pvt, 0);
> @@ -264,6 +264,7 @@ static int get_scrub_rate(struct mem_ctl_info *mci)
>  		break;
>  
>  	case 0x17:
> +	case 0x18:
>  		amd64_read_pci_cfg(pvt->F6, F17H_SCR_BASE_ADDR, &scrubval);
>  		if (scrubval & BIT(0)) {
>  			amd64_read_pci_cfg(pvt->F6, F17H_SCR_LIMIT_ADDR, &scrubval);
> @@ -1044,6 +1045,7 @@ static void determine_memory_type(struct amd64_pvt *pvt)
>  		goto ddr3;
>  
>  	case 0x17:
> +	case 0x18:
>  		if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(5))
>  			pvt->dram_type = MEM_LRDDR4;
>  		else if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(4))
> @@ -2200,6 +2202,16 @@ static struct amd64_family_type family_types[] = {
>  			.dbam_to_cs		= f17_base_addr_to_cs_size,
>  		}
>  	},
> +	[HYGON_F18_CPUS] = {
> +		/* Hygon F18h uses the same AMD F17h support */
> +		.ctl_name = "Hygon_F18h",
> +		.f0_id = PCI_DEVICE_ID_HYGON_18H_DF_F0,
> +		.f6_id = PCI_DEVICE_ID_HYGON_18H_DF_F6,
> +		.ops = {
> +			.early_channel_count	= f17_early_channel_count,
> +			.dbam_to_cs		= f17_base_addr_to_cs_size,
> +		}
> +	},
>  };
>  
>  /*
> @@ -3192,6 +3204,11 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
>  		pvt->ops	= &family_types[F17_CPUS].ops;
>  		break;
>  
> +	case 0x18:
> +		fam_type	= &family_types[HYGON_F18_CPUS];
> +		pvt->ops	= &family_types[HYGON_F18_CPUS].ops;
> +		break;
> +

You can use the F17_CPUS array element here and overwrite the ->ctl_name
string only. No need to define [HYGON_F18_CPUS] above... yet.

>  	default:
>  		amd64_err("Unsupported family!\n");
>  		return NULL;
> @@ -3428,6 +3445,7 @@ static const struct x86_cpu_id amd64_cpuids[] = {
>  	{ X86_VENDOR_AMD, 0x15, X86_MODEL_ANY,	X86_FEATURE_ANY, 0 },
>  	{ X86_VENDOR_AMD, 0x16, X86_MODEL_ANY,	X86_FEATURE_ANY, 0 },
>  	{ X86_VENDOR_AMD, 0x17, X86_MODEL_ANY,	X86_FEATURE_ANY, 0 },
> +	{ X86_VENDOR_HYGON, 0x18, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(x86cpu, amd64_cpuids);
> diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
> index 1d4b74e..6e5f609 100644
> --- a/drivers/edac/amd64_edac.h
> +++ b/drivers/edac/amd64_edac.h
> @@ -116,6 +116,9 @@
>  #define PCI_DEVICE_ID_AMD_17H_DF_F0	0x1460
>  #define PCI_DEVICE_ID_AMD_17H_DF_F6	0x1466
>  
> +#define PCI_DEVICE_ID_HYGON_18H_DF_F0	0x1460
> +#define PCI_DEVICE_ID_HYGON_18H_DF_F6	0x1466

As in the previous patch - use the AMD defines.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
