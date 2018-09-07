Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0657CC43143
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DF6206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="ITwiCNBK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0DF6206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731224AbeIHC3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:29:06 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:33295 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbeIHC3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356769; x=1567892769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wd7SjAWl+vF0w1dTPHdES7Xo58a3Kr99oG4ob4z2k6s=;
  b=ITwiCNBK5rDP6tm2OJxz9UDPVqnTe5znFd8MCsHLs6OwSQjBywQJLNe0
   UEg6eTEKupFz/9b4QYok9fe2LKc1YN9Qd1axyZNr/8cfd1bzNVSaVEpoq
   3Aj7pSM9/uMCZ813bn2HVebMRZwV4OJW0ATQUFJI1tO6UvDPNqTLljwk7
   Q=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="757370673"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:43:35 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w87LgQgq049763
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:42:27 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LgOf1027549
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:42:24 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LgNfk027548;
        Fri, 7 Sep 2018 23:42:23 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 36/60] cosched: Use hrq_of() for rq_clock() and rq_clock_task()
Date:   Fri,  7 Sep 2018 23:40:23 +0200
Message-Id: <20180907214047.26914-37-jschoenh@amazon.de>
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

We use and keep rq->clock updated on all hierarchical runqueues. In
fact, not using the hierarchical runqueue would be incorrect as there is
no guarantee that the leader's CPU runqueue clock is updated.

Switch all obvious cases from rq_of() to hrq_of().

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/core.c |  7 +++++++
 kernel/sched/fair.c | 24 ++++++++++++------------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c4358396f588..a9f5339d58cb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -138,6 +138,13 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 #if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
 	s64 steal = 0, irq_delta = 0;
 #endif
+#ifdef CONFIG_COSCHEDULING
+	/*
+	 * FIXME: We don't have IRQ and steal time aggregates on non-CPU
+	 *        runqueues. The following just accounts for one of the CPUs
+	 *        instead of all.
+	 */
+#endif
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 	irq_delta = irq_time_read(cpu_of(rq)) - rq->prev_irq_time;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 24d01bf8f796..fde1c4ba4bb4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -858,7 +858,7 @@ static void update_tg_load_avg(struct cfs_rq *cfs_rq, int force)
 static void update_curr(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *curr = cfs_rq->curr;
-	u64 now = rq_clock_task(rq_of(cfs_rq));
+	u64 now = rq_clock_task(hrq_of(cfs_rq));
 	u64 delta_exec;
 
 	if (unlikely(!curr))
@@ -903,7 +903,7 @@ update_stats_wait_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	if (!schedstat_enabled())
 		return;
 
-	wait_start = rq_clock(rq_of(cfs_rq));
+	wait_start = rq_clock(hrq_of(cfs_rq));
 	prev_wait_start = schedstat_val(se->statistics.wait_start);
 
 	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)) &&
@@ -922,7 +922,7 @@ update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	if (!schedstat_enabled())
 		return;
 
-	delta = rq_clock(rq_of(cfs_rq)) - schedstat_val(se->statistics.wait_start);
+	delta = rq_clock(hrq_of(cfs_rq)) - schedstat_val(se->statistics.wait_start);
 
 	if (entity_is_task(se)) {
 		p = task_of(se);
@@ -961,7 +961,7 @@ update_stats_enqueue_sleeper(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		tsk = task_of(se);
 
 	if (sleep_start) {
-		u64 delta = rq_clock(rq_of(cfs_rq)) - sleep_start;
+		u64 delta = rq_clock(hrq_of(cfs_rq)) - sleep_start;
 
 		if ((s64)delta < 0)
 			delta = 0;
@@ -978,7 +978,7 @@ update_stats_enqueue_sleeper(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		}
 	}
 	if (block_start) {
-		u64 delta = rq_clock(rq_of(cfs_rq)) - block_start;
+		u64 delta = rq_clock(hrq_of(cfs_rq)) - block_start;
 
 		if ((s64)delta < 0)
 			delta = 0;
@@ -1052,10 +1052,10 @@ update_stats_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 		if (tsk->state & TASK_INTERRUPTIBLE)
 			__schedstat_set(se->statistics.sleep_start,
-				      rq_clock(rq_of(cfs_rq)));
+					rq_clock(hrq_of(cfs_rq)));
 		if (tsk->state & TASK_UNINTERRUPTIBLE)
 			__schedstat_set(se->statistics.block_start,
-				      rq_clock(rq_of(cfs_rq)));
+					rq_clock(hrq_of(cfs_rq)));
 	}
 }
 
@@ -1068,7 +1068,7 @@ update_stats_curr_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	/*
 	 * We are starting a new run period:
 	 */
-	se->exec_start = rq_clock_task(rq_of(cfs_rq));
+	se->exec_start = rq_clock_task(hrq_of(cfs_rq));
 }
 
 /**************************************************
@@ -4253,7 +4253,7 @@ static inline u64 cfs_rq_clock_task(struct cfs_rq *cfs_rq)
 	if (unlikely(cfs_rq->throttle_count))
 		return cfs_rq->throttled_clock_task - cfs_rq->throttled_clock_task_time;
 
-	return rq_clock_task(rq_of(cfs_rq)) - cfs_rq->throttled_clock_task_time;
+	return rq_clock_task(hrq_of(cfs_rq)) - cfs_rq->throttled_clock_task_time;
 }
 
 /* returns 0 on failure to allocate runtime */
@@ -4306,7 +4306,7 @@ static void expire_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 
 	/* if the deadline is ahead of our clock, nothing to do */
-	if (likely((s64)(rq_clock(rq_of(cfs_rq)) - cfs_rq->runtime_expires) < 0))
+	if (likely((s64)(rq_clock(hrq_of(cfs_rq)) - cfs_rq->runtime_expires) < 0))
 		return;
 
 	if (cfs_rq->runtime_remaining < 0)
@@ -4771,7 +4771,7 @@ static void sync_throttle(struct cfs_rq *cfs_rq)
 	pcfs_rq = parent_cfs_rq(cfs_rq);
 
 	cfs_rq->throttle_count = pcfs_rq->throttle_count;
-	cfs_rq->throttled_clock_task = rq_clock_task(rq_of(cfs_rq));
+	cfs_rq->throttled_clock_task = rq_clock_task(hrq_of(cfs_rq));
 }
 
 /* conditionally throttle active cfs_rq's from put_prev_entity() */
@@ -4932,7 +4932,7 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 #else /* CONFIG_CFS_BANDWIDTH */
 static inline u64 cfs_rq_clock_task(struct cfs_rq *cfs_rq)
 {
-	return rq_clock_task(rq_of(cfs_rq));
+	return rq_clock_task(hrq_of(cfs_rq));
 }
 
 static void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec) {}
-- 
2.9.3.1.gcba166c.dirty

