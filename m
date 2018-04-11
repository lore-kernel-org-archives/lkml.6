Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753299AbeDKNrg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:47:36 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38699 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753236AbeDKNrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:47:32 -0400
X-Google-Smtp-Source: AIpwx4+GJD+u0nodSJddDF8/Emfigy7DBR1QJFLK8lPU1CP/FdgmDKe1Fq4KpKPSp3B3MngvnodO0g==
X-ME-Sender: <xms:7hHOWlvkQre2YFh13ckCZQGQ8pQ1s7k3erNB58paXsb5Fx4fvHzlaA>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [RFC tip/locking/lockdep v6 04/20] lockdep: Redefine LOCK_*_STATE* bits
Date: Wed, 11 Apr 2018 21:50:54 +0800
Message-Id: <20180411135110.9217-5-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180411135110.9217-1-boqun.feng@gmail.com>
References: <20180411135110.9217-1-boqun.feng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are three types of lock acquisitions: write, non-recursive read
and recursive read, among which write locks and non-recursive read locks
have no difference from a viewpoint for deadlock detections, because a
write acquisition of the corresponding lock on an independent CPU or
task makes a non-recursive read lock act as a write lock in the sense of
deadlock. So we could treat them as the same type (named as
"non-recursive lock") in lockdep.

As in the irq lock inversion detection (safe->unsafe deadlock
detection), we used to differ write lock with read lock (non-recursive
and recursive ones), such a classification could be improved as
non-recursive read lock behaves the same as write lock, so this patch
redefines the meanings of LOCK_{USED_IN, ENABLED}_STATE*.

old:
	LOCK_* : stands for write lock
	LOCK_*_READ: stands for read lock(non-recursive and recursive)
new:
	LOCK_* : stands for non-recursive(write lock and non-recursive
	read lock)
	LOCK_*_RR: stands for recursive read lock

Such a change is needed for a future improvement on recursive read
related irq inversion deadlock detection.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 Documentation/locking/lockdep-design.txt |  6 +++---
 kernel/locking/lockdep.c                 | 28 ++++++++++++++--------------
 kernel/locking/lockdep_internals.h       | 16 ++++++++--------
 kernel/locking/lockdep_proc.c            | 12 ++++++------
 4 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/Documentation/locking/lockdep-design.txt b/Documentation/locking/lockdep-design.txt
index 6bb9e90e2c4f..53ede30ce16d 100644
--- a/Documentation/locking/lockdep-design.txt
+++ b/Documentation/locking/lockdep-design.txt
@@ -30,9 +30,9 @@ State
 The validator tracks lock-class usage history into 4n + 1 separate state bits:
 
 - 'ever held in STATE context'
-- 'ever held as readlock in STATE context'
+- 'ever held as recursive readlock in STATE context'
 - 'ever held with STATE enabled'
-- 'ever held as readlock with STATE enabled'
+- 'ever held as recurisve readlock with STATE enabled'
 
 Where STATE can be either one of (kernel/locking/lockdep_states.h)
  - hardirq
@@ -51,7 +51,7 @@ locking error messages, inside curlies. A contrived example:
     (&sio_locks[i].lock){-.-...}, at: [<c02867fd>] mutex_lock+0x21/0x24
 
 
-The bit position indicates STATE, STATE-read, for each of the states listed
+The bit position indicates STATE, STATE-RR, for each of the states listed
 above, and the character displayed in each indicates:
 
    '.'  acquired while irqs disabled and not in irq context
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index f39a071ef0a8..14af2327b52a 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -448,10 +448,10 @@ DEFINE_PER_CPU(struct lockdep_stats, lockdep_stats);
  */
 
 #define __USAGE(__STATE)						\
