Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752366AbeEPOJu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 10:09:50 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:42182 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbeEPOJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 10:09:48 -0400
X-Google-Smtp-Source: AB8JxZqfEEhlah2tKKHwH1QM1FfoPQk87P7Mgw3DxHHo+nWdpLXMSYuhcxVPFKeGOGCrDTNxblfVjDqZBpoHQyNDe24=
MIME-Version: 1.0
In-Reply-To: <20180515141124.84254-18-namit@vmware.com>
References: <20180515141124.84254-1-namit@vmware.com> <20180515141124.84254-18-namit@vmware.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 16 May 2018 07:09:46 -0700
X-Google-Sender-Auth: CalvUtI-o9jZ6A_ZDtvzltBNi0I
Message-ID: <CAGXu5jKGdy_VGpAnNGbK14fp43d3XuKU+b_1FMWFC1WFyg4WxA@mail.gmail.com>
Subject: Re: [RFC 8/8] bitops: prevent compiler inline decision distortion
To: Nadav Amit <namit@vmware.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 7:11 AM, Nadav Amit <namit@vmware.com> wrote:
> There are several places in the kernel in which there is a condition
> that is based on whether the input is known to be constant in
> compilation time. If it is, there are complex computations, which only
> take place during compilation time.

What we found while rewriting the min()/max() defines was that GCC's
__builtin_choose_expr() evaluates constant expressions, not the wider
possibility of constant values. And the older the GCC the less
__builtin_constant_p() would resolve to a constant expression, which
would force __builtin_choose_expr() along the "non constant" path.

> Although this scheme works correctly, when GCC computes the expected
> cost of this code in time and size, it disregards the fact that the
> computations of the "constant" case will not take place during runtime
> for the non-constant case. The cost of these functions is considered to
> be much higher.  As a result, inline and branching decisions of the
> compiler are distorted. Specifically, functions are less likely to be
> inlined due to their preserved big size and execution time.
>
> One of this cases is test_bit() which performs some computations for
> constant inputs.
>
> The solution is to use __builtin_choose_expr() to detect whether the
> input is constant instead of a C condition. GCC evaluates the builtin
> earlier, which allows it to improve code-generation decisions.

In the case of test_bit(), I *think* all the optimization-desired
cases are already only constant expressions, so I think this is safe,
but I wouldn't want to do this generally for uses of
__builtin_constant_p().

-Kees

>
> This patch allows function such as bitmap_pos_to_ord() to be inlined.
> Its overall effect on size:
>
>    text    data     bss     dec     hex filename
> 18149165 10064176 2936832 31150173 1db505d ./vmlinux before
> 18149210 10064048 2936832 31150090 1db500a ./vmlinux after (-83)
>
> Static text symbols:
> Before: 39643
> After:  39632   (-11)
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  arch/x86/include/asm/bitops.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
> index 9f645ba57dbb..f1cb1c9125a9 100644
> --- a/arch/x86/include/asm/bitops.h
> +++ b/arch/x86/include/asm/bitops.h
> @@ -349,10 +349,10 @@ static __always_inline bool variable_test_bit(long nr, volatile const unsigned l
>  static bool test_bit(int nr, const volatile unsigned long *addr);
>  #endif
>
> -#define test_bit(nr, addr)                     \
> -       (__builtin_constant_p((nr))             \
> -        ? constant_test_bit((nr), (addr))      \
> -        : variable_test_bit((nr), (addr)))
> +#define test_bit(nr, addr)                                     \
> +       __builtin_choose_expr(__builtin_constant_p((nr)),       \
> +               constant_test_bit((nr), (addr)),                \
> +               variable_test_bit((nr), (addr)))
>
>  /**
>   * __ffs - find first set bit in word
> --
> 2.17.0
>



-- 
Kees Cook
Pixel Security
