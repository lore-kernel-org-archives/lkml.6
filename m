Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A066BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579722083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="dwXtNGkR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 579722083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730676AbeIHCZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:25:42 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:20149 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730289AbeIHCZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356566; x=1567892566;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fJZsUcncZZ9JMwcDSNUsV1a6k65xIvCQdkxCg1cixWQ=;
  b=dwXtNGkRsk34xpX8JBv8TjH8dE0j9G3veNBYUhMjMl8N01yddMTd1Ay/
   YUJVoc0sMHhvjreIh6I4TuSA8h557CrJ9L4zrmhFuoty0owkXNq81gAqf
   vnVzkGgBDy/TmG6jycgywX7+ztQ6kiDqVrerZKNRo94VwNXhRtKQd1tDV
   g=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="696509990"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:42:46 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w87LgeXX070078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:42:44 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87Lgd0l027673
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:42:39 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LgcKj027669;
        Fri, 7 Sep 2018 23:42:38 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 44/60] cosched: Perform various rq_of() adjustments in scheduler code
Date:   Fri,  7 Sep 2018 23:40:31 +0200
Message-Id: <20180907214047.26914-45-jschoenh@amazon.de>
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

The functions check_preempt_tick() and entity_tick() are executed by
the leader of the group. As such, we already hold the lock for the
per CPU runqueue. Thus, we can use the quick path to resched_curr().
Also, hrtimers are only used/active on per-CPU runqueues. So, use that.

The function __account_cfs_rq_runtime() is called via the enqueue
path, where we don't necessarily hold the per-CPU runqueue lock.
Take the long route though resched_curr().

The function list_add_leaf_cfs_rq() manages a supposedly depth
ordered list of CFS runqueues that contribute to the load on a certain
runqueue. This is used during load balancing. We keep these lists per
hierarchy level, which corresponds to the lock we hold and also
keeps the per-CPU logic compatible to what is there.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/fair.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f55954e7cedc..fff88694560c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -342,7 +342,7 @@ static inline struct cfs_rq *parent_cfs_rq(struct cfs_rq *cfs_rq)
 static inline void list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	if (!cfs_rq->on_list) {
-		struct rq *rq = rq_of(cfs_rq);
+		struct rq *rq = hrq_of(cfs_rq);
 		struct cfs_rq *pcfs_rq = parent_cfs_rq(cfs_rq);
 		/*
 		 * Ensure we either appear before our parent (if already
@@ -4072,7 +4072,7 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 	ideal_runtime = sched_slice(cfs_rq, curr);
 	delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
 	if (delta_exec > ideal_runtime) {
-		resched_curr(rq_of(cfs_rq));
+		resched_curr(cpu_rq_of(cfs_rq));
 		/*
 		 * The current task ran long enough, ensure it doesn't get
 		 * re-elected due to buddy favours.
@@ -4096,7 +4096,7 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 		return;
 
 	if (delta > ideal_runtime)
-		resched_curr(rq_of(cfs_rq));
+		resched_curr(cpu_rq_of(cfs_rq));
 }
 
 static void
@@ -4238,14 +4238,14 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 	 * validating it and just reschedule.
 	 */
 	if (queued) {
-		resched_curr(rq_of(cfs_rq));
+		resched_curr(cpu_rq_of(cfs_rq));
 		return;
 	}
 	/*
 	 * don't let the period tick interfere with the hrtick preemption
 	 */
 	if (!sched_feat(DOUBLE_TICK) &&
-			hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
+			hrtimer_active(&cpu_rq_of(cfs_rq)->hrtick_timer))
 		return;
 #endif
 
@@ -4422,7 +4422,7 @@ static void __account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
 	 * hierarchy can be throttled
 	 */
 	if (!assign_cfs_rq_runtime(cfs_rq) && likely(cfs_rq->curr))
-		resched_curr(rq_of(cfs_rq));
+		resched_curr(hrq_of(cfs_rq));
 }
 
 static __always_inline
-- 
2.9.3.1.gcba166c.dirty

