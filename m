Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9512C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B629204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B629204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbeH2R4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:56:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:38972 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727651AbeH2R4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:56:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CF76CAFC0;
        Wed, 29 Aug 2018 13:59:24 +0000 (UTC)
Date:   Wed, 29 Aug 2018 15:59:49 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        stable@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v2 2/3] x86/mm: add .data..decrypted section to hold
 shared variables
Message-ID: <20180829135949.GF6337@nazgul.tnic>
References: <1535494377-25600-1-git-send-email-brijesh.singh@amd.com>
 <1535494377-25600-3-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1535494377-25600-3-git-send-email-brijesh.singh@amd.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 05:12:56PM -0500, Brijesh Singh wrote:
> kvmclock defines few static variables which are shared with hypervisor

							... with the hypervisor ...

> during the kvmclock initialization.
> 
> When SEV is active, memory is encrypted with a guest-specific key, and
> if guest OS wants to share the memory region with hypervisor then it must
> clear the C-bit before sharing it. Currently, we use
> kernel_physical_mapping_init() to split large pages before clearing the
> C-bit on shared pages. But the kernel_physical_mapping_init fails when

"But it fails when... "

> called from the kvmclock initialization (mainly because memblock allocator
> was not ready).

"... is not ready that early during boot)."

> The '__decrypted' can be used to define a shared variable; the variables

"Add a __decrypted section attribute which can be used when defining
such shared variable. The so-defined variables will be placed..."

> will be put in the .data.decryption section. This section is mapped with

" ... in the .data..decrypted section."

> C=0 early in the boot, we also ensure that the initialized values are

"... early during boot, "

> updated to match with C=0 (i.e perform an in-place decryption). The
> .data..decrypted section is PMD aligned and sized so that we avoid the

"... PMD-aligned ... "

> need to split the large pages when mapping this section.
> 
> The sme_encrypt_kernel() was used to perform the in-place encryption
> of the Linux kernel and initrd when SME is active. The routine has been
> enhanced to decrypt the .data..decryption section for both SME and SEV
> cases.

".data..decrypted"

> 
> While reusing the sme_populate_pgd() we found that the function does not
> update the flags if the pte/pmd entry already exists. The patch updates
> the function to take care of it.


Change the tone to impartial:

"While at it, fix sme_populate_pgd() to update page flags if the PMD/PTE
entry already exists."

And avoid using "This patch" - what this patch does, should be visible
to the enlightened onlooker.

> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> Cc: stable@vger.kernel.org
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
>  arch/x86/include/asm/mem_encrypt.h |   6 +++
>  arch/x86/kernel/head64.c           |   9 ++++
>  arch/x86/kernel/vmlinux.lds.S      |  17 +++++++
>  arch/x86/mm/mem_encrypt_identity.c | 100 +++++++++++++++++++++++++++++--------
>  4 files changed, 112 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> index c064383..802b2eb 100644
> --- a/arch/x86/include/asm/mem_encrypt.h
> +++ b/arch/x86/include/asm/mem_encrypt.h
> @@ -52,6 +52,8 @@ void __init mem_encrypt_init(void);
>  bool sme_active(void);
>  bool sev_active(void);
>  
> +#define __decrypted __attribute__((__section__(".data..decrypted")))
> +
>  #else	/* !CONFIG_AMD_MEM_ENCRYPT */
>  
>  #define sme_me_mask	0ULL
> @@ -77,6 +79,8 @@ early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { return 0;
>  static inline int __init
>  early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0; }
>  
> +#define __decrypted
> +
>  #endif	/* CONFIG_AMD_MEM_ENCRYPT */
>  
>  /*
> @@ -88,6 +92,8 @@ early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0;
>  #define __sme_pa(x)		(__pa(x) | sme_me_mask)
>  #define __sme_pa_nodebug(x)	(__pa_nodebug(x) | sme_me_mask)
>  
> +extern char __start_data_decrypted[], __end_data_decrypted[];
> +
>  #endif	/* __ASSEMBLY__ */
>  
>  #endif	/* __X86_MEM_ENCRYPT_H__ */
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index 8047379..3e03129 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -112,6 +112,7 @@ static bool __head check_la57_support(unsigned long physaddr)
>  unsigned long __head __startup_64(unsigned long physaddr,
>  				  struct boot_params *bp)
>  {
> +	unsigned long vaddr, vaddr_end;
>  	unsigned long load_delta, *p;
>  	unsigned long pgtable_flags;
>  	pgdval_t *pgd;
> @@ -234,6 +235,14 @@ unsigned long __head __startup_64(unsigned long physaddr,
>  	/* Encrypt the kernel and related (if SME is active) */
>  	sme_encrypt_kernel(bp);
>  
> +	/* Clear the memory encryption mask from the decrypted section */

End sentences with a fullstop.

> +	vaddr = (unsigned long)__start_data_decrypted;
> +	vaddr_end = (unsigned long)__end_data_decrypted;
> +	for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
> +		i = pmd_index(vaddr);
> +		pmd[i] -= sme_get_me_mask();
> +	}

This needs to be no-op on !SME machines. Hint: if (sme_active())...

>  	/*
>  	 * Return the SME encryption mask (if SME is active) to be used as a
>  	 * modifier for the initial pgdir entry programmed into CR3.
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 8bde0a4..0ef9320 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -89,6 +89,21 @@ PHDRS {
>  	note PT_NOTE FLAGS(0);          /* ___ */
>  }
>  
> +/*
> + * This section contains data which will be mapped as decrypted. Memory
> + * encryption operates on a page basis. But we make this section a pmd

"... make this section PMD-aligned ..."

Also, avoid the "we" and formulate in passive voice.

> + * aligned to avoid spliting the pages while mapping the section early.
> + *
> + * Note: We use a separate section so that only this section gets
> + * decrypted to avoid exposing more than we wish.
> + */
> +#define DATA_DECRYPTED_SECTION						\

