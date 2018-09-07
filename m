Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958E3C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414BF206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="o6V+5uga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 414BF206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbeIHCZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:25:49 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:23044 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730236AbeIHCZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356573; x=1567892573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=km3ah0eo7AG9vo5OgMHmPErlNk+gZ/1QSD4OmP5nt5c=;
  b=o6V+5ugaEEWhp+Md//PYrV31HQSzCSXnGCKv1rdQFP2N+3MHPbYaN4o7
   CgEyofFTMYWxWB/js8gIzKNYvdA+2R2qe7Qr4KyYK8pPPBm+/P+KKbedZ
   8Soc/TM8nUv2E1n4HGjh4bDMvgnAwmjW8e/c5/8BiyfxP0+r/xnUuM/zW
   U=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="361243252"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:42:52 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w87Lgkvt021471
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:42:48 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87Lgi2o027719
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:42:44 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87Lghrn027718;
        Fri, 7 Sep 2018 23:42:43 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 47/60] cosched: Adjust SE traversal and locking for common leader activities
Date:   Fri,  7 Sep 2018 23:40:34 +0200
Message-Id: <20180907214047.26914-48-jschoenh@amazon.de>
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

Modify some of the core scheduler paths, which function as entry points
into the CFS scheduling class and which are activities where the leader
operates on behalf of the group.

There are (a) handling the tick, (b) picking the next task from the
runqueue, (c) setting a task to be current, and (d) putting the current
task back.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/fair.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2aa3a60dfca5..2227e4840355 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6664,12 +6664,14 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 static struct task_struct *
 pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
-	struct cfs_rq *cfs_rq = &rq->cfs;
+	struct cfs_rq *cfs_rq, *top_cfs_rq;
+	struct rq_owner_flags orf;
 	struct sched_entity *se;
 	struct task_struct *p;
 	int new_tasks;
 
 again:
+	top_cfs_rq = cfs_rq = &rq_lock_owned(rq, &orf)->cfs;
 	if (!cfs_rq->nr_running)
 		goto idle;
 
@@ -6707,7 +6709,7 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 			 * be correct.
 			 */
 			if (unlikely(check_cfs_rq_runtime(cfs_rq))) {
-				cfs_rq = &rq->cfs;
+				cfs_rq = top_cfs_rq;
 
 				if (!cfs_rq->nr_running)
 					goto idle;
@@ -6775,9 +6777,13 @@ done: __maybe_unused;
 	if (hrtick_enabled(rq))
 		hrtick_start_fair(rq, p);
 
+	rq_unlock_owned(rq, &orf);
+
 	return p;
 
 idle:
+	rq_unlock_owned(rq, &orf);
+
 	new_tasks = idle_balance(rq, rf);
 
 	/*
@@ -6796,12 +6802,15 @@ done: __maybe_unused;
 
 void put_prev_entity_fair(struct rq *rq, struct sched_entity *se)
 {
+	struct rq_owner_flags orf;
 	struct cfs_rq *cfs_rq;
 
-	for_each_sched_entity(se) {
+	rq_lock_owned(rq, &orf);
+	for_each_owned_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 		put_prev_entity(cfs_rq, se);
 	}
+	rq_unlock_owned(rq, &orf);
 }
 
 /*
@@ -9712,11 +9721,14 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &curr->se;
+	struct rq_owner_flags orf;
 
-	for_each_sched_entity(se) {
+	rq_lock_owned(rq, &orf);
+	for_each_owned_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 		entity_tick(cfs_rq, se, queued);
 	}
+	rq_unlock_owned(rq, &orf);
 
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
@@ -9906,13 +9918,19 @@ static void switched_to_fair(struct rq *rq, struct task_struct *p)
 
 void set_curr_entity_fair(struct rq *rq, struct sched_entity *se)
 {
-	for_each_sched_entity(se) {
+	struct rq_owner_flags orf;
+
+	rq_lock_owned(rq, &orf);
+
+	for_each_owned_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
 		set_next_entity(cfs_rq, se);
 		/* ensure bandwidth has been allocated on our new cfs_rq */
 		account_cfs_rq_runtime(cfs_rq, 0);
 	}
+
+	rq_unlock_owned(rq, &orf);
 }
 
 /*
-- 
2.9.3.1.gcba166c.dirty

