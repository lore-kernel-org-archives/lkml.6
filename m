Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1839DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32AC20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32AC20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbeIJRV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:21:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:40220 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728066AbeIJRV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:21:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CE34CAE23;
        Mon, 10 Sep 2018 12:27:33 +0000 (UTC)
Date:   Mon, 10 Sep 2018 14:27:27 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v6 5/5] x86/kvm: Avoid dynamic allocation of pvclock data
 when SEV is active
Message-ID: <20180910122727.GE21815@zn.tnic>
References: <1536343050-18532-1-git-send-email-brijesh.singh@amd.com>
 <1536343050-18532-6-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1536343050-18532-6-git-send-email-brijesh.singh@amd.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 12:57:30PM -0500, Brijesh Singh wrote:
> Currently, the per-cpu pvclock data is allocated dynamically when
> cpu > HVC_BOOT_ARRAY_SIZE.

Well no, you need to write this correctly - what is "cpu >
HVC_BOOT_ARRAY_SIZE" ?!

( I know what it is but I know it only because I've looked at that code before.  )

So no, please explain it in English not in code.

> The physical address of this variable is
> shared between the guest and the hypervisor hence it must be mapped as
> unencrypted (ie. C=0) when SEV is active.

This sentence is a good example about how to explain stuff in commit
messages.

> The C-bit works on a page,

"The C-bit determines the encryption status of a 4K page."

> hence we will be required to perform a

Use passive tone in your commit message: no "we", etc...

> full 4k page allocation to store a single 32-byte pvclock variable. It
> will waste fairly sizeable amount of memory since each CPU will be doing

"... will waste *a* fairly sizeable amount of ..."

> a separate 4k allocation.

Start new paragraph here and use passive tone.

> Let's define a second array for the SEV case to
> statically allocate for NR_CPUS and put this array in .data..decrypted

NR_CPUS needs explaining for the unenlightened reader. Also,

	"... put this array in *the* .data..decrypted section... "

> section so that its mapped with C=0 during boot.

<---- newline here.

> The .data..decrypted
> section has a big chunk of memory that is currently unused. And since
> second array will be used only when memory encryption is active hence

"... since *the* second array... "

s/hence //

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

Proper prefixing:

"mem_encrypt_free_decrypted"

or so

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

Hmm, so worst case that's 64 4K pages:

(8192*32)/4096 = 64 4K pages.

Now, the real question from all this SNAFU is, why can't all those point
to a single struct pvclock_vsyscall_time_info and all CPUs read a single
thing? Why do they have to be per-CPU and thus waste so much memory?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
