Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0EDC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E172083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="N0VSfm3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E172083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbeIHCYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:24:54 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:2723 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbeIHCYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356518; x=1567892518;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DVD7rAPBUimF5wAJp1SQhf/Aih/IV9vNclwGQZ9xpaE=;
  b=N0VSfm3U+a+t8qGm0HNFdr543Ua+w2ao+TbSvCFkN3YOQQZOnjknIMHz
   7a1HIzhpuROTspR1K8LLhh4rpvJNMElZHNekjQ2/7CGKfEeAkCxwowXgH
   cIaGw0Lf5Q0bUQo7Ef4M8f3dR/TKwlYzo6FhBQSv0HE2T5sGAbBrjfK3T
   Y=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="355980832"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:41:58 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w87LfqQY048136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:41:54 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LfoOC027327
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:41:50 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87Lfn5F027322;
        Fri, 7 Sep 2018 23:41:49 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 20/60] sched: Let {en,de}queue_entity_fair() work with a varying amount of tasks
Date:   Fri,  7 Sep 2018 23:40:07 +0200
Message-Id: <20180907214047.26914-21-jschoenh@amazon.de>
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

Make the task delta handled by enqueue_entity_fair() and dequeue_task_fair()
variable as required by unthrottle_cfs_rq() and throttle_cfs_rq().

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/fair.c  | 18 ++++++++++--------
 kernel/sched/sched.h |  6 ++++--
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a96328c5a864..f13fb4460b66 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4979,7 +4979,8 @@ static inline void hrtick_update(struct rq *rq)
 }
 #endif
 
-bool enqueue_entity_fair(struct rq *rq, struct sched_entity *se, int flags)
+bool enqueue_entity_fair(struct rq *rq, struct sched_entity *se, int flags,
+			 unsigned int task_delta)
 {
 	struct cfs_rq *cfs_rq;
 
@@ -4997,14 +4998,14 @@ bool enqueue_entity_fair(struct rq *rq, struct sched_entity *se, int flags)
 		 */
 		if (cfs_rq_throttled(cfs_rq))
 			break;
-		cfs_rq->h_nr_running++;
+		cfs_rq->h_nr_running += task_delta;
 
 		flags = ENQUEUE_WAKEUP;
 	}
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
-		cfs_rq->h_nr_running++;
+		cfs_rq->h_nr_running += task_delta;
 
 		if (cfs_rq_throttled(cfs_rq))
 			break;
@@ -5042,7 +5043,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (p->in_iowait)
 		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
 
-	throttled = enqueue_entity_fair(rq, &p->se, flags);
+	throttled = enqueue_entity_fair(rq, &p->se, flags, 1);
 
 	if (!throttled)
 		add_nr_running(rq, 1);
@@ -5052,7 +5053,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 static void set_next_buddy(struct sched_entity *se);
 
-bool dequeue_entity_fair(struct rq *rq, struct sched_entity *se, int flags)
+bool dequeue_entity_fair(struct rq *rq, struct sched_entity *se, int flags,
+			 unsigned int task_delta)
 {
 	struct cfs_rq *cfs_rq;
 	int task_sleep = flags & DEQUEUE_SLEEP;
@@ -5069,7 +5071,7 @@ bool dequeue_entity_fair(struct rq *rq, struct sched_entity *se, int flags)
 		*/
 		if (cfs_rq_throttled(cfs_rq))
 			break;
-		cfs_rq->h_nr_running--;
+		cfs_rq->h_nr_running -= task_delta;
 
 		/* Don't dequeue parent if it has other entities besides us */
 		if (cfs_rq->load.weight) {
@@ -5088,7 +5090,7 @@ bool dequeue_entity_fair(struct rq *rq, struct sched_entity *se, int flags)
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
-		cfs_rq->h_nr_running--;
+		cfs_rq->h_nr_running -= task_delta;
 
 		if (cfs_rq_throttled(cfs_rq))
 			break;
@@ -5107,7 +5109,7 @@ bool dequeue_entity_fair(struct rq *rq, struct sched_entity *se, int flags)
  */
 static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
-	bool throttled = dequeue_entity_fair(rq, &p->se, flags);
+	bool throttled = dequeue_entity_fair(rq, &p->se, flags, 1);
 
 	if (!throttled)
 		sub_nr_running(rq, 1);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9016049f36c3..569a487ed07c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1543,8 +1543,10 @@ extern const u32		sched_prio_to_wmult[40];
 
 #define RETRY_TASK		((void *)-1UL)
 
-bool enqueue_entity_fair(struct rq *rq, struct sched_entity *se, int flags);
-bool dequeue_entity_fair(struct rq *rq, struct sched_entity *se, int flags);
+bool enqueue_entity_fair(struct rq *rq, struct sched_entity *se, int flags,
+			 unsigned int task_delta);
+bool dequeue_entity_fair(struct rq *rq, struct sched_entity *se, int flags,
+			 unsigned int task_delta);
 
 struct sched_class {
 	const struct sched_class *next;
-- 
2.9.3.1.gcba166c.dirty

