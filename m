Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED346ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 01:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AE720652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 01:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPILk+G/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98AE720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbeJVKOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 06:14:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39952 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbeJVKOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 06:14:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id d2-v6so43099100wro.7;
        Sun, 21 Oct 2018 18:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ojTOEs+8njVQiQ7CsF/ABi4pQ6MudcxosewOh9vmRws=;
        b=OPILk+G/BXMB3+HTxQUyX996cESwSWlnOR4XkQ7aNVF/sCDe2ymuPezXuZycdH6wX3
         uMkkYHw9VdaXIraMri54/GfaGgS66PBq9s/jr7S2r5bM8EDKiEDShQQO+CzxX0HxZc52
         ulZ51GTgyGHPC+X+Af4Gacei/D2gAwFlIlBC15oyFEEa+8UHv9T/9UPvHdptQV16xmYw
         hawMIp0ah8Ww6zurgpQCNX1pvQNDVG/8ry87e46f4R4dpSvB64+N1YS9i8r+CE4n0MwQ
         nVRkil2npySgT4e2K6ZRhkOPo6W6GVGFMCUdQ33meLeDyI4rZjkyeiQkCoYK7gFbm/L/
         xzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ojTOEs+8njVQiQ7CsF/ABi4pQ6MudcxosewOh9vmRws=;
        b=SmgQurxBhCVFUmW90GJRhthWVr5cKh9j1vV5edYRlUl0HxD6/mdb+tQLegnZre1uSC
         G+KAIC7PbJx4FRYiv14vdtU73NGpb7wF2gcSaB0FL6I/ZrnYKMTrwkzd6EY0pAkjXN3h
         BPRhcAN+6KE8rOkdtRCVm2gF1+OOvSJVRk5nH+7EQ8AAtiKymcg9LscBvdhVOYKNi7xM
         QsJEFt+i+8EGM3qpD8MDB1XEpGJpO0NyRMoh2r19EuX3QlpDOH6mUN4Kp++ZYf0qU0vn
         hpW8W+lAKBu8yi16r34NgifmalJTV+l1Q9HcHXBScMiQdKAwQhE5RtnOaudPRM2cXlFo
         AmsQ==
X-Gm-Message-State: ABuFfoicUbVK52JxAbv0L6pqy9AvBqvACuC6tCyXtxvDYa2VJfFrElfE
        BQGW6Q/IwxuLqSzKcAjtxJw=
X-Google-Smtp-Source: ACcGV63SNbJUW6HVfqJTwkITrWZrbiMsWXJ9FdwrdezuJFfW5+EEoSTSwHFMwe10j2V3OE0D3rVPiQ==
X-Received: by 2002:adf:92a6:: with SMTP id 35-v6mr45523536wrn.137.1540173461640;
        Sun, 21 Oct 2018 18:57:41 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h82-v6sm7816133wmf.14.2018.10.21.18.57.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 18:57:40 -0700 (PDT)
Date:   Mon, 22 Oct 2018 03:57:38 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 1/2] x86/efi: Unmap efi boot services code/data regions
 from efi_pgd
Message-ID: <20181022015738.GB24095@gmail.com>
References: <1540172145-17134-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1540172145-17134-2-git-send-email-sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540172145-17134-2-git-send-email-sai.praneeth.prakhya@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com> wrote:

> Ideally, after kernel assumes control of the platform firmware shouldn't
> access EFI Boot Services Code/Data regions. But, it's noticed that this
> is not so true in many x86 platforms. Hence, during boot, kernel
> reserves efi boot services code/data regions [1] and maps [2] them to
> efi_pgd so that call to set_virtual_address_map() doesn't fail. After
> returning from set_virtual_address_map(), kernel frees the reserved
> regions [3] but they still remain mapped.
> 
> This means that any code that's running in efi_pgd address space (e.g:
> any efi runtime service) would still be able to access efi boot services
> code/data regions but the contents of these regions would have long been
> over written by someone else as they are freed by efi_free_boot_services().
> So, it's important to unmap these regions. After unmapping boot services
> code/data regions, any illegal access by buggy firmware to these regions
> would result in page fault which will be handled by efi specific fault
> handler.
> 
> [1] Please see efi_reserve_boot_services()
> [2] Please see efi_map_region() -> __map_region()
> [3] Please see efi_free_boot_services()
> 
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Bhupesh Sharma <bhsharma@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/x86/include/asm/pgtable_types.h |  2 ++
>  arch/x86/mm/pageattr.c               | 21 +++++++++++++++++++++
>  arch/x86/platform/efi/quirks.c       | 26 ++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+)
> 
> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index b64acb08a62b..796476f11151 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -566,6 +566,8 @@ extern pmd_t *lookup_pmd_address(unsigned long address);
>  extern phys_addr_t slow_virt_to_phys(void *__address);
>  extern int kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
>  				   unsigned numpages, unsigned long page_flags);
> +extern int kernel_unmap_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
> +				     unsigned long numpages);
>  #endif	/* !__ASSEMBLY__ */
>  
>  #endif /* _ASM_X86_PGTABLE_DEFS_H */
> diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
> index 51a5a69ecac9..b88ed8e91790 100644
> --- a/arch/x86/mm/pageattr.c
> +++ b/arch/x86/mm/pageattr.c
> @@ -2147,6 +2147,27 @@ int kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
>  	return retval;
>  }
>  
> +int kernel_unmap_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
> +			      unsigned long numpages)
> +{
> +	int retval;
> +
> +	struct cpa_data cpa = {
> +		.vaddr = &address,
> +		.pfn = pfn,
> +		.pgd = pgd,
> +		.numpages = numpages,
> +		.mask_set = __pgprot(0),
> +		.mask_clr = __pgprot(_PAGE_PRESENT | _PAGE_RW),
> +		.flags = 0,
> +	};
> +
> +	retval = __change_page_attr_set_clr(&cpa, 0);
> +	__flush_tlb_all();
> +
> +	return retval;
> +}

