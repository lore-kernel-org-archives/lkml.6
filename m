Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752689AbeEOIyZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:54:25 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55393 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752346AbeEOIyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:54:21 -0400
X-Google-Smtp-Source: AB8JxZq0ACv8b1L3qP8i9TCKXtLokBWXT+Ntx89H3mqMw698vhI2o8Oo5ZS6n9vPN5BSLQDTEKCskA==
Date: Tue, 15 May 2018 10:54:17 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, mark.rutland@arm.com,
        torvalds@linux-foundation.org, paulmck@linux.vnet.ibm.com,
        tglx@linutronix.de, hpa@zytor.com, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:locking/core] locking/atomics: Simplify the op definitions
 in atomic.h some more
Message-ID: <20180515085417.GB30420@gmail.com>
References: <20180505083635.622xmcvb42dw5xxh@gmail.com>
 <tip-87d655a48dfe74293f72dc001ed042142cf00d44@git.kernel.org>
 <20180509073327.GE12217@hirez.programming.kicks-ass.net>
 <20180509130316.GB20254@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509130316.GB20254@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Will Deacon <will.deacon@arm.com> wrote:

> With this patch, we're already seeing arch code (powerpc, risc-v) having
> to add what is basically boiler-plate code, and it seems like we're just
> doing this to make the generic code more readable! I'd much prefer we kept
> the arch code simple, and took on the complexity burden in the generic code
> where it can be looked after in one place.

For PowerPC this is not really true, the patch has this effect:

   2 files changed, 28 insertions(+), 20 deletions(-)

and made it more obvious where the arch gets its low level definitions from.

For RISC-V it's true:

 arch/riscv/include/asm/atomic.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

but even before this it was already largely boilerplate:

#define atomic_inc_return_relaxed	atomic_inc_return_relaxed
#define atomic_dec_return_relaxed	atomic_dec_return_relaxed
#define atomic_inc_return		atomic_inc_return
#define atomic_dec_return		atomic_dec_return

#define atomic_fetch_inc_relaxed	atomic_fetch_inc_relaxed
#define atomic_fetch_dec_relaxed	atomic_fetch_dec_relaxed
#define atomic_fetch_inc		atomic_fetch_inc
#define atomic_fetch_dec		atomic_fetch_dec

#ifndef CONFIG_GENERIC_ATOMIC64
#define atomic64_inc_return_relaxed	atomic64_inc_return_relaxed
#define atomic64_dec_return_relaxed	atomic64_dec_return_relaxed
#define atomic64_inc_return		atomic64_inc_return
#define atomic64_dec_return		atomic64_dec_return

#define atomic64_fetch_inc_relaxed	atomic64_fetch_inc_relaxed
#define atomic64_fetch_dec_relaxed	atomic64_fetch_dec_relaxed
#define atomic64_fetch_inc		atomic64_fetch_inc
#define atomic64_fetch_dec		atomic64_fetch_dec
#endif

What this change does it that it makes _all_ the low level ops obviously mapped in 
the low level header, if an arch decides to implement the _relaxed variants 
itself. Not half of them in the low level header, half of them in the generic 
header...

Thanks,

	Ingo
