Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4712C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9D2206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="VOmFMPnL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9D2206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbeIHCYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:24:25 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:9907 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbeIHCYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356489; x=1567892489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZqFGOA0lgfYCPfAfxDQvq+P8HW9MJe4/IJ/OsIilrnc=;
  b=VOmFMPnL4/ChP1xDkL9P9PoqqfVXD9pBEeVh0ZbEJwZhux50oIZiWFj9
   xsIJLpvGl9i08NuWNsig51e2fOqJYoyj8GplLe1MZRT+1OStSngUSeBlW
   8b/kUsKxqUcsRp8nBThNbmsPmEyYxr9gEzgbO/x1nS4CiiMOM7v0nIz9k
   w=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="355980793"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:41:28 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w87LfLYA033870
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:41:23 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LfJ2p027148
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:41:19 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LfIN3027147;
        Fri, 7 Sep 2018 23:41:18 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 06/60] sched: Add a lock-free variant of resched_cpu()
Date:   Fri,  7 Sep 2018 23:39:53 +0200
Message-Id: <20180907214047.26914-7-jschoenh@amazon.de>
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

Add resched_cpu_locked(), which still works as expected, when it is called
while we already hold a runqueue lock from a different CPU.

There is some optimization potential by merging the logic of resched_curr()
and resched_cpu_locked() to avoid IPIs when calls to both functions happen.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/core.c  | 21 +++++++++++++++++++--
 kernel/sched/sched.h |  6 ++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fd1b0abd8474..c38a54f57e90 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -486,6 +486,15 @@ void resched_cpu(int cpu)
 }
 
 #ifdef CONFIG_SMP
+/* resched_cpu() when you're already holding a RQ lock of a different CPU */
+void resched_cpu_locked(int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+
+	if (!atomic_read(&rq->resched) && !atomic_xchg(&rq->resched, 1))
+		smp_send_reschedule(cpu);
+}
+
 #ifdef CONFIG_NO_HZ_COMMON
 /*
  * In the semi idle case, use the nearest busy CPU for migrating timers
@@ -1744,6 +1753,14 @@ void sched_ttwu_pending(void)
 
 void scheduler_ipi(void)
 {
+	struct rq *rq = this_rq();
+
+	/* Handle lock-free requests to reschedule the current task */
+	if (atomic_read(&rq->resched)) {
+		atomic_set(&rq->resched, 0);
+		set_thread_flag(TIF_NEED_RESCHED);
+	}
+
 	/*
 	 * Fold TIF_NEED_RESCHED into the preempt_count; anybody setting
 	 * TIF_NEED_RESCHED remotely (for the first time) will also send
@@ -1751,7 +1768,7 @@ void scheduler_ipi(void)
 	 */
 	preempt_fold_need_resched();
 
-	if (llist_empty(&this_rq()->wake_list) && !got_nohz_idle_kick())
+	if (llist_empty(&rq->wake_list) && !got_nohz_idle_kick())
 		return;
 
 	/*
@@ -1774,7 +1791,7 @@ void scheduler_ipi(void)
 	 * Check if someone kicked us for doing the nohz idle load balance.
 	 */
 	if (unlikely(got_nohz_idle_kick())) {
-		this_rq()->idle_balance = 1;
+		rq->idle_balance = 1;
 		raise_softirq_irqoff(SCHED_SOFTIRQ);
 	}
 	irq_exit();
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f6da85447f3c..926a26d816a2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -850,6 +850,9 @@ struct rq {
 	int			cpu;
 	int			online;
 
+	/* Lock-free rescheduling request for this runqueue */
+	atomic_t resched;
+
 	struct list_head cfs_tasks;
 
 	struct sched_avg	avg_rt;
@@ -1647,6 +1650,9 @@ extern void reweight_task(struct task_struct *p, int prio);
 
 extern void resched_curr(struct rq *rq);
 extern void resched_cpu(int cpu);
+#ifdef CONFIG_SMP
+void resched_cpu_locked(int cpu);
+#endif
 
 extern struct rt_bandwidth def_rt_bandwidth;
 extern void init_rt_bandwidth(struct rt_bandwidth *rt_b, u64 period, u64 runtime);
-- 
2.9.3.1.gcba166c.dirty

