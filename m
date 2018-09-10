Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CCBC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA2E20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA2E20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbeIJRW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:22:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728066AbeIJRW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:22:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1711987A87;
        Mon, 10 Sep 2018 12:28:35 +0000 (UTC)
Received: from [10.36.117.149] (ovpn-117-149.ams2.redhat.com [10.36.117.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D02982027EB8;
        Mon, 10 Sep 2018 12:28:32 +0000 (UTC)
Subject: Re: [PATCH v6 5/5] x86/kvm: Avoid dynamic allocation of pvclock data
 when SEV is active
To:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1536343050-18532-1-git-send-email-brijesh.singh@amd.com>
 <1536343050-18532-6-git-send-email-brijesh.singh@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <0b176f2f-ee25-f290-ef92-e32d32c79c60@redhat.com>
Date:   Mon, 10 Sep 2018 14:28:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536343050-18532-6-git-send-email-brijesh.singh@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 10 Sep 2018 12:28:35 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 10 Sep 2018 12:28:35 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'pbonzini@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2018 19:57, Brijesh Singh wrote:
> Currently, the per-cpu pvclock data is allocated dynamically when
> cpu > HVC_BOOT_ARRAY_SIZE. The physical address of this variable is
> shared between the guest and the hypervisor hence it must be mapped as
> unencrypted (ie. C=0) when SEV is active.
> 
> The C-bit works on a page, hence we will be required to perform a
> full 4k page allocation to store a single 32-byte pvclock variable. It
> will waste fairly sizeable amount of memory since each CPU will be doing
> a separate 4k allocation. Let's define a second array for the SEV case to
> statically allocate for NR_CPUS and put this array in .data..decrypted
> section so that its mapped with C=0 during boot. The .data..decrypted
> section has a big chunk of memory that is currently unused. And since
> second array will be used only when memory encryption is active hence
> free it when encryption is not active.
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
>  arch/x86/kernel/kvmclock.c         | 14 ++++++++++++++
>  arch/x86/kernel/vmlinux.lds.S      |  3 +++
>  arch/x86/mm/init.c                 |  3 +++
>  arch/x86/mm/mem_encrypt.c          | 10 ++++++++++
>  5 files changed, 34 insertions(+)
> 
> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> index 802b2eb..cc46584 100644
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
> +#define __decrypted_aux __attribute__((__section__(".data..decrypted.aux")))
>  
>  #else	/* !CONFIG_AMD_MEM_ENCRYPT */
>  
> @@ -80,6 +82,7 @@ static inline int __init
>  early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0; }
>  
>  #define __decrypted
> +#define __decrypted_aux
>  
>  #endif	/* CONFIG_AMD_MEM_ENCRYPT */
>  
> @@ -93,6 +96,7 @@ early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0;
>  #define __sme_pa_nodebug(x)	(__pa_nodebug(x) | sme_me_mask)
>  
>  extern char __start_data_decrypted[], __end_data_decrypted[];
> +extern char __start_data_decrypted_aux[];
>  
>  #endif	/* __ASSEMBLY__ */
>  
> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index 376fd3a..6086b56 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -65,6 +65,15 @@ static struct pvclock_vsyscall_time_info
>  static struct pvclock_wall_clock wall_clock __decrypted;
>  static DEFINE_PER_CPU(struct pvclock_vsyscall_time_info *, hv_clock_per_cpu);
>  
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +/*
> + * The auxiliary array will be used when SEV is active. In non-SEV case,
> + * it will be freed by free_decrypted_mem().
> + */
> +static struct pvclock_vsyscall_time_info
> +			hv_clock_aux[NR_CPUS] __decrypted_aux;
> +#endif
> +
>  static inline struct pvclock_vcpu_time_info *this_cpu_pvti(void)
>  {
>  	return &this_cpu_read(hv_clock_per_cpu)->pvti;
> @@ -269,6 +278,11 @@ static int kvmclock_setup_percpu(unsigned int cpu)
>  	/* Use the static page for the first CPUs, allocate otherwise */
>  	if (cpu < HVC_BOOT_ARRAY_SIZE)
>  		p = &hv_clock_boot[cpu];
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +	/* Use the static page from auxiliary array instead of allocating it. */
> +	else if (sev_active())
> +		p = &hv_clock_aux[cpu - HVC_BOOT_ARRAY_SIZE];
> +#endif
>  	else
>  		p = kzalloc(sizeof(*p), GFP_KERNEL);
>  
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 4cb1064..bde287a 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -77,6 +77,9 @@ jiffies_64 = jiffies;
>  	. = ALIGN(PMD_SIZE);					\
>  	__start_data_decrypted = .;				\
>  	*(.data..decrypted);					\
> +	. = ALIGN(PAGE_SIZE);					\
> +	__start_data_decrypted_aux = .;				\
> +	*(.data..decrypted.aux);				\
>  	. = ALIGN(PMD_SIZE);					\
>  	__end_data_decrypted = .;				\
>  
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index 7a8fc26..052b279 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -815,9 +815,12 @@ void free_kernel_image_pages(void *begin, void *end)
>  		set_memory_np_noalias(begin_ul, len_pages);
>  }
>  
> +void __weak free_decrypted_mem(void) { }
> +
>  void __ref free_initmem(void)
>  {
>  	e820__reallocate_tables();
> +	free_decrypted_mem();
>  
>  	free_kernel_image_pages(&__init_begin, &__init_end);
>  }
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index b2de398..9a08c52 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -348,6 +348,16 @@ bool sev_active(void)
>  EXPORT_SYMBOL(sev_active);
>  
>  /* Architecture __weak replacement functions */
> +void __init free_decrypted_mem(void)
> +{
> +	if (mem_encrypt_active())
> +		return;
> +
> +	free_init_pages("unused decrypted",
> +			(unsigned long)__start_data_decrypted_aux,
> +			(unsigned long)__end_data_decrypted);
> +}
> +
>  void __init mem_encrypt_init(void)
>  {
>  	if (!sme_me_mask)
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
