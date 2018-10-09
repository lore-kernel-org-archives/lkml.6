Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B47C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B129204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B129204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbeJIQlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 12:41:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35816 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbeJIQlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 12:41:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id w5-v6so1007299wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 02:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XI2XQf8S1vi1KRw0FJDK/HTbbuYWwx9icOC8VoPEKLs=;
        b=q1xAv41AGP0bISwneScBXlLIemXT+Am2A7Yt6/sTE2rDCjR9nEtE/aBWTfVJOVGLhi
         vDMV2/Urh2E9UwM0WnbpQ2rR3mvAow4t79RBnT8d6IL/2hkGl9tzTqkPCWN/51MnSrwE
         gUrKEdDR1VG3h2jgjGI0W/2vZoIdFCH/VT7SsqGHK0ZVI3SKo0D6paR0pv1Q7gtedbaT
         5G4KdNsWUyerNBpfCADGzHuO8F5lMLqEghPkv85UCYU9oYlp4QY2N/U/qgjw0s/bdmeO
         Sw53Y/I51Z/Xdr5bflIeL7WHlywnGlHOyQMTbkgrmUfb0ONYWuJamPYBXHcpiWyNVKSR
         jXDA==
X-Gm-Message-State: ABuFfoh5xNPjYTghagsMM6qvIBYxgZPPJwVBzL2ylWmXDmlvHcNvEZdQ
        OSWbie5POmwKNFLrL6hQEgbfjw==
X-Google-Smtp-Source: ACcGV60EbEssGMhzxKiRVWTriaRM0WoA0fhcqYcmjAqxBtRUX4fCZxG6WaW6geKnGtWF82lGK2uSdw==
X-Received: by 2002:adf:a1dd:: with SMTP id v29-v6mr18940705wrv.50.1539077106417;
        Tue, 09 Oct 2018 02:25:06 -0700 (PDT)
Received: from localhost.localdomain.Speedport_W_921V_1_44_000 (p200300EF2BD31613C1F2E846AEDA540D.dip0.t-ipconnect.de. [2003:ef:2bd3:1613:c1f2:e846:aeda:540d])
        by smtp.gmail.com with ESMTPSA id o201-v6sm16049413wmg.16.2018.10.09.02.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 02:25:05 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [RFD/RFC PATCH 2/8] locking/mutex: Removes wakeups from under mutex::wait_lock
Date:   Tue,  9 Oct 2018 11:24:28 +0200
Message-Id: <20181009092434.26221-3-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009092434.26221-1-juri.lelli@redhat.com>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

