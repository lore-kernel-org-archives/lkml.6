Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B176DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750BD208A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 750BD208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeH1Rr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:47:26 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38676 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727706AbeH1Rq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:46:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AF421AED;
        Tue, 28 Aug 2018 06:54:43 -0700 (PDT)
Received: from e110439-lin.Cambridge.arm.com (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 796633F5BD;
        Tue, 28 Aug 2018 06:54:40 -0700 (PDT)
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v4 14/16] sched/core: uclamp: request CAP_SYS_ADMIN by default
Date:   Tue, 28 Aug 2018 14:53:22 +0100
Message-Id: <20180828135324.21976-15-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828135324.21976-1-patrick.bellasi@arm.com>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of clamp groups supported is limited and defined at compile
time. However, a malicious user can currently ask for many different
clamp values thus consuming all the available clamp groups.

Since on properly configured systems we expect only a limited set of
different clamp values, the previous problem can be mitigated by
allowing access to clamp groups configuration only to privileged tasks.
This should still allow a System Management Software to properly
pre-configure the system.

Let's restrict the tuning of utilization clamp values, by default, to
tasks with CAP_SYS_ADMIN capabilities.

Whenever this should be considered too restrictive and/or not required
for a specific platforms, a kernel boot option is provided to change
this default behavior thus allowing non privileged tasks to change their
utilization clamp values.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Paul Turner <pjt@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Steve Muckle <smuckle@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Quentin Perret <quentin.perret@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
Changes in v4:
 Others:
 - new patch added in this version
 - rebased on v4.19-rc1
---
 .../admin-guide/kernel-parameters.txt         |  3 +++
 kernel/sched/core.c                           | 22 ++++++++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9871e649ffef..481f8214ea9a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4561,6 +4561,9 @@
 			<port#>,<js1>,<js2>,<js3>,<js4>,<js5>,<js6>,<js7>
 			See also Documentation/input/devices/joystick-parport.rst
 
+	uclamp_user	[KNL] Enable task-specific utilization clamping tuning
+			also from tasks without CAP_SYS_ADMIN capability.
+
 	udbg-immortal	[PPC] When debugging early kernel crashes that
 			happen after console_init() and before a proper
 			console driver takes over, this boot options might
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 222397edb8a7..8341ce580a9a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1510,14 +1510,29 @@ static inline int alloc_uclamp_sched_group(struct task_group *tg,
 static inline void free_uclamp_sched_group(struct task_group *tg) { }
 #endif /* CONFIG_UCLAMP_TASK_GROUP */
 
+static bool uclamp_user_allowed __read_mostly;
+static int __init uclamp_user_allow(char *str)
+{
+	uclamp_user_allowed = true;
+
+	return 0;
+}
+early_param("uclamp_user", uclamp_user_allow);
+
 static inline int __setscheduler_uclamp(struct task_struct *p,
-					const struct sched_attr *attr)
+					const struct sched_attr *attr,
+					bool user)
 {
 	int group_id[UCLAMP_CNT] = { UCLAMP_NOT_VALID };
 	int lower_bound, upper_bound;
 	struct uclamp_se *uc_se;
 	int result = 0;
 
+	if (!capable(CAP_SYS_ADMIN) &&
+	    user && !uclamp_user_allowed) {
+		return -EPERM;
+	}
+
 	mutex_lock(&uclamp_mutex);
 
 	/* Find a valid group_id for each required clamp value */
@@ -1702,7 +1717,8 @@ static inline int alloc_uclamp_sched_group(struct task_group *tg,
 	return 1;
 }
 static inline int __setscheduler_uclamp(struct task_struct *p,
-					const struct sched_attr *attr)
+					const struct sched_attr *attr,
+					bool user)
 {
 	return -EINVAL;
 }
@@ -5217,7 +5233,7 @@ static int __sched_setscheduler(struct task_struct *p,
 
 	/* Configure utilization clamps for the task */
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP) {
-		retval = __setscheduler_uclamp(p, attr);
+		retval = __setscheduler_uclamp(p, attr, user);
 		if (retval)
 			return retval;
 	}
-- 
2.18.0

