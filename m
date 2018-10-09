Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79706C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC68204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC68204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeJIQle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 12:41:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39318 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeJIQlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 12:41:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id 61-v6so1000053wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 02:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5N9xzKL9+ZTyttS7+jIGOcxkAOnYuHpyhyQNGO6+joU=;
        b=fqE7tzZiL9lryXa+zhX677LymLhedrMKmhNLZvXKV7j7SGgZGGYpW1wG+SS7aBwhfy
         qIM9DzLGV633ckXB/KOutViWspk1kLRdN5rRb5XVE9gCeZrC9HM/Vfke841z7wttgtQd
         8L5sjcJ9xVVmZLC30GnR29rXS/RxsRnXUx3mKAzeO4i9BzqS8I14ys/ODPM1yHtdqI9G
         MHXGlDmJeIGey/qctwNLQrw9WKymFtfUfDw4j4XLsqHnq2WvxMCIzejtTWObyQfW1xV7
         l6KXxb8Yy4N1sP73cTO9Aeru+WydndSLh/NSuihttZhwElk4q6N0pfWeipeMorkOQVg/
         3kbg==
X-Gm-Message-State: ABuFfoi3ckmvmy555ebP1FQqLuwqdJXQhE2gOi6b7QmF4KUnP+HXdEes
        tJVrvySTJrW1tFNMN3w4aX6ldw==
X-Google-Smtp-Source: ACcGV61bSI4vXUa0vDLrVYt8at/VYtpkovmPZ/+Pkj19WcwqhjDOyFqQAnmUOXhFSQDKM1hLmpAEug==
X-Received: by 2002:adf:8206:: with SMTP id 6-v6mr19107299wrb.160.1539077115777;
        Tue, 09 Oct 2018 02:25:15 -0700 (PDT)
Received: from localhost.localdomain.Speedport_W_921V_1_44_000 (p200300EF2BD31613C1F2E846AEDA540D.dip0.t-ipconnect.de. [2003:ef:2bd3:1613:c1f2:e846:aeda:540d])
        by smtp.gmail.com with ESMTPSA id o201-v6sm16049413wmg.16.2018.10.09.02.25.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 02:25:14 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [RFD/RFC PATCH 6/8] locking/mutex: make mutex::wait_lock irq safe
Date:   Tue,  9 Oct 2018 11:24:32 +0200
Message-Id: <20181009092434.26221-7-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009092434.26221-1-juri.lelli@redhat.com>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mutex::wait_lock might be nested under rq->lock.

Make it irq safe then.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/locking/mutex.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 23312afa7fca..c16cb84420c3 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -444,6 +444,7 @@ __ww_mutex_check_waiters(struct mutex *lock,
 static __always_inline void
 ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 {
+	unsigned long flags;
 	DEFINE_WAKE_Q(wake_q);
 
 	ww_mutex_lock_acquired(lock, ctx);
@@ -473,9 +474,9 @@ ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 	 * Uh oh, we raced in fastpath, check if any of the waiters need to
 	 * die or wound us.
 	 */
-	raw_spin_lock(&lock->base.wait_lock);
+	raw_spin_lock_irqsave(&lock->base.wait_lock, flags);
 	__ww_mutex_check_waiters(&lock->base, ctx, &wake_q);
-	raw_spin_unlock(&lock->base.wait_lock);
+	raw_spin_unlock_irqrestore(&lock->base.wait_lock, flags);
 
 	wake_up_q(&wake_q);
 }
@@ -917,6 +918,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	bool first = false;
 	struct ww_mutex *ww;
 	int ret;
+	unsigned long flags;
 
 	might_sleep();
 
@@ -947,7 +949,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 		return 0;
 	}
 
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	/*
 	 * After waiting to acquire the wait_lock, try again.
 	 */
@@ -1012,7 +1014,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 				goto err;
 		}
 
-		raw_spin_unlock(&lock->wait_lock);
+		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 		schedule_preempt_disabled();
 
 		/*
@@ -1039,9 +1041,9 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 		    (first && mutex_optimistic_spin(lock, ww_ctx, use_ww_ctx, &waiter)))
 			break;
 
-		raw_spin_lock(&lock->wait_lock);
+		raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	}
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 acquired:
 	__set_current_state(TASK_RUNNING);
 
@@ -1070,7 +1072,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	if (use_ww_ctx && ww_ctx)
 		ww_mutex_lock_acquired(ww, ww_ctx);
 
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	wake_up_q(&wake_q);
 	preempt_enable();
 	return 0;
@@ -1079,7 +1081,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	__set_current_state(TASK_RUNNING);
 	mutex_remove_waiter(lock, &waiter, current);
 err_early_kill:
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, 1, ip);
 	wake_up_q(&wake_q);
@@ -1220,6 +1222,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	 * conditional on having proxy exec configured in?
 	 */
 	unsigned long owner = MUTEX_FLAG_HANDOFF;
+	unsigned long flags;
 
 	mutex_release(&lock->dep_map, 1, ip);
 
@@ -1261,7 +1264,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	}
 #endif
 
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	debug_mutex_unlock(lock);
 
 #ifdef CONFIG_PROXY_EXEC
@@ -1302,7 +1305,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		__mutex_handoff(lock, next);
 
 	preempt_disable(); // XXX unlock->wakeup inversion like
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
 	wake_up_q(&wake_q); // XXX must force resched on proxy
 	preempt_enable();
-- 
2.17.1

