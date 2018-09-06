Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09AEC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5570220645
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5570220645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbeIFSnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:43:23 -0400
Received: from mga17.intel.com ([192.55.52.151]:18208 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbeIFSnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:43:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 07:07:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,338,1531810800"; 
   d="scan'208";a="78461033"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.20])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Sep 2018 07:07:39 -0700
Date:   Thu, 6 Sep 2018 07:07:39 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v5 5/5] x86/kvm: Avoid dynamic allocation of pvclock data
 when SEV is active
Message-ID: <20180906140738.GA370@linux.intel.com>
References: <1536234182-2809-1-git-send-email-brijesh.singh@amd.com>
 <1536234182-2809-6-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1536234182-2809-6-git-send-email-brijesh.singh@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 06:43:02AM -0500, Brijesh Singh wrote:
> Currently, the per-cpu pvclock data is allocated dynamically when
> cpu > HVC_BOOT_ARRAY_SIZE. The physical address of this variable is
> shared between the guest and the hypervisor hence it must be mapped as
> unencrypted (ie. C=0) when SEV is active.
> 
> When SEV is active, we will be wasting fairly sizeable amount of memory
> since each CPU will be doing a separate 4k allocation so that it can clear
> C-bit. Let's define few extra static page sized array of pvclock data.
> In the preparatory stage of CPU hotplug, use the element of this static
> array to avoid the dynamic allocation. This array will be put in
> the .data..decrypted section so that its mapped with C=0 during the boot.
> 
> In non-SEV case, this static page will unused and free'd by the
> free_decrypted_mem().
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
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
>  arch/x86/include/asm/mem_encrypt.h |  4 ++++
>  arch/x86/kernel/kvmclock.c         | 22 +++++++++++++++++++---
>  arch/x86/kernel/vmlinux.lds.S      |  3 +++
>  arch/x86/mm/init.c                 |  3 +++
>  arch/x86/mm/mem_encrypt.c          | 10 ++++++++++
>  5 files changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> index 802b2eb..aa204af 100644
> --- a/arch/x86/include/asm/mem_encrypt.h
> +++ b/arch/x86/include/asm/mem_encrypt.h
> @@ -48,11 +48,13 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
>  
>  /* Architecture __weak replacement functions */
>  void __init mem_encrypt_init(void);
> +void __init free_decrypted_mem(void);
>  
>  bool sme_active(void);
>  bool sev_active(void);
>  
>  #define __decrypted __attribute__((__section__(".data..decrypted")))
> +#define __decrypted_hvclock __attribute__((__section__(".data..decrypted_hvclock")))
>  
>  #else	/* !CONFIG_AMD_MEM_ENCRYPT */
>  
> @@ -80,6 +82,7 @@ static inline int __init
>  early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0; }
>  
>  #define __decrypted
> +#define __decrypted_hvclock
>  
>  #endif	/* CONFIG_AMD_MEM_ENCRYPT */
>  
> @@ -93,6 +96,7 @@ early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0;
>  #define __sme_pa_nodebug(x)	(__pa_nodebug(x) | sme_me_mask)
>  
>  extern char __start_data_decrypted[], __end_data_decrypted[];
> +extern char __start_data_decrypted_hvclock[];
>  
>  #endif	/* __ASSEMBLY__ */
>  
> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index 376fd3a..5b88773 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -65,6 +65,13 @@ static struct pvclock_vsyscall_time_info
>  static struct pvclock_wall_clock wall_clock __decrypted;
>  static DEFINE_PER_CPU(struct pvclock_vsyscall_time_info *, hv_clock_per_cpu);
>  
> +
> +/* This should cover upto 512 VCPUS (first 64 are covered by hv_clock_boot[]). */
> +#define HVC_DECRYPTED_ARRAY_SIZE \
> +	((PAGE_SIZE * 7)  / sizeof(struct pvclock_vsyscall_time_info))

I think we can define the size relative to NR_CPUS rather than picking
an arbitrary number of pages, maybe with a BUILD_BUG_ON to make sure
the total size won't require a second 2mb page for __decrpyted.

#define HVC_DECRYPTED_ARRAY_SIZE  \
	PAGE_ALIGN((NR_CPUS - HVC_BOOT_ARRAY_SIZE) * \
		   sizeof(struct pvclock_vsyscall_time_info))

> +static struct pvclock_vsyscall_time_info
> +			hv_clock_dec[HVC_DECRYPTED_ARRAY_SIZE] __decrypted_hvclock;
> +
>  static inline struct pvclock_vcpu_time_info *this_cpu_pvti(void)
>  {
>  	return &this_cpu_read(hv_clock_per_cpu)->pvti;
> @@ -267,10 +274,19 @@ static int kvmclock_setup_percpu(unsigned int cpu)
>  		return 0;
>  
>  	/* Use the static page for the first CPUs, allocate otherwise */
> -	if (cpu < HVC_BOOT_ARRAY_SIZE)
> +	if (cpu < HVC_BOOT_ARRAY_SIZE) {
>  		p = &hv_clock_boot[cpu];
> -	else
> -		p = kzalloc(sizeof(*p), GFP_KERNEL);
> +	} else {
> +		/*
> +		 * When SEV is active, use the static pages from
> +		 * .data..decrypted_hvclock section. The pages are already
> +		 * mapped with C=0.
> +		 */
> +		if (sev_active())
> +			p = &hv_clock_dec[cpu - HVC_BOOT_ARRAY_SIZE];
> +		else
> +			p = kzalloc(sizeof(*p), GFP_KERNEL);
> +	}

Personal preference, but I think an if-elif-else with a single block
comment would be easier to read.

	/*
	 * Blah blah blah
	 */
	if (cpu < HVC_BOOT_ARRAY_SIZE)
		p = &hv_clock_boot[cpu];
	else if (sev_active())
		p = &hv_clock_dec[cpu - HVC_BOOT_ARRAY_SIZE];
	else
		p = kzalloc(sizeof(*p), GFP_KERNEL);
