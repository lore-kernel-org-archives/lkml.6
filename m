Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932123AbeCKHzo (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 03:55:44 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:42656 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932087AbeCKHzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 03:55:43 -0400
X-Google-Smtp-Source: AG47ELt4AZYyFIvCx45FjQhAVfoCNx16F16mW7NG2ke3OokUMABVB7nLw99C+Cxt73ifT9HSlGSxqo72Ec+mrWGCj5Y=
MIME-Version: 1.0
From: =?UTF-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>
Date: Sun, 11 Mar 2018 15:55:41 +0800
Message-ID: <CAJDTihwMgUqjK6YL2M_WZY4VBaifVYgNvdZOF_fNrnk_p27Kvw@mail.gmail.com>
Subject: smp_mb__after_spinlock requirement too strong?
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, stern@rowland.harvard.edu, will.deacon@arm.com,
        torvalds@linux-foundation.org, npiggin@gmail.com, mingo@kernel.org,
        mpe@ellerman.id.au, oleg@redhat.com, benh@kernel.crashing.org,
        paulmck@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter pointed out in this patch https://patchwork.kernel.org/patch/9771921/
that the spinning-lock used at __schedule() should be RCsc to ensure
visibility of writes prior to __schedule when the task is to be migrated to
another CPU.

And this is emphasized at the comment of the newly introduced
smp_mb__after_spinlock(),

 * This barrier must provide two things:
 *
 *   - it must guarantee a STORE before the spin_lock() is ordered against a
 *     LOAD after it, see the comments at its two usage sites.
 *
 *   - it must ensure the critical section is RCsc.
 *
 * The latter is important for cases where we observe values written by other
 * CPUs in spin-loops, without barriers, while being subject to scheduling.
 *
 * CPU0         CPU1            CPU2
 *
 *          for (;;) {
 *            if (READ_ONCE(X))
 *              break;
 *          }
 * X=1
 *          <sched-out>
 *                      <sched-in>
 *                      r = X;
 *
 * without transitivity it could be that CPU1 observes X!=0 breaks the loop,
 * we get migrated and CPU2 sees X==0.

which is used at,

__schedule(bool preempt) {
    ...
    rq_lock(rq, &rf);
    smp_mb__after_spinlock();
    ...
}
.

If I didn't miss something, I found this kind of visibility is __not__
necessarily
depends on the spinning-lock at __schedule being RCsc.

In fact, as for runnable task A, the migration would be,

 CPU0         CPU1            CPU2

<ACCESS before schedule out A>

lock(rq0)
schedule out A
unock(rq0)

              lock(rq0)
              remove A from rq0
              unlock(rq0)

              lock(rq2)
              add A into rq2
              unlock(rq2)
                                        lock(rq2)
                                        schedule in A
                                        unlock(rq2)

                                        <ACCESS after schedule in A>

<ACCESS before schedule out A> happens-before
unlock(rq0) happends-before
lock(rq0) happends-before
unlock(rq2) happens-before
lock(rq2) happens-before
<ACCESS after schedule in A>

And for stopped tasks,

 CPU0         CPU1            CPU2

<ACCESS before schedule out A>

lock(rq0)
schedule out A
remove A from rq0
store-release(A->on_cpu)
unock(rq0)

              load_acquire(A->on_cpu)
              set_task_cpu(A, 2)

              lock(rq2)
              add A into rq2
              unlock(rq2)

                                        lock(rq2)
                                        schedule in A
                                        unlock(rq2)

                                        <ACCESS after schedule in A>

<ACCESS before schedule out A> happens-before
store-release(A->on_cpu)  happens-before
load_acquire(A->on_cpu)  happens-before
unlock(rq2) happens-before
lock(rq2) happens-before
<ACCESS after schedule in A>

So, I think the only requirement to smp_mb__after_spinlock is
to guarantee a STORE before the spin_lock() is ordered
against a LOAD after it. So we could remove the RCsc requirement
to allow more efficient implementation.

Did I miss something or this RCsc requirement does not really matter?
