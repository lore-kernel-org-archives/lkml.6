Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967349AbeBNLFr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 06:05:47 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58765 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967252AbeBNLFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 06:05:46 -0500
Date: Wed, 14 Feb 2018 03:04:45 -0800
From: tip-bot for Juri Lelli <tipbot@zytor.com>
Message-ID: <tip-a1ea544fe0911492b9f8d101bcbf46cc8c47fbc5@git.kernel.org>
Cc: juri.lelli@redhat.com, hpa@zytor.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org
Reply-To: corbet@lwn.net, peterz@infradead.org, tglx@linutronix.de,
        mingo@kernel.org, hpa@zytor.com, torvalds@linux-foundation.org,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20180213185519.18186-3-juri.lelli@redhat.com>
References: <20180213185519.18186-3-juri.lelli@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] Documentation/locking/lockdep: Add section about
 available annotations
Git-Commit-ID: a1ea544fe0911492b9f8d101bcbf46cc8c47fbc5
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

Commit-ID:  a1ea544fe0911492b9f8d101bcbf46cc8c47fbc5
Gitweb:     https://git.kernel.org/tip/a1ea544fe0911492b9f8d101bcbf46cc8c47fbc5
Author:     Juri Lelli <juri.lelli@redhat.com>
AuthorDate: Tue, 13 Feb 2018 19:55:19 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 14 Feb 2018 12:01:22 +0100

Documentation/locking/lockdep: Add section about available annotations

Add section about annotations that can be used to perform additional runtime
checking of locking correctness: assert that certain locks are held and
prevent accidental unlocking.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-doc@vger.kernel.org
Link: http://lkml.kernel.org/r/20180213185519.18186-3-juri.lelli@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/locking/lockdep-design.txt | 47 ++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/locking/lockdep-design.txt b/Documentation/locking/lockdep-design.txt
index e341c2f..49f58a0 100644
--- a/Documentation/locking/lockdep-design.txt
+++ b/Documentation/locking/lockdep-design.txt
@@ -169,6 +169,53 @@ Note: When changing code to use the _nested() primitives, be careful and
 check really thoroughly that the hierarchy is correctly mapped; otherwise
 you can get false positives or false negatives.
 
+Annotations
+-----------
+
+Two constructs can be used to annotate and check where and if certain locks
+must be held: lockdep_assert_held*(&lock) and lockdep_*pin_lock(&lock).
+
+As the name suggests, lockdep_assert_held* family of macros assert that a
+particular lock is held at a certain time (and generate a WARN() otherwise).
+This annotation is largely used all over the kernel, e.g. kernel/sched/
+core.c
+
+  void update_rq_clock(struct rq *rq)
+  {
+	s64 delta;
+
+	lockdep_assert_held(&rq->lock);
+	[...]
+  }
+
+where holding rq->lock is required to safely update a rq's clock.
+
+The other family of macros is lockdep_*pin_lock(), which is admittedly only
+used for rq->lock ATM. Despite their limited adoption these annotations
+generate a WARN() if the lock of interest is "accidentally" unlocked. This turns
+out to be especially helpful to debug code with callbacks, where an upper
+layer assumes a lock remains taken, but a lower layer thinks it can maybe drop
+and reacquire the lock ("unwittingly" introducing races). lockdep_pin_lock()
+returns a 'struct pin_cookie' that is then used by lockdep_unpin_lock() to check
+that nobody tampered with the lock, e.g. kernel/sched/sched.h
+
+  static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
+  {
+	rf->cookie = lockdep_pin_lock(&rq->lock);
+	[...]
+  }
+
+  static inline void rq_unpin_lock(struct rq *rq, struct rq_flags *rf)
+  {
+	[...]
+	lockdep_unpin_lock(&rq->lock, rf->cookie);
+  }
+
+While comments about locking requirements might provide useful information,
+the runtime checks performed by annotations are invaluable when debugging
+locking problems and they carry the same level of details when inspecting
+code.  Always prefer annotations when in doubt!
+
 Proof of 100% correctness:
 --------------------------
 
