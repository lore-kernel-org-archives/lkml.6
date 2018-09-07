Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276A6C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98D420855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="iCn6B0Ih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C98D420855
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbeIHCYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:24:52 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:46720 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbeIHCYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356516; x=1567892516;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DgPsyn48O8Glx2DFGpBU1Ne5xK7AqrTdK2DEG0uX2ag=;
  b=iCn6B0IhxO9Yi/B7C4bRTj9iQ0aSnEJIG58qAUhKdgLRdsifIe6+V/Hq
   g35pcpYbyXde58FXRNwphCheFFKBIDwlHSvGYXl3OjbizTQDRXaqka9KD
   18Ip8g3RN0ps5zXtDeUhloatS8E1y5+TvsAdL2AU8CDOZ3yq5Ug7wMtly
   U=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="737530425"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:41:55 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w87LfoLZ058989
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:41:52 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87Lfmha027315
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:41:49 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LfmwU027311;
        Fri, 7 Sep 2018 23:41:48 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 19/60] sched: Add entity variants of enqueue_task_fair() and dequeue_task_fair()
Date:   Fri,  7 Sep 2018 23:40:06 +0200
Message-Id: <20180907214047.26914-20-jschoenh@amazon.de>
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

There is fair amount of overlap between enqueue_task_fair() and
unthrottle_cfs_rq(), as well as between dequeue_task_fair() and
throttle_cfs_rq(). This is the first step toward having both of
them use the same basic function.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/fair.c  | 82 ++++++++++++++++++++++++++++++----------------------
 kernel/sched/sched.h |  3 ++
 2 files changed, 51 insertions(+), 34 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9f63ac37f5ef..a96328c5a864 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4979,32 +4979,9 @@ static inline void hrtick_update(struct rq *rq)
 }
 #endif
 
-/*
- * The enqueue_task method is called before nr_running is
- * increased. Here we update the fair scheduling stats and
- * then put the task into the rbtree:
- */
-static void
-enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
+bool enqueue_entity_fair(struct rq *rq, struct sched_entity *se, int flags)
 {
 	struct cfs_rq *cfs_rq;
-	struct sched_entity *se = &p->se;
-
-	/*
-	 * The code below (indirectly) updates schedutil which looks at
-	 * the cfs_rq utilization to select a frequency.
-	 * Let's add the task's estimated utilization to the cfs_rq's
-	 * estimated utilization, before we update schedutil.
-	 */
-	util_est_enqueue(&rq->cfs, p);
-
-	/*
-	 * If in_iowait is set, the code below may not trigger any cpufreq
-	 * utilization updates, so do it here explicitly with the IOWAIT flag
-	 * passed.
-	 */
-	if (p->in_iowait)
-		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
 
 	for_each_sched_entity(se) {
 		if (se->on_rq)
@@ -5036,7 +5013,38 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		update_cfs_group(se);
 	}
 
-	if (!se)
+	return se != NULL;
+}
+
+/*
+ * The enqueue_task method is called before nr_running is
+ * increased. Here we update the fair scheduling stats and
+ * then put the task into the rbtree:
+ */
+static void
+enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
+{
+	bool throttled;
+
+	/*
+	 * The code below (indirectly) updates schedutil which looks at
+	 * the cfs_rq utilization to select a frequency.
+	 * Let's add the task's estimated utilization to the cfs_rq's
+	 * estimated utilization, before we update schedutil.
+	 */
+	util_est_enqueue(&rq->cfs, p);
+
+	/*
+	 * If in_iowait is set, the code below may not trigger any cpufreq
+	 * utilization updates, so do it here explicitly with the IOWAIT flag
+	 * passed.
+	 */
+	if (p->in_iowait)
+		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
+
+	throttled = enqueue_entity_fair(rq, &p->se, flags);
+
+	if (!throttled)
 		add_nr_running(rq, 1);
 
 	hrtick_update(rq);
@@ -5044,15 +5052,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 static void set_next_buddy(struct sched_entity *se);
 
-/*
- * The dequeue_task method is called before nr_running is
- * decreased. We remove the task from the rbtree and
- * update the fair scheduling stats:
- */
-static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
+bool dequeue_entity_fair(struct rq *rq, struct sched_entity *se, int flags)
 {
 	struct cfs_rq *cfs_rq;
-	struct sched_entity *se = &p->se;
 	int task_sleep = flags & DEQUEUE_SLEEP;
 
 	for_each_sched_entity(se) {
@@ -5095,10 +5097,22 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		update_cfs_group(se);
 	}
 
-	if (!se)
+	return se != NULL;
+}
+
+/*
+ * The dequeue_task method is called before nr_running is
+ * decreased. We remove the task from the rbtree and
+ * update the fair scheduling stats:
+ */
+static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
+{
+	bool throttled = dequeue_entity_fair(rq, &p->se, flags);
+
+	if (!throttled)
 		sub_nr_running(rq, 1);
 
-	util_est_dequeue(&rq->cfs, p, task_sleep);
+	util_est_dequeue(&rq->cfs, p, flags & DEQUEUE_SLEEP);
 	hrtick_update(rq);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3e0ad36938fb..9016049f36c3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1543,6 +1543,9 @@ extern const u32		sched_prio_to_wmult[40];
 
 #define RETRY_TASK		((void *)-1UL)
 
+bool enqueue_entity_fair(struct rq *rq, struct sched_entity *se, int flags);
+bool dequeue_entity_fair(struct rq *rq, struct sched_entity *se, int flags);
+
 struct sched_class {
 	const struct sched_class *next;
 
-- 
2.9.3.1.gcba166c.dirty

