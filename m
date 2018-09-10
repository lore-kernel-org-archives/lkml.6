Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B5CC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E6020870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E6020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbeIJQsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:48:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:35372 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728015AbeIJQsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:48:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8627AAD57;
        Mon, 10 Sep 2018 11:54:50 +0000 (UTC)
Date:   Mon, 10 Sep 2018 13:54:43 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v6 3/5] x86/mm: add .data..decrypted section to hold
 shared variables
Message-ID: <20180910115443.GC21815@zn.tnic>
References: <1536343050-18532-1-git-send-email-brijesh.singh@amd.com>
 <1536343050-18532-4-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1536343050-18532-4-git-send-email-brijesh.singh@amd.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 12:57:28PM -0500, Brijesh Singh wrote:
> kvmclock defines few static variables which are shared with the
> hypervisor during the kvmclock initialization.
> 
> When SEV is active, memory is encrypted with a guest-specific key, and
> if guest OS wants to share the memory region with hypervisor then it must

"... if *the* guest OS ... with *the* hypervisor ..."

> clear the C-bit before sharing it.

<---- newline here.

> Currently, we use
> kernel_physical_mapping_init() to split large pages before clearing the
> C-bit on shared pages. But it fails when called from the kvmclock
> initialization (mainly because memblock allocator is not ready that early

		... because *the* memblock allocator...

hmm, those definite articles are kinda all lost... :)

> during boot).
> 
> Add a __decrypted section attribute which can be used when defining
> such shared variable. The so-defined variables will be placed in the
> .data..decrypted section. This section is mapped with C=0 early
> during boot, we also ensure that the initialized values are updated
> to match with C=0 (i.e perform an in-place decryption). The
> .data..decrypted section is PMD-aligned and sized so that we avoid
> the need to split the large pages when mapping the section.
> 
> The sme_encrypt_kernel() was used to perform the in-place encryption

Here, of all things, you don't need a definite article :)

"sme_encrypt_kernel() performs the in-place encryption...

> of the Linux kernel and initrd when SME is active. The routine has been
> enhanced to decrypt the .data..decrypted section for both SME and SEV
> cases.

Otherwise, that's a much better commit message!

> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
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
>  arch/x86/include/asm/mem_encrypt.h |  6 +++
>  arch/x86/kernel/head64.c           | 11 +++++
>  arch/x86/kernel/vmlinux.lds.S      | 17 +++++++
>  arch/x86/mm/mem_encrypt_identity.c | 94 ++++++++++++++++++++++++++++++++------
>  4 files changed, 113 insertions(+), 15 deletions(-)

...

> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 8bde0a4..4cb1064 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -65,6 +65,21 @@ jiffies_64 = jiffies;
>  #define ALIGN_ENTRY_TEXT_BEGIN	. = ALIGN(PMD_SIZE);
>  #define ALIGN_ENTRY_TEXT_END	. = ALIGN(PMD_SIZE);
>  
> +/*
> + * This section contains data which will be mapped as decrypted. Memory
> + * encryption operates on a page basis. Make this section PMD-aligned
> + * to avoid spliting the pages while mapping the section early.

"splitting" - damn, that spell checker of yours is still not working... ;-\

> + *
> + * Note: We use a separate section so that only this section gets
> + * decrypted to avoid exposing more than we wish.
> + */
> +#define DATA_DECRYPTED						\
> +	. = ALIGN(PMD_SIZE);					\
> +	__start_data_decrypted = .;				\
> +	*(.data..decrypted);					\
> +	. = ALIGN(PMD_SIZE);					\
> +	__end_data_decrypted = .;				\
> +
>  #else
>  
>  #define X86_ALIGN_RODATA_BEGIN

...

> @@ -487,28 +510,69 @@ static void __init teardown_workarea_map(struct sme_workarea_data *wa,
>  	native_write_cr3(__native_read_cr3());
>  }
>  
> +static void __init decrypt_shared_data(struct sme_workarea_data *wa,
> +				       struct sme_populate_pgd_data *ppd)
> +{
> +	unsigned long decrypted_start, decrypted_end, decrypted_len;
> +
> +	/* Physical addresses of decrypted data section */
> +	decrypted_start = __pa_symbol(__start_data_decrypted);
> +	decrypted_end = ALIGN(__pa_symbol(__end_data_decrypted), PMD_PAGE_SIZE);

Why?

You have:

+       . = ALIGN(PMD_SIZE);                                    \
+       __end_data_decrypted = .;                               \

It is already aligned by definition?!?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
