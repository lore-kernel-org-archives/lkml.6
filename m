Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC58C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1606D2080A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfBHKGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:06:40 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47570 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbfBHKGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:06:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A481FA78;
        Fri,  8 Feb 2019 02:06:36 -0800 (PST)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8DAE43F557;
        Fri,  8 Feb 2019 02:06:33 -0800 (PST)
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
Subject: [PATCH v7 07/15] sched/core: uclamp: Set default clamps for RT tasks
Date:   Fri,  8 Feb 2019 10:05:46 +0000
Message-Id: <20190208100554.32196-8-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208100554.32196-1-patrick.bellasi@arm.com>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default FAIR tasks start without clamps, i.e. neither boosted nor
capped, and they run at the best frequency matching their utilization
demand.  This default behavior does not fit RT tasks which instead are
expected to run at the maximum available frequency, if not otherwise
required by explicitly capping them.

Enforce the correct behavior for RT tasks by setting util_min to max
whenever:

 1. a task is switched to the RT class and it does not already have a
    user-defined clamp value assigned.

 2. a task is forked from a parent with RESET_ON_FORK set.

NOTE: utilization clamp values are cross scheduling class attributes and
thus they are never changed/reset once a value has been explicitly
defined from user-space.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/core.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8b282616e9c9..569564012ddc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1049,6 +1049,28 @@ static int uclamp_validate(struct task_struct *p,
 static void __setscheduler_uclamp(struct task_struct *p,
 				  const struct sched_attr *attr)
 {
+	unsigned int clamp_id;
+
+	/*
+	 * On scheduling class change, reset to default clamps for tasks
+	 * without a task-specific value.
+	 */
+	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
+		unsigned int clamp_value = uclamp_none(clamp_id);
+		struct uclamp_se *uc_se = &p->uclamp[clamp_id];
+
+		/* Keep using defined clamps across class changes */
+		if (uc_se->user_defined)
+			continue;
+
+		/* By default, RT tasks always get 100% boost */
+		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
+			clamp_value = uclamp_none(UCLAMP_MAX);
+
+		uc_se->bucket_id = uclamp_bucket_id(clamp_value);
+		uc_se->value = clamp_value;
+	}
+
 	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
 		return;
 
@@ -1087,6 +1109,10 @@ static void uclamp_fork(struct task_struct *p, bool reset)
 	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
 		unsigned int clamp_value = uclamp_none(clamp_id);
 
+		/* By default, RT tasks always get 100% boost */
+		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
+			clamp_value = uclamp_none(UCLAMP_MAX);
+
 		p->uclamp[clamp_id].user_defined = false;
 		p->uclamp[clamp_id].value = clamp_value;
 		p->uclamp[clamp_id].bucket_id = uclamp_bucket_id(clamp_value);
-- 
2.20.1

