Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751372AbeBVUxK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 15:53:10 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:37125 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbeBVUxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 15:53:09 -0500
X-Google-Smtp-Source: AH8x224QRoK9IRIzy8InM9q3h2Yw/3Kekb29wieT7ROh8VkQQQBc0MWQty+toPjsPcLu5CaIUwIQscsRFwg806k5+uQ=
MIME-Version: 1.0
In-Reply-To: <20180222203704.62AB5499@viggo.jf.intel.com>
References: <20180222203651.B776810C@viggo.jf.intel.com> <20180222203704.62AB5499@viggo.jf.intel.com>
From: Kees Cook <keescook@google.com>
Date: Thu, 22 Feb 2018 12:53:06 -0800
Message-ID: <CAGXu5j+1e8dnSWgg8oF1FS_EBhuHqPe3r5MzrCdFgE4bD_9a5Q@mail.gmail.com>
Subject: Re: [RFC][PATCH 08/10] x86/mm: do not forbid _PAGE_RW before init for __ro_after_init
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Juergen Gross <jgross@suse.com>,
        X86 ML <x86@kernel.org>, namit@vmware.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 12:37 PM, Dave Hansen
<dave.hansen@linux.intel.com> wrote:
>
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> __ro_after_init data gets stuck in the .rodata section.  That's normally
> fine because the kernel itself manages the R/W properties.
>
> But, if we run __change_page_attr() on an area which is __ro_after_init,
> the .rodata checks will trigger and force the area to be immediately
> read-only, even if it is early-ish in boot.  This caused problems when
> trying to clear the _PAGE_GLOBAL bit for these area in the PTI code:
> it cleared _PAGE_GLOBAL like I asked, but also took it up on itself
> to clear _PAGE_RW.  The kernel then oopses the next time it wrote to
> a __ro_after_init data structure.
>
> To fix this, add the kernel_set_to_readonly check, just like we have
> for kernel text, just a few lines below in this function.

Yup, looks sensible. Thanks!

>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Kees Cook <keescook@google.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: x86@kernel.org
> Cc: Nadav Amit <namit@vmware.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>
>  b/arch/x86/mm/pageattr.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff -puN arch/x86/mm/pageattr.c~check-kernel_set_to_readonly arch/x86/mm/pageattr.c
> --- a/arch/x86/mm/pageattr.c~check-kernel_set_to_readonly       2018-02-22 12:36:21.531036546 -0800
> +++ b/arch/x86/mm/pageattr.c    2018-02-22 12:36:21.535036546 -0800
> @@ -298,9 +298,11 @@ static inline pgprot_t static_protection
>
>         /*
>          * The .rodata section needs to be read-only. Using the pfn
> -        * catches all aliases.
> +        * catches all aliases.  This also includes __ro_after_init,
> +        * so do not enforce until kernel_set_to_readonly is true.
>          */
> -       if (within(pfn, __pa_symbol(__start_rodata) >> PAGE_SHIFT,
> +       if (kernel_set_to_readonly &&
> +           within(pfn, __pa_symbol(__start_rodata) >> PAGE_SHIFT,
>                    __pa_symbol(__end_rodata) >> PAGE_SHIFT))
>                 pgprot_val(forbidden) |= _PAGE_RW;
>
> _



-- 
Kees Cook
Pixel Security
