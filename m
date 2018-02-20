Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751590AbeBTKkc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 05:40:32 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:43987 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751467AbeBTKk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 05:40:29 -0500
X-Google-Smtp-Source: AH8x2275gQPqnI5zhha7Oa/OSWoyoKQSpA8HQkqvybFPpmOycDb6itMe7nqfPPBSD7gP4WuXWugt0++5cx5VXO7iIzM=
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Ymn4U7R849psS49N8LKesAEpsTBnbZbpgJsvut6CsQ6g@mail.gmail.com>
References: <cover.1517246437.git.dvyukov@google.com> <20180130153609.GA10917@arm.com>
 <20180131072858.5hoy6wsukda27v2o@gmail.com> <CACT4Y+Y1Qbsd4DOb6K6y0MVC2e_StjgYERE9ntJmQb+6BtZciA@mail.gmail.com>
 <20180131161725.GA18758@arm.com> <CACT4Y+Ymn4U7R849psS49N8LKesAEpsTBnbZbpgJsvut6CsQ6g@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 20 Feb 2018 11:40:07 +0100
Message-ID: <CACT4Y+a1yWWfz5NZKjb1v8EFJA-Yag4ZjGxq7K2fJ6A2JRDnOA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] x86, kasan: add KASAN checks to atomic operations
To: Will Deacon <will.deacon@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
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

On Wed, Feb 7, 2018 at 3:17 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Jan 31, 2018 at 5:17 PM, Will Deacon <will.deacon@arm.com> wrote:
>>> > * Will Deacon <will.deacon@arm.com> wrote:
>>> >> e.g. for atomic[64]_read, your asm-generic header looks like:
>>> >>
>>> >> #ifndef _LINUX_ATOMIC_INSTRUMENTED_H
>>> >> #define _LINUX_ATOMIC_INSTRUMENTED_H
>>> >>
>>> >> #include <linux/build_bug.h>
>>> >> #include <linux/kasan-checks.h>
>>> >>
>>> >> static __always_inline int __atomic_read_instrumented(const atomic_t *v)
>>> >> {
>>> >>       kasan_check_read(v, sizeof(*v));
>>> >>       return atomic_read(v);
>>> >> }
>>> >>
>>> >> static __always_inline s64 __atomic64_read_instrumented(const atomic64_t *v)
>>> >> {
>>> >>       kasan_check_read(v, sizeof(*v));
>>> >>       return atomic64_read(v);
>>> >> }
>>> >>
>>> >> #undef atomic_read
>>> >> #undef atomic64_read
>>> >>
>>> >> #define atomic_read   __atomic_read_instrumented
>>> >> #define atomic64_read __atomic64_read_instrumented
>>> >>
>>> >> #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
>>> >>
>>> >> and the arch code just includes that in asm/atomic.h once it's done with
>>> >> its definitions.
>>> >>
>>> >> What do you think? Too stinky?
>>> >
>>> > Hm, so while this could work - I actually *like* the low level changes: they are
>>> > straightforward, trivial, easy to read and they add the arch_ prefix that makes it
>>> > abundantly clear that this isn't the highest level interface.
>>> >
>>> > The KASAN callbacks in the generic methods are also abundantly clear and very easy
>>> > to read. I could literally verify the sanity of the series while still being only
>>> > half awake. ;-)
>>> >
>>> > Also note that the arch renaming should be 'trivial', in the sense that any
>>> > missing rename results in a clear build breakage. Plus any architecture making use
>>> > of this new KASAN feature should probably be tested before it's enabled - and the
>>> > renaming of the low level atomic APIs kind of forces that too.
>>> >
>>> > So while this approach creates some churn, this series is IMHO a marked
>>> > improvement over the previous iterations.
>>>
>>>
>>> I think I mildly leaning towards Ingo's point.
>>> I guess people will first find the version in arch (because that's
>>> where they used to be), but that version is actually not the one that
>>> is called.
>>> The renaming is mechanical and you get build errors if anything is
>>> wrong. It's macros that caused hard to debug runtime crashes and
>>> multiple revisions of this series.
>>
>> Sure, and it sounds like you're proposing to do the arm64 changes anyway so
>> I'm not complaining! Just thought I'd float the alternative to see what
>> people think.
>
>
> Any other comments?
> Ingo, will you take this to locking tree?


Any other comments?
Ingo, will you take this to locking tree?
