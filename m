Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EABBC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174DF20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Wcu4v8bm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174DF20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbeIHCZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:25:00 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:28575 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730004AbeIHCY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356524; x=1567892524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cFEIvKdv9arNngd5zBLVX3sFtX1JtMNhcR2VDzzqRGs=;
  b=Wcu4v8bmLsVhSMdQxRUwiBdg84AuvPG2W3tYf5aKIr+PoNAuyvnBwQDW
   w4wNzKxap6TBxzw6d6jhePL4GgPAVItE1NRapIcUX7qD0qewGwz6zs5Ia
   IQ233+F9mdNL/ei4twY7vcbyHU4GkWsMh3D94Y8RO1pa+Ty7DQVmKNoDo
   0=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="696509913"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-7c3c5f85.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:42:03 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2a-7c3c5f85.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w87Lfxn9035640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:42:00 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LfvE4027352
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:41:57 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LfpKE027335;
        Fri, 7 Sep 2018 23:41:51 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 21/60] sched: Add entity variants of put_prev_task_fair() and set_curr_task_fair()
Date:   Fri,  7 Sep 2018 23:40:08 +0200
Message-Id: <20180907214047.26914-22-jschoenh@amazon.de>
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

Add entity variants of put_prev_task_fair() and set_curr_task_fair()
that will be later used by coscheduling.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/fair.c  | 34 +++++++++++++++++++++-------------
 kernel/sched/sched.h |  2 ++
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f13fb4460b66..18b1d81951f1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6651,12 +6651,8 @@ done: __maybe_unused;
 	return NULL;
 }
 
-/*
- * Account for a descheduled task:
- */
-static void put_prev_task_fair(struct rq *rq, struct task_struct *prev)
+void put_prev_entity_fair(struct rq *rq, struct sched_entity *se)
 {
-	struct sched_entity *se = &prev->se;
 	struct cfs_rq *cfs_rq;
 
 	for_each_sched_entity(se) {
@@ -6666,6 +6662,14 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev)
 }
 
 /*
+ * Account for a descheduled task:
+ */
+static void put_prev_task_fair(struct rq *rq, struct task_struct *prev)
+{
+	put_prev_entity_fair(rq, &prev->se);
+}
+
+/*
  * sched_yield() is very simple
  *
  * The magic of dealing with the ->skip buddy is in pick_next_entity.
@@ -9758,15 +9762,8 @@ static void switched_to_fair(struct rq *rq, struct task_struct *p)
 	}
 }
 
-/* Account for a task changing its policy or group.
- *
- * This routine is mostly called to set cfs_rq->curr field when a task
- * migrates between groups/classes.
- */
-static void set_curr_task_fair(struct rq *rq)
+void set_curr_entity_fair(struct rq *rq, struct sched_entity *se)
 {
-	struct sched_entity *se = &rq->curr->se;
-
 	for_each_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
@@ -9776,6 +9773,17 @@ static void set_curr_task_fair(struct rq *rq)
 	}
 }
 
+/*
+ * Account for a task changing its policy or group.
+ *
+ * This routine is mostly called to set cfs_rq->curr field when a task
+ * migrates between groups/classes.
+ */
+static void set_curr_task_fair(struct rq *rq)
+{
+	set_curr_entity_fair(rq, &rq->curr->se);
+}
+
 void init_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 569a487ed07c..b36e61914a42 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1547,6 +1547,8 @@ bool enqueue_entity_fair(struct rq *rq, struct sched_entity *se, int flags,
 			 unsigned int task_delta);
 bool dequeue_entity_fair(struct rq *rq, struct sched_entity *se, int flags,
 			 unsigned int task_delta);
+void put_prev_entity_fair(struct rq *rq, struct sched_entity *se);
+void set_curr_entity_fair(struct rq *rq, struct sched_entity *se);
 
 struct sched_class {
 	const struct sched_class *next;
-- 
2.9.3.1.gcba166c.dirty

