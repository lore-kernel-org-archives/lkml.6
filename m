Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DECC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF641214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfBDJAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:00:25 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36989 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfBDJAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:00:25 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x14908CP358779
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 01:00:08 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x14908tK358776;
        Mon, 4 Feb 2019 01:00:08 -0800
Date:   Mon, 4 Feb 2019 01:00:08 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-62478d9911fab9694c195f0ca8e4701de09be98e@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        efault@gmx.de, tglx@linutronix.de, peterz@infradead.org,
        vincent.guittot@linaro.org, torvalds@linux-foundation.org
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, efault@gmx.de,
          mingo@kernel.org, torvalds@linux-foundation.org,
          vincent.guittot@linaro.org, peterz@infradead.org,
          tglx@linutronix.de
In-Reply-To: <1548257214-13745-2-git-send-email-vincent.guittot@linaro.org>
References: <1548257214-13745-2-git-send-email-vincent.guittot@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Move the rq_of() helper function
Git-Commit-ID: 62478d9911fab9694c195f0ca8e4701de09be98e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  62478d9911fab9694c195f0ca8e4701de09be98e
Gitweb:     https://git.kernel.org/tip/62478d9911fab9694c195f0ca8e4701de09be98e
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Wed, 23 Jan 2019 16:26:52 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 4 Feb 2019 09:13:21 +0100

sched/fair: Move the rq_of() helper function

Move rq_of() helper function so it can be used in pelt.c

[ mingo: Improve readability while at it. ]

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Morten.Rasmussen@arm.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bsegall@google.com
Cc: dietmar.eggemann@arm.com
Cc: patrick.bellasi@arm.com
Cc: pjt@google.com
Cc: pkondeti@codeaurora.org
Cc: quentin.perret@arm.com
Cc: rjw@rjwysocki.net
Cc: srinivas.pandruvada@linux.intel.com
Cc: thara.gopinath@linaro.org
Link: https://lkml.kernel.org/r/1548257214-13745-2-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c  | 13 -------------
 kernel/sched/sched.h | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5b2b919c7929..da13e834e990 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -248,13 +248,6 @@ const struct sched_class fair_sched_class;
  */
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-
-/* cpu runqueue to which this cfs_rq is attached */
-static inline struct rq *rq_of(struct cfs_rq *cfs_rq)
-{
-	return cfs_rq->rq;
-}
-
 static inline struct task_struct *task_of(struct sched_entity *se)
 {
 	SCHED_WARN_ON(!entity_is_task(se));
@@ -410,12 +403,6 @@ static inline struct task_struct *task_of(struct sched_entity *se)
 	return container_of(se, struct task_struct, se);
 }
 
-static inline struct rq *rq_of(struct cfs_rq *cfs_rq)
-{
-	return container_of(cfs_rq, struct rq, cfs);
-}
-
-
 #define for_each_sched_entity(se) \
 		for (; se; se = NULL)
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d27c1a5d4e25..0ed130fae2a9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -951,6 +951,22 @@ struct rq {
 #endif
 };
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+
+/* CPU runqueue to which this cfs_rq is attached */
+static inline struct rq *rq_of(struct cfs_rq *cfs_rq)
+{
+	return cfs_rq->rq;
+}
+
+#else
+
+static inline struct rq *rq_of(struct cfs_rq *cfs_rq)
+{
+	return container_of(cfs_rq, struct rq, cfs);
+}
+#endif
+
 static inline int cpu_of(struct rq *rq)
 {
 #ifdef CONFIG_SMP
