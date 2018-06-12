Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 74862C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A7F208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A7F208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934614AbeFLQRK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:17:10 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41429 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933947AbeFLQQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:16:44 -0400
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fSlyL-0000sL-NF; Tue, 12 Jun 2018 18:16:41 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/3] locking/refcount: implement refcount_dec_and_lock_irqsave()
Date:   Tue, 12 Jun 2018 18:16:21 +0200
Message-Id: <20180612161621.22645-4-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612161621.22645-1-bigeasy@linutronix.de>
References: <20180612161621.22645-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anna-Maria Gleixner <anna-maria@linutronix.de>

There are in-tree users of refcount_dec_and_lock() which must acquire the
spin lock with interrupts disabled. To workaround the lack of an irqsave
variant of refcount_dec_and_lock() they use local_irq_save() at the call
site. This causes extra code and creates in some places unneeded long
interrupt disabled times. These places need also extra treatment for
PREEMPT_RT due to the disconnect of the irq disabling and the lock
function.

Implement the missing irqsave variant of the function.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
[bigeasy: s@atomic_dec_and_lock@refcount_dec_and_lock@g]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/refcount.h |  4 +++-
 lib/refcount.c           | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 4193c41e383a..a685da2c4522 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -98,5 +98,7 @@ extern __must_check bool refcount_dec_if_one(refcount_t *=
r);
 extern __must_check bool refcount_dec_not_one(refcount_t *r);
 extern __must_check bool refcount_dec_and_mutex_lock(refcount_t *r, struct=
 mutex *lock);
 extern __must_check bool refcount_dec_and_lock(refcount_t *r, spinlock_t *=
lock);
-
+extern __must_check bool refcount_dec_and_lock_irqsave(refcount_t *r,
+						       spinlock_t *lock,
+						       unsigned long *flags);
 #endif /* _LINUX_REFCOUNT_H */
diff --git a/lib/refcount.c b/lib/refcount.c
index 0eb48353abe3..d3b81cefce91 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -350,3 +350,31 @@ bool refcount_dec_and_lock(refcount_t *r, spinlock_t *=
lock)
 }
 EXPORT_SYMBOL(refcount_dec_and_lock);
=20
+/**
+ * refcount_dec_and_lock_irqsave - return holding spinlock with disabled
+ *                                 interrupts if able to decrement refcoun=
t to 0
+ * @r: the refcount
+ * @lock: the spinlock to be locked
+ * @flags: saved IRQ-flags if the is acquired
+ *
+ * Same as refcount_dec_and_lock() above except that the spinlock is acqui=
red
+ * with disabled interupts.
+ *
+ * Return: true and hold spinlock if able to decrement refcount to 0, false
+ *         otherwise
+ */
+bool refcount_dec_and_lock_irqsave(refcount_t *r, spinlock_t *lock,
+				   unsigned long *flags)
+{
+	if (refcount_dec_not_one(r))
+		return false;
+
+	spin_lock_irqsave(lock, *flags);
+	if (!refcount_dec_and_test(r)) {
+		spin_unlock_irqrestore(lock, *flags);
+		return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL(refcount_dec_and_lock_irqsave);
--=20
2.17.1

