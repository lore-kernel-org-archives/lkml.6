Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29015C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 06:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28EE20870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 06:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRGhT4Fu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28EE20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbeJ2Oy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 10:54:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34630 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbeJ2OyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 10:54:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id l6-v6so7281650wrt.1;
        Sun, 28 Oct 2018 23:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fViLSSpmSunhL7kwz5QkTKH/7Udxa755oUcw9IRimvo=;
        b=KRGhT4Fu7vbnSOArVUCwqmGKhltLCUc2V1m4DYBtvXRrIPwy58qO/916kkkYKkD6Uj
         7vLd0Gni/l4F76jQPYQYE6eJkINLACovE6M3k/PXOPJvJ/WGJkJpBRPOPIVGTkOgmujm
         zbglArJExe1dWmCDg3zQUTQ+eN+onL4p6H8PPGuAbBlfwEYIEx5eSiF/IQpLqOMPQ1hX
         pk99sRJjIR4EsvoHgbvlMpfed3xhZaCpB0dCBrRXo4wH4SHOx3XpHFQrU3n7cHALNY5N
         rva4FeGcdGzJSKDMuCg3ez1GYGQY1EbDbR8thuv98kqIU7gY8K/j2AYGj4sJS8YFbvHo
         iAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fViLSSpmSunhL7kwz5QkTKH/7Udxa755oUcw9IRimvo=;
        b=Mq6VX4tVinsocsJwjL0smM8ysevIcCbbpvVMnMtpWVd0vQp3S1xb0A6/IfjZ1Ed6Di
         kTKpPXt9K9CrMbvFWvMoWpsK/CPcAUQrBDEg5eu8gJr+w5WvTW1l71x7a9qp3jG347FU
         NIvIY2IXpq1TqgNvR/WbVb5m9/SyziBysVIK1lv1JPie62rlqGXTyaKk6j+hhDFpSHWe
         8pzS5AiMgHLJiUtFbeN3ZkgiUSpbRaPDvXXQ9heib17sb5OQGiyLkwZ2Sz4OqfxxP66X
         R5hW/hMFEnlacAl9PRQ9IPLsI34E7eggdJbPkdN6X/83zsO1SHNMnbBSCeWh0y4MCX9/
         XtsQ==
X-Gm-Message-State: AGRZ1gI27uaG2ETLxSpKdWVQcvGjfsIZt7tV0aJoKbegLikhPQA1+zuC
        YjVuwkbWDel39rnV1yBxHRI=
X-Google-Smtp-Source: AJdET5dknmnfN1XApBWOkD6YUjsZbxovtePax5VDXxF4Y7N+E2oGpIt8VnW9zobMTpG4fT/hVACiHA==
X-Received: by 2002:adf:f852:: with SMTP id d18-v6mr12689825wrq.125.1540793231633;
        Sun, 28 Oct 2018 23:07:11 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b8sm13632204wrx.97.2018.10.28.23.07.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 23:07:10 -0700 (PDT)
Date:   Mon, 29 Oct 2018 07:07:08 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH V2 1/2] x86/efi: Unmap EFI boot services code/data
 regions from efi_pgd
Message-ID: <20181029060708.GB128403@gmail.com>
References: <20181026213845.28166-1-sai.praneeth.prakhya@intel.com>
 <20181026213845.28166-2-sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026213845.28166-2-sai.praneeth.prakhya@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com> wrote:

