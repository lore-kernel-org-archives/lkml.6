Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BE5ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3ED205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEaEGog/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3ED205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbeKBBqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:46:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44124 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKBBqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:46:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id w3-v6so9269235pgs.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 09:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nqPTt/q+RuPSX4Lg3asMfrv576QWWsfgMtclBbcMVUs=;
        b=NEaEGog/PtPjjFJKy34Zkj0sVifwdftmTudhiuaRE4NerdZnz8RGa9SdH2mwVZqhk3
         ojrHSdNutv4cGWIEjOGrqMzicGRWUuqTJy6xldY3TcAK55WMRY1BjfckOceH3UEdEldn
         xu2gSKEUvYzKsdPcX/VCnKq5ldj33b1ld0vrdgVUYrojxjMo02Rz/64a66Qn/zGmVo1U
         ruDvWV8MT7VNKo7qiOfnycnzK2vo4EwKN6r6btF6RrlmsHKPzwScjNcqvc+vwj1gmItp
         FFJ+VyQVBYNUHOuO1BaWPohpuWyEDXOVcYoFfjrLOFcZtCO2pI4hs4RXA+TqISP6Ws1X
         LYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nqPTt/q+RuPSX4Lg3asMfrv576QWWsfgMtclBbcMVUs=;
        b=jxhiFqZIF9w/ePdUJ9oBw4A2b2JzuvIf2GFySmtsgsxhwI/vRsng2iBnmKdL9Sj7fV
         IaDhyAHPxMVvGlXc8OvVJS6h70noU6lKDng8H9C90S8TvEndgZ+1JgpHUyRFxg7CkkSv
         MGOpLQ3WD4ajmRjdcdEkE0gsYfkkEg5kk4NUwuVIuLuDjD8gduAjYC9855o/eiPNvgk4
         Ee+WcVzSL8Pvk/kokIIAkONPeoh3iqafhRsYs3K7mpOZAqvONwAjvub3SneDyjXs5sX0
         qfkraBeAeOvH8rLXFIGUfoJHEZ84FtIELSgkdv5wzs955PvtBVqE7DO7HQ0oFCGmcb05
         7rNQ==
X-Gm-Message-State: AGRZ1gLW4R9ANjD2JtKFGn40bhqQD2HyMIPMomGKIUxVn6QIM5q8yb98
        qECPEn2z4FTimnQEiAIeKpw=
X-Google-Smtp-Source: AJdET5f7NgpHbLz7yN3nbA7LCxjebIgSDEZUr/1aG53FddbgnbvesV8Hk4Ah/69rRzp4VecM7X45lQ==
X-Received: by 2002:a63:7c13:: with SMTP id x19mr7714448pgc.45.1541090559006;
        Thu, 01 Nov 2018 09:42:39 -0700 (PDT)
Received: from localhost.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id g14-v6sm32578317pfb.130.2018.11.01.09.42.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 09:42:38 -0700 (PDT)
From:   Muchun Song <smuchun@gmail.com>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched/core: Introduce set_next_task() helper for better code readability
Date:   Fri,  2 Nov 2018 00:42:22 +0800
Message-Id: <20181101164222.43015-1-smuchun@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we pick the next task, we will do the following for the task:
  1) p->se.exec_start = rq_clock_task(rq);
  2) dequeue_pushable{_dl}_task(rq, p);

When we call set_curr_task_{rt,dl}(), we also need to do the same thing
above. In rt.c, the code at 1) is in the _pick_next_task_rt() and the
code at 2) is in the pick_next_task_rt(). If we put two operations in
one function, maybe better. So, we introduce a new function
set_next_task(), which is responsible for doing the above.

By introducing the function we can get rid of calling the
dequeue_pushable{_dl}_task() directly(We can call set_next_task()) in
pick_next_task_{rt,dl}() and have better code readability and reuse.
In set_curr_task_{rt,dl}(), we also can call set_next_task().