That's certainly a creative use of __change_page_attr_set_clr() by EFI 
used for mapping in pages so far (kernel_map_pages_in_pgd()), and now 
used for unmapping as well. Doesn't look wrong, just a bit weird as part 
of CPA.

Could you please write the initializer in an easier to read fashion:

	struct cpa_data cpa = {
		.vaddr		= &address,
		.pfn		= pfn,
		.pgd		= pgd,
		.numpages	= numpages,
		.mask_set	= __pgprot(0),
		.mask_clr	= __pgprot(_PAGE_PRESENT | _PAGE_RW),
		.flags		= 0,
	};

?

The one bit that is odd is the cpa->pfn field - for unmapped pages that's 
totally uninteresting and I'm wondering whether setting it to 0 wouldn't 
be better.

Does the CPU _ever_ look look at the PFN if the page is !_PAGE_PRESENT, 
for example speculatively? If yes then what is the recommended value for 
the pfn - zero perhaps?

Also note that if for whatever reason the PFN range of the EFI boot area 
gets hot-unplugged, we'd have outright invalid PFNs - although this is 
probably very unlikely from a platform perspective.

> +/*
> + * Apart from having VA mappings for efi boot services code/data regions,
> + * (duplicate) 1:1 mappings were also created as a catch for buggy firmware. So,
> + * unmap both 1:1 and VA mappings.
> + */

Speling nits:

- please capitalize 'EFI' consistently.
- s/catch/quirk ?

BTW., are the 1:1 'boot mappings' a buggy firmware quirk, or something 
required by the EFI spec? (or both? ;-)

> +static void __init efi_unmap_pages(efi_memory_desc_t *md)
> +{
> +	pgd_t *pgd = efi_mm.pgd;
> +	u64 pfn = md->phys_addr >> PAGE_SHIFT;

Note that this md->phys_addr isn't really meaningful once it gets 
unmapped.

> +
> +	if (kernel_unmap_pages_in_pgd(pgd, pfn, md->phys_addr, md->num_pages))
> +		pr_err("Failed to unmap 1:1 mapping: PA 0x%llx -> VA 0x%llx!\n",
> +		       md->phys_addr, md->virt_addr);
> +
> +	if (kernel_unmap_pages_in_pgd(pgd, pfn, md->virt_addr, md->num_pages))
> +		pr_err("Failed to unmap VA mapping: PA 0x%llx -> VA 0x%llx!\n",
> +		       md->phys_addr, md->virt_addr);

Please keep pr_err()'s in a single line. (and ignore checkpatch.)

> +}
> +
>  void __init efi_free_boot_services(void)
>  {
>  	phys_addr_t new_phys, new_size;
> @@ -415,6 +434,13 @@ void __init efi_free_boot_services(void)
>  		}
>  
>  		free_bootmem_late(start, size);
> +
> +		/*
> +		 * Before calling set_virtual_address_map(), boot services
> +		 * code/data regions were mapped as a catch for buggy firmware.
> +		 * Unmap them from efi_pgd as they have already been freed.
> +		 */
> +		efi_unmap_pages(md);

Ditto.

BTW., the ordering here is wrong: we should unmap any virtual aliases 
from pagetables _before_ we free the underlying memory. The ordering is 
probably harmless in this case but overall a good practice.

Thanks,

	Ingo
