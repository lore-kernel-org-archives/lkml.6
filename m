Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753681AbeE3VMn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:12:43 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:41405 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753275AbeE3VMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:12:40 -0400
X-Google-Smtp-Source: ADUXVKLCorTu4PNiSFTBuy8P3FAj+zYrTjuapI7Ovy3OlPgSb+xdwRrEFbT7mxca5rGNOB9WlINwVNUbLx+RkcYHQwM=
MIME-Version: 1.0
In-Reply-To: <20180530134645.GA31844@parrot.com>
References: <20180529224207.GA13354@beast> <20180530134645.GA31844@parrot.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 30 May 2018 14:12:38 -0700
X-Google-Sender-Auth: ABUQGIK4S18pknpvjvl7kC7Wwzk
Message-ID: <CAGXu5jK-Z=Ms2mdxmDnA5Gji-tx4HfDGtFRPYNcEwtQC-DzeHw@mail.gmail.com>
Subject: Re: [PATCH] lib/bch: Remove VLA usage
To: Ivan Djelic <ivan.djelic@parrot.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Linux mtd <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4ULCnUV017772

On Wed, May 30, 2018 at 6:46 AM, Ivan Djelic <ivan.djelic@parrot.com> wrote:
> On Tue, May 29, 2018 at 03:42:07PM -0700, Kees Cook wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this removes
>> the on-stack working buffers in favor of pre-allocated working buffers
>> (which were already used in other places). Since these routines must
>> already be serialized (since they work on bch->ecc_buf), adding the usage
>> of bch->ecc_work would be similarly safe. Additionally, since "max m" is
>> only 15, this was adjusted to just use a fixed size array in those cases.
>
> Hi Kees,
>
> Using an on-stack buffer instead of a pre-allocated buffer was done initially
> for performance reasons.  For "usual" (m,t) values (for instance m=13, t=4),
> there is a huge performance difference between the on-stack buffer version and
> the kmalloc version. I didn't investigate the reason for this, but I ran a
> quick benchmark on my PC:
>
> little-endian, type sizes: int=4 long=8 longlong=8
> cpu: Intel(R) Core(TM) i5 CPU         650  @ 3.20GHz
> calibration: iter=4.9143µs niter=2034 nsamples=200 m=13 t=4
>
>   Buffer allocation |  Encoding throughput (Mbit/s)
> ---------------------------------------------------
>  on-stack, VLA      |   3988
>  on-stack, fixed    |   4494
>  kmalloc            |   1967
>
> The first line shows the performance of the current code, using a VLA.
> The second line shows the performance when r[] is allocated on the stack with
> a fixed, constant size (the maximum allowed value).
> The third line shows the performance when r is a pre-allocated working buffer.
>
> In fact, when using a pre-allocated buffer there is no need to introduce 'ecc_work':
> you can directly point 'r' to bch->ecc_buf and remove memcpy() surrounding the
> 'while (mlen--)' loop. Everything happens inside the 'bch->ecc_buf' buffer.
> But with a big performance penalty. Looks like declaring a temporary buffer on the
> stack to store ECC values allows GCC to do a better job at optimizing the loop.
>
> So rather than introducing 'ecc_work', I suggest we compute the maximum allowed
> size for r[] and use that:
>
> sizeof(r) = sizeof(uint32_t)*(l+1)
> l+1 = BCH_ECC_WORDS(bch) = DIV_ROUND_UP(m*t, 32)
>
> We also know that:
>
> m*t < 2^m - 1 (ECC maximum size)
>
> therefore:
>
> l+1 < DIV_ROUND_UP(2^m - 1, 32) < 2^(m-5)
>
> So instead of 'uint32_t r[l+1]' we could declare 'uint32_t r[1 << (BCH_MAX_M-5)]'.
> And replace 'sizeof(r)' with 'sizeof(*bch->ecc_buf)*(l+1)' in memset/memcpy calls.
> In practice the actual maximum size of r[] is (1 << (15-5))*sizeof(uint32_t) = 4096 bytes.
>
> What do you think ?

I actually did that implementation first since I didn't realize how
large that allocation could get. 4096 is a HUGE stack allocation. The
kernel build warns at 2048. The defaults seen during allmodconfig are:

CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4

So those builds are already seeing a large stack allocation, but it
was hidden from the checking tools before because it was a dynamic
stack allocation:

lib/bch.c: In function ‘encode_bch’:
lib/bch.c:261:1: warning: the frame size of 2288 bytes is larger than
2048 bytes [-Wframe-larger-than=]

This could be masked in the Makefile, though, since this is already
the situation the code runs under. I'll send that patch...

-Kees

-- 
Kees Cook
Pixel Security
