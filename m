Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81356C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D592083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D592083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbeJCEvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:51:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:29371 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbeJCEvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:51:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2018 15:06:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,333,1534834800"; 
   d="scan'208";a="79350977"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.130]) ([10.24.14.130])
  by orsmga006.jf.intel.com with ESMTP; 02 Oct 2018 15:06:15 -0700
Subject: Re: [RFC PATCH 06/10] arch/x86: Initialize the resource functions
 that are different
To:     "Moger, Babu" <Babu.Moger@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "vikas.shivappa@linux.intel.com" <vikas.shivappa@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "bp@suse.de" <bp@suse.de>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "luto@kernel.org" <luto@kernel.org>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "jannh@google.com" <jannh@google.com>,
        "dima@arista.com" <dima@arista.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180924191841.29111-1-babu.moger@amd.com>
 <20180924191841.29111-7-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <d35e76c8-a79a-c574-33ff-20db12b8219a@intel.com>
Date:   Tue, 2 Oct 2018 15:06:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180924191841.29111-7-babu.moger@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 9/24/2018 12:19 PM, Moger, Babu wrote:
> Initialize the resource functions that are different between the
> vendors. Some features are initialized differently between the vendors.
> 
> For example, MBA feature varies significantly between Intel and AMD.
> Separate the initialization of these resource functions. That way we
> can easily add AMD's functions later.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/rdt.c | 28 +++++++++++++++++++++++++---
>  arch/x86/kernel/cpu/rdt.h |  4 ++++
>  2 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/rdt.c b/arch/x86/kernel/cpu/rdt.c
> index 736715b81fd8..6dec45bf81d6 100644
> --- a/arch/x86/kernel/cpu/rdt.c
> +++ b/arch/x86/kernel/cpu/rdt.c
> @@ -174,10 +174,7 @@ struct rdt_resource rdt_resources_all[] = {
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
> @@ -865,6 +862,25 @@ static __init void rdt_check_mba(void)
>  		rdt_get_mem_config(&rdt_resources_all[RDT_RESOURCE_MBA]);
>  }
>  
> +static __init void rdt_init_res_defs_intel(void)
> +{
> +	struct rdt_resource *r;
> +
> +	for_each_rdt_resource(r) {
> +		if (r->rid == RDT_RESOURCE_MBA) {
> +			r->msr_base = IA32_MBA_THRTL_BASE;
> +			r->msr_update = mba_wrmsr;
> +			r->parse_ctrlval = parse_bw;
> +		}
> +	}
> +}

Patch 10 introduces parse_bw_amd and mba_wrmsr_amd as you prepare us for
in the commit message. I think it would reduce confusion if these
functions, mba_wrmsr and parse_bw, also follow this pattern to contain
the vendor name. So, mba_wrmsr -> mba_wrmsr_intel, parse_bw ->
parse_bw_intel.

> +
> +static __init void rdt_init_res_defs(void)
> +{
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
> +		rdt_init_res_defs_intel();
> +}
> +
>  static enum cpuhp_state rdt_online;
>  
>  static int __init rdt_late_init(void)
> @@ -875,6 +891,12 @@ static int __init rdt_late_init(void)
>  	/* Run quirks first */
>  	rdt_quirks();
>  
> +	/*
> +	 * Initialize functions(or definitions) that are different
> +	 * between vendors here.
> +	 */
> +	rdt_init_res_defs();
> +

While it does seem as though currently rdt_quirks() is not using any of
the settings made in rdt_init_res_defs() it (rdt_quirks()) does use the
partially initialized resources structure and this may in the future
include using parameters that have not been initialized yet.

I thus think it would be safer to do this initialization before
rdt_quirks().

Reinette
