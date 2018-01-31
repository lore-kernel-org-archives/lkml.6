Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbeAaH3D (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 02:29:03 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39076 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbeAaH3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 02:29:02 -0500
X-Google-Smtp-Source: AH8x225nStR3ek8oC3xzShY+HeQeNvvHy1h8+I/l61WVyM0xlxCaFH5OYu+FK9w0nrNclgvXXxh7Mw==
Date: Wed, 31 Jan 2018 08:28:58 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, mark.rutland@arm.com,
        peterz@infradead.org, mingo@redhat.com, hpa@zytor.com,
        aryabinin@virtuozzo.com, kasan-dev@googlegroups.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v6 0/4] x86, kasan: add KASAN checks to atomic operations
Message-ID: <20180131072858.5hoy6wsukda27v2o@gmail.com>
References: <cover.1517246437.git.dvyukov@google.com>
 <20180130153609.GA10917@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130153609.GA10917@arm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Will Deacon <will.deacon@arm.com> wrote:

> Hi Dmitry,
> 
> On Mon, Jan 29, 2018 at 06:26:03PM +0100, Dmitry Vyukov wrote:
> > KASAN uses compiler instrumentation to intercept all memory accesses.
> > But it does not see memory accesses done in assembly code.
> > One notable user of assembly code is atomic operations. Frequently,
> > for example, an atomic reference decrement is the last access to an
> > object and a good candidate for a racy use-after-free.
> > 
> > Atomic operations are defined in arch files, but KASAN instrumentation
> > is required for several archs that support KASAN. Later we will need
> > similar hooks for KMSAN (uninit use detector) and KTSAN (data race
> > detector).
> > 
> > This change introduces wrappers around atomic operations that can be
> > used to add KASAN/KMSAN/KTSAN instrumentation across several archs,
> > and adds KASAN checks to them.
> > 
> > This patch uses the wrappers only for x86 arch. Arm64 will be switched
> > later. And we also plan to instrument bitops in a similar way.
> 
> One way you could reduce the intrusivness for each architecture would be
> to leave the existing macro names as-is, and redefine them in the
> asm-generic header. It's certainly ugly, but it makes the porting work
> a lot smaller. Apologies if you've considered this approach before, but
> I figured it was worth mentioning just in case.
> 
> e.g. for atomic[64]_read, your asm-generic header looks like:
> 
> #ifndef _LINUX_ATOMIC_INSTRUMENTED_H
> #define _LINUX_ATOMIC_INSTRUMENTED_H
> 
> #include <linux/build_bug.h>
> #include <linux/kasan-checks.h>
> 
> static __always_inline int __atomic_read_instrumented(const atomic_t *v)
> {
> 	kasan_check_read(v, sizeof(*v));
> 	return atomic_read(v);
> }
> 
> static __always_inline s64 __atomic64_read_instrumented(const atomic64_t *v)
> {
> 	kasan_check_read(v, sizeof(*v));
> 	return atomic64_read(v);
> }
> 
> #undef atomic_read
> #undef atomic64_read
> 
> #define atomic_read	__atomic_read_instrumented
> #define atomic64_read	__atomic64_read_instrumented
> 
> #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
> 
> and the arch code just includes that in asm/atomic.h once it's done with
> its definitions.
> 
> What do you think? Too stinky?

Hm, so while this could work - I actually *like* the low level changes: they are 
straightforward, trivial, easy to read and they add the arch_ prefix that makes it 
abundantly clear that this isn't the highest level interface.

The KASAN callbacks in the generic methods are also abundantly clear and very easy 
to read. I could literally verify the sanity of the series while still being only 
half awake. ;-)

Also note that the arch renaming should be 'trivial', in the sense that any 
missing rename results in a clear build breakage. Plus any architecture making use 
of this new KASAN feature should probably be tested before it's enabled - and the 
renaming of the low level atomic APIs kind of forces that too.

So while this approach creates some churn, this series is IMHO a marked 
improvement over the previous iterations.

Thanks,

	Ingo
