Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888F0FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 263BE20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 263BE20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeINMYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 08:24:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:46892 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727005AbeINMYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 08:24:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B20A9AC3B;
        Fri, 14 Sep 2018 07:11:04 +0000 (UTC)
Date:   Fri, 14 Sep 2018 09:10:56 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v8 1/2] x86/mm: add .bss..decrypted section to hold
 shared variables
Message-ID: <20180914071056.GA4747@zn.tnic>
References: <1536875471-17391-1-git-send-email-brijesh.singh@amd.com>
 <1536875471-17391-2-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1536875471-17391-2-git-send-email-brijesh.singh@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 04:51:10PM -0500, Brijesh Singh wrote:
> kvmclock defines few static variables which are shared with the
> hypervisor during the kvmclock initialization.

...

> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index 8047379..c16af27 100644
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
> @@ -235,6 +236,21 @@ unsigned long __head __startup_64(unsigned long physaddr,
>  	sme_encrypt_kernel(bp);
>  
>  	/*
> +	 * Clear the memory encryption mask from the .bss..decrypted section.
> +	 * The bss section will be memset to zero later in the initialization so
> +	 * there is no need to zero it after changing the memory encryption
> +	 * attribute.
> +	 */
> +	if (mem_encrypt_active()) {
> +		vaddr = (unsigned long)__start_bss_decrypted;
> +		vaddr_end = (unsigned long)__end_bss_decrypted;
> +		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
> +			i = pmd_index(vaddr);
> +			pmd[i] -= sme_get_me_mask();
> +		}
> +	}

Why isn't this chunk at the end of sme_encrypt_kernel() instead of here?

> +	/*
>  	 * Return the SME encryption mask (if SME is active) to be used as a
>  	 * modifier for the initial pgdir entry programmed into CR3.
>  	 */
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 9c77d2d..0d618ee 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -65,6 +65,23 @@ jiffies_64 = jiffies;
>  #define ALIGN_ENTRY_TEXT_BEGIN	. = ALIGN(PMD_SIZE);
>  #define ALIGN_ENTRY_TEXT_END	. = ALIGN(PMD_SIZE);
>  
> +/*
> + * This section contains data which will be mapped as decrypted. Memory
> + * encryption operates on a page basis. Make this section PMD-aligned
> + * to avoid splitting the pages while mapping the section early.
> + *
> + * Note: We use a separate section so that only this section gets
> + * decrypted to avoid exposing more than we wish.
> + */
> +#define BSS_DECRYPTED						\
> +	. = ALIGN(PMD_SIZE);					\
> +	__start_bss_decrypted = .;				\
> +	*(.bss..decrypted);					\
> +	. = ALIGN(PAGE_SIZE);					\
> +	__start_bss_decrypted_unused = .;			\
> +	. = ALIGN(PMD_SIZE);					\
> +	__end_bss_decrypted = .;				\
> +
>  #else
>  
>  #define X86_ALIGN_RODATA_BEGIN
> @@ -74,6 +91,7 @@ jiffies_64 = jiffies;
>  
>  #define ALIGN_ENTRY_TEXT_BEGIN
>  #define ALIGN_ENTRY_TEXT_END
> +#define BSS_DECRYPTED
>  
>  #endif
>  
> @@ -345,6 +363,7 @@ SECTIONS
>  		__bss_start = .;
>  		*(.bss..page_aligned)
>  		*(.bss)
> +		BSS_DECRYPTED
>  		. = ALIGN(PAGE_SIZE);
>  		__bss_stop = .;

Putting it in the BSS would need a bit of care in the future as it poses
a certain ordering on the calls in x86_64_start_kernel() (not that there
isn't any now :)):

You have:

x86_64_start_kernel:

	...

	clear_bss();

	...

	x86_64_start_reservations() -> ... -> setup_arch() -> kvmclock_init()

so it would be prudent to put at least a comment somewhere, say, over
the definition of BSS_DECRYPTED or so, that attention should be paid to
the clear_bss() call early.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
