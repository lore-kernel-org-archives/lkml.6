Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752721AbeBSLrM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:47:12 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:37603 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752581AbeBSLrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:47:10 -0500
X-Google-Smtp-Source: AH8x224+OLxN0uwhKMDR97W1dLBxQJr6OsgTGeHbElVSlc6yVnvus0fYhzjogF4fXBV7HjFBYyG7+FcxslAuPNKRWeI=
MIME-Version: 1.0
In-Reply-To: <1517840166-15399-1-git-send-email-will.deacon@arm.com>
References: <1517840166-15399-1-git-send-email-will.deacon@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Feb 2018 12:47:08 +0100
X-Google-Sender-Auth: pqcfGL773QNOpWSxfgSB1E4uJig
Message-ID: <CAMuHMdU=DybUCyL3S11Uij1sHSoyBoeR3KXZz2A__kvgqVQmQA@mail.gmail.com>
Subject: Re: [PATCH] nospec: Move array_index_nospec parameter checking into
 separate macro
To: Will Deacon <will.deacon@arm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1JBlGCZ005499

Hi Will,

On Mon, Feb 5, 2018 at 3:16 PM, Will Deacon <will.deacon@arm.com> wrote:
> For architectures providing their own implementation of
> array_index_mask_nospec in asm/barrier.h, attempting to use WARN_ONCE to
> complain about out-of-range parameters using WARN_ON results in a mess
> of mutually-dependent include files.
>
> Rather than unpick the dependencies, simply have the core code in nospec.h
> perform the checking for us.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  include/linux/nospec.h | 36 +++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/nospec.h b/include/linux/nospec.h
> index b99bced39ac2..fbc98e2c8228 100644
> --- a/include/linux/nospec.h
> +++ b/include/linux/nospec.h
> @@ -20,20 +20,6 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
>                                                     unsigned long size)
>  {
>         /*
> -        * Warn developers about inappropriate array_index_nospec() usage.
> -        *
> -        * Even if the CPU speculates past the WARN_ONCE branch, the
> -        * sign bit of @index is taken into account when generating the
> -        * mask.
> -        *
> -        * This warning is compiled out when the compiler can infer that
> -        * @index and @size are less than LONG_MAX.
> -        */
> -       if (WARN_ONCE(index > LONG_MAX || size > LONG_MAX,
> -                       "array_index_nospec() limited to range of [0, LONG_MAX]\n"))
> -               return 0;
> -
> -       /*
>          * Always calculate and emit the mask even if the compiler
>          * thinks the mask is not needed. The compiler does not take
>          * into account the value of @index under speculation.
> @@ -44,6 +30,26 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
>  #endif
>
>  /*
> + * Warn developers about inappropriate array_index_nospec() usage.
> + *
> + * Even if the CPU speculates past the WARN_ONCE branch, the
> + * sign bit of @index is taken into account when generating the
> + * mask.
> + *
> + * This warning is compiled out when the compiler can infer that
> + * @index and @size are less than LONG_MAX.
> + */
> +#define array_index_mask_nospec_check(index, size)                             \
> +({                                                                             \
> +       if (WARN_ONCE(index > LONG_MAX || size > LONG_MAX,                      \
> +           "array_index_nospec() limited to range of [0, LONG_MAX]\n"))        \
> +               _mask = 0;                                                      \
> +       else                                                                    \
> +               _mask = array_index_mask_nospec(index, size);                   \
> +       _mask;                                                                  \
> +})
> +
> +/*
>   * array_index_nospec - sanitize an array index after a bounds check
>   *
>   * For a code sequence like:
> @@ -61,7 +67,7 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
>  ({                                                                     \
>         typeof(index) _i = (index);                                     \
>         typeof(size) _s = (size);                                       \
> -       unsigned long _mask = array_index_mask_nospec(_i, _s);          \
> +       unsigned long _mask = array_index_mask_nospec_check(_i, _s);    \
>                                                                         \
>         BUILD_BUG_ON(sizeof(_i) > sizeof(long));                        \
>         BUILD_BUG_ON(sizeof(_s) > sizeof(long));                        \

This change is commit 8fa80c503b484ddc ("nospec: Move array_index_nospec()
parameter checking into separate macro") in v4.16-rc2, and triggers the
following warning with gcc-4.1.2:

    net/wireless/nl80211.c: In function ‘parse_txq_params’:
    net/wireless/nl80211.c:2099: warning: comparison is always false
due to limited range of data type

Reverting the commit gets rid of the warning.

As kisskb hasn't completed the full build of  v4.16-rc2 yet, I don't know if
other compiler versions are affected.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
