Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1FCC64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D015B2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D015B2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbeJCEwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:52:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:28067 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbeJCEwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:52:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2018 15:07:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,333,1534834800"; 
   d="scan'208";a="79351315"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.130]) ([10.24.14.130])
  by orsmga006.jf.intel.com with ESMTP; 02 Oct 2018 15:07:22 -0700
Subject: Re: [RFC PATCH 07/10] arch/x86: Bring few more functions into the
 resource structure
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
 <20180924191841.29111-8-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <6a4085c8-b220-1694-eb96-e858f2a091f5@intel.com>
Date:   Tue, 2 Oct 2018 15:07:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180924191841.29111-8-babu.moger@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 9/24/2018 12:19 PM, Moger, Babu wrote:
> Bring all resource functions that are different between the vendors
> into resource structure and initialize them dynamically.
> 
> Implement these functions separately for each vendors.
> update_mba_bw : Feedback loop bandwidth update functionality is not
>                 needed for AMD.
> cbm_validate  : Cache bitmask validate function. AMD allows
>                 non-contiguous masks. So, use separate functions for
>                 Intel and AMD.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/rdt.c             | 17 +++++++++++++----
>  arch/x86/kernel/cpu/rdt.h             | 19 +++++++++++++------
>  arch/x86/kernel/cpu/rdt_ctrlmondata.c |  4 ++--
>  arch/x86/kernel/cpu/rdt_monitor.c     | 10 +++++++---
>  4 files changed, 35 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/rdt.c b/arch/x86/kernel/cpu/rdt.c
> index 6dec45bf81d6..ae26b9b3fafa 100644
> --- a/arch/x86/kernel/cpu/rdt.c
> +++ b/arch/x86/kernel/cpu/rdt.c
> @@ -867,10 +867,19 @@ static __init void rdt_init_res_defs_intel(void)
>  	struct rdt_resource *r;
>  
>  	for_each_rdt_resource(r) {
> -		if (r->rid == RDT_RESOURCE_MBA) {
> -			r->msr_base = IA32_MBA_THRTL_BASE;
> -			r->msr_update = mba_wrmsr;
> -			r->parse_ctrlval = parse_bw;
> +		if ((r->rid == RDT_RESOURCE_L3) ||
> +		    (r->rid == RDT_RESOURCE_L3DATA) ||
> +		    (r->rid == RDT_RESOURCE_L3CODE) ||
> +		    (r->rid == RDT_RESOURCE_L2) ||
> +		    (r->rid == RDT_RESOURCE_L2DATA) ||
> +		    (r->rid == RDT_RESOURCE_L2CODE))
> +			r->cbm_validate = cbm_validate;

Same comment here about naming as in patch 6. Later cbm_validate_amd
would appear while this remains - to help reduce confusion it may help
to rename this function to cbm_validate_intel at this time.

> +
> +		else if (r->rid == RDT_RESOURCE_MBA) {
> +			 r->msr_base = IA32_MBA_THRTL_BASE;
> +			 r->msr_update = mba_wrmsr;
> +			 r->parse_ctrlval = parse_bw;
> +			 r->update_mba_bw = update_mba_bw;

Same comment about naming.

>  		}
>  	}
>  }
> diff --git a/arch/x86/kernel/cpu/rdt.h b/arch/x86/kernel/cpu/rdt.h
> index 2569c10c37f4..7205157d359b 100644
> --- a/arch/x86/kernel/cpu/rdt.h
> +++ b/arch/x86/kernel/cpu/rdt.h
> @@ -386,9 +386,9 @@ static inline bool is_mbm_event(int e)
>   * struct rdt_resource - attributes of an RDT resource
>   * @rid:		The index of the resource
>   * @alloc_enabled:	Is allocation enabled on this machine
> - * @mon_enabled:		Is monitoring enabled for this feature
> + * @mon_enabled:	Is monitoring enabled for this feature
>   * @alloc_capable:	Is allocation available on this machine
> - * @mon_capable:		Is monitor feature available on this machine
> + * @mon_capable:	Is monitor feature available on this machine
>   * @name:		Name to use in "schemata" file
>   * @num_closid:		Number of CLOSIDs available
>   * @cache_level:	Which cache level defines scope of this resource
> @@ -400,10 +400,12 @@ static inline bool is_mbm_event(int e)
>   * @cache:		Cache allocation related data
>   * @format_str:		Per resource format string to show domain value
>   * @parse_ctrlval:	Per resource function pointer to parse control values
> - * @evt_list:			List of monitoring events
> - * @num_rmid:			Number of RMIDs available
> - * @mon_scale:			cqm counter * mon_scale = occupancy in bytes
> - * @fflags:			flags to choose base and info files
> + * @update_mba_bw:	Feedback loop for MBA software controllerer function

controllerer -> controller ?

> + * @cbm_validate	Cache bitmask validate function
> + * @evt_list:		List of monitoring events
> + * @num_rmid:		Number of RMIDs available
> + * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
> + * @fflags:		flags to choose base and info files
>   */
>  struct rdt_resource {
>  	int			rid;
> @@ -425,6 +427,9 @@ struct rdt_resource {
>  	const char		*format_str;
>  	int (*parse_ctrlval)	(void *data, struct rdt_resource *r,
>  				 struct rdt_domain *d);
> +	void (*update_mba_bw)   (struct rdtgroup *rgrp,
> +				 struct rdt_domain *dom_mbm);
> +	bool (*cbm_validate)    (char *buf, u32 *data, struct rdt_resource *r);
>  	struct list_head	evt_list;
>  	int			num_rmid;
>  	unsigned int		mon_scale;
> @@ -562,5 +567,7 @@ void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
>  void cqm_handle_limbo(struct work_struct *work);
>  bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
>  void __check_limbo(struct rdt_domain *d, bool force_free);
> +void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm);
> +bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r);
>  
>  #endif /* _ASM_X86_RDT_H */
> diff --git a/arch/x86/kernel/cpu/rdt_ctrlmondata.c b/arch/x86/kernel/cpu/rdt_ctrlmondata.c
> index 0565c564b297..5a282b6c4bd7 100644
> --- a/arch/x86/kernel/cpu/rdt_ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/rdt_ctrlmondata.c
> @@ -88,7 +88,7 @@ int parse_bw(void *_buf, struct rdt_resource *r, struct rdt_domain *d)
>   *	are allowed (e.g. FFFFH, 0FF0H, 003CH, etc.).
>   * Additionally Haswell requires at least two bits set.
>   */
> -static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
> +bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>  {
>  	unsigned long first_bit, zero_bit, val;
>  	unsigned int cbm_len = r->cache.cbm_len;
> @@ -153,7 +153,7 @@ int parse_cbm(void *_data, struct rdt_resource *r, struct rdt_domain *d)
>  		return -EINVAL;
>  	}
>  
> -	if (!cbm_validate(data->buf, &cbm_val, r))
> +	if ((r->cbm_validate) && !(r->cbm_validate(data->buf, &cbm_val, r)))

I do not think you need all of those brackets.

Reinette
