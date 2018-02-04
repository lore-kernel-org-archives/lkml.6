Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbeBDKU4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 05:20:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:49468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751015AbeBDKUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 05:20:49 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 653AD217AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 4 Feb 2018 10:20:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Crt Mori <cmo@melexis.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Rusty Russell <rusty@rustcorp.com.au>, Ian Abbott <abbotti@mev.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, Joe Perches <joe@perches.com>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH v13 1/3] lib: Add strongly typed 64bit int_sqrt
Message-ID: <20180204102043.39516d75@archlinux>
In-Reply-To: <20180111101957.27290-1-cmo@melexis.com>
References: <20180111101957.27290-1-cmo@melexis.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2018 11:19:57 +0100
Crt Mori <cmo@melexis.com> wrote:

> There is no option to perform 64bit integer sqrt on 32bit platform.
> Added stronger typed int_sqrt64 enables the 64bit calculations to
> be performed on 32bit platforms. Using same algorithm as int_sqrt()
> with strong typing provides enough precision also on 32bit platforms,
> but it sacrifices some performance. In case values are smaller than
> ULONG_MAX the standard int_sqrt is used for calculation to maximize the
> performance due to more native calculations.
> 
> Signed-off-by: Crt Mori <cmo@melexis.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks all for input on this and to Crt for persistence!

Jonathan

> ---
>  include/linux/kernel.h |  9 +++++++++
>  lib/int_sqrt.c         | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 0ad4c3044cf9..e4a3dc64e650 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -460,6 +460,15 @@ extern int func_ptr_is_kernel_text(void *ptr);
>  
>  unsigned long int_sqrt(unsigned long);
>  
> +#if BITS_PER_LONG < 64
> +u32 int_sqrt64(u64 x);
> +#else
> +static inline u32 int_sqrt64(u64 x)
> +{
> +	return (u32)int_sqrt(x);
> +}
> +#endif
> +
>  extern void bust_spinlocks(int yes);
>  extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
>  extern int panic_timeout;
> diff --git a/lib/int_sqrt.c b/lib/int_sqrt.c
> index 1ef4cc344977..77386bc611d0 100644
> --- a/lib/int_sqrt.c
> +++ b/lib/int_sqrt.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/export.h>
> +#include <linux/bitops.h>
>  
>  /**
>   * int_sqrt - rough approximation to sqrt
> @@ -36,3 +37,33 @@ unsigned long int_sqrt(unsigned long x)
>  	return y;
>  }
>  EXPORT_SYMBOL(int_sqrt);
> +
> +#if BITS_PER_LONG < 64
> +/**
> + * int_sqrt64 - strongly typed int_sqrt function when minimum 64 bit input
> + * is expected.
> + * @x: 64bit integer of which to calculate the sqrt
> + */
> +u32 int_sqrt64(u64 x)
> +{
> +	u64 b, m, y = 0;
> +
> +	if (x <= ULONG_MAX)
> +		return int_sqrt((unsigned long) x);
> +
> +	m = 1ULL << (fls64(x) & ~1ULL);
> +	while (m != 0) {
> +		b = y + m;
> +		y >>= 1;
> +
> +		if (x >= b) {
> +			x -= b;
> +			y += m;
> +		}
> +		m >>= 2;
> +	}
> +
> +	return y;
> +}
> +EXPORT_SYMBOL(int_sqrt64);
> +#endif