In preparation to nest mutex::wait_lock under rq::lock we need to remove
wakeups from under it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[Heavily changed after 55f036ca7e74 ("locking: WW mutex cleanup") and
08295b3b5bee ("locking: Implement an algorithm choice for Wound-Wait
mutexes")]
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/locking/mutex.c | 43 +++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index df34ce70fcde..f37402cd8496 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -338,7 +338,7 @@ __ww_ctx_stamp_after(struct ww_acquire_ctx *a, struct ww_acquire_ctx *b)
  */
 static bool __sched
 __ww_mutex_die(struct mutex *lock, struct mutex_waiter *waiter,
-	       struct ww_acquire_ctx *ww_ctx)
+	       struct ww_acquire_ctx *ww_ctx, struct wake_q_head *wake_q)
 {
 	if (!ww_ctx->is_wait_die)
 		return false;
@@ -346,7 +346,7 @@ __ww_mutex_die(struct mutex *lock, struct mutex_waiter *waiter,
 	if (waiter->ww_ctx->acquired > 0 &&
 			__ww_ctx_stamp_after(waiter->ww_ctx, ww_ctx)) {
 		debug_mutex_wake_waiter(lock, waiter);
-		wake_up_process(waiter->task);
+		wake_q_add(wake_q, waiter->task); // XXX
 	}
 
 	return true;
@@ -361,7 +361,8 @@ __ww_mutex_die(struct mutex *lock, struct mutex_waiter *waiter,
  */
 static bool __ww_mutex_wound(struct mutex *lock,
 			     struct ww_acquire_ctx *ww_ctx,
-			     struct ww_acquire_ctx *hold_ctx)
+			     struct ww_acquire_ctx *hold_ctx,
+			     struct wake_q_head *wake_q)
 {
 	struct task_struct *owner = __mutex_owner(lock);
 
@@ -393,7 +394,7 @@ static bool __ww_mutex_wound(struct mutex *lock,
 		 * wakeup pending to re-read the wounded state.
 		 */
 		if (owner != current)
-			wake_up_process(owner);
+			wake_q_add(wake_q, owner); // XXX
 
 		return true;
 	}
@@ -414,7 +415,9 @@ static bool __ww_mutex_wound(struct mutex *lock,
  * The current task must not be on the wait list.
  */
 static void __sched
-__ww_mutex_check_waiters(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
+__ww_mutex_check_waiters(struct mutex *lock,
+			 struct ww_acquire_ctx *ww_ctx,
+			 struct wake_q_head *wake_q)
 {
 	struct mutex_waiter *cur;
 
@@ -424,8 +427,8 @@ __ww_mutex_check_waiters(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
 		if (!cur->ww_ctx)
 			continue;
 
-		if (__ww_mutex_die(lock, cur, ww_ctx) ||
-		    __ww_mutex_wound(lock, cur->ww_ctx, ww_ctx))
+		if (__ww_mutex_die(lock, cur, ww_ctx, wake_q) ||
+		    __ww_mutex_wound(lock, cur->ww_ctx, ww_ctx, wake_q))
 			break;
 	}
 }
@@ -437,6 +440,8 @@ __ww_mutex_check_waiters(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
 static __always_inline void
 ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 {
+	DEFINE_WAKE_Q(wake_q);
+
 	ww_mutex_lock_acquired(lock, ctx);
 
 	/*
@@ -465,8 +470,10 @@ ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 	 * die or wound us.
 	 */
 	raw_spin_lock(&lock->base.wait_lock);
-	__ww_mutex_check_waiters(&lock->base, ctx);
+	__ww_mutex_check_waiters(&lock->base, ctx, &wake_q);
 	raw_spin_unlock(&lock->base.wait_lock);
+
+	wake_up_q(&wake_q);
 }
 
 #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
@@ -824,7 +831,8 @@ __ww_mutex_check_kill(struct mutex *lock, struct mutex_waiter *waiter,
 static inline int __sched
 __ww_mutex_add_waiter(struct mutex_waiter *waiter,
 		      struct mutex *lock,
-		      struct ww_acquire_ctx *ww_ctx)
+		      struct ww_acquire_ctx *ww_ctx,
+		      struct wake_q_head *wake_q)
 {
 	struct mutex_waiter *cur;
 	struct list_head *pos;
@@ -868,7 +876,7 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
 		pos = &cur->list;
 
 		/* Wait-Die: ensure younger waiters die. */
-		__ww_mutex_die(lock, cur, ww_ctx);
+		__ww_mutex_die(lock, cur, ww_ctx, wake_q);
 	}
 
 	__mutex_add_waiter(lock, waiter, pos);
@@ -886,7 +894,7 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
 		 * such that either we or the fastpath will wound @ww->ctx.
 		 */
 		smp_mb();
-		__ww_mutex_wound(lock, ww_ctx, ww->ctx);
+		__ww_mutex_wound(lock, ww_ctx, ww->ctx, wake_q);
 	}
 
 	return 0;
@@ -900,6 +908,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 		    struct lockdep_map *nest_lock, unsigned long ip,
 		    struct ww_acquire_ctx *ww_ctx, const bool use_ww_ctx)
 {
+	DEFINE_WAKE_Q(wake_q);
 	struct mutex_waiter waiter;
 	bool first = false;
 	struct ww_mutex *ww;
@@ -940,7 +949,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	 */
 	if (__mutex_trylock(lock)) {
 		if (use_ww_ctx && ww_ctx)
-			__ww_mutex_check_waiters(lock, ww_ctx);
+			__ww_mutex_check_waiters(lock, ww_ctx, &wake_q);
 
 		goto skip_wait;
 	}
@@ -962,7 +971,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 		 * Add in stamp order, waking up waiters that must kill
 		 * themselves.
 		 */
-		ret = __ww_mutex_add_waiter(&waiter, lock, ww_ctx);
+		ret = __ww_mutex_add_waiter(&waiter, lock, ww_ctx, &wake_q);
 		if (ret)
 			goto err_early_kill;
 
@@ -1034,7 +1043,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 		 */
 		if (!ww_ctx->is_wait_die &&
 		    !__mutex_waiter_is_first(lock, &waiter))
-			__ww_mutex_check_waiters(lock, ww_ctx);
+			__ww_mutex_check_waiters(lock, ww_ctx, &wake_q);
 	}
 
 	mutex_remove_waiter(lock, &waiter, current);
@@ -1051,6 +1060,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 		ww_mutex_lock_acquired(ww, ww_ctx);
 
 	raw_spin_unlock(&lock->wait_lock);
+	wake_up_q(&wake_q);
 	preempt_enable();
 	return 0;
 
@@ -1061,6 +1071,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	raw_spin_unlock(&lock->wait_lock);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, 1, ip);
+	wake_up_q(&wake_q);
 	preempt_enable();
 	return ret;
 }
@@ -1244,9 +1255,11 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	if (owner & MUTEX_FLAG_HANDOFF)
 		__mutex_handoff(lock, next);
 
+	preempt_disable(); // XXX unlock->wakeup inversion like
 	raw_spin_unlock(&lock->wait_lock);
 
-	wake_up_q(&wake_q);
+	wake_up_q(&wake_q); // XXX must force resched on proxy
+	preempt_enable();
 }
 
 #ifndef CONFIG_DEBUG_LOCK_ALLOC
-- 
2.17.1

