Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B597FECDFB3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA1E2089D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA1E2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbeGOXw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 19:52:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:32959 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeGOXw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 19:52:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6FNRXUA921307
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Jul 2018 16:27:33 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6FNRXPL921304;
        Sun, 15 Jul 2018 16:27:33 -0700
Date:   Sun, 15 Jul 2018 16:27:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-3ae117c6cd7c4783819a0766aa97b9493a8a0f62@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        mingo@kernel.org, viresh.kumar@linaro.org, tglx@linutronix.de,
        vincent.guittot@linaro.org, hpa@zytor.com, peterz@infradead.org
Reply-To: torvalds@linux-foundation.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          peterz@infradead.org, tglx@linutronix.de,
          vincent.guittot@linaro.org, viresh.kumar@linaro.org
In-Reply-To: <1530200714-4504-4-git-send-email-vincent.guittot@linaro.org>
References: <1530200714-4504-4-git-send-email-vincent.guittot@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] cpufreq/schedutil: Use RT utilization tracking
Git-Commit-ID: 3ae117c6cd7c4783819a0766aa97b9493a8a0f62
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

Commit-ID:  3ae117c6cd7c4783819a0766aa97b9493a8a0f62
Gitweb:     https://git.kernel.org/tip/3ae117c6cd7c4783819a0766aa97b9493a8a0f62
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Thu, 28 Jun 2018 17:45:06 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 15 Jul 2018 23:51:20 +0200

cpufreq/schedutil: Use RT utilization tracking

Add both CFS and RT utilization when selecting an OPP for CFS tasks as RT
can preempt and steal CFS's running time.

RT util_avg is used to take into account the utilization of RT tasks
on the CPU when selecting OPP. If a RT task migrate, the RT utilization
will not migrate but will decay over time. On an overloaded CPU, CFS
utilization reflects the remaining utilization avialable on CPU. When RT
task migrates, the CFS utilization will increase when tasks will start to
use the newly available capacity. At the same pace, RT utilization will
decay and both variations will compensate each other to keep unchanged
overall utilization and will prevent any OPP drop.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Morten.Rasmussen@arm.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: claudio@evidence.eu.com
Cc: daniel.lezcano@linaro.org
Cc: dietmar.eggemann@arm.com
Cc: joel@joelfernandes.org
Cc: juri.lelli@redhat.com
Cc: luca.abeni@santannapisa.it
Cc: patrick.bellasi@arm.com
Cc: quentin.perret@arm.com
Cc: rjw@rjwysocki.net
Cc: valentin.schneider@arm.com
Link: http://lkml.kernel.org/r/1530200714-4504-4-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/cpufreq_schedutil.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index c907fde01eaa..da29b5a33adb 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -56,6 +56,7 @@ struct sugov_cpu {
 	/* The fields below are only needed when sharing a policy: */
 	unsigned long		util_cfs;
 	unsigned long		util_dl;
+	unsigned long		util_rt;
 	unsigned long		max;
 
 	/* The field below is for single-CPU policies only: */
@@ -186,15 +187,21 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
 	sg_cpu->max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
 	sg_cpu->util_cfs = cpu_util_cfs(rq);
 	sg_cpu->util_dl  = cpu_util_dl(rq);
+	sg_cpu->util_rt  = cpu_util_rt(rq);
 }
 
 static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
+	unsigned long util;
 
 	if (rt_rq_is_runnable(&rq->rt))
 		return sg_cpu->max;
 
+	util = sg_cpu->util_dl;
+	util += sg_cpu->util_cfs;
+	util += sg_cpu->util_rt;
+
 	/*
 	 * Utilization required by DEADLINE must always be granted while, for
 	 * FAIR, we use blocked utilization of IDLE CPUs as a mechanism to
@@ -205,7 +212,7 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
 	 * ready for such an interface. So, we only do the latter for now.
 	 */
-	return min(sg_cpu->max, (sg_cpu->util_dl + sg_cpu->util_cfs));
+	return min(sg_cpu->max, util);
 }
 
 /**
