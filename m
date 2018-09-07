Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370D3C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE477206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="iAC4VJXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE477206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731295AbeIHCaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:30:02 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:19210 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbeIHCaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356824; x=1567892824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=197Va6z8O9Y0RxXyyj9QMYRMk0sy+1yqHzp7nix8DAs=;
  b=iAC4VJXb8mrsurPeufxr+wsYO36nFHllwXBwJHWFifPCpcRWRuXol495
   7PrVCYfOA70RjcAR/qFEJthJ9pgtmH/UzlfFi83OgD4P+Thi3InSb/Vus
   QGmAltlC0oZxbje5N910dWifH9Y6AA2qF9UtCyCUYiI/2wMy1cD3LwKi3
   M=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="629734714"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2c-cd289015.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:44:31 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2c-cd289015.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w87Lh6v0024572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:43:08 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87Lh4Qr027868
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:43:04 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87Lh3Jw027867;
        Fri, 7 Sep 2018 23:43:03 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 58/60] cosched: Switch runqueues between regular scheduling and coscheduling
Date:   Fri,  7 Sep 2018 23:40:45 +0200
Message-Id: <20180907214047.26914-59-jschoenh@amazon.de>
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

A regularly scheduled runqueue is enqueued via its TG-SE in its parent
task-group.  When coscheduled it is enqueued via its hierarchical
parent's SD-SE. Switching between both means to replace one with the
other, and taking care to get rid of all references to the no longer
current SE, which is recorded as parent SE for various other SEs.

Essentially, this changes the SE-parent path through the task-group and
SD hierarchy, by flipping a part of this path. For example, switching
the runqueue marked with X from !is_root to is_root as part of switching
the child-TG from scheduled==2 to scheduled==1:

Before:
                               parent-TG
             child-TG
                  ,----------------O
System         ,O´
              /                O       O
Core        X´      O
           /                 O   O   O   O
CPU       O   O   O   O

        CPU0  1   2   3      0   1   2   3

After:
                               parent-TG
             child-TG
                                  ,O
System          O                /
              ,----------------O´      O
Core        X´      O
           /                 O   O   O   O
CPU       O   O   O   O

        CPU0  1   2   3      0   1   2   3

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/cosched.c | 138 ++++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/fair.c    |  14 ++++-
 kernel/sched/sched.h   |   2 +
 3 files changed, 151 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cosched.c b/kernel/sched/cosched.c
index 7c8b8c8d2814..eb6a6a61521e 100644
--- a/kernel/sched/cosched.c
+++ b/kernel/sched/cosched.c
@@ -515,9 +515,145 @@ void cosched_offline_group(struct task_group *tg)
 		list_del_rcu(&cfs->sdrq.tg_siblings);
 }
 
