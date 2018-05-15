Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752373AbeEOGcz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:32:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44357 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752195AbeEOGcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:32:53 -0400
Date: Mon, 14 May 2018 23:32:17 -0700
From: "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Message-ID: <tip-1bd3742043fa44dd0ec25770abdcdfe1f6e8681e@git.kernel.org>
Cc: mingo@kernel.org, will.deacon@arm.com, torvalds@linux-foundation.org,
        andrea.parri@amarulasolutions.com, linux-kernel@vger.kernel.org,
        stern@rowland.harvard.edu, paulmck@linux.vnet.ibm.com,
        akpm@linux-foundation.org, pbonzini@redhat.com, hpa@zytor.com,
        tglx@linutronix.de, peterz@infradead.org
Reply-To: paulmck@linux.vnet.ibm.com, stern@rowland.harvard.edu,
        linux-kernel@vger.kernel.org, andrea.parri@amarulasolutions.com,
        torvalds@linux-foundation.org, will.deacon@arm.com, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com,
        pbonzini@redhat.com, akpm@linux-foundation.org
In-Reply-To: <1526340837-12222-11-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1526340837-12222-11-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/memory-model: Flag "cumulativity" and
 "propagation" tests
Git-Commit-ID: 1bd3742043fa44dd0ec25770abdcdfe1f6e8681e
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

Commit-ID:  1bd3742043fa44dd0ec25770abdcdfe1f6e8681e
Gitweb:     https://git.kernel.org/tip/1bd3742043fa44dd0ec25770abdcdfe1f6e8681e
Author:     Paul E. McKenney <paulmck@linux.vnet.ibm.com>
AuthorDate: Mon, 14 May 2018 16:33:49 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 15 May 2018 08:11:17 +0200

tools/memory-model: Flag "cumulativity" and "propagation" tests

This commit flags WRC+pooncerelease+rmbonceonce+Once.litmus
as being forbidden by smp_store_release() A-cumulativity and
IRIW+mbonceonces+OnceOnce.litmus as being forbidden by the LKMM
propagation rule.

Suggested-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Reported-by: Paolo Bonzini <pbonzini@redhat.com>
[ paulmck: Updated wording as suggested by Alan Stern. ]
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: akiyks@gmail.com
Cc: boqun.feng@gmail.com
Cc: dhowells@redhat.com
Cc: j.alglave@ucl.ac.uk
Cc: linux-arch@vger.kernel.org
Cc: luc.maranget@inria.fr
Cc: npiggin@gmail.com
Cc: parri.andrea@gmail.com
Link: http://lkml.kernel.org/r/1526340837-12222-11-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus | 2 +-
 tools/memory-model/litmus-tests/README                           | 9 ++++++---
 .../litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus       | 4 +++-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus b/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus
index 50d5db9ea983..98a3716efa37 100644
--- a/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus
+++ b/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus
@@ -7,7 +7,7 @@ C IRIW+mbonceonces+OnceOnce
  * between each pairs of reads.  In other words, is smp_mb() sufficient to
  * cause two different reading processes to agree on the order of a pair
  * of writes, where each write is to a different variable by a different
- * process?
+ * process?  This litmus test exercises LKMM's "propagation" rule.
  *)
 
 {}
diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index 6919909bbd0f..17eb9a8c222d 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -23,7 +23,8 @@ IRIW+mbonceonces+OnceOnce.litmus
 	between each pairs of reads.  In other words, is smp_mb()
 	sufficient to cause two different reading processes to agree on
 	the order of a pair of writes, where each write is to a different
-	variable by a different process?
+	variable by a different process?  This litmus test is forbidden
+	by LKMM's propagation rule.
 
 IRIW+poonceonces+OnceOnce.litmus
 	Test of independent reads from independent writes with nothing
@@ -119,8 +120,10 @@ S+wmbonceonce+poacquireonce.litmus
 
 WRC+poonceonces+Once.litmus
 WRC+pooncerelease+rmbonceonce+Once.litmus
-	These two are members of an extension of the MP litmus-test class
-	in which the first write is moved to a separate process.
+	These two are members of an extension of the MP litmus-test
+	class in which the first write is moved to a separate process.
+	The second is forbidden because smp_store_release() is
+	A-cumulative in LKMM.
 
 Z6.0+pooncelock+pooncelock+pombonce.litmus
 	Is the ordering provided by a spin_unlock() and a subsequent
diff --git a/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus b/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus
index 97fcbffde9a0..ad3448b941e6 100644
--- a/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus
+++ b/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus
@@ -5,7 +5,9 @@ C WRC+pooncerelease+rmbonceonce+Once
  *
  * This litmus test is an extension of the message-passing pattern, where
  * the first write is moved to a separate process.  Because it features
- * a release and a read memory barrier, it should be forbidden.
+ * a release and a read memory barrier, it should be forbidden.  More
+ * specifically, this litmus test is forbidden because smp_store_release()
+ * is A-cumulative in LKMM.
  *)
 
 {}
