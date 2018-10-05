Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896A6C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113C9208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 113C9208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbeJEXUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:20:18 -0400
Received: from foss.arm.com ([217.140.101.70]:54782 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729669AbeJEXUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:20:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5149BED1;
        Fri,  5 Oct 2018 09:20:53 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E66143F5D3;
        Fri,  5 Oct 2018 09:20:47 -0700 (PDT)
Subject: Re: [RFC PATCH 10/10] arch/x86: Introduce QOS feature for AMD
To:     "Moger, Babu" <Babu.Moger@amd.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "vikas.shivappa@linux.intel.com" <vikas.shivappa@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
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
 <20180924191841.29111-11-babu.moger@amd.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <81d5c963-0f00-29fa-2259-2b7fc26da123@arm.com>
Date:   Fri, 5 Oct 2018 17:20:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180924191841.29111-11-babu.moger@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 24/09/18 20:19, Moger, Babu wrote:
> Enables QOS feature on AMD.
> Following QoS sub-features are supported in AMD if the underlying
> hardware supports it.
>  - L3 Cache allocation enforcement
>  - L3 Cache occupancy monitoring
>  - L3 Code-Data Prioritization support
>  - Memory Bandwidth Enforcement(Allocation)
> 
> There are differences in the way some of the features are implemented.
> Separate those functions and add those as vendor specific functions.
> The major difference is in MBA feature.
>  - AMD uses CPUID leaf 0x80000020 to initialize the MBA features.
>  - AMD uses direct bandwidth value instead of delay based on bandwidth
>    values.
>  - MSR register base addresses are different for MBA.

>  - Also AMD allows non-contiguous L3 cache bit masks.

Nice!

This is visible to user-space, the 'Cache Bit Masks (CBM)' section of
Documentation/x86/intel_rdt_ui.txt currently says 'X86 hardware requires ... a
contiguous block'.

Does user-space need to know it can do this in advance, or is it a try-it-and-see?

Arm's MPAM stuff can do this too, but I'm against having the ABI vary between
architectures. If this is going to be discoverable, I'd like it to work on Arm too.


Thanks,

James

> Adds following functions to take care of the differences.
> rdt_get_mem_config_amd : MBA initialization function
> parse_bw_amd : Bandwidth parsing
> mba_wrmsr_amd: Writes bandwidth value
> cbm_validate_amd : L3 cache bitmask validation

> diff --git a/arch/x86/kernel/cpu/rdt_ctrlmondata.c b/arch/x86/kernel/cpu/rdt_ctrlmondata.c
> index 5a282b6c4bd7..1e4631f88696 100644
> --- a/arch/x86/kernel/cpu/rdt_ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/rdt_ctrlmondata.c
> @@ -123,6 +169,41 @@ bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>  	return true;
>  }
>  
> +/*
> + * Check whether a cache bit mask is valid. AMD allows
> + * non-contiguous masks.
> + */
> +bool cbm_validate_amd(char *buf, u32 *data, struct rdt_resource *r)
> +{
> +	unsigned long first_bit, zero_bit, val;
> +	unsigned int cbm_len = r->cache.cbm_len;
> +	int ret;
> +
> +	ret = kstrtoul(buf, 16, &val);
> +	if (ret) {
> +		rdt_last_cmd_printf("non-hex character in mask %s\n", buf);
> +		return false;
> +	}
> +
> +	if (val == 0 || val > r->default_ctrl) {
> +		rdt_last_cmd_puts("mask out of range\n");
> +		return false;
> +	}
> +
> +	first_bit = find_first_bit(&val, cbm_len);
> +	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
> +
> +
> +	if ((zero_bit - first_bit) < r->cache.min_cbm_bits) {
> +		rdt_last_cmd_printf("Need at least %d bits in mask\n",
> +				    r->cache.min_cbm_bits);
> +		return false;
> +	}
> +
> +	*data = val;
> +	return true;
> +}
> +
>  struct rdt_cbm_parse_data {
>  	struct rdtgroup		*rdtgrp;
>  	char			*buf;
> 

