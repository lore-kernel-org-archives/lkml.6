Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8428AC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0652083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="QsbWsNdm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0652083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbeIHCYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:24:15 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:60236 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbeIHCYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356480; x=1567892480;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sJvlh8HzNYgqt17xwqY0KkguBDWUGUbjLs2d1zA4ih8=;
  b=QsbWsNdmezvySfHAJrix0MIaX0VHTId2q8GD/9RdkF3IRES3hzuMyep8
   Wxazt2we7KPG9IgIHdi3GsLnnn4mNzQgU+GIlYA/3wTHM3pkoslJ1wp2m
   blhhJ8Q2ZF/w8dIaeJVEHcZNnWUVCa5D2mNqjSIYxACPLEY8wwYFh/cDm
   s=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="355980779"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:41:18 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w87LfDHF130618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:41:15 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LfBSv027102
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:41:11 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87Lf9Ge027097;
        Fri, 7 Sep 2018 23:41:09 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 02/60] sched: Introduce set_entity_cfs() to place a SE into a certain CFS runqueue
Date:   Fri,  7 Sep 2018 23:39:49 +0200
Message-Id: <20180907214047.26914-3-jschoenh@amazon.de>
X-Mailer: git-send-email 2.9.3.1.gcba166c.dirty
In-Reply-To: <20180907214047.26914-1-jschoenh@amazon.de>
References: <20180907214047.26914-1-jschoenh@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the logic to place a SE into a CFS runqueue into its own
function.

This consolidates various sprinkled updates of se->cfs_rq, se->parent,
and se->depth at the cost of updating se->depth unnecessarily on
same-group movements between CPUs.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/fair.c  | 26 ++++----------------------
 kernel/sched/sched.h | 12 +++++++++---
 2 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 638fd14bb6c4..3de0158729a6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9683,14 +9683,6 @@ static void attach_entity_cfs_rq(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
-#ifdef CONFIG_FAIR_GROUP_SCHED
-	/*
-	 * Since the real-depth could have been changed (only FAIR
-	 * class maintain depth value), reset depth properly.
-	 */
-	se->depth = se->parent ? se->parent->depth + 1 : 0;
-#endif
-
 	/* Synchronize entity with its cfs_rq */
 	update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD);
 	attach_entity_load_avg(cfs_rq, se, 0);
@@ -9781,10 +9773,7 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
 #ifdef CONFIG_FAIR_GROUP_SCHED
 static void task_set_group_fair(struct task_struct *p)
 {
-	struct sched_entity *se = &p->se;
-
 	set_task_rq(p, task_cpu(p));
-	se->depth = se->parent ? se->parent->depth + 1 : 0;
 }
 
 static void task_move_group_fair(struct task_struct *p)
@@ -9855,7 +9844,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 			goto err_free_rq;
 
 		init_cfs_rq(cfs_rq);
-		init_tg_cfs_entry(tg, cfs_rq, se, i, parent->cfs_rq[i]->my_se);
+		init_tg_cfs_entry(tg, cfs_rq, se, i, parent->cfs_rq[i]);
 		init_entity_runnable_average(se);
 	}
 
@@ -9912,7 +9901,7 @@ void unregister_fair_sched_group(struct task_group *tg)
 
 void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 			struct sched_entity *se, int cpu,
-			struct sched_entity *parent)
+			struct cfs_rq *parent)
 {
 	struct rq *rq = cpu_rq(cpu);
 
@@ -9927,18 +9916,11 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 	if (!se)
 		return;
 
-	if (!parent) {
-		se->cfs_rq = &rq->cfs;
-		se->depth = 0;
-	} else {
-		se->cfs_rq = parent->my_q;
-		se->depth = parent->depth + 1;
-	}
-
+	set_entity_cfs(se, parent);
 	se->my_q = cfs_rq;
+
 	/* guarantee group entities always have weight */
 	update_load_set(&se->load, NICE_0_LOAD);
-	se->parent = parent;
 }
 
 static DEFINE_MUTEX(shares_mutex);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8435bf70a701..b4d0e8a68697 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -428,7 +428,7 @@ extern void online_fair_sched_group(struct task_group *tg);
 extern void unregister_fair_sched_group(struct task_group *tg);
 extern void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 			struct sched_entity *se, int cpu,
-			struct sched_entity *parent);
+			struct cfs_rq *parent);
 extern void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
 
 extern void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b);
@@ -1290,6 +1290,13 @@ static inline struct task_group *task_group(struct task_struct *p)
 	return p->sched_task_group;
 }
 
+static inline void set_entity_cfs(struct sched_entity *se, struct cfs_rq *cfs_rq)
+{
+	se->cfs_rq = cfs_rq;
+	se->parent = cfs_rq->my_se;
+	se->depth = se->parent ? se->parent->depth + 1 : 0;
+}
+
 /* Change a task's cfs_rq and parent entity if it moves across CPUs/groups */
 static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
 {
@@ -1299,8 +1306,7 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	set_task_rq_fair(&p->se, p->se.cfs_rq, tg->cfs_rq[cpu]);
-	p->se.cfs_rq = tg->cfs_rq[cpu];
-	p->se.parent = tg->cfs_rq[cpu]->my_se;
+	set_entity_cfs(&p->se, tg->cfs_rq[cpu]);
 #endif
 
 #ifdef CONFIG_RT_GROUP_SCHED
-- 
2.9.3.1.gcba166c.dirty

