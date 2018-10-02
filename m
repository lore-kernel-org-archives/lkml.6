Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F7AC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A6B206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A6B206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeJCCGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:06:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:64946 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbeJCCGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:06:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2018 12:21:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,332,1534834800"; 
   d="scan'208";a="79315814"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.130]) ([10.24.14.130])
  by orsmga006.jf.intel.com with ESMTP; 02 Oct 2018 12:21:12 -0700
Subject: Re: [RFC PATCH 03/10] arch/x86: Re-arrange RDT init code
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
 <20180924191841.29111-4-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <09e1f4dc-7882-9bb4-f5a7-e9e7caafee84@intel.com>
Date:   Tue, 2 Oct 2018 12:21:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180924191841.29111-4-babu.moger@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 9/24/2018 12:19 PM, Moger, Babu wrote:
> Re-organize the RDT init code. Separate the call sequence for each
> feature. That way, it is easy to call quirks or features separately
> for each vendor if there are differences.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/rdt.c | 44 ++++++++++++++++++++++++++++-----------
>  1 file changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/rdt.c b/arch/x86/kernel/cpu/rdt.c
> index b361c63170d7..736715b81fd8 100644
> --- a/arch/x86/kernel/cpu/rdt.c
> +++ b/arch/x86/kernel/cpu/rdt.c
> @@ -813,10 +813,6 @@ static __init bool get_rdt_alloc_resources(void)
>  		ret = true;
>  	}
>  
> -	if (rdt_cpu_has(X86_FEATURE_MBA)) {
> -		if (rdt_get_mem_config(&rdt_resources_all[RDT_RESOURCE_MBA]))
> -			ret = true;
> -	}

The commit message mentions that the call sequence for each feature is
separated, but here only the MBA feature is separated.

The MBA feature detection is removed above .... (more later)

>  	return ret;
>  }
>  
> @@ -831,11 +827,12 @@ static __init bool get_rdt_mon_resources(void)
>  
>  	if (!rdt_mon_features)
>  		return false;
> +	else
> +		return true;
>  
> -	return !rdt_get_mon_l3_config(&rdt_resources_all[RDT_RESOURCE_L3]);
>  }
>  
> -static __init void rdt_quirks(void)
> +static __init void rdt_quirks_intel(void)
>  {
>  	switch (boot_cpu_data.x86_model) {
>  	case INTEL_FAM6_HASWELL_X:
> @@ -850,13 +847,22 @@ static __init void rdt_quirks(void)
>  	}
>  }
>  
> -static __init bool get_rdt_resources(void)
> +static __init void rdt_quirks(void)
>  {
> -	rdt_quirks();
> -	rdt_alloc_capable = get_rdt_alloc_resources();
> -	rdt_mon_capable = get_rdt_mon_resources();
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
> +		rdt_quirks_intel();
> +}
> +
> +static __init void rdt_detect_l3_mon(void)
> +{
> +	if (rdt_mon_capable)
> +		rdt_get_mon_l3_config(&rdt_resources_all[RDT_RESOURCE_L3]);

The possible errors from this configuration is now lost.

> +}
>  
> -	return (rdt_mon_capable || rdt_alloc_capable);
> +static __init void rdt_check_mba(void)
> +{
> +	if (rdt_cpu_has(X86_FEATURE_MBA))
> +		rdt_get_mem_config(&rdt_resources_all[RDT_RESOURCE_MBA]);

Here too the possible failure of this configuration is now lost.

>  }
>  
>  static enum cpuhp_state rdt_online;
> @@ -866,8 +872,22 @@ static int __init rdt_late_init(void)
>  	struct rdt_resource *r;
>  	int state, ret;
>  
> -	if (!get_rdt_resources())
> +	/* Run quirks first */
> +	rdt_quirks();
> +
> +	rdt_alloc_capable = get_rdt_alloc_resources();
> +	rdt_mon_capable = get_rdt_mon_resources();
> +
> +	if (!(rdt_alloc_capable || rdt_mon_capable)) {
> +		pr_info("RDT allocation or monitoring not detected\n");

This function ends with a log entry for every resource discovered. Is
this new log entry needed to indicate that such resources have not been
found? Could it not just be the absence of the other message?

>  		return -ENODEV;
> +	}

... (continued from above) ... since the MBA feature detection was
removed from get_rdt_alloc_resources() would the above not cause failure
on systems that only support MBA?

> +
> +	/* Detect l3 monitoring resources */

I do not think this comment is accurate ... has the monitoring resources
not been detected earlier in get_rdt_mon_resources() and now they will
be configured?

> +	rdt_detect_l3_mon();
> +
> +	/* Check for Memory Bandwidth Allocation */
> +	rdt_check_mba();

To follow up on above .. the potential failure of these configurations
are now lost here. Initialization should not continue if these
configurations failed.

>  
>  	rdt_init_padding();
>  
> 

Reinette
