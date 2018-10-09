Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D27C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030492086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030492086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeJIQlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 12:41:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52375 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbeJIQlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 12:41:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id 189-v6so1091475wmw.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 02:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cQxvnFit2BCY60loYmUovAXp52dGzvN9j1fTOZFvu+Q=;
        b=H0KWzJPMifEFcAqluBxQepQXgjPwAjsSNNg6T9EEpUAJYXfcwtJ4VkDsMD+SFeCo6k
         L8o5lhVV1e/bmb4uIOOEWNoNzrX3m6z4jhOUjhhNLwRVIQIIBhrX6UdPUGsm2kPIGuOJ
         9DPY9NkFgkLuvu3oIuqLTPg0F+cDASbGbmQ+oM3VIUFjm+63BEh4SM/j6ewDK7J2JRT1
         VEqn1mKKsPz5krNtSmsBaYjRw6AJ9TWbuQiOyDr4OMkmN/jXq9wf479ffVlng5eDb36k
         KvU7E2WYMgttOnInWmAhuvkz8NdPj9lJrboBks31zgflow2pA76WvmhuBVJuu+BlO8UT
         KuOg==
X-Gm-Message-State: ABuFfoit9xefY+Ztl9F8Xz+QZ27lzkw6t/Fi+w4SSec+BZvCiPRKmZxV
        KZNTye9mWU6FXjQZ37ihdDwsjA==
X-Google-Smtp-Source: ACcGV62wyYhM3W5jwSgfbpJiUXHwYBOVihW62k8yFm2NqVBLF9T9IJibi6evbx41/vhR64Utn6g1oQ==
X-Received: by 2002:a1c:2052:: with SMTP id g79-v6mr1318278wmg.42.1539077109211;
        Tue, 09 Oct 2018 02:25:09 -0700 (PDT)
Received: from localhost.localdomain.Speedport_W_921V_1_44_000 (p200300EF2BD31613C1F2E846AEDA540D.dip0.t-ipconnect.de. [2003:ef:2bd3:1613:c1f2:e846:aeda:540d])
        by smtp.gmail.com with ESMTPSA id o201-v6sm16049413wmg.16.2018.10.09.02.25.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 02:25:08 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [RFD/RFC PATCH 3/8] locking/mutex: Rework task_struct::blocked_on
Date:   Tue,  9 Oct 2018 11:24:29 +0200
Message-Id: <20181009092434.26221-4-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009092434.26221-1-juri.lelli@redhat.com>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Track the blocked-on relation for mutexes, this allows following this
relation at schedule time. Add blocked_task to track the inverse
relation.

                ,-> task
                |     | blocked-on
                |     v
   blocked-task |   mutex
                |     | owner
                |     v
                `-- task

This patch only enables blocked-on relation, blocked-task will be
enabled in a later patch implementing proxy().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[minor changes while rebasing]
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/sched.h        | 6 ++----
 kernel/fork.c                | 6 +++---
 kernel/locking/mutex-debug.c | 7 +++----
 kernel/locking/mutex.c       | 3 +++
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 977cb57d7bc9..a35e8ab3eef1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -907,10 +907,8 @@ struct task_struct {
 	struct rt_mutex_waiter		*pi_blocked_on;
 #endif
 
-#ifdef CONFIG_DEBUG_MUTEXES
-	/* Mutex deadlock detection: */
-	struct mutex_waiter		*blocked_on;
-#endif
+	struct task_struct 	*blocked_task;	/* task that's boosting us */
+	struct mutex 		*blocked_on;	/* lock we're blocked on */
 
 #ifdef CONFIG_TRACE_IRQFLAGS
 	unsigned int			irq_events;
diff --git a/kernel/fork.c b/kernel/fork.c
index f0b58479534f..ef27a675b0d7 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1827,9 +1827,9 @@ static __latent_entropy struct task_struct *copy_process(
 	lockdep_init_task(p);
 #endif
 
-#ifdef CONFIG_DEBUG_MUTEXES
-	p->blocked_on = NULL; /* not blocked yet */
-#endif
+	p->blocked_task = NULL; /* nobody is boosting us yet*/
+	p->blocked_on = NULL;  /* not blocked yet */
+
 #ifdef CONFIG_BCACHE
 	p->sequential_io	= 0;
 	p->sequential_io_avg	= 0;
diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index a660d38b6c29..6605e083a3e9 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -53,8 +53,8 @@ void debug_mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 {
 	SMP_DEBUG_LOCKS_WARN_ON(!raw_spin_is_locked(&lock->wait_lock));
 
-	/* Mark the current thread as blocked on the lock: */
-	task->blocked_on = waiter;
+	/* Current thread can't be alredy blocked (since it's executing!) */
+	DEBUG_LOCKS_WARN_ON(task->blocked_on);
 }
 
 void mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
@@ -62,8 +62,7 @@ void mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 {
 	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
 	DEBUG_LOCKS_WARN_ON(waiter->task != task);
-	DEBUG_LOCKS_WARN_ON(task->blocked_on != waiter);
-	task->blocked_on = NULL;
+	DEBUG_LOCKS_WARN_ON(task->blocked_on != lock);
 
 	list_del_init(&waiter->list);
 	waiter->task = NULL;
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index f37402cd8496..76b59b555da3 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -979,6 +979,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	}
 
 	waiter.task = current;
+	current->blocked_on = lock;
 
 	set_current_state(state);
 	for (;;) {
@@ -1047,6 +1048,8 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	}
 
 	mutex_remove_waiter(lock, &waiter, current);
+	current->blocked_on = NULL;
+
 	if (likely(list_empty(&lock->wait_list)))
 		__mutex_clear_flag(lock, MUTEX_FLAGS);
 
-- 
2.17.1

