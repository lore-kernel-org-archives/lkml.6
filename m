Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A75C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8E02083B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbfBDO1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:27:53 -0500
Received: from mga12.intel.com ([192.55.52.136]:26340 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfBDO1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:27:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 06:27:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="123802390"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 04 Feb 2019 06:27:52 -0800
Received: from [10.254.84.37] (kliang2-mobl1.ccr.corp.intel.com [10.254.84.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 8B5095800E0;
        Mon,  4 Feb 2019 06:27:51 -0800 (PST)
Subject: Re: [PATCH V6 1/5] x86/cpufeature: Add facility to check for min
 microcode revisions
To:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bp@alien8.de, peterz@infradead.org, mingo@redhat.com
Cc:     ak@linux.intel.com, eranian@google.com
References: <1548106951-4811-1-git-send-email-kan.liang@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <42b58a0f-964e-dc8e-dab7-74ce0f52d5b6@linux.intel.com>
Date:   Mon, 4 Feb 2019 09:27:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1548106951-4811-1-git-send-email-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Ping. Any comments on this series?

Thanks,
Kan

On 1/21/2019 4:42 PM, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> For bug workarounds or checks, it is useful to check for specific
> microcode revisions.
> 
> Add a new generic function to match the CPU with stepping.
> Add the other function to check the min microcode revisions for
> the matched CPU.
> A new table format is introduced to facilitate the quirk to
> fill the related information.
> 
> This does not change the existing x86_cpu_id because it's an ABI
> shared with modules, and also has quite different requirements,
> as in no wildcards, but everything has to be matched exactly.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Originally-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
> 
> Changes since V5:
> - Use proper tag
> - Rename x86_cpu_check to x86_cpu_desc, and rename its members
>    the same way as the corresponding members in struct cpuinfo_x86
>    are named.
> - Rename INTEL_CHECK_UCODE to INTEL_CPU_DESC
> - Use EXPORT_SYMBOL_GPL
> 
>   arch/x86/include/asm/cpu_device_id.h | 28 ++++++++++++++++++++++++++++
>   arch/x86/kernel/cpu/match.c          | 31 +++++++++++++++++++++++++++++++
>   2 files changed, 59 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
> index baeba05..f35b303 100644
> --- a/arch/x86/include/asm/cpu_device_id.h
> +++ b/arch/x86/include/asm/cpu_device_id.h
> @@ -11,4 +11,32 @@
>   
>   extern const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match);
>   
> +/*
> + * Match specific microcode revisions.
> + *
> + * vendor/family/model/stepping must be all set.
> + *
> + * only checks against the boot CPU.  When mixed-stepping configs are
> + * valid for a CPU model, add a quirk for every valid stepping and
> + * do the fine-tuning in the quirk handler.
> + */
> +
> +struct x86_cpu_desc {
> +	__u8	x86;		/* CPU family */
> +	__u8	x86_vendor;	/* CPU vendor */
> +	__u8	x86_model;
> +	__u8	x86_stepping;
> +	__u32	x86_microcode_rev;
> +};
> +
> +#define INTEL_CPU_DESC(mod, step, rev) {			\
> +	.x86 = 6,						\
> +	.x86_vendor = X86_VENDOR_INTEL,				\
> +	.x86_model = mod,					\
> +	.x86_stepping = step,					\
> +	.x86_microcode_rev = rev,				\
> +}
> +
> +extern bool x86_cpu_has_min_microcode_rev(const struct x86_cpu_desc *table);
> +
>   #endif
> diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
> index 3fed388..4f4bf89 100644
> --- a/arch/x86/kernel/cpu/match.c
> +++ b/arch/x86/kernel/cpu/match.c
> @@ -48,3 +48,34 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
>   	return NULL;
>   }
>   EXPORT_SYMBOL(x86_match_cpu);
> +
> +static const struct x86_cpu_desc *
> +x86_match_cpu_with_stepping(const struct x86_cpu_desc *match)
> +{
> +	struct cpuinfo_x86 *c = &boot_cpu_data;
> +	const struct x86_cpu_desc *m;
> +
> +	for (m = match; m->x86 | m->x86_model; m++) {
> +		if (c->x86_vendor != m->x86_vendor)
> +			continue;
> +		if (c->x86 != m->x86)
> +			continue;
> +		if (c->x86_model != m->x86_model)
> +			continue;
> +		if (c->x86_stepping != m->x86_stepping)
> +			continue;
> +		return m;
> +	}
> +	return NULL;
> +}
> +
> +bool x86_cpu_has_min_microcode_rev(const struct x86_cpu_desc *table)
> +{
> +	const struct x86_cpu_desc *res = x86_match_cpu_with_stepping(table);
> +
> +	if (!res || res->x86_microcode_rev > boot_cpu_data.microcode)
> +		return false;
> +
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(x86_cpu_has_min_microcode_rev);
> 
