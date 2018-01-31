Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753687AbeAaIxd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 03:53:33 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:38134 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752062AbeAaIxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 03:53:32 -0500
X-Google-Smtp-Source: AH8x227DXejwfhnWrUo596jXtMesbn2UE9PFjuhd9RSAxiTt8DW8s8ciwqj8/eEjzaZqhSyu36OnuJbFo66arTSmJsk=
MIME-Version: 1.0
In-Reply-To: <20180131072858.5hoy6wsukda27v2o@gmail.com>
References: <cover.1517246437.git.dvyukov@google.com> <20180130153609.GA10917@arm.com>
 <20180131072858.5hoy6wsukda27v2o@gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 31 Jan 2018 09:53:10 +0100
Message-ID: <CACT4Y+Y1Qbsd4DOb6K6y0MVC2e_StjgYERE9ntJmQb+6BtZciA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] x86, kasan: add KASAN checks to atomic operations
To: Ingo Molnar <mingo@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 8:28 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Will Deacon <will.deacon@arm.com> wrote:
>
>> Hi Dmitry,
>>
>> On Mon, Jan 29, 2018 at 06:26:03PM +0100, Dmitry Vyukov wrote:
>> > KASAN uses compiler instrumentation to intercept all memory accesses.
>> > But it does not see memory accesses done in assembly code.
>> > One notable user of assembly code is atomic operations. Frequently,
>> > for example, an atomic reference decrement is the last access to an
>> > object and a good candidate for a racy use-after-free.
>> >
>> > Atomic operations are defined in arch files, but KASAN instrumentation
>> > is required for several archs that support KASAN. Later we will need
>> > similar hooks for KMSAN (uninit use detector) and KTSAN (data race
>> > detector).
>> >
>> > This change introduces wrappers around atomic operations that can be
>> > used to add KASAN/KMSAN/KTSAN instrumentation across several archs,
>> > and adds KASAN checks to them.
>> >
>> > This patch uses the wrappers only for x86 arch. Arm64 will be switched
>> > later. And we also plan to instrument bitops in a similar way.
>>
>> One way you could reduce the intrusivness for each architecture would be
>> to leave the existing macro names as-is, and redefine them in the
>> asm-generic header. It's certainly ugly, but it makes the porting work
>> a lot smaller. Apologies if you've considered this approach before, but
>> I figured it was worth mentioning just in case.
>>
>> e.g. for atomic[64]_read, your asm-generic header looks like:
>>
>> #ifndef _LINUX_ATOMIC_INSTRUMENTED_H
>> #define _LINUX_ATOMIC_INSTRUMENTED_H
>>
>> #include <linux/build_bug.h>
>> #include <linux/kasan-checks.h>
>>
>> static __always_inline int __atomic_read_instrumented(const atomic_t *v)
>> {
>>       kasan_check_read(v, sizeof(*v));
>>       return atomic_read(v);
>> }
>>
>> static __always_inline s64 __atomic64_read_instrumented(const atomic64_t *v)
>> {
>>       kasan_check_read(v, sizeof(*v));
>>       return atomic64_read(v);
>> }
>>
>> #undef atomic_read
>> #undef atomic64_read
>>
>> #define atomic_read   __atomic_read_instrumented
>> #define atomic64_read __atomic64_read_instrumented
>>
>> #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
>>
>> and the arch code just includes that in asm/atomic.h once it's done with
>> its definitions.
>>
>> What do you think? Too stinky?
>
> Hm, so while this could work - I actually *like* the low level changes: they are
> straightforward, trivial, easy to read and they add the arch_ prefix that makes it
> abundantly clear that this isn't the highest level interface.
>
> The KASAN callbacks in the generic methods are also abundantly clear and very easy
> to read. I could literally verify the sanity of the series while still being only
> half awake. ;-)
>
> Also note that the arch renaming should be 'trivial', in the sense that any
> missing rename results in a clear build breakage. Plus any architecture making use
> of this new KASAN feature should probably be tested before it's enabled - and the
> renaming of the low level atomic APIs kind of forces that too.
>
> So while this approach creates some churn, this series is IMHO a marked
> improvement over the previous iterations.


I think I mildly leaning towards Ingo's point.
I guess people will first find the version in arch (because that's
where they used to be), but that version is actually not the one that
is called.
The renaming is mechanical and you get build errors if anything is
wrong. It's macros that caused hard to debug runtime crashes and
multiple revisions of this series.
