Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F281C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD8B2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="D6l+IuLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AD8B2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731096AbeIHCaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:30:21 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:14952 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbeIHCaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356844; x=1567892844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZxzLqVY0B2OYwWUR7ddX1Uxp5pB/9uPyGm70CF8C8ko=;
  b=D6l+IuLdPEAofBqMxhlcbrdbFeRA2Eo6BZv9/nhNQfXHkqyTaVS/qwQj
   JxriLfrZBybEp4hHkTSf8T4md8pEyQ8kLjlQ/JiPMdNBL9efLFqK6JUmR
   GwuRJd7D+dzCpFnbWgN2UojPOZmrHcrjlZPRIhDvMkmMmlYYLu7/cA6Xt
   E=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="757370797"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:44:50 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w87LgmEP061274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:42:50 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LgkZA027730
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:42:46 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87Lgjal027729;
        Fri, 7 Sep 2018 23:42:45 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 48/60] cosched: Adjust SE traversal and locking for yielding and buddies
Date:   Fri,  7 Sep 2018 23:40:35 +0200
Message-Id: <20180907214047.26914-49-jschoenh@amazon.de>
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

Buddies are not very well defined with coscheduling. Usually, they
bubble up the hierarchy on a single CPU to steer task picking either
away from a certain task (yield a task: skip buddy) or towards a certain
task (yield to a task, execute a woken task: next buddy; execute a
recently preempted task: last buddy).

If we still allow buddies to bubble up the full hierarchy with
coscheduling, then for example yielding a task would always yield the
coscheduled set of tasks it is part of. If we keep effects constrained
to a coscheduled set, then one set could never preempt another set.

For now, we limit buddy activities to the scope of the leader that
does the activity with an exception for preemption, which may operate
in the scope of a different leader. That makes yielding behavior
potentially weird and asymmetric for the time being, but it seems to
work well for preemption.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/fair.c | 51 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2227e4840355..6d64f4478fda 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3962,7 +3962,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 static void __clear_buddies_last(struct sched_entity *se)
 {
-	for_each_sched_entity(se) {
+	for_each_owned_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 		if (cfs_rq->last != se)
 			break;
@@ -3973,7 +3973,7 @@ static void __clear_buddies_last(struct sched_entity *se)
 
 static void __clear_buddies_next(struct sched_entity *se)
 {
-	for_each_sched_entity(se) {
+	for_each_owned_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 		if (cfs_rq->next != se)
 			break;
@@ -3984,7 +3984,7 @@ static void __clear_buddies_next(struct sched_entity *se)
 
 static void __clear_buddies_skip(struct sched_entity *se)
 {
-	for_each_sched_entity(se) {
+	for_each_owned_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 		if (cfs_rq->skip != se)
 			break;
@@ -4005,6 +4005,18 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		__clear_buddies_skip(se);
 }
 
+static void clear_buddies_lock(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	struct rq_owner_flags orf;
+
+	if (cfs_rq->last != se && cfs_rq->next != se && cfs_rq->skip != se)
+		return;
+
+	rq_lock_owned(hrq_of(cfs_rq), &orf);
+	clear_buddies(cfs_rq, se);
+	rq_unlock_owned(hrq_of(cfs_rq), &orf);
+}
+
 static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
 
 static void
@@ -4028,7 +4040,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	update_stats_dequeue(cfs_rq, se, flags);
 
-	clear_buddies(cfs_rq, se);
+	clear_buddies_lock(cfs_rq, se);
 
 	if (se != cfs_rq->curr)
 		__dequeue_entity(cfs_rq, se);
@@ -6547,31 +6559,45 @@ wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
 
 static void set_last_buddy(struct sched_entity *se)
 {
+	struct rq_owner_flags orf;
+	struct rq *rq;
+
 	if (entity_is_task(se) && unlikely(task_of(se)->policy == SCHED_IDLE))
 		return;
 
-	for_each_sched_entity(se) {
+	rq = hrq_of(cfs_rq_of(se));
+
+	rq_lock_owned(rq, &orf);
+	for_each_owned_sched_entity(se) {
 		if (SCHED_WARN_ON(!se->on_rq))
-			return;
+			break;
 		cfs_rq_of(se)->last = se;
 	}
+	rq_unlock_owned(rq, &orf);
 }
 
 static void set_next_buddy(struct sched_entity *se)
 {
+	struct rq_owner_flags orf;
+	struct rq *rq;
+
 	if (entity_is_task(se) && unlikely(task_of(se)->policy == SCHED_IDLE))
 		return;
 
-	for_each_sched_entity(se) {
+	rq = hrq_of(cfs_rq_of(se));
+
+	rq_lock_owned(rq, &orf);
+	for_each_owned_sched_entity(se) {
 		if (SCHED_WARN_ON(!se->on_rq))
-			return;
+			break;
 		cfs_rq_of(se)->next = se;
 	}
+	rq_unlock_owned(rq, &orf);
 }
 
 static void set_skip_buddy(struct sched_entity *se)
 {
-	for_each_sched_entity(se)
+	for_each_owned_sched_entity(se)
 		cfs_rq_of(se)->skip = se;
 }
 
@@ -6831,6 +6857,7 @@ static void yield_task_fair(struct rq *rq)
 	struct task_struct *curr = rq->curr;
 	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
 	struct sched_entity *se = &curr->se;
+	struct rq_owner_flags orf;
 
 	/*
 	 * Are we the only task in the tree?
@@ -6838,6 +6865,7 @@ static void yield_task_fair(struct rq *rq)
 	if (unlikely(rq->nr_running == 1))
 		return;
 
+	rq_lock_owned(rq, &orf);
 	clear_buddies(cfs_rq, se);
 
 	if (curr->policy != SCHED_BATCH) {
@@ -6855,21 +6883,26 @@ static void yield_task_fair(struct rq *rq)
 	}
 
 	set_skip_buddy(se);
+	rq_unlock_owned(rq, &orf);
 }
 
 static bool yield_to_task_fair(struct rq *rq, struct task_struct *p, bool preempt)
 {
 	struct sched_entity *se = &p->se;
+	struct rq_owner_flags orf;
 
 	/* throttled hierarchies are not runnable */
 	if (!se->on_rq || throttled_hierarchy(cfs_rq_of(se)))
 		return false;
 
+	rq_lock_owned(rq, &orf);
+
 	/* Tell the scheduler that we'd really like pse to run next. */
 	set_next_buddy(se);
 
 	yield_task_fair(rq);
 
+	rq_unlock_owned(rq, &orf);
 	return true;
 }
 
-- 
2.9.3.1.gcba166c.dirty