DATA_DECRYPTED is perfectly fine.

> +	. = ALIGN(PMD_SIZE);						\
> +	__start_data_decrypted = .;					\
> +	*(.data..decrypted);						\
> +	. = ALIGN(PMD_SIZE);						\
> +	__end_data_decrypted = .;					\
> +
>  SECTIONS
>  {
>  #ifdef CONFIG_X86_32
> @@ -171,6 +186,8 @@ SECTIONS
>  		/* rarely changed data like cpu maps */
>  		READ_MOSTLY_DATA(INTERNODE_CACHE_BYTES)
>  
> +		DATA_DECRYPTED_SECTION
> +
>  		/* End of data section */
>  		_edata = .;
>  	} :data
> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> index bf6097e..88c1cce 100644
> --- a/arch/x86/mm/mem_encrypt_identity.c
> +++ b/arch/x86/mm/mem_encrypt_identity.c
> @@ -51,6 +51,8 @@
>  				 (_PAGE_PAT | _PAGE_PWT))
>  
>  #define PMD_FLAGS_ENC		(PMD_FLAGS_LARGE | _PAGE_ENC)
> +#define PMD_FLAGS_ENC_WP	((PMD_FLAGS_ENC & ~_PAGE_CACHE_MASK) | \
> +				 (_PAGE_PAT | _PAGE_PWT))
>  
>  #define PTE_FLAGS		(__PAGE_KERNEL_EXEC & ~_PAGE_GLOBAL)
>  
> @@ -59,6 +61,8 @@
>  				 (_PAGE_PAT | _PAGE_PWT))
>  
>  #define PTE_FLAGS_ENC		(PTE_FLAGS | _PAGE_ENC)
> +#define PTE_FLAGS_ENC_WP	((PTE_FLAGS_ENC & ~_PAGE_CACHE_MASK) | \
> +				 (_PAGE_PAT | _PAGE_PWT))
>  
>  struct sme_populate_pgd_data {
>  	void    *pgtable_area;
> @@ -154,9 +158,6 @@ static void __init sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
>  		return;
>  
>  	pmd = pmd_offset(pud, ppd->vaddr);
> -	if (pmd_large(*pmd))
> -		return;
> -
>  	set_pmd(pmd, __pmd(ppd->paddr | ppd->pmd_flags));
>  }
>  
> @@ -182,8 +183,7 @@ static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
>  		return;
>  
>  	pte = pte_offset_map(pmd, ppd->vaddr);
> -	if (pte_none(*pte))
> -		set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
> +	set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
>  }
>  

This looks like it belongs in a prepatch fix.

