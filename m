Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032730AbeEXS2T (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 14:28:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50574 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032629AbeEXS2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 14:28:18 -0400
Date: Thu, 24 May 2018 20:28:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sodagudi Prasad <psodagud@codeaurora.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Eric Biggers <ebiggers@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>, sherryy@android.com,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Christoph Lameter <cl@linux.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sasha Levin <alexander.levin@verizon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: write_lock_irq(&tasklist_lock)
Message-ID: <20180524182806.GL12198@hirez.programming.kicks-ass.net>
References: <0879f797135033e05e8e9166a3c85628@codeaurora.org>
 <20180523130547.GF26965@arm.com>
 <CA+55aFwKLBKdf3gdWkJSdewQYYXYYfN29SPT+etPqpopxA0CMQ@mail.gmail.com>
 <20180523153607.GD2983@arm.com>
 <CA+55aFy9mVCJUniAMVvJjqaa=ke2mx6HfkPhCGP54ncdh70peQ@mail.gmail.com>
 <20180524124928.GH8689@arm.com>
 <20180524135158.GA19987@tardis>
 <618c3c6392edb632695ca31d62b319bd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <618c3c6392edb632695ca31d62b319bd@codeaurora.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 10:37:25AM -0700, Sodagudi Prasad wrote:
>  Kernel version is locked for couple of products and same issue observed on
> both 4.14.41
> and 4.9.96 kernels. We can only accept the stable updates from upstream for
> these products.

> If QUEUED_RWLOCKS works on above listed kernel versions without any issues,
> we can enabled QUEUED_RWLOCKS.

You want:

e0d02285f16e ("locking/qrwlock: Use 'struct qrwlock' instead of 'struct __qrwlock'")
4df714be4dcf ("locking/atomic: Add atomic_cond_read_acquire()")
b519b56e378e ("locking/qrwlock: Use atomic_cond_read_acquire() when spinning in qrwlock")
087133ac9076 ("locking/qrwlock, arm64: Move rwlock implementation over to qrwlocks")
d13316614633 ("locking/qrwlock: Prevent slowpath writers getting held up by fastpath")

IIRC, enabling QUEUED_RWLOCKS will 'work' but esp. that
atomic_cond_read_acquire() one is goodness for ARM64.

> Can we go ahead with Linus suggestion for these kernel version?
> So that IRQ wont be disabled for quite a long time.
> 
>  static void tasklist_write_lock(void)
>    {
>          unsigned long flags;
>          local_irq_save(flags);
>          while (!write_trylock(&tasklist_lock)) {
>                  local_irq_restore(flags);
>                  do { cpu_relax(); } while (write_islocked(&tasklist_lock));
>                  local_irq_disable();
>          }
>    }

First you say you can only take stable updates, then you ask for a
gruesome hack that will seriously regress architectures that do use
qrwlock which will hence never make it into stable.

Just take the arm64 qrwlock patches and pretend they're from stable.
