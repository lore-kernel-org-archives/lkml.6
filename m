Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751248AbeEEJGO (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 05:06:14 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37322 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbeEEJGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 05:06:13 -0400
X-Google-Smtp-Source: AB8JxZr5QNPr6wKQ+tB1CPnO4tnqz0ZKgICWBM93cDoNuYvJzhVJ6570Mb0vNdBbXrpoCalK4daS5b4qASDYX6yNWg4=
MIME-Version: 1.0
In-Reply-To: <20180505084721.GA32344@noisy.programming.kicks-ass.net>
References: <20180504173937.25300-1-mark.rutland@arm.com> <20180504173937.25300-2-mark.rutland@arm.com>
 <20180504180105.GS12217@hirez.programming.kicks-ass.net> <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
 <20180505081100.nsyrqrpzq2vd27bk@gmail.com> <20180505084721.GA32344@noisy.programming.kicks-ass.net>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sat, 5 May 2018 11:05:51 +0200
Message-ID: <CACT4Y+Z1WKxdkodRBc5PzfyQQmfJCJ3n1JyQc-+WCkqGZeg5Wg@mail.gmail.com>
Subject: Re: [PATCH] locking/atomics: Clean up the atomic.h maze of #defines
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 5, 2018 at 10:47 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Sat, May 05, 2018 at 10:11:00AM +0200, Ingo Molnar wrote:
>
>> Before:
>>
>>  #ifndef atomic_fetch_dec_relaxed
>>
>>  #ifndef atomic_fetch_dec
>>  #define atomic_fetch_dec(v)          atomic_fetch_sub(1, (v))
>>  #define atomic_fetch_dec_relaxed(v)  atomic_fetch_sub_relaxed(1, (v))
>>  #define atomic_fetch_dec_acquire(v)  atomic_fetch_sub_acquire(1, (v))
>>  #define atomic_fetch_dec_release(v)  atomic_fetch_sub_release(1, (v))
>>  #else /* atomic_fetch_dec */
>>  #define atomic_fetch_dec_relaxed     atomic_fetch_dec
>>  #define atomic_fetch_dec_acquire     atomic_fetch_dec
>>  #define atomic_fetch_dec_release     atomic_fetch_dec
>>  #endif /* atomic_fetch_dec */
>>
>>  #else /* atomic_fetch_dec_relaxed */
>>
>>  #ifndef atomic_fetch_dec_acquire
>>  #define atomic_fetch_dec_acquire(...)                                        \
>>       __atomic_op_acquire(atomic_fetch_dec, __VA_ARGS__)
>>  #endif
>>
>>  #ifndef atomic_fetch_dec_release
>>  #define atomic_fetch_dec_release(...)                                        \
>>       __atomic_op_release(atomic_fetch_dec, __VA_ARGS__)
>>  #endif
>>
>>  #ifndef atomic_fetch_dec
>>  #define atomic_fetch_dec(...)                                                \
>>       __atomic_op_fence(atomic_fetch_dec, __VA_ARGS__)
>>  #endif
>>  #endif /* atomic_fetch_dec_relaxed */
>>
>> After:
>>
>>  #ifndef atomic_fetch_dec_relaxed
>>  # ifndef atomic_fetch_dec
>>  #  define atomic_fetch_dec(v)                        atomic_fetch_sub(1, (v))
>>  #  define atomic_fetch_dec_relaxed(v)                atomic_fetch_sub_relaxed(1, (v))
>>  #  define atomic_fetch_dec_acquire(v)                atomic_fetch_sub_acquire(1, (v))
>>  #  define atomic_fetch_dec_release(v)                atomic_fetch_sub_release(1, (v))
>>  # else
>>  #  define atomic_fetch_dec_relaxed           atomic_fetch_dec
>>  #  define atomic_fetch_dec_acquire           atomic_fetch_dec
>>  #  define atomic_fetch_dec_release           atomic_fetch_dec
>>  # endif
>>  #else
>>  # ifndef atomic_fetch_dec_acquire
>>  #  define atomic_fetch_dec_acquire(...)      __atomic_op_acquire(atomic_fetch_dec, __VA_ARGS__)
>>  # endif
>>  # ifndef atomic_fetch_dec_release
>>  #  define atomic_fetch_dec_release(...)      __atomic_op_release(atomic_fetch_dec, __VA_ARGS__)
>>  # endif
>>  # ifndef atomic_fetch_dec
>>  #  define atomic_fetch_dec(...)              __atomic_op_fence(atomic_fetch_dec, __VA_ARGS__)
>>  # endif
>>  #endif
>>
>> The new variant is readable at a glance, and the hierarchy of defines is very
>> obvious as well.
>
> It wraps and looks hideous in my normal setup. And I do detest that indent
> after # thing.
>
>> And I think we could do even better - there's absolutely no reason why _every_
>> operation has to be made conditional on a finegrained level - they are overriden
>> in API groups. In fact allowing individual override is arguably a fragility.
>>
>> So we could do the following simplification on top of that:
>>
>>  #ifndef atomic_fetch_dec_relaxed
>>  # ifndef atomic_fetch_dec
>>  #  define atomic_fetch_dec(v)                        atomic_fetch_sub(1, (v))
>>  #  define atomic_fetch_dec_relaxed(v)                atomic_fetch_sub_relaxed(1, (v))
>>  #  define atomic_fetch_dec_acquire(v)                atomic_fetch_sub_acquire(1, (v))
>>  #  define atomic_fetch_dec_release(v)                atomic_fetch_sub_release(1, (v))
>>  # else
>>  #  define atomic_fetch_dec_relaxed           atomic_fetch_dec
>>  #  define atomic_fetch_dec_acquire           atomic_fetch_dec
>>  #  define atomic_fetch_dec_release           atomic_fetch_dec
>>  # endif
>>  #else
>>  # ifndef atomic_fetch_dec
>>  #  define atomic_fetch_dec(...)              __atomic_op_fence(atomic_fetch_dec, __VA_ARGS__)
>>  #  define atomic_fetch_dec_acquire(...)      __atomic_op_acquire(atomic_fetch_dec, __VA_ARGS__)
>>  #  define atomic_fetch_dec_release(...)      __atomic_op_release(atomic_fetch_dec, __VA_ARGS__)
>>  # endif
>>  #endif
>
> This would disallow an architecture to override just fetch_dec_release for
> instance.
>
> I don't think there currently is any architecture that does that, but the
> intent was to allow it to override anything and only provide defaults where it
> does not.
>
> None of this takes away the giant trainwreck that is the annotated atomic stuff
> though.
>
> And I seriously hate this one:
>
>   ba1c9f83f633 ("locking/atomic/x86: Un-macro-ify atomic ops implementation")
>
> and will likely undo that the moment I need to change anything there.
>
> So no, don't like.

That was asked by Ingo:
https://groups.google.com/d/msg/kasan-dev/3sNHjjb4GCI/Xz1uVWaaAAAJ

I think in the end all of current options suck in one way or another,
so we are just going in circles.
We either need something different (e.g. codegen), or settle on one
option for doing it.