+static void update_parent_entities(struct cfs_rq *cfs)
+{
+	struct sched_entity *se = __pick_first_entity(cfs);
+
+	while (se) {
+		set_entity_cfs(se, se->cfs_rq);
+		se = __pick_next_entity(se);
+	}
+
+	if (cfs->curr) {
+		/* curr is not kept within the tree */
+		set_entity_cfs(cfs->curr, cfs->curr->cfs_rq);
+	}
+}
+
+/*
+ * FIXME: We may be missing calls to attach_entity_cfs_rq() & co here
+ *        and maybe elsewhere.
+ */
 static void sdrq_update_root(struct sdrq *sdrq)
 {
-	/* TBD */
+	bool is_root, running;
+	struct sdrq *child;
+	struct rq *rq = sdrq->cfs_rq->rq;
+	struct rq *prq = parent_rq(rq);
+	struct rq_flags rf, prf;
+
+	lockdep_assert_held(&sdrq->cfs_rq->tg->lock);
+
+	if (!sdrq->sd_parent) {
+		/* If we are at the top, is_root must always be true */
+		SCHED_WARN_ON(sdrq->is_root != 1);
+		return;
+	}
+
+	is_root = sdrq->cfs_rq->tg->scheduled <= sdrq->data->level;
+
+	/* Exit early, when there is no change */
+	if (is_root == sdrq->is_root)
+		return;
+
+	/* Get proper locks */
+	rq_lock_irqsave(rq, &rf);
+
+	sdrq->is_root = is_root;
+	if (is_root)
+		sdrq->cfs_rq->my_se = sdrq->tg_se;
+	else
+		sdrq->cfs_rq->my_se = sdrq->sd_parent->sd_se;
+
+	/* Update parent entity of SD-SE */
+	if (sdrq->sd_se)
+		set_entity_cfs(sdrq->sd_se, sdrq->cfs_rq);
+
+	/* Update parent entities of TG-SEs of child task groups */
+	rcu_read_lock();
+	list_for_each_entry_rcu(child, &sdrq->tg_children, tg_siblings)
+		set_entity_cfs(child->tg_se, sdrq->cfs_rq);
+	rcu_read_unlock();
+
+	/*
+	 * Update parent entities of tasks
+	 *
+	 * This is complicated by the fact, that there are no per-cpu lists of
+	 * tasks. There is the complete list of tasks via do_each_thread/
+	 * while_each_thread, but that is too much. Then, there is a list
+	 * of all tasks within the current task group via cgroup_iter_start/
+	 * cgroup_iter_next/cgroup_iter_end, but that would require additional
+	 * filtering for the correct CPU, which is also not nice.
+	 *
+	 * Therefore, we only go through all currently enqueued tasks, and make
+	 * sure to update all non-enqueued tasks during enqueue in
+	 * enqueue_task_fair().
+	 */
+	update_parent_entities(sdrq->cfs_rq);
+
+	/*
+	 * FIXME: update_parent_entities() also updates non-task-SEs.
+	 * So we could skip sd_se and tg_se updates, when we also update
+	 * them during enqueuing. Not sure about the overhead, though.
+	 */
+
+	running = sdrq->cfs_rq->nr_running > 0;
+
+	/* FIXME: Might fire on dynamic reconfigurations with throttling */
+	SCHED_WARN_ON(running && sdrq->cfs_rq->load.weight == 0);
+	SCHED_WARN_ON(!running && sdrq->cfs_rq->load.weight);
+
+	if (is_root) {
+		/* Change from 0 to 1: possibly dequeue sd_se, enqueue tg_se */
+		if (running) {
+			atomic64_sub(sdrq->cfs_rq->load.weight,
+				     &sdrq->sd_parent->sdse_load);
+			dequeue_entity_fair(rq, sdrq->sd_parent->sd_se,
+					    DEQUEUE_SLEEP,
+					    sdrq->cfs_rq->h_nr_running);
+		}
+		if (sdrq->cfs_rq->curr) {
+			rq_lock(prq, &prf);
+			if (sdrq->data->leader == sdrq->sd_parent->data->leader)
+				put_prev_entity_fair(prq, sdrq->sd_parent->sd_se);
+			rq_unlock(prq, &prf);
+			if (sdrq->tg_se)
+				set_curr_entity_fair(rq, sdrq->tg_se);
+		}
+		/*
+		 * FIXME: this is probably not enough with nested TGs, as the weights of the
+		 * nested TGS could still be zero.
+		 */
+		if ((sdrq->cfs_rq->curr || running) && sdrq->tg_se)
+			update_cfs_group(sdrq->tg_se);
+		if (running && sdrq->tg_se)
+			enqueue_entity_fair(rq, sdrq->tg_se,
+					    ENQUEUE_WAKEUP,
+					    sdrq->cfs_rq->h_nr_running);
+	} else {
+		/* Change from 1 to 0: dequeue tg_se, possibly enqueue sd_se */
+		if (running && sdrq->tg_se)
+			dequeue_entity_fair(rq, sdrq->tg_se, DEQUEUE_SLEEP,
+					    sdrq->cfs_rq->h_nr_running);
+		if (sdrq->cfs_rq->curr) {
+			if (sdrq->tg_se)
+				put_prev_entity_fair(rq, sdrq->tg_se);
+			rq_lock(prq, &prf);
+			update_rq_clock(prq);
+			if (sdrq->data->leader == sdrq->sd_parent->data->leader)
+				set_curr_entity_fair(prq, sdrq->sd_parent->sd_se);
+			rq_unlock(prq, &prf);
+		}
+		if (running) {
+			atomic64_add(sdrq->cfs_rq->load.weight,
+				     &sdrq->sd_parent->sdse_load);
+			enqueue_entity_fair(rq, sdrq->sd_parent->sd_se,
+					    ENQUEUE_WAKEUP,
+					    sdrq->cfs_rq->h_nr_running);
+		}
+	}
+
+	rq_unlock_irqrestore(rq, &rf);
 }
 
 void cosched_set_scheduled(struct task_group *tg, int level)
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0c1d9334ea8e..322a84ec9511 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -768,7 +768,7 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
 	return rb_entry(left, struct sched_entity, run_node);
 }
 
-static struct sched_entity *__pick_next_entity(struct sched_entity *se)
+struct sched_entity *__pick_next_entity(struct sched_entity *se)
 {
 	struct rb_node *next = rb_next(&se->run_node);
 
@@ -3145,7 +3145,7 @@ static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
  * Recomputes the group entity based on the current state of its group
  * runqueue.
  */
-static void update_cfs_group(struct sched_entity *se)
+void update_cfs_group(struct sched_entity *se)
 {
 	struct cfs_rq *gcfs_rq = group_cfs_rq(se);
 	long shares, runnable;
@@ -5336,6 +5336,16 @@ bool enqueue_entity_fair(struct rq *rq, struct sched_entity *se, int flags,
 	int lcpu = rq->sdrq_data.leader;
 #endif
 
+#ifdef CONFIG_COSCHEDULING
+	/*
+	 * Update se->parent, in case sdrq_update_root() was called while
+	 * this task was sleeping.
+	 *
+	 * FIXME: Can this be moved into enqueue_task_fair()?
+	 */
+	set_entity_cfs(se, se->cfs_rq);
+#endif
+
 	rq_chain_init(&rc, rq);
 	for_each_sched_entity(se) {
 		rq_chain_lock(&rc, se);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e257451e05a5..310a706f0361 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -477,6 +477,7 @@ extern void sched_move_task(struct task_struct *tsk);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 extern int sched_group_set_shares(struct task_group *tg, unsigned long shares);
+void update_cfs_group(struct sched_entity *se);
 
 #ifdef CONFIG_SMP
 extern void set_task_rq_fair(struct sched_entity *se,
@@ -2453,6 +2454,7 @@ static inline void double_rq_unlock(struct rq *rq1, struct rq *rq2)
 
 extern struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq);
 extern struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq);
+struct sched_entity *__pick_next_entity(struct sched_entity *se);
 
 #ifdef	CONFIG_SCHED_DEBUG
 extern bool sched_debug_enabled;
-- 
2.9.3.1.gcba166c.dirty

