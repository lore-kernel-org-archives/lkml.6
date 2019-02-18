Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85E1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698EA2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KwGp4Etk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390611AbfBRRlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:41:12 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47748 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389074AbfBRRki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZDXQOGvrjVH4aaFPaJBoPZQ8p6uHvU6K12bkrpjJBlM=; b=KwGp4EtkF/icZmsaGlNwhIyjJG
        QNMV6f+Tj17LZ5DfV0J/aB7PfDv+2wW2PrtAMsxh9BRlTTgPqMnk6iXVEwNFfq+4qhhb8ek96p5ZZ
        IwjKjEaIb6NmHhfS94SD6vXL6k//Y+821GfBjB1XXL2Dq+eKQavniurlQV+SL6XYYk2Z1cH6pZzo8
        UTcjV5h4Xbg3N8n+PKNfGbmFUDSNQIiV+Qbi3tJRc3QQmhxtPQiDHXdFr3im+0V/l9Nrl4m+oqZDE
        n4t5RS5xlzYcL0sM1gbc1gqfIGHRnuzQV499fFbu3i/SApMrCD42ShdDZiIdwGsfh0FpM7oKwcqxk
        h297cWjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gvmu2-0001F6-UW; Mon, 18 Feb 2019 17:40:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3D9972848B87D; Mon, 18 Feb 2019 18:40:23 +0100 (CET)
Message-Id: <20190218173514.549503978@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 18 Feb 2019 17:56:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [RFC][PATCH 11/16] sched: Basic tracking of matching tasks
References: <20190218165620.383905466@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce task_struct::core_cookie as an opaque identifier for core
scheduling. When enabled; core scheduling will only allow matching
task to be on the core; where idle matches everything.

When task_struct::core_cookie is set (and core scheduling is enabled)
these tasks are indexed in a second RB-tree, first on cookie value
then on scheduling function, such that matching task selection always
finds the most elegible match.

NOTE: *shudder* at the overhead...

