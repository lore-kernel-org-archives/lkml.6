Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6324BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6466E206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZMoPGMfn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6466E206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbeKTU1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:27:43 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41508 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbeKTU1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:27:43 -0500
Received: from zn.tnic (p200300EC2BCDE000F95221CD056129B8.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:e000:f952:21cd:561:29b8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5A92C1EC06A7;
        Tue, 20 Nov 2018 10:59:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1542707965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NPz1f1mOocB+sE/VabMKl3FM4SDVu0AsyAPUNGCaKGg=;
        b=ZMoPGMfnVzkciLlEC/DadFS3mHaVyub6h8GzqD8Guuhb3iW7n08faloo0S9ukw8mtsrBWe
        vQzPNSKp7uOr7zj2EGwDLk+kiQTQfCiatavsnMx5aPEs1cJ73mYP77kqex8wtfIjjIoUnY
        kK673XHGOONfHffoq4E8L0Gfor1p0NY=
Date:   Tue, 20 Nov 2018 10:59:18 +0100
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
Subject: Re: [PATCH v8 06/13] arch/resctrl: Initialize the resource functions
 that are different
Message-ID: <20181120095918.GD2527@zn.tnic>
References: <20181116205407.10457-1-babu.moger@amd.com>
 <20181116205407.10457-7-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181116205407.10457-7-babu.moger@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 08:54:32PM +0000, Moger, Babu wrote:
> Initialize the resource functions that are different between the
> vendors. Some features are initialized differently between the vendors.
> Add _intel suffix to Intel specific functions.
> 
> For example, MBA feature varies significantly between Intel and AMD.
> Separate the initialization of these resource functions. That way we
> can easily add AMD's functions later.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl.c             | 34 +++++++++++++++++++----
>  arch/x86/kernel/cpu/resctrl.h             |  8 ++++--
>  arch/x86/kernel/cpu/resctrl_ctrlmondata.c |  4 +--
>  3 files changed, 37 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl.c b/arch/x86/kernel/cpu/resctrl.c
> index 18c8222f326c..eeb7e0e4883e 100644
> --- a/arch/x86/kernel/cpu/resctrl.c
> +++ b/arch/x86/kernel/cpu/resctrl.c
> @@ -57,7 +57,8 @@ int max_name_width, max_data_width;
>  bool rdt_alloc_capable;
>  
>  static void
> -mba_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r);
> +mba_wrmsr_intel(struct rdt_domain *d, struct msr_param *m,
> +		struct rdt_resource *r);
>  static void
>  cat_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r);
>  
> @@ -171,10 +172,7 @@ struct rdt_resource rdt_resources_all[] = {
>  		.rid			= RDT_RESOURCE_MBA,
>  		.name			= "MB",
>  		.domains		= domain_init(RDT_RESOURCE_MBA),
> -		.msr_base		= IA32_MBA_THRTL_BASE,
> -		.msr_update		= mba_wrmsr,
>  		.cache_level		= 3,
> -		.parse_ctrlval		= parse_bw,
>  		.format_str		= "%d=%*u",
>  		.fflags			= RFTYPE_RES_MB,
>  	},
> @@ -356,7 +354,8 @@ u32 delay_bw_map(unsigned long bw, struct rdt_resource *r)
>  }
>  
>  static void
> -mba_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
> +mba_wrmsr_intel(struct rdt_domain *d, struct msr_param *m,
> +		struct rdt_resource *r)
>  {
>  	unsigned int i;
>  
> @@ -873,6 +872,25 @@ static __init bool get_rdt_resources(void)
>  	return (rdt_mon_capable || rdt_alloc_capable);
>  }
>  
> +static __init void rdt_init_res_defs_intel(void)
> +{
> +	struct rdt_resource *r;
> +
> +	for_each_rdt_resource(r) {
> +		if (r->rid == RDT_RESOURCE_MBA) {
> +			r->msr_base = IA32_MBA_THRTL_BASE;
> +			r->msr_update = mba_wrmsr_intel;
> +			r->parse_ctrlval = parse_bw_intel;
> +		}
> +	}
> +}
> +
> +static __init void rdt_init_res_defs(void)
> +{
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
> +		rdt_init_res_defs_intel();
> +}

So I'm wondering: instead of having mba_wrmsr_intel() and
mba_wrmsr_amd() and adding those per-vendor initialization functions,
why don't you push down the vendor differentiation into mba_wrmsr()?

Then in that function you do

	if (vendor == X86_VENDOR_INTEL)
		__mba_wrmsr_intel();
	else if (vendor == X86_VENDOR_AMD)
		__mba_wrmsr_amd();

and so on and then you don't have to do any of that initialization dance
here and the struct rdt_resource assignment for the MBA will remain
nicely similar to the other ones...

Hmmm?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