> Ideally, after kernel assumes control of the platform, firmware shouldn't
> access EFI boot services code/data regions. But, it's noticed that this is
> not so true in many x86 platforms. Hence, during boot, kernel reserves EFI
> boot services code/data regions [1] and maps [2] them to efi_pgd so that
> call to set_virtual_address_map() doesn't fail. After returning from
> set_virtual_address_map(), kernel frees the reserved regions [3] but they
> still remain mapped.
> 
> This means that any code that's running in efi_pgd address space (e.g: any
> EFI runtime service) would still be able to access EFI boot services
> code/data regions but the contents of these regions would have long been
> over written by someone else as they are freed by efi_free_boot_services().
> So, it's important to unmap these regions. After unmapping EFI boot
> services code/data regions, any illegal access by buggy firmware to these
> regions would result in page fault which will be handled by efi specific
> fault handler.
> 
> Unmapping EFI boot services code/data regions will result in clearing
> PAGE_PRESENT bit and it shouldn't bother L1TF cases because it's already
> handled by protnone_mask() at arch/x86/include/asm/pgtable-invert.h.
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
>  arch/x86/mm/pageattr.c               | 26 ++++++++++++++++++++++++++
>  arch/x86/platform/efi/quirks.c       | 25 +++++++++++++++++++++++++
>  3 files changed, 53 insertions(+)
> 
> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index b64acb08a62b..cda04ecf5432 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -566,6 +566,8 @@ extern pmd_t *lookup_pmd_address(unsigned long address);
>  extern phys_addr_t slow_virt_to_phys(void *__address);
>  extern int kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
>  				   unsigned numpages, unsigned long page_flags);
> +extern int kernel_unmap_pages_in_pgd(pgd_t *pgd, unsigned long address,
> +				     unsigned long numpages);
>  #endif	/* !__ASSEMBLY__ */
>  
>  #endif /* _ASM_X86_PGTABLE_DEFS_H */
> diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
> index 51a5a69ecac9..248f16181bed 100644
> --- a/arch/x86/mm/pageattr.c
> +++ b/arch/x86/mm/pageattr.c
> @@ -2147,6 +2147,32 @@ int kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
>  	return retval;
>  }
>  
> +int kernel_unmap_pages_in_pgd(pgd_t *pgd, unsigned long address,
> +			      unsigned long numpages)
> +{
> +	int retval;
> +
> +	/*
> +	 * The typical sequence for unmapping is to find a pte through
> +	 * lookup_address_in_pgd() (ideally, it should never return NULL because
> +	 * the address is already mapped) and change it's protections.
> +	 * As pfn is the *target* of a mapping, it's not useful while unmapping.
> +	 */
> +	struct cpa_data cpa = {
> +		.vaddr		= &address,
> +		.pgd		= pgd,
> +		.numpages	= numpages,
> +		.mask_set	= __pgprot(0),
> +		.mask_clr	= __pgprot(_PAGE_PRESENT | _PAGE_RW),
> +		.flags		= 0,
> +	};
> +
> +	retval = __change_page_attr_set_clr(&cpa, 0);
> +	__flush_tlb_all();

So, just to clarify, 'pfn' is kept at 0 here? Might make sense to write 
it out explicitly like 'flags', even if it's not used by 
__change_page_attr_set_clr().


> +
> +	return retval;
> +}
> +
>  /*
>   * The testcases use internal knowledge of the implementation that shouldn't
>   * be exposed to the rest of the kernel. Include these directly here.
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index 669babcaf245..fb1c44b11235 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -370,6 +370,24 @@ void __init efi_reserve_boot_services(void)
>  	}
>  }
>  
> +/*
> + * Apart from having VA mappings for EFI boot services code/data regions,
> + * (duplicate) 1:1 mappings were also created as a quirk for buggy firmware. So,
> + * unmap both 1:1 and VA mappings.
> + */
> +static void __init efi_unmap_pages(efi_memory_desc_t *md)
> +{
> +	pgd_t *pgd = efi_mm.pgd;
> +	u64 pa = md->phys_addr;
> +	u64 va = md->virt_addr;
> +
> +	if (kernel_unmap_pages_in_pgd(pgd, pa, md->num_pages))
> +		pr_err("Failed to unmap 1:1 mapping for 0x%llx\n", pa);
> +
> +	if (kernel_unmap_pages_in_pgd(pgd, va, md->num_pages))
> +		pr_err("Failed to unmap VA mapping for 0x%llx\n", va);
> +}
> +
>  void __init efi_free_boot_services(void)
>  {
>  	phys_addr_t new_phys, new_size;
> @@ -394,6 +412,13 @@ void __init efi_free_boot_services(void)
>  			continue;
>  		}
>  
> +		/*
> +		 * Before calling set_virtual_address_map(), EFI boot services
> +		 * code/data regions were mapped as a quirk for buggy firmware.
> +		 * Unmap them from efi_pgd before freeing them up.
> +		 */
> +		efi_unmap_pages(md);
> +
>  		/*
>  		 * Nasty quirk: if all sub-1MB memory is used for boot
>  		 * services, we can get here without having allocated the

Assuming nothing breaks and Ard likes it too:

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