-	[LOCK_USED_IN_##__STATE] = "IN-"__stringify(__STATE)"-W",	\
-	[LOCK_ENABLED_##__STATE] = __stringify(__STATE)"-ON-W",		\
-	[LOCK_USED_IN_##__STATE##_READ] = "IN-"__stringify(__STATE)"-R",\
-	[LOCK_ENABLED_##__STATE##_READ] = __stringify(__STATE)"-ON-R",
+	[LOCK_USED_IN_##__STATE] = "IN-"__stringify(__STATE),		\
+	[LOCK_ENABLED_##__STATE] = __stringify(__STATE)"-ON",		\
+	[LOCK_USED_IN_##__STATE##_RR] = "IN-"__stringify(__STATE)"-RR",	\
+	[LOCK_ENABLED_##__STATE##_RR] = __stringify(__STATE)"-ON-RR",
 
 static const char *usage_str[] =
 {
@@ -492,7 +492,7 @@ void get_usage_chars(struct lock_class *class, char usage[LOCK_USAGE_CHARS])
 
 #define LOCKDEP_STATE(__STATE) 						\
 	usage[i++] = get_usage_char(class, LOCK_USED_IN_##__STATE);	\
-	usage[i++] = get_usage_char(class, LOCK_USED_IN_##__STATE##_READ);
+	usage[i++] = get_usage_char(class, LOCK_USED_IN_##__STATE##_RR);
 #include "lockdep_states.h"
 #undef LOCKDEP_STATE
 
@@ -1645,7 +1645,7 @@ static const char *state_names[] = {
 
 static const char *state_rnames[] = {
 #define LOCKDEP_STATE(__STATE) \
-	__stringify(__STATE)"-READ",
+	__stringify(__STATE)"-RR",
 #include "lockdep_states.h"
 #undef LOCKDEP_STATE
 };
@@ -3039,14 +3039,14 @@ static int mark_irqflags(struct task_struct *curr, struct held_lock *hlock)
 	 * mark the lock as used in these contexts:
 	 */
 	if (!hlock->trylock) {
-		if (hlock->read) {
+		if (hlock->read == 2) {
 			if (curr->hardirq_context)
 				if (!mark_lock(curr, hlock,
-						LOCK_USED_IN_HARDIRQ_READ))
+						LOCK_USED_IN_HARDIRQ_RR))
 					return 0;
 			if (curr->softirq_context)
 				if (!mark_lock(curr, hlock,
-						LOCK_USED_IN_SOFTIRQ_READ))
+						LOCK_USED_IN_SOFTIRQ_RR))
 					return 0;
 		} else {
 			if (curr->hardirq_context)
@@ -3058,13 +3058,13 @@ static int mark_irqflags(struct task_struct *curr, struct held_lock *hlock)
 		}
 	}
 	if (!hlock->hardirqs_off) {
-		if (hlock->read) {
+		if (hlock->read == 2) {
 			if (!mark_lock(curr, hlock,
-					LOCK_ENABLED_HARDIRQ_READ))
+					LOCK_ENABLED_HARDIRQ_RR))
 				return 0;
 			if (curr->softirqs_enabled)
 				if (!mark_lock(curr, hlock,
-						LOCK_ENABLED_SOFTIRQ_READ))
+						LOCK_ENABLED_SOFTIRQ_RR))
 					return 0;
 		} else {
 			if (!mark_lock(curr, hlock,
@@ -3170,9 +3170,9 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	switch (new_bit) {
 #define LOCKDEP_STATE(__STATE)			\
 	case LOCK_USED_IN_##__STATE:		\
-	case LOCK_USED_IN_##__STATE##_READ:	\
+	case LOCK_USED_IN_##__STATE##_RR:	\
 	case LOCK_ENABLED_##__STATE:		\
-	case LOCK_ENABLED_##__STATE##_READ:
+	case LOCK_ENABLED_##__STATE##_RR:
 #include "lockdep_states.h"
 #undef LOCKDEP_STATE
 		ret = mark_lock_irq(curr, this, new_bit);
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index d459d624ba2a..93002d337936 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -13,9 +13,9 @@
 enum lock_usage_bit {
 #define LOCKDEP_STATE(__STATE)		\
 	LOCK_USED_IN_##__STATE,		\
-	LOCK_USED_IN_##__STATE##_READ,	\
+	LOCK_USED_IN_##__STATE##_RR,	\
 	LOCK_ENABLED_##__STATE,		\
-	LOCK_ENABLED_##__STATE##_READ,
+	LOCK_ENABLED_##__STATE##_RR,
 #include "lockdep_states.h"
 #undef LOCKDEP_STATE
 	LOCK_USED,
@@ -30,9 +30,9 @@ enum lock_usage_bit {
 enum {
 #define LOCKDEP_STATE(__STATE)						\
 	__LOCKF(USED_IN_##__STATE)					\
-	__LOCKF(USED_IN_##__STATE##_READ)				\
+	__LOCKF(USED_IN_##__STATE##_RR)				\
 	__LOCKF(ENABLED_##__STATE)					\
-	__LOCKF(ENABLED_##__STATE##_READ)
+	__LOCKF(ENABLED_##__STATE##_RR)
 #include "lockdep_states.h"
 #undef LOCKDEP_STATE
 	__LOCKF(USED)
@@ -41,10 +41,10 @@ enum {
 #define LOCKF_ENABLED_IRQ (LOCKF_ENABLED_HARDIRQ | LOCKF_ENABLED_SOFTIRQ)
 #define LOCKF_USED_IN_IRQ (LOCKF_USED_IN_HARDIRQ | LOCKF_USED_IN_SOFTIRQ)
 
-#define LOCKF_ENABLED_IRQ_READ \
-		(LOCKF_ENABLED_HARDIRQ_READ | LOCKF_ENABLED_SOFTIRQ_READ)
-#define LOCKF_USED_IN_IRQ_READ \
-		(LOCKF_USED_IN_HARDIRQ_READ | LOCKF_USED_IN_SOFTIRQ_READ)
+#define LOCKF_ENABLED_IRQ_RR \
+		(LOCKF_ENABLED_HARDIRQ_RR | LOCKF_ENABLED_SOFTIRQ_RR)
+#define LOCKF_USED_IN_IRQ_RR \
+		(LOCKF_USED_IN_HARDIRQ_RR | LOCKF_USED_IN_SOFTIRQ_RR)
 
 /*
  * CONFIG_LOCKDEP_SMALL is defined for sparc. Sparc requires .text,
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index ad69bbc9bd28..630a6bc6e24c 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -252,17 +252,17 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 			nr_hardirq_safe++;
 		if (class->usage_mask & LOCKF_ENABLED_HARDIRQ)
 			nr_hardirq_unsafe++;
-		if (class->usage_mask & LOCKF_USED_IN_IRQ_READ)
+		if (class->usage_mask & LOCKF_USED_IN_IRQ_RR)
 			nr_irq_read_safe++;
-		if (class->usage_mask & LOCKF_ENABLED_IRQ_READ)
+		if (class->usage_mask & LOCKF_ENABLED_IRQ_RR)
 			nr_irq_read_unsafe++;
-		if (class->usage_mask & LOCKF_USED_IN_SOFTIRQ_READ)
+		if (class->usage_mask & LOCKF_USED_IN_SOFTIRQ_RR)
 			nr_softirq_read_safe++;
-		if (class->usage_mask & LOCKF_ENABLED_SOFTIRQ_READ)
+		if (class->usage_mask & LOCKF_ENABLED_SOFTIRQ_RR)
 			nr_softirq_read_unsafe++;
-		if (class->usage_mask & LOCKF_USED_IN_HARDIRQ_READ)
+		if (class->usage_mask & LOCKF_USED_IN_HARDIRQ_RR)
 			nr_hardirq_read_safe++;
-		if (class->usage_mask & LOCKF_ENABLED_HARDIRQ_READ)
+		if (class->usage_mask & LOCKF_ENABLED_HARDIRQ_RR)
 			nr_hardirq_read_unsafe++;
 
 #ifdef CONFIG_PROVE_LOCKING
-- 
2.16.2
