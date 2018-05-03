Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbeECDml (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 23:42:41 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38732 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751993AbeECDmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 23:42:39 -0400
X-Google-Smtp-Source: AB8JxZorrcSE7GGsyeqZMk0+M3cH0bVv8Ws2/YZMVK6llEU9rc0xW0UyeE9Y1I98xQDqvv3bWByV5g==
Date: Wed, 2 May 2018 20:42:30 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/boot/compressed: Exclude 'top_pgtable' from
 relocation
In-Reply-To: <20180502160816.35986-1-kirill.shutemov@linux.intel.com>
Message-ID: <alpine.LSU.2.11.1805022001080.3096@eggly.anvils>
References: <20180502160816.35986-1-kirill.shutemov@linux.intel.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 May 2018, Kirill A. Shutemov wrote:

> startup_64() copies kernel (including .data section) to the new place.
> It's required for safe in-place decompression.
> 
> This is a problem if the original place is referenced: by mistake I've
> put 'top_pgtable' into .data section and the address is loaded into CR3.
> If the original place gets overwritten during image decompression the
> kernel will crash and the machine will be rebooted.
> 
> Move 'top_pgtable' into .pgtable section where the rest of page tables
> are. This section is not subject for relocation.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: e9d0e6330eb8 ("x86/boot/compressed/64: Prepare new top-level page table for trampoline")

Thanks for the Cc, Kirill, which I presume was because I'd mentioned
to you that I was unable to boot 4.17-rc on laptop or workstation.

Which is still so with 4.17-rc3, and I'm sorry to say still so with this
patch: even if I add the fix which I think this patch needs, see below.

I did bisect on Monday, and the first bad was your commit 194a9749c73d
"x86/boot/compressed/64: Handle 5-level paging boot if kernel is above 4G".
(Cc'ing Dave since his PTI Global work was my other suspect, but that's
off the hook - if I revert just 194a9749c73d then I have no trouble.)

Am I really the only one getting immediate reboot on x86_64?
Perhaps everyone else has machines with 5-level page tables now ?-)

I've looked at the changes a little, and tried a few things (hoping to
avoid a long back and forth describing and trying things for you); but
no success yet, and rather out of my depth with these changes - I've
not had to delve into boot/compressed before.

(I did briefly get excited by the
trampoline_32bit + TRAMPOLINE_32BIT_PGTABLE_OFFSET
in cleanup_trampoline(), which lacks a "/ sizeof(unsigned long)";
but since ...PGTABLE_OFFSET is 0 anyway, that's nothing but cosmetic.)

Hugh

> ---
>  arch/x86/boot/compressed/head_64.S    | 8 ++++++++
>  arch/x86/boot/compressed/pgtable_64.c | 4 +---
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index fca012baba19..c433c21703e6 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -649,3 +649,11 @@ boot_stack_end:
>  	.balign 4096
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
> index 32af1cbcd903..3a0578f54550 100644
> --- a/arch/x86/boot/compressed/pgtable_64.c
> +++ b/arch/x86/boot/compressed/pgtable_64.c
> @@ -25,10 +25,8 @@ static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
>  /*
>   * The page table is going to be used instead of page table in the trampoline
>   * memory.
> - *
> - * It must not be in BSS as BSS is cleared after cleanup_trampoline().
>   */
> -static char top_pgtable[PAGE_SIZE] __aligned(PAGE_SIZE) __section(.data);
> +extern char *top_pgtable;

Doesn't that need to be extern char top_pgtable[] ?

>  
>  /*
>   * Trampoline address will be printed by extract_kernel() for debugging
> -- 
> 2.17.0
