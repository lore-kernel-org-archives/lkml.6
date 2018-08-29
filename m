Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8692CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCC920647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FCC920647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbeH2Xyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 19:54:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:26602 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727245AbeH2Xyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 19:54:33 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 12:56:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,304,1531810800"; 
   d="scan'208";a="85570799"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.20])
  by fmsmga001.fm.intel.com with ESMTP; 29 Aug 2018 12:56:07 -0700
Date:   Wed, 29 Aug 2018 12:56:07 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v3 4/4] x86/kvm: use __decrypted attribute in shared
 variables
Message-ID: <20180829195558.GA6801@linux.intel.com>
References: <1535567040-1370-1-git-send-email-brijesh.singh@amd.com>
 <1535567040-1370-5-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1535567040-1370-5-git-send-email-brijesh.singh@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 01:24:00PM -0500, Brijesh Singh wrote:
> The following commit:
> 
>   368a540e0232 (x86/kvmclock: Remove memblock dependency)

Checkpatch prefers:

    Commit 368a540e0232 ("x86/kvmclock: Remove memblock dependency")

That'll also save three lines in the commit message.
 
> caused SEV guest regression. When SEV is active, we map the shared
> variables (wall_clock and hv_clock_boot) with C=0 to ensure that both
> the guest and the hypervisor is able to access the data. To map the

Nit: s/is/are

> variables we use kernel_physical_mapping_init() to split the large pages,
> but this routine fails to allocate a new page. Before the above commit,
> kvmclock initialization was called after memory allocator was available
> but now its called early during boot.

What about something like this to make the issue a bit clearer:

  variables we use kernel_physical_mapping_init() to split the large pages,
  but splitting large pages requires allocating a new PMD, which fails now
  that kvmclock initialization is called early during boot.

> Recently we added a special .data..decrypted section to hold the shared
> variables. This section is mapped with C=0 early during boot. Use
> __decrypted attribute to put the wall_clock and hv_clock_boot in
> .data..decrypted section so that they are mapped with C=0.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
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

This is a definite downside to the section approach.  Unless I missed
something, the section padding goes to waste since we don't have a
mechanism in place to allocate into that section, e.g. as is we're
burning nearly 2mb of data since we're only using 4k of the 2mb page.
And every decrypted allocation can potentially fracture a large page
since the allocator is unaware of the decrypted requirement.  Might
not be an issue for kvmclock since it's a one-time allocation, but
we could suffer death by a thousand cuts if there are scenarios where
a decrypted allocation isn't be persistent (VirtIO queues maybe?).

Duplicating the full kernel tables for C=0 accesses doesn't suffer
from these issues.  And I think potential corruption issues due to
mis-{aligned,size} objects can be detected through static analysis,
build assertions and/or runtime checks.

> +		p = kzalloc(sz, GFP_KERNEL);

For the SEV case, can't we do a straight kmalloc() since we zero
out the page after decrypting it?

> +
> +		/*
> +		 * The physical address of per-cpu variable will be shared with
> +		 * the hypervisor. Let's clear the C-bit before we assign the
> +		 * memory to per_cpu variable.
> +		 */
> +		if (p && sev_active()) {
> +			rc = set_memory_decrypted((unsigned long)p, sz >> PAGE_SHIFT);
> +			if (rc)
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
