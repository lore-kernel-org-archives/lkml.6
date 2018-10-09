Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3D0C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F77204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F77204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeJIQlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 12:41:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41476 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbeJIQlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 12:41:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id x12-v6so990926wru.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 02:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Klvx/VAbcZUESi3F+iPNMAHbNP0czwjNcz1wQrWOTH4=;
        b=cK3k+ujzYgIqDBX5baoms3TTUaBKehd3yfh3hxh9uA++zVA2vbT9jcEERDkLM4TkZx
         2sKtGmw2kdMnyKwlKWsvsfqXkpjzbB8Htcz29B8lxx/EYv6i90G8CgekxBXd0JgCI+zA
         OVpt0SbNLWdwd/zrJ7ZZ31H7Bsl3zjm1qbrFM2B4F9FEh8rULKKLQuz2AS6Dr5gOHyT3
         4X/HV896zGhxXYoHdCkL6XFdZ7+WwnbWaIxawkmz0kmUJ/1hsDs507oNJ1smM2z79oto
         Hbr6SVnGN5nLjhPnHC7CoPp52UXKOWuzkQNbprxP8iQB3/v7wKPzL8EG9BRceyuoKphf
         rA9g==
X-Gm-Message-State: ABuFfog7PunoGVwKPxUJz8xCJ5IeZ1JGbnd2BBJwJi5wRfYzULQgyizW
        aPMoyFNkd86HqePGVHDqslp8spKSoLBKZg==
X-Google-Smtp-Source: ACcGV60WSdx0WoLw1s2fFsRovE4RafuxkwGUEJRMhZAsermhsV51y5kYIG/wGR/1zP6I2XySlM2aQQ==
X-Received: by 2002:adf:edc2:: with SMTP id v2-v6mr17963846wro.208.1539077119878;
        Tue, 09 Oct 2018 02:25:19 -0700 (PDT)
Received: from localhost.localdomain.Speedport_W_921V_1_44_000 (p200300EF2BD31613C1F2E846AEDA540D.dip0.t-ipconnect.de. [2003:ef:2bd3:1613:c1f2:e846:aeda:540d])
        by smtp.gmail.com with ESMTPSA id o201-v6sm16049413wmg.16.2018.10.09.02.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 02:25:19 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [RFD/RFC PATCH 8/8] sched: Fixup task CPUs for potential proxies.
Date:   Tue,  9 Oct 2018 11:24:34 +0200
Message-Id: <20181009092434.26221-9-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009092434.26221-1-juri.lelli@redhat.com>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a mutex owner with potential proxies wakes up those proxies are
activated as well, on the same CPU of the owner. They might have been
sleeping on a different CPU however.

Fixup potential proxies CPU at wakeup time before activating them (or
they get woken up with a wrong CPU reference).

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 54003515fd29..0314afe4ba80 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1664,6 +1664,14 @@ static inline void ttwu_activate(struct rq *rq, struct task_struct *p, int en_fl
 					 blocked_entry);
 
 		list_del_init(&pp->blocked_entry);
+		/* XXX can't call set_task_cpu() because we are not holding
+		 * neither pp->pi_lock nor task's rq lock. This should however
+		 * be fine as this task can't be woken up as it is blocked on
+		 * this mutex atm.
+		 * A problem however might be that __set_task_cpu() calls
+		 * set_task_rq() which deals with groups and such...
+		 */
+		__set_task_cpu(pp, cpu_of(rq));
 		activate_task(rq, pp, en_flags);
 		pp->on_rq = TASK_ON_RQ_QUEUED;
 		resched_curr(rq);
@@ -3847,7 +3855,8 @@ static void __sched notrace __schedule(bool preempt)
 			 * whether it wants to wake up a task to maintain
 			 * concurrency.
 			 */
-			if (prev->flags & PF_WQ_WORKER) {
+			if ((prev->flags & PF_WQ_WORKER) &&
+			    !task_is_blocked(prev)) {
 				struct task_struct *to_wakeup;
 
 				to_wakeup = wq_worker_sleeping(prev);
-- 
2.17.1