Do this things such that we end up with:

  static struct task_struct *pick_next_task_{rt,dl}(struct rq *rq,
  		struct task_struct *prev, struct rq_flags *rf)
  {
  	/* do something else ... */

  	put_prev_task(rq, prev);

  	/* pick next task p */

  	set_next_task(rq, p);

  	/* do something else ... */
  }

put_prev_task() can match set_next_task(), which can make the
code more readable.

Signed-off-by: Muchun Song <smuchun@gmail.com>
---
 kernel/sched/deadline.c | 19 ++++++++++---------
 kernel/sched/rt.c       | 26 ++++++++++++--------------
 2 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 91e4202b0634..470ba6b464fe 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1695,6 +1695,14 @@ static void start_hrtick_dl(struct rq *rq, struct task_struct *p)
 }
 #endif
 
+static inline void set_next_task(struct rq *rq, struct task_struct *p)
+{
+	p->se.exec_start = rq_clock_task(rq);
+
+	/* You can't push away the running task */
+	dequeue_pushable_dl_task(rq, p);
+}
+
 static struct sched_dl_entity *pick_next_dl_entity(struct rq *rq,
 						   struct dl_rq *dl_rq)
 {
@@ -1750,10 +1758,8 @@ pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	BUG_ON(!dl_se);
 
 	p = dl_task_of(dl_se);
-	p->se.exec_start = rq_clock_task(rq);
 
-	/* Running task will never be pushed. */
-       dequeue_pushable_dl_task(rq, p);
+	set_next_task(rq, p);
 
 	if (hrtick_enabled(rq))
 		start_hrtick_dl(rq, p);
@@ -1808,12 +1814,7 @@ static void task_fork_dl(struct task_struct *p)
 
 static void set_curr_task_dl(struct rq *rq)
 {
-	struct task_struct *p = rq->curr;
-
-	p->se.exec_start = rq_clock_task(rq);
-
-	/* You can't push away the running task */
-	dequeue_pushable_dl_task(rq, p);
+	set_next_task(rq, rq->curr);
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index a21ea6021929..481bb7aa25c5 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1498,6 +1498,14 @@ static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flag
 #endif
 }
 
+static inline void set_next_task(struct rq *rq, struct task_struct *p)
+{
+	p->se.exec_start = rq_clock_task(rq);
+
+	/* The running task is never eligible for pushing */
+	dequeue_pushable_task(rq, p);
+}
+
 static struct sched_rt_entity *pick_next_rt_entity(struct rq *rq,
 						   struct rt_rq *rt_rq)
 {
@@ -1518,8 +1526,7 @@ static struct sched_rt_entity *pick_next_rt_entity(struct rq *rq,
 static struct task_struct *_pick_next_task_rt(struct rq *rq)
 {
 	struct sched_rt_entity *rt_se;
-	struct task_struct *p;
-	struct rt_rq *rt_rq  = &rq->rt;
+	struct rt_rq *rt_rq = &rq->rt;
 
 	do {
 		rt_se = pick_next_rt_entity(rq, rt_rq);
@@ -1527,10 +1534,7 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
 		rt_rq = group_rt_rq(rt_se);
 	} while (rt_rq);
 
-	p = rt_task_of(rt_se);
-	p->se.exec_start = rq_clock_task(rq);
-
-	return p;
+	return rt_task_of(rt_se);
 }
 
 static struct task_struct *
@@ -1573,8 +1577,7 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	p = _pick_next_task_rt(rq);
 
-	/* The running task is never eligible for pushing */
-	dequeue_pushable_task(rq, p);
+	set_next_task(rq, p);
 
 	rt_queue_push_tasks(rq);
 
@@ -2355,12 +2358,7 @@ static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued)
 
 static void set_curr_task_rt(struct rq *rq)
 {
-	struct task_struct *p = rq->curr;
-
-	p->se.exec_start = rq_clock_task(rq);
-
-	/* The running task is never eligible for pushing */
-	dequeue_pushable_task(rq, p);
+	set_next_task(rq, rq->curr);
 }
 
 static unsigned int get_rr_interval_rt(struct rq *rq, struct task_struct *task)
-- 
2.17.1