NOTE: *sigh*, a 3rd copy of the scheduling function; the alternative
is per class tracking of cookies and that just duplicates a lot of
stuff for no raisin (the 2nd copy lives in the rt-mutex PI code).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h |    8 ++
 kernel/sched/core.c   |  145 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h  |    4 +
 3 files changed, 156 insertions(+), 1 deletion(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -635,10 +635,16 @@ struct task_struct {
 	const struct sched_class	*sched_class;
 	struct sched_entity		se;
 	struct sched_rt_entity		rt;
+	struct sched_dl_entity		dl;
+
+#ifdef CONFIG_SCHED_CORE
+	struct rb_node			core_node;
+	unsigned long			core_cookie;
+#endif
+
 #ifdef CONFIG_CGROUP_SCHED
 	struct task_group		*sched_task_group;
 #endif
-	struct sched_dl_entity		dl;
 
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 	/* List of struct preempt_notifier: */
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -64,6 +64,140 @@ int sysctl_sched_rt_runtime = 950000;
 
 DEFINE_STATIC_KEY_FALSE(__sched_core_enabled);
 
+/* kernel prio, less is more */
+static inline int __task_prio(struct task_struct *p)
+{
+	if (p->sched_class == &stop_sched_class) /* trumps deadline */
+		return -2;
+
+	if (rt_prio(p->prio)) /* includes deadline */
+		return p->prio; /* [-1, 99] */
+
+	if (p->sched_class == &idle_sched_class)
+		return MAX_RT_PRIO + NICE_WIDTH; /* 140 */
+
+	return MAX_RT_PRIO + MAX_NICE; /* 120, squash fair */
+}
+
+/*
+ * l(a,b)
+ * le(a,b) := !l(b,a)
+ * g(a,b)  := l(b,a)
+ * ge(a,b) := !l(a,b)
+ */
+
+/* real prio, less is less */
+static inline bool __prio_less(struct task_struct *a, struct task_struct *b, bool runtime)
+{
+	int pa = __task_prio(a), pb = __task_prio(b);
+
+	if (-pa < -pb)
+		return true;
+
+	if (-pb < -pa)
+		return false;
+
+	if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
+		return !dl_time_before(a->dl.deadline, b->dl.deadline);
+
+	if (pa == MAX_RT_PRIO + MAX_NICE && runtime) /* fair */
+		return !((s64)(a->se.vruntime - b->se.vruntime) < 0);
+
+	return false;
+}
+
+static inline bool cpu_prio_less(struct task_struct *a, struct task_struct *b)
+{
+	return __prio_less(a, b, true);
+}
+
+static inline bool core_prio_less(struct task_struct *a, struct task_struct *b)
+{
+	/* cannot compare vruntime across CPUs */
+	return __prio_less(a, b, false);
+}
+
+static inline bool __sched_core_less(struct task_struct *a, struct task_struct *b)
+{
+	if (a->core_cookie < b->core_cookie)
+		return true;
+
+	if (a->core_cookie > b->core_cookie)
+		return false;
+
+	/* flip prio, so high prio is leftmost */
+	if (cpu_prio_less(b, a))
+		return true;
+
+	return false;
+}
+
+void sched_core_enqueue(struct rq *rq, struct task_struct *p)
+{
+	struct rb_node *parent, **node;
+	struct task_struct *node_task;
+
+	rq->core->core_task_seq++;
+
+	if (!p->core_cookie)
+		return;
+
+	node = &rq->core_tree.rb_node;
+	parent = *node;
+
+	while (*node) {
+		node_task = container_of(*node, struct task_struct, core_node);
+		parent = *node;
+
+		if (__sched_core_less(p, node_task))
+			node = &parent->rb_left;
+		else
+			node = &parent->rb_right;
+	}
+
+	rb_link_node(&p->core_node, parent, node);
+	rb_insert_color(&p->core_node, &rq->core_tree);
+}
+
+void sched_core_dequeue(struct rq *rq, struct task_struct *p)
+{
+	rq->core->core_task_seq++;
+
+	if (!p->core_cookie)
+		return;
+
+	rb_erase(&p->core_node, &rq->core_tree);
+}
+
+/*
+ * Find left-most (aka, highest priority) task matching @cookie.
+ */
+struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
+{
+	struct rb_node *node = rq->core_tree.rb_node;
+	struct task_struct *node_task, *match;
+
+	/*
+	 * The idle task always matches any cookie!
+	 */
+	match = idle_sched_class.pick_task(rq);
+
+	while (node) {
+		node_task = container_of(node, struct task_struct, core_node);
+
+		if (node_task->core_cookie < cookie) {
+			node = node->rb_left;
+		} else if (node_task->core_cookie > cookie) {
+			node = node->rb_right;
+		} else {
+			match = node_task;
+			node = node->rb_left;
+		}
+	}
+
+	return match;
+}
+
 /*
  * The static-key + stop-machine variable are needed such that:
  *
@@ -122,6 +256,11 @@ void sched_core_put(void)
 	mutex_unlock(&sched_core_mutex);
 }
 
+#else /* !CONFIG_SCHED_CORE */
+
+static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
+static inline void sched_core_dequeue(struct rq *rq, struct task_struct *p) { }
+
 #endif /* CONFIG_SCHED_CORE */
 
 /*
@@ -826,6 +965,9 @@ static void set_load_weight(struct task_
 
 static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	if (sched_core_enabled(rq))
+		sched_core_enqueue(rq, p);
+
 	if (!(flags & ENQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
@@ -839,6 +981,9 @@ static inline void enqueue_task(struct r
 
 static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	if (sched_core_enabled(rq))
+		sched_core_dequeue(rq, p);
+
 	if (!(flags & DEQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -957,6 +957,10 @@ struct rq {
 	/* per rq */
 	struct rq		*core;
 	unsigned int		core_enabled;
+	struct rb_root		core_tree;
+
+	/* shared state */
+	unsigned int		core_task_seq;
 #endif
 };
 


