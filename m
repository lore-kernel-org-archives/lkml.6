Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753093AbeDFNXB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:23:01 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40038 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752412AbeDFNW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:22:59 -0400
X-Google-Smtp-Source: AIpwx4+KtSQlx84f1DTnUMxNcHPrYL9mk+rX/sda6oZhRzrgPvQfxjXBJuZGgdjtErpA98KuDz6KcA==
Date: Fri, 6 Apr 2018 15:22:49 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, mingo@kernel.org, boqun.feng@gmail.com,
        paulmck@linux.vnet.ibm.com, catalin.marinas@arm.com
Subject: Re: [PATCH 00/10] kernel/locking: qspinlock improvements
Message-ID: <20180406132249.GA7071@andrea>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 05:58:57PM +0100, Will Deacon wrote:
> Hi all,
> 
> I've been kicking the tyres further on qspinlock and with this set of patches
> I'm happy with the performance and fairness properties. In particular, the
> locking algorithm now guarantees forward progress whereas the implementation
> in mainline can starve threads indefinitely in cmpxchg loops.
> 
> Catalin has also implemented a model of this using TLA to prove that the
> lock is fair, although this doesn't take the memory model into account:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/kernel-tla.git/commit/

Nice!  I'll dig into this formalization, but my guess is that our model
(and axiomatic models "a-la-herd", in general) are not well-suited when
it comes to study properties such as fairness, liveness...

Did you already think about this?

  Andrea


> 
> I'd still like to get more benchmark numbers and wider exposure before
> enabling this for arm64, but my current testing is looking very promising.
> This series, along with the arm64-specific patches, is available at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=qspinlock
> 
> Cheers,
> 
> Will
> 
> --->8
> 
> Jason Low (1):
>   locking/mcs: Use smp_cond_load_acquire() in mcs spin loop
> 
> Will Deacon (9):
>   locking/qspinlock: Don't spin on pending->locked transition in
>     slowpath
>   locking/qspinlock: Remove unbounded cmpxchg loop from locking slowpath
>   locking/qspinlock: Kill cmpxchg loop when claiming lock from head of
>     queue
>   locking/qspinlock: Use atomic_cond_read_acquire
>   barriers: Introduce smp_cond_load_relaxed and atomic_cond_read_relaxed
>   locking/qspinlock: Use smp_cond_load_relaxed to wait for next node
>   locking/qspinlock: Merge struct __qspinlock into struct qspinlock
>   locking/qspinlock: Make queued_spin_unlock use smp_store_release
>   locking/qspinlock: Elide back-to-back RELEASE operations with
>     smp_wmb()
> 
>  arch/x86/include/asm/qspinlock.h          |  19 ++-
>  arch/x86/include/asm/qspinlock_paravirt.h |   3 +-
>  include/asm-generic/barrier.h             |  27 ++++-
>  include/asm-generic/qspinlock.h           |   2 +-
>  include/asm-generic/qspinlock_types.h     |  32 ++++-
>  include/linux/atomic.h                    |   2 +
>  kernel/locking/mcs_spinlock.h             |  10 +-
>  kernel/locking/qspinlock.c                | 191 ++++++++++--------------------
>  kernel/locking/qspinlock_paravirt.h       |  34 ++----
>  9 files changed, 141 insertions(+), 179 deletions(-)
> 
> -- 
> 2.1.4
> 
