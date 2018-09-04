Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A2DC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E796C206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E796C206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeIEC7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 22:59:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:31138 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbeIEC7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 22:59:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 15:32:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,330,1531810800"; 
   d="scan'208";a="67552818"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.20])
  by fmsmga007.fm.intel.com with ESMTP; 04 Sep 2018 15:32:00 -0700
Date:   Tue, 4 Sep 2018 15:32:00 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v4 4/4] x86/kvm: use __decrypted attribute in shared
 variables
Message-ID: <20180904223200.GA7248@linux.intel.com>
References: <1536024582-25700-1-git-send-email-brijesh.singh@amd.com>
 <1536024582-25700-5-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1536024582-25700-5-git-send-email-brijesh.singh@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 08:29:42PM -0500, Brijesh Singh wrote:
> Commit: 368a540e0232 (x86/kvmclock: Remove memblock dependency)
> caused SEV guest regression. When SEV is active, we map the shared
> variables (wall_clock and hv_clock_boot) with C=0 to ensure that both
> the guest and the hypervisor are able to access the data. To map the
> variables we use kernel_physical_mapping_init() to split the large pages,
> but splitting large pages requires allocating a new PMD, which fails now
> that kvmclock initialization is called early during boot.
> 
> Recently we added a special .data..decrypted section to hold the shared
> variables. This section is mapped with C=0 early during boot. Use
> __decrypted attribute to put the wall_clock and hv_clock_boot in
> .data..decrypted section so that they are mapped with C=0.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Fixes: 368a540e0232 ("x86/kvmclock: Remove memblock dependency")
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: kvm@vger.kernel.org
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: kvm@vger.kernel.org
> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
> ---
>  arch/x86/kernel/kvmclock.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index 1e67646..08f5f8a 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -28,6 +28,7 @@
>  #include <linux/sched/clock.h>
>  #include <linux/mm.h>
>  #include <linux/slab.h>
> +#include <linux/set_memory.h>
>  
>  #include <asm/hypervisor.h>
>  #include <asm/mem_encrypt.h>
> @@ -61,8 +62,8 @@ early_param("no-kvmclock-vsyscall", parse_no_kvmclock_vsyscall);
>  	(PAGE_SIZE / sizeof(struct pvclock_vsyscall_time_info))
>  
>  static struct pvclock_vsyscall_time_info
> -			hv_clock_boot[HVC_BOOT_ARRAY_SIZE] __aligned(PAGE_SIZE);
> -static struct pvclock_wall_clock wall_clock;
> +			hv_clock_boot[HVC_BOOT_ARRAY_SIZE] __decrypted __aligned(PAGE_SIZE);
> +static struct pvclock_wall_clock wall_clock __decrypted;
>  static DEFINE_PER_CPU(struct pvclock_vsyscall_time_info *, hv_clock_per_cpu);
>  
>  static inline struct pvclock_vcpu_time_info *this_cpu_pvti(void)
> @@ -267,10 +268,29 @@ static int kvmclock_setup_percpu(unsigned int cpu)
>  		return 0;
>  
>  	/* Use the static page for the first CPUs, allocate otherwise */
> -	if (cpu < HVC_BOOT_ARRAY_SIZE)
> +	if (cpu < HVC_BOOT_ARRAY_SIZE) {
>  		p = &hv_clock_boot[cpu];
> -	else
> -		p = kzalloc(sizeof(*p), GFP_KERNEL);
> +	} else {
> +		int rc;
> +		unsigned int sz = sizeof(*p);
> +
> +		if (sev_active())
> +			sz = PAGE_ALIGN(sz);

Hmm, again we're wasting a fairly sizable amount of memory since each
CPU is doing a separate 4k allocation.  What if we defined an auxilary
array in __decrypted to be used for cpus > HVC_BOOT_ARRAY_SIZE when
SEV is active?  struct pvclock_vsyscall_time_info is 32 bytes so we
could handle the max of 8192 CPUs with 256kb of data (252kb if you
subtract the pre-existing 4k page), i.e. the SEV case wouldn't need
additional memory beyond the 2mb page that's reserved for __decrypted.
The non-SEV case could do free_kernel_image_pages() on the unused
array (which would need to be page sized) so it wouldn't waste memory.

> +
> +		p = kzalloc(sz, GFP_KERNEL);
> +
> +		/*
> +		 * The physical address of per-cpu variable will be shared with
> +		 * the hypervisor. Let's clear the C-bit before we assign the
> +		 * memory to per_cpu variable.
> +		 */
> +		if (p && sev_active()) {
> +			rc = set_memory_decrypted((unsigned long)p, sz >> PAGE_SHIFT);
> +			if (rc)

@p is being leaked if set_memory_decrypted() fails.

> +				return rc;
> +			memset(p, 0, sz);
> +		}
> +	}
>  
>  	per_cpu(hv_clock_per_cpu, cpu) = p;
>  	return p ? 0 : -ENOMEM;
> -- 
> 2.7.4
> 
