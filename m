Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96606C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE9F20656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbfAOKPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:15:32 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46790 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727238AbfAOKPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:15:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FB381596;
        Tue, 15 Jan 2019 02:15:30 -0800 (PST)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ED5D43F70D;
        Tue, 15 Jan 2019 02:15:26 -0800 (PST)
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
Subject: [PATCH v6 01/16] sched/core: Allow sched_setattr() to use the current policy
Date:   Tue, 15 Jan 2019 10:14:58 +0000
Message-Id: <20190115101513.2822-2-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190115101513.2822-1-patrick.bellasi@arm.com>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sched_setattr() syscall mandates that a policy is always specified.
This requires to always know which policy a task will have when
attributes are configured and it makes it impossible to add more generic
task attributes valid across different scheduling policies.
Reading the policy before setting generic tasks attributes is racy since
we cannot be sure it is not changed concurrently.

Introduce the required support to change generic task attributes without
affecting the current task policy. This is done by adding an attribute flag
(SCHED_FLAG_KEEP_POLICY) to enforce the usage of the current policy.

This is done by extending to the sched_setattr() non-POSIX syscall with
the SETPARAM_POLICY policy already used by the sched_setparam() POSIX
syscall.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>

---
Changes in v6:
 Message-ID: <20181107135801.GE9761@hirez.programming.kicks-ass.net>
 - rename SCHED_FLAG_TUNE_POLICY in  SCHED_FLAG_KEEP_POLICY
 - moved at the beginning of the series
---
 include/uapi/linux/sched.h |  6 +++++-
 kernel/sched/core.c        | 11 ++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 22627f80063e..43832a87016a 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -40,6 +40,8 @@
 /* SCHED_ISO: reserved but not implemented yet */
 #define SCHED_IDLE		5
 #define SCHED_DEADLINE		6
+/* Must be the last entry: used to sanity check attr.policy values */
+#define SCHED_POLICY_MAX	7
 
 /* Can be ORed in to make sure the process is reverted back to SCHED_NORMAL on fork */
 #define SCHED_RESET_ON_FORK     0x40000000
@@ -50,9 +52,11 @@
 #define SCHED_FLAG_RESET_ON_FORK	0x01
 #define SCHED_FLAG_RECLAIM		0x02
 #define SCHED_FLAG_DL_OVERRUN		0x04
+#define SCHED_FLAG_KEEP_POLICY		0x08
 
 #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
 			 SCHED_FLAG_RECLAIM		| \
-			 SCHED_FLAG_DL_OVERRUN)
+			 SCHED_FLAG_DL_OVERRUN		| \
+			 SCHED_FLAG_KEEP_POLICY)
 
 #endif /* _UAPI_LINUX_SCHED_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a674c7db2f29..a68763a4ccae 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4560,8 +4560,17 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
 	if (retval)
 		return retval;
 
-	if ((int)attr.sched_policy < 0)
+	/*
+	 * A valid policy is always required from userspace, unless
+	 * SCHED_FLAG_KEEP_POLICY is set and the current policy
+	 * is enforced for this call.
+	 */
+	if (attr.sched_policy >= SCHED_POLICY_MAX &&
+	    !(attr.sched_flags & SCHED_FLAG_KEEP_POLICY)) {
 		return -EINVAL;
+	}
+	if (attr.sched_flags & SCHED_FLAG_KEEP_POLICY)
+		attr.sched_policy = SETPARAM_POLICY;
 
 	rcu_read_lock();
 	retval = -ESRCH;
-- 
2.19.2

