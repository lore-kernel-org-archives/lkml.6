Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66A0C282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D632080A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfBHKGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:06:36 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47554 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbfBHKGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:06:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DB721596;
        Fri,  8 Feb 2019 02:06:33 -0800 (PST)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 372033F557;
        Fri,  8 Feb 2019 02:06:30 -0800 (PST)
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
Subject: [PATCH v7 06/15] sched/core: uclamp: Reset uclamp values on RESET_ON_FORK
Date:   Fri,  8 Feb 2019 10:05:45 +0000
Message-Id: <20190208100554.32196-7-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208100554.32196-1-patrick.bellasi@arm.com>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A forked tasks gets the same clamp values of its parent however, when
the RESET_ON_FORK flag is set on parent, e.g. via:

   sys_sched_setattr()
      sched_setattr()
         __sched_setscheduler(attr::SCHED_FLAG_RESET_ON_FORK)

the new forked task is expected to start with all attributes reset to
default values.

Do that for utilization clamp values too by caching the reset request
and propagating it into the existing uclamp_fork() call which already
provides the required initialization for other uclamp related bits.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/core.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 070caa1f72eb..8b282616e9c9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1071,7 +1071,7 @@ static void __setscheduler_uclamp(struct task_struct *p,
 	}
 }
 
-static void uclamp_fork(struct task_struct *p)
+static void uclamp_fork(struct task_struct *p, bool reset)
 {
 	unsigned int clamp_id;
 
@@ -1080,6 +1080,17 @@ static void uclamp_fork(struct task_struct *p)
 
 	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id)
 		p->uclamp[clamp_id].active = false;
+
+	if (likely(!reset))
+		return;
+
+	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
+		unsigned int clamp_value = uclamp_none(clamp_id);
+
+		p->uclamp[clamp_id].user_defined = false;
+		p->uclamp[clamp_id].value = clamp_value;
+		p->uclamp[clamp_id].bucket_id = uclamp_bucket_id(clamp_value);
+	}
 }
 
 static void __init init_uclamp(void)
@@ -1124,7 +1135,7 @@ static inline int uclamp_validate(struct task_struct *p,
 }
 static void __setscheduler_uclamp(struct task_struct *p,
 				  const struct sched_attr *attr) { }
-static inline void uclamp_fork(struct task_struct *p) { }
+static inline void uclamp_fork(struct task_struct *p, bool reset) { }
 static inline void init_uclamp(void) { }
 #endif /* CONFIG_UCLAMP_TASK */
 
@@ -2711,6 +2722,7 @@ static inline void init_schedstats(void) {}
 int sched_fork(unsigned long clone_flags, struct task_struct *p)
 {
 	unsigned long flags;
+	bool reset;
 
 	__sched_fork(clone_flags, p);
 	/*
@@ -2728,7 +2740,8 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	/*
 	 * Revert to default priority/policy on fork if requested.
 	 */
-	if (unlikely(p->sched_reset_on_fork)) {
+	reset = p->sched_reset_on_fork;
+	if (unlikely(reset)) {
 		if (task_has_dl_policy(p) || task_has_rt_policy(p)) {
 			p->policy = SCHED_NORMAL;
 			p->static_prio = NICE_TO_PRIO(0);
@@ -2755,7 +2768,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 
 	init_entity_runnable_average(&p->se);
 
-	uclamp_fork(p);
+	uclamp_fork(p, reset);
 
 	/*
 	 * The child is not yet in the pid-hash so no cgroup attach races,
-- 
2.20.1

