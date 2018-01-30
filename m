Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753244AbeA3PgK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 10:36:10 -0500
Received: from foss.arm.com ([217.140.101.70]:55338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752933AbeA3PgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 10:36:09 -0500
Date: Tue, 30 Jan 2018 15:36:10 +0000
From: Will Deacon <will.deacon@arm.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: mark.rutland@arm.com, peterz@infradead.org, mingo@redhat.com,
        hpa@zytor.com, aryabinin@virtuozzo.com, kasan-dev@googlegroups.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v6 0/4] x86, kasan: add KASAN checks to atomic operations
Message-ID: <20180130153609.GA10917@arm.com>
References: <cover.1517246437.git.dvyukov@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1517246437.git.dvyukov@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Mon, Jan 29, 2018 at 06:26:03PM +0100, Dmitry Vyukov wrote:
> KASAN uses compiler instrumentation to intercept all memory accesses.
> But it does not see memory accesses done in assembly code.
> One notable user of assembly code is atomic operations. Frequently,
> for example, an atomic reference decrement is the last access to an
> object and a good candidate for a racy use-after-free.
> 
> Atomic operations are defined in arch files, but KASAN instrumentation
> is required for several archs that support KASAN. Later we will need
> similar hooks for KMSAN (uninit use detector) and KTSAN (data race
> detector).
> 
> This change introduces wrappers around atomic operations that can be
> used to add KASAN/KMSAN/KTSAN instrumentation across several archs,
> and adds KASAN checks to them.
> 
> This patch uses the wrappers only for x86 arch. Arm64 will be switched
> later. And we also plan to instrument bitops in a similar way.

One way you could reduce the intrusivness for each architecture would be
to leave the existing macro names as-is, and redefine them in the
asm-generic header. It's certainly ugly, but it makes the porting work
a lot smaller. Apologies if you've considered this approach before, but
I figured it was worth mentioning just in case.

e.g. for atomic[64]_read, your asm-generic header looks like:

#ifndef _LINUX_ATOMIC_INSTRUMENTED_H
#define _LINUX_ATOMIC_INSTRUMENTED_H

#include <linux/build_bug.h>
#include <linux/kasan-checks.h>

static __always_inline int __atomic_read_instrumented(const atomic_t *v)
{
	kasan_check_read(v, sizeof(*v));
	return atomic_read(v);
}

static __always_inline s64 __atomic64_read_instrumented(const atomic64_t *v)
{
	kasan_check_read(v, sizeof(*v));
	return atomic64_read(v);
}

#undef atomic_read
#undef atomic64_read

#define atomic_read	__atomic_read_instrumented
#define atomic64_read	__atomic64_read_instrumented

#endif /* _LINUX_ATOMIC_INSTRUMENTED_H */

and the arch code just includes that in asm/atomic.h once it's done with
its definitions.

What do you think? Too stinky?

Will
