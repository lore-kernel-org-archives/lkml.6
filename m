Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935522AbeEIRQd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:16:33 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:45478 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935505AbeEIRQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:16:26 -0400
X-Google-Smtp-Source: AB8JxZqeTYoGtnII+qD4sBQSuCy48JIzCbe/nl3zs7dp4EiLteAIqY6bjb+HnmjDS+dEDwXGKY8NlL6SPs0zJnm9Vic=
MIME-Version: 1.0
In-Reply-To: <20180509114328.9887-1-mpe@ellerman.id.au>
References: <20180509114328.9887-1-mpe@ellerman.id.au>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 9 May 2018 10:16:24 -0700
X-Google-Sender-Auth: yjyPubY8TcrQ-EfAnx89lN2Vfg8
Message-ID: <CAGXu5jJSDFid-w3kdhCYH_9d_n1AOnJkDaFg70OaWvjpsJ2sgQ@mail.gmail.com>
Subject: Re: [PATCH] lib/test_bitmap.c: Fix bitmap optimisation tests to
 report errors correctly
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 9, 2018 at 4:43 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
>
> I had neglected to increment the error counter when the tests failed,
> which made the tests noisy when they fail, but not actually return an
> error code.
>
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> Fixes: 3cc78125a081 ("lib/test_bitmap.c: add optimisation tests")
> Cc: stable@vger.kernel.org # v4.13+
> Tested-by: Michael Ellerman <mpe@ellerman.id.au>

FWIW:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  lib/test_bitmap.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> We noticed this a while back but the patch got lost.
>
> Andrew are you happy to take it?
>
> cheers
>
>
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index de16f7869fb1..6cd7d0740005 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -331,23 +331,32 @@ static void noinline __init test_mem_optimisations(void)
>         unsigned int start, nbits;
>
>         for (start = 0; start < 1024; start += 8) {
> -               memset(bmap1, 0x5a, sizeof(bmap1));
> -               memset(bmap2, 0x5a, sizeof(bmap2));
>                 for (nbits = 0; nbits < 1024 - start; nbits += 8) {
> +                       memset(bmap1, 0x5a, sizeof(bmap1));
> +                       memset(bmap2, 0x5a, sizeof(bmap2));
> +
>                         bitmap_set(bmap1, start, nbits);
>                         __bitmap_set(bmap2, start, nbits);
> -                       if (!bitmap_equal(bmap1, bmap2, 1024))
> +                       if (!bitmap_equal(bmap1, bmap2, 1024)) {
>                                 printk("set not equal %d %d\n", start, nbits);
> -                       if (!__bitmap_equal(bmap1, bmap2, 1024))
> +                               failed_tests++;
> +                       }
> +                       if (!__bitmap_equal(bmap1, bmap2, 1024)) {
>                                 printk("set not __equal %d %d\n", start, nbits);
> +                               failed_tests++;
> +                       }
>
>                         bitmap_clear(bmap1, start, nbits);
>                         __bitmap_clear(bmap2, start, nbits);
> -                       if (!bitmap_equal(bmap1, bmap2, 1024))
> +                       if (!bitmap_equal(bmap1, bmap2, 1024)) {
>                                 printk("clear not equal %d %d\n", start, nbits);
> -                       if (!__bitmap_equal(bmap1, bmap2, 1024))
> +                               failed_tests++;
> +                       }
> +                       if (!__bitmap_equal(bmap1, bmap2, 1024)) {
>                                 printk("clear not __equal %d %d\n", start,
>                                                                         nbits);
> +                               failed_tests++;
> +                       }
>                 }
>         }
>  }
> --
> 2.14.1
>



-- 
Kees Cook
Pixel Security
