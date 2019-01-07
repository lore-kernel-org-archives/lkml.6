Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF764C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0D02147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbfAGTyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:54:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:35388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727885AbfAGTxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:53:34 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2774021855;
        Mon,  7 Jan 2019 19:53:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1ggaxo-0000IL-7Q; Mon, 07 Jan 2019 14:53:32 -0500
Message-Id: <20190107195332.098645365@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Jan 2019 14:52:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Clark Williams <williams@redhat.com>
Subject: [PATCH RT 03/13] mm/kasan: make quarantine_lock a raw_spinlock_t
References: <20190107195252.599921907@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14.87-rt50-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Clark Williams <williams@redhat.com>

[ Upstream commit 089cb35faad5da57fa90399b230b3aee4920bb02 ]

The static lock quarantine_lock is used in quarantine.c to protect the
quarantine queue datastructures. It is taken inside quarantine queue
manipulation routines (quarantine_put(), quarantine_reduce() and
quarantine_remove_cache()), with IRQs disabled.
This is not a problem on a stock kernel but is problematic on an RT
kernel where spin locks are sleeping spinlocks, which can sleep and can
not be acquired with disabled interrupts.

Convert the quarantine_lock to a raw spinlock_t. The usage of
quarantine_lock is confined to quarantine.c and the work performed while
the lock is held is limited.

Signed-off-by: Clark Williams <williams@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 mm/kasan/quarantine.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index 3a8ddf8baf7d..b209dbaefde8 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -103,7 +103,7 @@ static int quarantine_head;
 static int quarantine_tail;
 /* Total size of all objects in global_quarantine across all batches. */
 static unsigned long quarantine_size;
-static DEFINE_SPINLOCK(quarantine_lock);
+static DEFINE_RAW_SPINLOCK(quarantine_lock);
 DEFINE_STATIC_SRCU(remove_cache_srcu);
 
 /* Maximum size of the global queue. */
@@ -190,7 +190,7 @@ void quarantine_put(struct kasan_free_meta *info, struct kmem_cache *cache)
 	if (unlikely(q->bytes > QUARANTINE_PERCPU_SIZE)) {
 		qlist_move_all(q, &temp);
 
-		spin_lock(&quarantine_lock);
+		raw_spin_lock(&quarantine_lock);
 		WRITE_ONCE(quarantine_size, quarantine_size + temp.bytes);
 		qlist_move_all(&temp, &global_quarantine[quarantine_tail]);
 		if (global_quarantine[quarantine_tail].bytes >=
@@ -203,7 +203,7 @@ void quarantine_put(struct kasan_free_meta *info, struct kmem_cache *cache)
 			if (new_tail != quarantine_head)
 				quarantine_tail = new_tail;
 		}
-		spin_unlock(&quarantine_lock);
+		raw_spin_unlock(&quarantine_lock);
 	}
 
 	local_irq_restore(flags);
@@ -230,7 +230,7 @@ void quarantine_reduce(void)
 	 * expected case).
 	 */
 	srcu_idx = srcu_read_lock(&remove_cache_srcu);
-	spin_lock_irqsave(&quarantine_lock, flags);
+	raw_spin_lock_irqsave(&quarantine_lock, flags);
 
 	/*
 	 * Update quarantine size in case of hotplug. Allocate a fraction of
@@ -254,7 +254,7 @@ void quarantine_reduce(void)
 			quarantine_head = 0;
 	}
 
-	spin_unlock_irqrestore(&quarantine_lock, flags);
+	raw_spin_unlock_irqrestore(&quarantine_lock, flags);
 
 	qlist_free_all(&to_free, NULL);
 	srcu_read_unlock(&remove_cache_srcu, srcu_idx);
@@ -310,17 +310,17 @@ void quarantine_remove_cache(struct kmem_cache *cache)
 	 */
 	on_each_cpu(per_cpu_remove_cache, cache, 1);
 
-	spin_lock_irqsave(&quarantine_lock, flags);
+	raw_spin_lock_irqsave(&quarantine_lock, flags);
 	for (i = 0; i < QUARANTINE_BATCHES; i++) {
 		if (qlist_empty(&global_quarantine[i]))
 			continue;
 		qlist_move_cache(&global_quarantine[i], &to_free, cache);
 		/* Scanning whole quarantine can take a while. */
-		spin_unlock_irqrestore(&quarantine_lock, flags);
+		raw_spin_unlock_irqrestore(&quarantine_lock, flags);
 		cond_resched();
-		spin_lock_irqsave(&quarantine_lock, flags);
+		raw_spin_lock_irqsave(&quarantine_lock, flags);
 	}
-	spin_unlock_irqrestore(&quarantine_lock, flags);
+	raw_spin_unlock_irqrestore(&quarantine_lock, flags);
 
 	qlist_free_all(&to_free, cache);
 
-- 
2.19.2


