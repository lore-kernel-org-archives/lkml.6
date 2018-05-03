Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751382AbeECRUE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 13:20:04 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:42581 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbeECRUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 13:20:03 -0400
X-Google-Smtp-Source: AB8JxZqxnmOB24GS3+Y7jpOZR7ol+tNlWeIeid5qvpRFDYMi6ZIaKLBtDyc8LgGwqJSocohgFxPZbg==
Date: Thu, 3 May 2018 10:19:53 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
cc: "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/boot/compressed: Exclude 'top_pgtable' from
 relocation
In-Reply-To: <20180503105205.qmosbbbbp5jssehj@black.fi.intel.com>
Message-ID: <alpine.LSU.2.11.1805031017420.1259@eggly.anvils>
References: <20180502160816.35986-1-kirill.shutemov@linux.intel.com> <alpine.LSU.2.11.1805022001080.3096@eggly.anvils> <20180503083849.j42uzp6jjpauk475@kshutemo-mobl1> <20180503105205.qmosbbbbp5jssehj@black.fi.intel.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 May 2018, Kirill A. Shutemov wrote:

> On Thu, May 03, 2018 at 08:38:49AM +0000, Kirill A. Shutemov wrote:
> > The patch is bogus and I still don't understand what is going on.
> 
> I think I found the issue. Could you check the patch below:

Sorry, no good on either machine, immediate reboot as before.
I'm gathering the info you asked, will send privately in an hour or so.

Hugh

> 
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index fca012baba19..86169ae1c536 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -370,10 +370,13 @@ trampoline_return:
>  	/*
>  	 * cleanup_trampoline() would restore trampoline memory.
>  	 *
> +	 * RDI is address of the page table to use (if required).
> +	 *
>  	 * RSI holds real mode data and needs to be preserved across
>  	 * this function call.
>  	 */
>  	pushq	%rsi
> +	leaq	top_pgtable(%rbx), %rdi
>  	call	cleanup_trampoline
>  	popq	%rsi
>  
> @@ -647,5 +650,14 @@ boot_stack_end:
>   */
>  	.section ".pgtable","a",@nobits
>  	.balign 4096
> +	.global pgtable
>  pgtable:
>  	.fill BOOT_PGT_SIZE, 1, 0
> +
> +/*
> + * The page table is going to be used instead of page table in the trampoline
> + * memory.
> + */
> +	.global top_pgtable
> +top_pgtable:
> +	.fill PAGE_SIZE, 1, 0
> diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
> index 32af1cbcd903..a362fa0b849c 100644
> --- a/arch/x86/boot/compressed/pgtable_64.c
> +++ b/arch/x86/boot/compressed/pgtable_64.c
> @@ -22,14 +22,6 @@ struct paging_config {
>  /* Buffer to preserve trampoline memory */
>  static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
>  
> -/*
> - * The page table is going to be used instead of page table in the trampoline
> - * memory.
> - *
> - * It must not be in BSS as BSS is cleared after cleanup_trampoline().
> - */
> -static char top_pgtable[PAGE_SIZE] __aligned(PAGE_SIZE) __section(.data);
> -
>  /*
>   * Trampoline address will be printed by extract_kernel() for debugging
>   * purposes.
> @@ -134,7 +126,7 @@ struct paging_config paging_prepare(void)
>  	return paging_config;
>  }
>  
> -void cleanup_trampoline(void)
> +void cleanup_trampoline(void *pgtable)
>  {
>  	void *trampoline_pgtable;
>  
> @@ -145,8 +137,8 @@ void cleanup_trampoline(void)
>  	 * if it's there.
>  	 */
>  	if ((void *)__native_read_cr3() == trampoline_pgtable) {
> -		memcpy(top_pgtable, trampoline_pgtable, PAGE_SIZE);
> -		native_write_cr3((unsigned long)top_pgtable);
> +		memcpy(pgtable, trampoline_pgtable, PAGE_SIZE);
> +		native_write_cr3((unsigned long)pgtable);
>  	}
>  
>  	/* Restore trampoline memory */
> -- 
>  Kirill A. Shutemov
> 
