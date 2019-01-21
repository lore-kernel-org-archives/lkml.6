Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1CCC282DE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD69C20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfAUHgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:36:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44845 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbfAUHgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:36:17 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4AACC19CF68;
        Mon, 21 Jan 2019 02:50:28 +0000 (UTC)
Received: from llong.com (ovpn-120-230.rdu2.redhat.com [10.10.120.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81A4C1048104;
        Mon, 21 Jan 2019 02:50:26 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        James Morse <james.morse@arm.com>,
        SRINIVAS <srinivas.eeda@oracle.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 5/5] locking/qspinlock: Add some locking debug code
Date:   Sun, 20 Jan 2019 21:49:54 -0500
Message-Id: <1548038994-30073-6-git-send-email-longman@redhat.com>
In-Reply-To: <1548038994-30073-1-git-send-email-longman@redhat.com>
References: <1548038994-30073-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 21 Jan 2019 02:50:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some optionally enabled debug code to check if more than one CPU
that enter the lock critical section simultaneously.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/qspinlock.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 8163633..7671dfc 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -97,6 +97,18 @@ struct qnode {
 };
 
 /*
+ * Define _Q_DEBUG_LOCK to verify if no more than one cpu can enter
+ * the lock critical section at the same time.
+ */
+// #define _Q_DEBUG_LOCK
+
+#ifdef _Q_DEBUG_LOCK
+#define _Q_DEBUG_WARN_ON(c)	WARN_ON_ONCE(c)
+#else
+#define _Q_DEBUG_WARN_ON(c)
+#endif
+
+/*
  * The pending bit spinning loop count.
  * This heuristic is used to limit the number of lockword accesses
  * made by atomic_cond_read_relaxed when waiting for the lock to
@@ -184,7 +196,13 @@ static __always_inline void clear_pending(struct qspinlock *lock)
  */
 static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
 {
+#ifdef _Q_DEBUG_LOCK
+	u16 old = xchg_relaxed(&lock->locked_pending, _Q_LOCKED_VAL);
+
+	WARN_ON_ONCE((old & _Q_LOCKED_VAL) || !(old & _Q_PENDING_VAL));
+#else
 	WRITE_ONCE(lock->locked_pending, _Q_LOCKED_VAL);
+#endif
 }
 
 /*
@@ -284,7 +302,13 @@ static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lo
  */
 static __always_inline void set_locked(struct qspinlock *lock)
 {
+#ifdef _O_DEBUG_LOCK
+	u8 old = xchg_relaxed(&lock->locked, _Q_LOCKED_VAL);
+
+	WARN_ON_ONCE(old);
+#else
 	WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
+#endif
 }
 
 /**
@@ -683,6 +707,9 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	if ((val & _Q_TAIL_MASK) == tail) {
 		u32 new = _Q_LOCKED_VAL | (val & _Q_WAIT_PEND_MASK);
 
+		_Q_DEBUG_WARN_ON((val & _Q_WAIT_PEND_MASK) &&
+				 (val & _Q_WAIT_PEND_MASK) != _Q_WAIT_PEND_VAL);
+
 		if (atomic_try_cmpxchg_relaxed(&lock->val, &val, new))
 			goto release; /* No contention */
 	}
-- 
1.8.3.1

