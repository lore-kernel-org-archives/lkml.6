Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeDFUuW convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 16:50:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751579AbeDFUuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 16:50:20 -0400
Subject: Re: [PATCH 02/10] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
To: Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        mingo@kernel.org, boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
        catalin.marinas@arm.com
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-3-git-send-email-will.deacon@arm.com>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <dc5f5e43-a60a-05f2-16fb-46960c40459e@redhat.com>
Date: Fri, 6 Apr 2018 16:50:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1522947547-24081-3-git-send-email-will.deacon@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2018 12:58 PM, Will Deacon wrote:
> The qspinlock locking slowpath utilises a "pending" bit as a simple form
> of an embedded test-and-set lock that can avoid the overhead of explicit
> queuing in cases where the lock is held but uncontended. This bit is
> managed using a cmpxchg loop which tries to transition the uncontended
> lock word from (0,0,0) -> (0,0,1) or (0,0,1) -> (0,1,1).
>
> Unfortunately, the cmpxchg loop is unbounded and lockers can be starved
> indefinitely if the lock word is seen to oscillate between unlocked
> (0,0,0) and locked (0,0,1). This could happen if concurrent lockers are
> able to take the lock in the cmpxchg loop without queuing and pass it
> around amongst themselves.
>
> This patch fixes the problem by unconditionally setting _Q_PENDING_VAL
> using atomic_fetch_or, and then inspecting the old value to see whether
> we need to spin on the current lock owner, or whether we now effectively
> hold the lock. The tricky scenario is when concurrent lockers end up
> queuing on the lock and the lock becomes available, causing us to see
> a lockword of (n,0,0). With pending now set, simply queuing could lead
> to deadlock as the head of the queue may not have observed the pending
> flag being cleared. Conversely, if the head of the queue did observe
> pending being cleared, then it could transition the lock from (n,0,0) ->
> (0,0,1) meaning that any attempt to "undo" our setting of the pending
> bit could race with a concurrent locker trying to set it.
>
> We handle this race by preserving the pending bit when taking the lock
> after reaching the head of the queue and leaving the tail entry intact
> if we saw pending set, because we know that the tail is going to be
> updated shortly.
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---

The pending bit was added to the qspinlock design to counter performance
degradation compared with ticket lock for workloads with light
spinlock contention. I run my spinlock stress test on a Intel Skylake
server running the vanilla 4.16 kernel vs a patched kernel with this
patchset. The locking rates with different number of locking threads
were as follows:

  # of threads  4.16 kernel     patched 4.16 kernel
  ------------  -----------     -------------------
        1       7,417 kop/s         7,408 kop/s
        2       5,755 kop/s         4,486 kop/s
        3       4,214 kop/s         4,169 kop/s
        4       4,396 kop/s         4,383 kop/s
       
The 2 contending threads case is the one that exercise the pending bit
code path the most. So it is obvious that this is the one that is most
impacted by this patchset. The differences in the other cases are mostly
noise or maybe just a little bit on the 3 contending threads case.

I am not against this patch, but we certainly need to find out a way to
bring the performance number up closer to what it is before applying
the patch.

Cheers,
Longman
