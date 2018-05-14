Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752687AbeENVeH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:34:07 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51714 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752173AbeENVeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:34:04 -0400
X-Google-Smtp-Source: AB8JxZpspsHs5GhzoUdoUKiOO1q2aU/9LE8/BgwtQjJ0lIWi5HmKn3rJ5PG/jA2VgEJbXUNjHkc2Lm5d+ABLTVFx3h0=
MIME-Version: 1.0
In-Reply-To: <1526306235-29755-1-git-send-email-geert@linux-m68k.org>
References: <1526306235-29755-1-git-send-email-geert@linux-m68k.org>
From: Martijn Coenen <maco@android.com>
Date: Mon, 14 May 2018 23:34:03 +0200
Message-ID: <CAB0TPYHGa-yOMLWdxvSMV942as+ygpHOUR4W9tpDFGmufoimqw@mail.gmail.com>
Subject: Re: [PATCH] m68k/uaccess: Revive 64-bit get_user()
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k <linux-m68k@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 3:57 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Revive support for 64-bit get_user(), which was disabled in commit
> d94af931af42152e ("[PATCH] m68k: clean up uaccess.h") due to a "broken"
> typeof in (then brand new) gcc-4.1.
>
>   - Keep on using u64 for the temporary, as __typeof__() doesn't drop
>     the const qualifier,
>   - Move it into a union (like mips32 does) to get rid of the cast, as
>     using get_user() to fetch a __user pointer would cause a "cast to
>     pointer from integer of different size" warning otherwise.

Can't vouch for the existing asm, but the changes to it look good to
me otherwise.

>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Martijn Coenen <maco@android.com>

> ---
>  arch/m68k/include/asm/uaccess_mm.h | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/arch/m68k/include/asm/uaccess_mm.h b/arch/m68k/include/asm/uaccess_mm.h
> index 75c172e909acdf18..c4cb889660aa0c35 100644
> --- a/arch/m68k/include/asm/uaccess_mm.h
> +++ b/arch/m68k/include/asm/uaccess_mm.h
> @@ -141,10 +141,12 @@ asm volatile ("\n"                                        \
>         case 4:                                                         \
>                 __get_user_asm(__gu_err, x, ptr, u32, l, r, -EFAULT);   \
>                 break;                                                  \
> -/*     case 8: disabled because gcc-4.1 has a broken typeof            \
> -           {                                                           \
> -               const void *__gu_ptr = (ptr);                           \
> -               u64 __gu_val;                                           \
> +       case 8: {                                                       \
> +               const void *__gu_ptr = (ptr);                           \
> +               union {                                                 \
> +                       u64 l;                                          \
> +                       __typeof__(*(ptr)) t;                           \
> +               } __gu_val;                                             \
>                 asm volatile ("\n"                                      \
>                         "1:     "MOVES".l       (%2)+,%1\n"             \
>                         "2:     "MOVES".l       (%2),%R1\n"             \
> @@ -162,13 +164,13 @@ asm volatile ("\n"                                        \
>                         "       .long   1b,10b\n"                       \
>                         "       .long   2b,10b\n"                       \
>                         "       .previous"                              \
> -                       : "+d" (__gu_err), "=&r" (__gu_val),            \
> +                       : "+d" (__gu_err), "=&r" (__gu_val.l),          \
>                           "+a" (__gu_ptr)                               \
>                         : "i" (-EFAULT)                                 \
>                         : "memory");                                    \
> -               (x) = (__force typeof(*(ptr)))__gu_val;                 \
> +               (x) = __gu_val.t;                                       \
>                 break;                                                  \
> -           }   */                                                      \
> +       }                                                               \
>         default:                                                        \
>                 __gu_err = __get_user_bad();                            \
>                 break;                                                  \
> --
> 2.7.4
>
