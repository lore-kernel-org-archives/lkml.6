Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3A7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C302085A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbfAOKQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:16:05 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46956 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728878AbfAOKQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:16:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6730F1596;
        Tue, 15 Jan 2019 02:16:00 -0800 (PST)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 507C23F70D;
        Tue, 15 Jan 2019 02:15:57 -0800 (PST)
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v6 10/16] sched/core: Add uclamp_util_with()
Date:   Tue, 15 Jan 2019 10:15:07 +0000
Message-Id: <20190115101513.2822-11-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190115101513.2822-1-patrick.bellasi@arm.com>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently uclamp_util() allows to clamp a specified utilization
considering the clamp values requested by RUNNABLE tasks in a CPU.
Sometimes however, it could be interesting to verify how clamp values
will change when a task is going to be running on a given CPU.
For example, the Energy Aware Scheduler (EAS) is interested in
evaluating and comparing the energy impact of different scheduling
decisions.

Add uclamp_util_with() which allows to clamp a given utilization by
considering the possible impact on CPU clamp values of a specified task.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/core.c  |  4 ++--
 kernel/sched/sched.h | 21 ++++++++++++++++++++-
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1ed01f381641..b41db1190d28 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -904,8 +904,8 @@ static inline unsigned int uclamp_effective_bucket_id(struct task_struct *p,
 	return bucket_id;
 }
 
-static unsigned int uclamp_effective_value(struct task_struct *p,
-					   unsigned int clamp_id)
+unsigned int uclamp_effective_value(struct task_struct *p,
+				    unsigned int clamp_id)
 {
 	unsigned int clamp_value, bucket_id;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 95d62a2a0b44..b7ce3023d023 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2268,11 +2268,20 @@ static inline unsigned int uclamp_none(int clamp_id)
 }
 
 #ifdef CONFIG_UCLAMP_TASK
-static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
+unsigned int uclamp_effective_value(struct task_struct *p, unsigned int clamp_id);
+
+static __always_inline
+unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
+			      struct task_struct *p)
 {
 	unsigned int min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
 	unsigned int max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
 
+	if (p) {
+		min_util = max(min_util, uclamp_effective_value(p, UCLAMP_MIN));
+		max_util = max(max_util, uclamp_effective_value(p, UCLAMP_MAX));
+	}
+
 	/*
 	 * Since CPU's {min,max}_util clamps are MAX aggregated considering
 	 * RUNNABLE tasks with _different_ clamps, we can end up with an
@@ -2283,7 +2292,17 @@ static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
 
 	return clamp(util, min_util, max_util);
 }
+
+static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
+{
+	return uclamp_util_with(rq, util, NULL);
+}
 #else /* CONFIG_UCLAMP_TASK */
+static inline unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
+					    struct task_struct *p)
+{
+	return util;
+}
 static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
 {
 	return util;
-- 
2.19.2

