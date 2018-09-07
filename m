Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37209C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAAB4206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="W3GwCJlY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAAB4206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbeIHCaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:30:20 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:14952 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbeIHCaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356843; x=1567892843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qR7M1zUzYR6TOiubja8Qz/e3sN07CZZ/lciZoJ2uZzw=;
  b=W3GwCJlYsHCJrpiYx6/3uAauEsIR+elk3LpZ2hXbxRQZDBt4plNWobDI
   0jiMtNfV7W/5O2Q5Vd0jqccXrWIYOzy8XFiqGxy/hFOELneAI5xX0cv51
   DgpDns5e1I3WFofydT3P0/CTWVUWGZfIMjAECA6HPmPuCOCE4V0AnzbY+
   4=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="757370796"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:44:49 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w87Lh20e040364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:43:04 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87Lh0uO027846
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:43:01 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87Lh0uh027845;
        Fri, 7 Sep 2018 23:43:00 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 56/60] cosched: Adjust wakeup preemption rules for coscheduling
Date:   Fri,  7 Sep 2018 23:40:43 +0200
Message-Id: <20180907214047.26914-57-jschoenh@amazon.de>
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

Modify check_preempt_wakeup() to work correctly with coscheduled sets.

On the one hand, that means not blindly preempting, when the woken
task potentially belongs to a different set and we're not allowed to
switch sets. Instead we have to notify the correct leader to follow up.

On the other hand, we need to handle additional idle cases, as CPUs
are now idle *within* certain coscheduled sets and woken tasks may
not preempt the idle task blindly anymore.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/fair.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 07fd9dd5561d..0c1d9334ea8e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6882,6 +6882,9 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	int next_buddy_marked = 0;
 	struct cfs_rq *cfs_rq;
 	int scale;
+#ifdef CONFIG_COSCHEDULING
+	struct rq_flags rf;
+#endif
 
 	/* FIXME: locking may be off after fetching the idle_se */
 	if (cosched_is_idle(rq, curr))
@@ -6908,6 +6911,13 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	}
 
 	/*
+	 * FIXME: Check whether this can be re-enabled with coscheduling
+	 *
+	 * We might want to send a reschedule IPI to the leader, which is only
+	 * checked further below.
+	 */
+#ifndef CONFIG_COSCHEDULING
+	/*
 	 * We can come here with TIF_NEED_RESCHED already set from new task
 	 * wake up path.
 	 *
@@ -6919,11 +6929,22 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	 */
 	if (test_tsk_need_resched(curr))
 		return;
+#endif
 
+	/*
+	 * FIXME: Check whether this can be re-enabled with coscheduling
+	 *
+	 * curr and p may belong could belong to different coscheduled sets,
+	 * in which case the decision is not straight-forward. Additionally,
+	 * the preempt code needs to know the CPU it has to send an IPI
+	 * to. This is not yet known here.
+	 */
+#ifndef CONFIG_COSCHEDULING
 	/* Idle tasks are by definition preempted by non-idle tasks. */
 	if (unlikely(curr->policy == SCHED_IDLE) &&
 	    likely(p->policy != SCHED_IDLE))
 		goto preempt;
+#endif
 
 	/*
 	 * Batch and idle tasks do not preempt non-idle tasks (their preemption
@@ -6932,7 +6953,55 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
 		return;
 
+	/*
+	 * FIXME: find_matching_se() might end up at SEs where a different CPU
+	 *        is leader. While we do get locks *afterwards* the question is
+	 *        whether anything bad can happen due to the lock-free traversal.
+	 */
 	find_matching_se(&se, &pse);
+
+#ifdef CONFIG_COSCHEDULING
+	if (se == pse) {
+		/*
+		 * There is nothing to do on this CPU within the current
+		 * coscheduled set and the newly woken task belongs to this
+		 * coscheduled set. Hence, it is a welcome distraction.
+		 *
+		 * [find_matching_se() walks up the hierarchy for se and pse
+		 *  until they are within the same CFS runqueue. As equality
+		 *  was eliminated at the beginning, equality now means that
+		 *  se was rq->idle_se from the start and pse approached it
+		 *  from within a child runqueue.]
+		 */
+		SCHED_WARN_ON(!cosched_is_idle(rq, curr));
+		SCHED_WARN_ON(cosched_get_idle_se(rq) != se);
+		goto preempt;
+	}
+
+	if (hrq_of(cfs_rq_of(se))->sdrq_data.level) {
+		rq_lock(hrq_of(cfs_rq_of(se)), &rf);
+		update_rq_clock(hrq_of(cfs_rq_of(se)));
+	}
+
+	if (!cfs_rq_of(se)->curr) {
+		/*
+		 * There is nothing to do at a higher level within the current
+		 * coscheduled set and the newly woken task belongs to a
+		 * different coscheduled set. Hence, it is a welcome
+		 * distraction for the leader of that higher level.
+		 *
+		 * [If a leader does not find a SE in its top_cfs_rq, it does
+		 *  not record anything as current. Still, it tells its
+		 *  children within which coscheduled set they are idle.
+		 *  find_matching_se() now ended at such an idle leader. As
+		 *  we checked for se==pse earlier, we cannot be this leader.]
+		 */
+		SCHED_WARN_ON(leader_of(se) == cpu_of(rq));
+		resched_cpu_locked(leader_of(se));
+		goto out;
+	}
+#endif
+
 	update_curr(cfs_rq_of(se));
 	BUG_ON(!pse);
 	if (wakeup_preempt_entity(se, pse) == 1) {
@@ -6942,18 +7011,30 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 		 */
 		if (!next_buddy_marked)
 			set_next_buddy(pse);
+#ifdef CONFIG_COSCHEDULING
+		if (leader_of(se) != cpu_of(rq)) {
+			resched_cpu_locked(leader_of(se));
+			goto out;
+		}
+		if (hrq_of(cfs_rq_of(se))->sdrq_data.level)
+			rq_unlock(hrq_of(cfs_rq_of(se)), &rf);
+#endif
 		goto preempt;
 	}
 
+#ifdef CONFIG_COSCHEDULING
+out:
+	if (hrq_of(cfs_rq_of(se))->sdrq_data.level)
+		rq_unlock(hrq_of(cfs_rq_of(se)), &rf);
+#endif
 	return;
-
 preempt:
 	resched_curr(rq);
 	/*
 	 * Only set the backward buddy when the current task is still
 	 * on the rq. This can happen when a wakeup gets interleaved
 	 * with schedule on the ->pre_schedule() or idle_balance()
-	 * point, either of which can * drop the rq lock.
+	 * point, either of which can drop the rq lock.
 	 *
 	 * Also, during early boot the idle thread is in the fair class,
 	 * for obvious reasons its a bad idea to schedule back to it.
-- 
2.9.3.1.gcba166c.dirty

