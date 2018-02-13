Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965646AbeBMSzt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 13:55:49 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51563 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965503AbeBMSzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 13:55:45 -0500
X-Google-Smtp-Source: AH8x225Qr+swDR5CTwtf1CR84ty9rmXZao08XI7olhxG6KqwrsWgxRBWLe6RSeZ2Ie3LoQPNy/VkuA==
From: Juri Lelli <juri.lelli@redhat.com>
To: peterz@infradead.org, mingo@redhat.com, corbet@lwn.net
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        juri.lelli@redhat.com
Subject: [RFC PATCH 2/2] Documentation/locking/lockdep: Add section about available annotations
Date: Tue, 13 Feb 2018 19:55:19 +0100
Message-Id: <20180213185519.18186-3-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180213185519.18186-1-juri.lelli@redhat.com>
References: <20180213185519.18186-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add section about annotations that can be used to perform additional runtime
checking of locking correctness: assert that certain locks are held and
prevent accidental unlocking.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
 Documentation/locking/lockdep-design.txt | 47 ++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/locking/lockdep-design.txt b/Documentation/locking/lockdep-design.txt
index e341c2f34e68..74347a24efc7 100644
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
+particular lock is held at a certain time (and generate a WARN otherwise).
+This annotation is largely used all over the kernel, e.g. kernel/sched/
+core.c
+
+  void update_rq_clock(struct rq *rq)
+  {
+  	s64 delta;
+
+  	lockdep_assert_held(&rq->lock);
+	[...]
+  }
+
+where holding rq->lock is required to safely update a rq's clock.
+
+The other family of macros is lockdep_*pin_lock, which is admittedly only
+used for rq->lock ATM. Despite their limited adoption these annotations
+generate a WARN if the lock of interest is "accidentally" unlocked. This turns
+out to be especially helpful to debug code with callbacks, where an upper
+layer assumes a lock remains taken, but a lower layer thinks it can maybe drop
+and reacquire the lock ("unwittingly" introducing races). lockdep_pin_lock
+returns a 'struct pin_cookie' that is then used by lockdep_unpin_lock to check
+that nobody tampered with the lock, e.g. kernel/sched/sched.h
+
+  static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
+  {
+  	rf->cookie = lockdep_pin_lock(&rq->lock);
+	[...]
+  }
+
+  static inline void rq_unpin_lock(struct rq *rq, struct rq_flags *rf)
+  {
+  	[...]
+  	lockdep_unpin_lock(&rq->lock, rf->cookie);
+  }
+
+While comments about locking requirements might provide useful information,
+the runtime checks performed by annotations are invaluable when debugging
+locking problems and they carry the same level of details when inspecting
+code.  Always prefer annotations when in doubt!
+
 Proof of 100% correctness:
 --------------------------
 
-- 
2.14.3
