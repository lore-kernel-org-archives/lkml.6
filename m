Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67921C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D662085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RXaDUvLO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391308AbfBRRlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:41:40 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47718 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388999AbfBRRkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:40:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gYAIWzZGBxADjQIKo9nMV0fAzamJEmiiKknmne9f4yA=; b=RXaDUvLOMpmcDgR3p6dNNH5M6C
        YMr81W65pjoE6fUoEeTum8aWd8rkgdbYBgdsFUYBVTcF9x+h4g4TbCAGzUjjkEU9vJW5bjpUc3OfX
        /UbHceq7WTZT/58sZlUbMUapGEKBkyMa4PB9xetoSXN8LMhqDgqHMOpABge0eujpKeVMYdnVUUJAE
        V5o8T3NirsBLCKVf5SAdzq9Xq4FNUIYGD8Yboe++0A6FnqHLNSr3vFkCEAjEvG+NDLYiypjbRmf5K
        rgnDrsSEGTbxVgMGQ6fOzobWg8LmctDUySwjK3axO3927V3yaddpZM8OsnPbwvzYohEpqX0zlOWDR
        SIO1BqNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gvmu2-0001F7-Ui; Mon, 18 Feb 2019 17:40:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 427C42848B87E; Mon, 18 Feb 2019 18:40:23 +0100 (CET)
Message-Id: <20190218173514.608856676@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 18 Feb 2019 17:56:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [RFC][PATCH 12/16] sched: A quick and dirty cgroup tagging interface
References: <20190218165620.383905466@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marks all tasks in a cgroup as matching for core-scheduling.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |   62 +++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |    4 +++
 2 files changed, 66 insertions(+)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6608,6 +6608,15 @@ static void sched_change_group(struct ta
 	tg = container_of(task_css_check(tsk, cpu_cgrp_id, true),
 			  struct task_group, css);
 	tg = autogroup_task_group(tsk, tg);
+
+#ifdef CONFIG_SCHED_CORE
+	if ((unsigned long)tsk->sched_task_group == tsk->core_cookie)
+		tsk->core_cookie = 0UL;
+
+	if (tg->tagged /* && !tsk->core_cookie ? */)
+		tsk->core_cookie = (unsigned long)tg;
+#endif
+
 	tsk->sched_task_group = tg;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -7067,6 +7076,43 @@ static u64 cpu_rt_period_read_uint(struc
 }
 #endif /* CONFIG_RT_GROUP_SCHED */
 
+#ifdef CONFIG_SCHED_CORE
+static u64 cpu_core_tag_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
+{
+	struct task_group *tg = css_tg(css);
+
+	return !!tg->tagged;
+}
+
+static int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype *cft, u64 val)
+{
+	struct task_group *tg = css_tg(css);
+	struct css_task_iter it;
+	struct task_struct *p;
+
+	if (val > 1)
+		return -ERANGE;
+
+	if (tg->tagged == !!val)
+		return 0;
+
+	tg->tagged = !!val;
+
+	if (!!val)
+		sched_core_get();
+
+	css_task_iter_start(css, 0, &it);
+	while ((p = css_task_iter_next(&it)))
+		p->core_cookie = !!val ? (unsigned long)tg : 0UL;
+	css_task_iter_end(&it);
+
+	if (!val)
+		sched_core_put();
+
+	return 0;
+}
+#endif
+
 static struct cftype cpu_legacy_files[] = {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	{
@@ -7103,6 +7149,14 @@ static struct cftype cpu_legacy_files[]
 		.write_u64 = cpu_rt_period_write_uint,
 	},
 #endif
+#ifdef CONFIG_SCHED_CORE
+	{
+		.name = "tag",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_core_tag_read_u64,
+		.write_u64 = cpu_core_tag_write_u64,
+	},
+#endif
 	{ }	/* Terminate */
 };
 
@@ -7270,6 +7324,14 @@ static struct cftype cpu_files[] = {
 		.write = cpu_max_write,
 	},
 #endif
+#ifdef CONFIG_SCHED_CORE
+	{
+		.name = "tag",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_core_tag_read_u64,
+		.write_u64 = cpu_core_tag_write_u64,
+	},
+#endif
 	{ }	/* terminate */
 };
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -363,6 +363,10 @@ struct cfs_bandwidth {
 struct task_group {
 	struct cgroup_subsys_state css;
 
+#ifdef CONFIG_SCHED_CORE
+	int			tagged;
+#endif
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* schedulable entities of this group on each CPU */
 	struct sched_entity	**se;


