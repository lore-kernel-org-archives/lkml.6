Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3012C32788
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3280020671
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Il37A8jz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3280020671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbeKTWpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 17:45:06 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35636 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728884AbeKTWpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 17:45:06 -0500
Received: from zn.tnic (p200300EC2BCDE000F95221CD056129B8.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:e000:f952:21cd:561:29b8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4CDCC1EC0319;
        Tue, 20 Nov 2018 13:16:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1542716173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/Jrx/ttp5sS1tQD0xnnCTxP6crBZhK8gYc9TXach50c=;
        b=Il37A8jzlEG+w/2oF2NRQjedbqMuGWhhAWA8BCWyk+gZ/cUUgXgJeQsqGfljM8JuXTeWSe
        YG/0lYIlqOzriDQsm13cV0H0eFsb6WIaKlPGvpddnsSiySAZdFRT7hAbkII7hMYRvUeVHO
        ZZgN6QGAIPyoV8oiM630Hfvqh5+T+AM=
Date:   Tue, 20 Nov 2018 13:16:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Moger, Babu" <Babu.Moger@amd.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "qianyue.zj@alibaba-inc.com" <qianyue.zj@alibaba-inc.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jannh@google.com" <jannh@google.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "rian@alum.mit.edu" <rian@alum.mit.edu>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v8 11/13] arch/resctrl: Introduce QOS feature for AMD
Message-ID: <20181120121606.GF2527@zn.tnic>
References: <20181116205407.10457-1-babu.moger@amd.com>
 <20181116205407.10457-12-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181116205407.10457-12-babu.moger@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 08:54:43PM +0000, Moger, Babu wrote:
> Enables QOS feature on AMD.

From Documentation/process/submitting-patches.rst:

"Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behaviour."

> Following QoS sub-features are supported in AMD if the underlying
> hardware supports it.
>  - L3 Cache allocation enforcement
>  - L3 Cache occupancy monitoring
>  - L3 Code-Data Prioritization support
>  - Memory Bandwidth Enforcement(Allocation)
> 
> The specification for this feature is available at
> https://developer.amd.com/wp-content/resources/56375.pdf

I hope that URL is stable.

> There are differences in the way some of the features are implemented.
> Separate those functions and add those as vendor specific functions.
> The major difference is in MBA feature.
>  - AMD uses CPUID leaf 0x80000020 to initialize the MBA features.
>  - AMD uses direct bandwidth value instead of delay based on bandwidth
>    values.
>  - MSR register base addresses are different for MBA.
>  - Also AMD allows non-contiguous L3 cache bit masks.
> 
> Adds following functions to take care of the differences.
> rdt_get_mem_config_amd : MBA initialization function
> parse_bw_amd : Bandwidth parsing
> mba_wrmsr_amd: Writes bandwidth value
> cbm_validate_amd : L3 cache bitmask validation

This paragraph is not needed - what you do is visible in the patch
itself.

> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl.c             | 68 +++++++++++++++++++++-
>  arch/x86/kernel/cpu/resctrl.h             |  5 ++
>  arch/x86/kernel/cpu/resctrl_ctrlmondata.c | 70 +++++++++++++++++++++++
>  3 files changed, 141 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl.c b/arch/x86/kernel/cpu/resctrl.c
> index 3f26c7c114e7..0d700ab7fcf9 100644
> --- a/arch/x86/kernel/cpu/resctrl.c
> +++ b/arch/x86/kernel/cpu/resctrl.c
> @@ -61,6 +61,9 @@ mba_wrmsr_intel(struct rdt_domain *d, struct msr_param *m,
>  		struct rdt_resource *r);
>  static void
>  cat_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r);
> +static void
> +mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m,
> +	      struct rdt_resource *r);
>  
>  #define domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].domains)
>  
> @@ -280,6 +283,31 @@ static bool rdt_get_mem_config(struct rdt_resource *r)
>  	return true;
>  }
>  
> +static bool rdt_get_mem_config_amd(struct rdt_resource *r)
> +{
> +	union cpuid_0x10_3_eax eax;
> +	union cpuid_0x10_x_edx edx;
> +	u32 ebx, ecx;
> +
> +	cpuid_count(0x80000020, 1, &eax.full, &ebx, &ecx, &edx.full);
> +	r->num_closid = edx.split.cos_max + 1;
> +	r->default_ctrl = MAX_MBA_BW_AMD;
> +
> +	/* AMD does not use delay. Set delay_linear to false by default */

You don't need to write in the comment *what* you do - that's obvious.
"AMD does not use delay" is more than enough.

> +	r->membw.delay_linear = false;
> +
> +	/* FIX ME - May need to be read from MSR */

FIX ME?

> +	r->membw.min_bw = 0;
> +	r->membw.bw_gran = 1;
> +	/* Max value is 2048, Data width should be 4 in decimal */
> +	r->data_width = 4;
> +
> +	r->alloc_capable = true;
> +	r->alloc_enabled = true;
> +
> +	return true;
> +}
> +
>  static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
>  {
>  	union cpuid_0x10_1_eax eax;
> @@ -339,6 +367,16 @@ static int get_cache_id(int cpu, int level)
>  	return -1;
>  }
>  
> +static void
> +mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
> +{
> +	unsigned int i;
> +
> +	/*  Write the bw values for mba. */

That's an obvious comment. Drop it.

> +	for (i = m->low; i < m->high; i++)
> +		wrmsrl(r->msr_base + i, d->ctrl_val[i]);
> +}
> +
>  /*
>   * Map the memory b/w percentage value to delay values
>   * that can be written to QOS_MSRs.
> @@ -792,8 +830,12 @@ static bool __init rdt_cpu_has(int flag)
>  
>  static __init bool rdt_mba_config(void)
>  {
> -	if (rdt_cpu_has(X86_FEATURE_MBA))
> -		return rdt_get_mem_config(&rdt_resources_all[RDT_RESOURCE_MBA]);
> +	if (rdt_cpu_has(X86_FEATURE_MBA)) {

Save yourself an indentation level:

	if (!rdt_cpu_has(X86_FEATURE_MBA))
		return false;

	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
		...


> +			return rdt_get_mem_config(&rdt_resources_all[RDT_RESOURCE_MBA]);
> +		else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
> +			return rdt_get_mem_config_amd(&rdt_resources_all[RDT_RESOURCE_MBA]);
> +	}
>  
>  	return false;
>  }

...

> diff --git a/arch/x86/kernel/cpu/resctrl.h b/arch/x86/kernel/cpu/resctrl.h
> index 102bcffbefd7..54ba21b7de2c 100644
> --- a/arch/x86/kernel/cpu/resctrl.h
> +++ b/arch/x86/kernel/cpu/resctrl.h
> @@ -11,6 +11,7 @@
>  #define IA32_L3_CBM_BASE	0xc90
>  #define IA32_L2_CBM_BASE	0xd10
>  #define IA32_MBA_THRTL_BASE	0xd50
> +#define IA32_MBA_BW_BASE	0xc0000200

	MSR_...

>  
>  #define IA32_QM_CTR		0x0c8e
>  #define IA32_QM_EVTSEL		0x0c8d
> @@ -34,6 +35,7 @@
>  #define MAX_MBA_BW			100u
>  #define MBA_IS_LINEAR			0x4
>  #define MBA_MAX_MBPS			U32_MAX
> +#define MAX_MBA_BW_AMD			0x800
>  
>  #define RMID_VAL_ERROR			BIT_ULL(63)
>  #define RMID_VAL_UNAVAIL		BIT_ULL(62)
> @@ -448,6 +450,8 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
>  	      struct rdt_domain *d);
>  int parse_bw_intel(struct rdt_parse_data *data, struct rdt_resource *r,
>  		   struct rdt_domain *d);
> +int parse_bw_amd(struct rdt_parse_data *data, struct rdt_resource *r,
> +		 struct rdt_domain *d);
>  
>  extern struct mutex rdtgroup_mutex;
>  
> @@ -579,5 +583,6 @@ void cqm_handle_limbo(struct work_struct *work);
>  bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
>  void __check_limbo(struct rdt_domain *d, bool force_free);
>  bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r);
> +bool cbm_validate_amd(char *buf, u32 *data, struct rdt_resource *r);
>  
>  #endif /* _ASM_X86_RESCTRL_H */
> diff --git a/arch/x86/kernel/cpu/resctrl_ctrlmondata.c b/arch/x86/kernel/cpu/resctrl_ctrlmondata.c
> index 71aa1d971430..b6ceb4db9322 100644
> --- a/arch/x86/kernel/cpu/resctrl_ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl_ctrlmondata.c
> @@ -28,6 +28,52 @@
>  #include <linux/slab.h>
>  #include "resctrl.h"
>  
> +/*
> + * Check whether MBA bandwidth percentage value is correct. The value is
> + * checked against the minimum and max bandwidth values specified by the

Either write "min" and "max" or write them both out fully.

> + * hardware. The allocated bandwidth percentage is rounded to the next
> + * control step available on the hardware.
> + */
> +static bool bw_validate_amd(char *buf, unsigned long *data,
> +			    struct rdt_resource *r)
> +{
> +	unsigned long bw;
> +	int ret;
> +
> +	ret = kstrtoul(buf, 10, &bw);
> +	if (ret) {
> +		rdt_last_cmd_printf("Non-decimal digit in MB value %s\n", buf);
> +		return false;
> +	}
> +
> +	if (bw < r->membw.min_bw || bw > r->default_ctrl) {
> +		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
> +				    r->membw.min_bw, r->default_ctrl);
> +		return false;
> +	}
> +
> +	*data = roundup(bw, (unsigned long)r->membw.bw_gran);
> +	return true;
> +}
> +
> +int parse_bw_amd(struct rdt_parse_data *data, struct rdt_resource *r,
> +		 struct rdt_domain *d)
> +{
> +	unsigned long bw_val;
> +
> +	if (d->have_new_ctrl) {
> +		rdt_last_cmd_printf("duplicate domain %d\n", d->id);

Start with a capital letter: "Duplicate domain..."

And looking at the rest, some of them start with a capital letter and
some of them not. Please unify that in a separate patch.

> +		return -EINVAL;
> +	}
> +
> +	if (!bw_validate_amd(data->buf, &bw_val, r))
> +		return -EINVAL;

<---- newline here.

> +	d->new_ctrl = bw_val;
> +	d->have_new_ctrl = true;
> +
> +	return 0;
> +}
> +
>  /*
>   * Check whether MBA bandwidth percentage value is correct. The value is
>   * checked against the minimum and max bandwidth values specified by the

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
