Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753581AbeBUKoX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:44:23 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36785 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751920AbeBUKoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:44:22 -0500
Date: Wed, 21 Feb 2018 02:43:59 -0800
From: tip-bot for Alan Stern <tipbot@zytor.com>
Message-ID: <tip-556bb7d252ae42d4653557325670e665087c38ad@git.kernel.org>
Cc: paulmck@linux.vnet.ibm.com, hpa@zytor.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        peterz@infradead.org, stern@rowland.harvard.edu, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: peterz@infradead.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, paulmck@linux.vnet.ibm.com,
        hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        stern@rowland.harvard.edu
In-Reply-To: <1519169112-20593-10-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1519169112-20593-10-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/memory-model: Add a S lock-based
 external-view litmus test
Git-Commit-ID: 556bb7d252ae42d4653557325670e665087c38ad
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  556bb7d252ae42d4653557325670e665087c38ad
Gitweb:     https://git.kernel.org/tip/556bb7d252ae42d4653557325670e665087c38ad
Author:     Alan Stern <stern@rowland.harvard.edu>
AuthorDate: Tue, 20 Feb 2018 15:25:10 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 09:58:15 +0100

tools/memory-model: Add a S lock-based external-view litmus test

This commit adds a litmus test in which P0() and P1() form a lock-based S
litmus test, with the addition of P2(), which observes P0()'s and P1()'s
accesses with a full memory barrier but without the lock.  This litmus
test asks whether writes carried out by two different processes under the
same lock will be seen in order by a third process not holding that lock.
The answer to this question is "yes" for all architectures supporting
the Linux kernel, but is "no" according to the current version of LKMM.

A patch to LKMM is under development.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: akiyks@gmail.com
Cc: boqun.feng@gmail.com
Cc: dhowells@redhat.com
Cc: j.alglave@ucl.ac.uk
Cc: linux-arch@vger.kernel.org
Cc: luc.maranget@inria.fr
Cc: nborisov@suse.com
Cc: npiggin@gmail.com
Cc: parri.andrea@gmail.com
Cc: will.deacon@arm.com
Link: http://lkml.kernel.org/r/1519169112-20593-10-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 ...ce.litmus => ISA2+pooncelock+pooncelock+pombonce.litmus} | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
similarity index 55%
copy from tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
copy to tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
index 10a2aa0..7a39a0a 100644
--- a/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
+++ b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
@@ -1,11 +1,11 @@
-C Z6.0+pooncelock+pooncelock+pombonce
+C ISA2+pooncelock+pooncelock+pombonce.litmus
 
 (*
  * Result: Sometimes
  *
- * This example demonstrates that a pair of accesses made by different
- * processes each while holding a given lock will not necessarily be
- * seen as ordered by a third process not holding that lock.
+ * This test shows that the ordering provided by a lock-protected S
+ * litmus test (P0() and P1()) are not visible to external process P2().
+ * This is likely to change soon.
  *)
 
 {}
@@ -31,10 +31,11 @@ P1(int *y, int *z, spinlock_t *mylock)
 P2(int *x, int *z)
 {
 	int r1;
+	int r2;
 
-	WRITE_ONCE(*z, 2);
+	r2 = READ_ONCE(*z);
 	smp_mb();
 	r1 = READ_ONCE(*x);
 }
 
-exists (1:r0=1 /\ z=2 /\ 2:r1=0)
+exists (1:r0=1 /\ 2:r2=1 /\ 2:r1=0)
