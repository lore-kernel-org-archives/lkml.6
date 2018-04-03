Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753071AbeDCTbv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 15:31:51 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37635 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752973AbeDCTbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 15:31:49 -0400
X-Google-Smtp-Source: AIpwx4+S2CXTX8krX9XxxygoCPIFS8r/mPjQT2280t0uWepDRHAXgKy+eCNDMPvoNObsBlBi7I299w==
Date: Tue, 3 Apr 2018 21:31:39 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: David Howells <dhowells@redhat.com>
Cc: paulmck@linux.vnet.ibm.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2 1/3] locking: Document the semantics of
 spin_is_locked()
Message-ID: <20180403193139.GA6143@andrea>
References: <20180403140715.GA5375@andrea>
 <20180403133543.GA26653@andrea>
 <1522600912-6208-2-git-send-email-andrea.parri@amarulasolutions.com>
 <1522600912-6208-1-git-send-email-andrea.parri@amarulasolutions.com>
 <29562.1522759749@warthog.procyon.org.uk>
 <13191.1522763553@warthog.procyon.org.uk>
 <3766.1522768987@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3766.1522768987@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 04:23:07PM +0100, David Howells wrote:
> Andrea Parri <andrea.parri@amarulasolutions.com> wrote:
> 
> > Sorry, but I don't understand your objection: are you suggesting to add
> > something like "Always return 0 on !SMP" to the comment?  what else?
> 
> Something like that, possibly along with a warning that this might not be what
> you want.  You might actually want it to return true on !SMP, it depends on
> what you're using it for.

I ended up with the following revision.  I hesitated on whether to refer
to 'include/linux/spinlock_up.h' or not, but in the end I decided to not
include the reference.  Please let me know what you think about this.

  Andrea


>From 85f2d12d4ad9769cc9f69cc5f447fdb8c5ed4d14 Mon Sep 17 00:00:00 2001
From: Andrea Parri <andrea.parri@amarulasolutions.com>
Date: Tue, 3 Apr 2018 21:23:07 +0200
Subject: [PATCH v3 1/3] locking: Document the semantics of spin_is_locked()

There appeared to be a certain, recurrent uncertainty concerning the
semantics of spin_is_locked(), likely a consequence of the fact that
this semantics remains undocumented or that it has been historically
linked to the (likewise unclear) semantics of spin_unlock_wait().

A recent auditing [1] of the callers of the primitive confirmed that
none of them are relying on particular ordering guarantees; document
this semantics by adding a docbook header to spin_is_locked().

[1] https://marc.info/?l=linux-kernel&m=151981440005264&w=2

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
---
 include/linux/spinlock.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 4894d322d2584..636a4436191c1 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -380,6 +380,20 @@ static __always_inline int spin_trylock_irq(spinlock_t *lock)
 	raw_spin_trylock_irqsave(spinlock_check(lock), flags); \
 })
 
+/**
+ * spin_is_locked() - Check whether a spinlock is locked.
+ * @lock: Pointer to the spinlock.
+ *
+ * This function is NOT required to provide any memory ordering
+ * guarantees; it could be used for debugging purposes or, when
+ * additional synchronization is needed, accompanied with other
+ * constructs (memory barriers) enforcing the synchronization.
+ *
+ * Return: 1, if @lock is (found to be) locked; 0, otherwise.
+ *
+ *	   Remark that this primitve can return a fixed value
+ *	   under certain !SMP configurations.
+ */
 static __always_inline int spin_is_locked(spinlock_t *lock)
 {
 	return raw_spin_is_locked(&lock->rlock);
-- 
2.7.4



> 
> David