>  static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
> @@ -235,6 +235,11 @@ static void __init sme_map_range_encrypted(struct sme_populate_pgd_data *ppd)
>  	__sme_map_range(ppd, PMD_FLAGS_ENC, PTE_FLAGS_ENC);
>  }
>  
> +static void __init sme_map_range_encrypted_wp(struct sme_populate_pgd_data *ppd)
> +{
> +	__sme_map_range(ppd, PMD_FLAGS_ENC_WP, PTE_FLAGS_ENC_WP);
> +}
> +
>  static void __init sme_map_range_decrypted(struct sme_populate_pgd_data *ppd)
>  {
>  	__sme_map_range(ppd, PMD_FLAGS_DEC, PTE_FLAGS_DEC);

These changes with the _WP flags and helper addition belong in a pre-patch.

> @@ -382,7 +387,10 @@ static void __init build_workarea_map(struct boot_params *bp,
>  	ppd->paddr = workarea_start;
>  	ppd->vaddr = workarea_start;
>  	ppd->vaddr_end = workarea_end;
> -	sme_map_range_decrypted(ppd);
> +	if (sev_active())
> +		sme_map_range_encrypted(ppd);
> +	else
> +		sme_map_range_decrypted(ppd);
>  
>  	/* Flush the TLB - no globals so cr3 is enough */
>  	native_write_cr3(__native_read_cr3());
> @@ -439,16 +447,27 @@ static void __init build_workarea_map(struct boot_params *bp,
>  		sme_map_range_decrypted_wp(ppd);
>  	}
>  
> -	/* Add decrypted workarea mappings to both kernel mappings */
> +	/*
> +	 * When SEV is active, kernel is already encrypted hence mapping
> +	 * the initial workarea_start as encrypted. When SME is active,
> +	 * the kernel is not encrypted hence add a decrypted workarea

s/ a//

> +	 * mappings to both kernel mappings.
> +	 */
>  	ppd->paddr = workarea_start;
>  	ppd->vaddr = workarea_start;
>  	ppd->vaddr_end = workarea_end;
> -	sme_map_range_decrypted(ppd);
> +	if (sev_active())
> +		sme_map_range_encrypted(ppd);
> +	else
> +		sme_map_range_decrypted(ppd);
>  
>  	ppd->paddr = workarea_start;
>  	ppd->vaddr = workarea_start + decrypted_base;
>  	ppd->vaddr_end = workarea_end + decrypted_base;
> -	sme_map_range_decrypted(ppd);
> +	if (sev_active())
> +		sme_map_range_encrypted(ppd);
> +	else
> +		sme_map_range_decrypted(ppd);
>  
>  	wa->kernel_start = kernel_start;
>  	wa->kernel_end = kernel_end;
> @@ -491,28 +510,69 @@ static void __init remove_workarea_map(struct sme_workarea_data *wa,
>  	native_write_cr3(__native_read_cr3());
>  }
>  
> +static void __init decrypt_data_decrypted_section(struct sme_workarea_data *wa,

That function name could use some clarifying change...

> +						  struct sme_populate_pgd_data *ppd)
> +{
> +	unsigned long decrypted_start, decrypted_end, decrypted_len;
> +
> +	/* Physical addresses of decrypted data section */
> +	decrypted_start = __pa_symbol(__start_data_decrypted);
> +	decrypted_end = ALIGN(__pa_symbol(__end_data_decrypted), PMD_PAGE_SIZE);
> +	decrypted_len = decrypted_end - decrypted_start;
> +
> +	if (!decrypted_len)
> +		return;
> +
> +	/* Add decrypted mapping for the section (identity) */
> +	ppd->paddr = decrypted_start;
> +	ppd->vaddr = decrypted_start;
> +	ppd->vaddr_end = decrypted_end;
> +	sme_map_range_decrypted(ppd);
> +
> +	/* Add encrypted-wp mapping for the section (non-identity) */
> +	ppd->paddr = decrypted_start;
> +	ppd->vaddr = decrypted_start + wa->decrypted_base;
> +	ppd->vaddr_end = decrypted_end + wa->decrypted_base;
> +	sme_map_range_encrypted_wp(ppd);
> +
> +	/* Perform in-place decryption */
> +	sme_encrypt_execute(decrypted_start,
> +			    decrypted_start + wa->decrypted_base,
> +			    decrypted_len, wa->workarea_start,
> +			    (unsigned long)ppd->pgd);
> +
> +	ppd->vaddr = decrypted_start + wa->decrypted_base;
> +	ppd->vaddr_end = decrypted_end + wa->decrypted_base;
> +	sme_clear_pgd(ppd);
> +}
> +
>  void __init sme_encrypt_kernel(struct boot_params *bp)
>  {
>  	struct sme_populate_pgd_data ppd;
>  	struct sme_workarea_data wa;
>  
> -	if (!sme_active())
> +	if (!mem_encrypt_active())
>  		return;
>  
>  	build_workarea_map(bp, &wa, &ppd);
>  
> -	/* When SEV is active, encrypt kernel and initrd */
> -	sme_encrypt_execute(wa.kernel_start,
> -			    wa.kernel_start + wa.decrypted_base,
> -			    wa.kernel_len, wa.workarea_start,
> -			    (unsigned long)ppd.pgd);
> -
> -	if (wa.initrd_len)
> -		sme_encrypt_execute(wa.initrd_start,
> -				    wa.initrd_start + wa.decrypted_base,
> -				    wa.initrd_len, wa.workarea_start,
> +	/* When SME is active, encrypt kernel and initrd */
> +	if (sme_active()) {
> +		sme_encrypt_execute(wa.kernel_start,
> +				    wa.kernel_start + wa.decrypted_base,
> +				    wa.kernel_len, wa.workarea_start,
>  				    (unsigned long)ppd.pgd);
>  
> +		if (wa.initrd_len)
> +			sme_encrypt_execute(wa.initrd_start,
> +					    wa.initrd_start + wa.decrypted_base,
> +					    wa.initrd_len, wa.workarea_start,
> +					    (unsigned long)ppd.pgd);
> +	}
> +
> +	/* Decrypt the contents of .data..decrypted section */
> +	decrypt_data_decrypted_section(&wa, &ppd);
> +
>  	remove_workarea_map(&wa, &ppd);
>  }
>  
> -- 
> 2.7.4
> 

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
