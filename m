Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A6FC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77573208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77573208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390475AbeHATby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:31:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51780 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389883AbeHATNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:13:37 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 49FD01077;
        Wed,  1 Aug 2018 17:01:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Joel Fernandes <joelaf@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Steve Muckle <smuckle@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 126/336] sched/cpufreq: Modify aggregate utilization to always include blocked FAIR utilization
Date:   Wed,  1 Aug 2018 18:47:41 +0200
Message-Id: <20180801165033.962278789@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Patrick Bellasi <patrick.bellasi@arm.com>

[ Upstream commit 8ecf04e11283a28ca88b8b8049ac93c3a99fcd2c ]

Since the refactoring introduced by:

   commit 8f111bc357aa ("cpufreq/schedutil: Rewrite CPUFREQ_RT support")

we aggregate FAIR utilization only if this class has runnable tasks.

This was mainly due to avoid the risk to stay on an high frequency just
because of the blocked utilization of a CPU not being properly decayed
while the CPU was idle.

However, since:

   commit 31e77c93e432 ("sched/fair: Update blocked load when newly idle")

the FAIR blocked utilization is properly decayed also for IDLE CPUs.

This allows us to use the FAIR blocked utilization as a safe mechanism
to gracefully reduce the frequency only if no FAIR tasks show up on a
CPU for a reasonable period of time.

Moreover, we also reduce the frequency drops of CPUs running periodic
tasks which, depending on the task periodicity and the time required
for a frequency switch, was increasing the chances to introduce some
undesirable performance variations.

Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J . Wysocki <rafael.j.wysocki@intel.com>
Cc: Steve Muckle <smuckle@google.com>
Link: http://lkml.kernel.org/r/20180524141023.13765-2-patrick.bellasi@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/cpufreq_schedutil.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -183,22 +183,21 @@ static void sugov_get_util(struct sugov_
 static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
-	unsigned long util;
 
-	if (rq->rt.rt_nr_running) {
-		util = sg_cpu->max;
-	} else {
-		util = sg_cpu->util_dl;
-		if (rq->cfs.h_nr_running)
-			util += sg_cpu->util_cfs;
-	}
+	if (rq->rt.rt_nr_running)
+		return sg_cpu->max;
 
 	/*
+	 * Utilization required by DEADLINE must always be granted while, for
+	 * FAIR, we use blocked utilization of IDLE CPUs as a mechanism to
+	 * gracefully reduce the frequency when no tasks show up for longer
+	 * periods of time.
+	 *
 	 * Ideally we would like to set util_dl as min/guaranteed freq and
 	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
 	 * ready for such an interface. So, we only do the latter for now.
 	 */
-	return min(util, sg_cpu->max);
+	return min(sg_cpu->max, (sg_cpu->util_dl + sg_cpu->util_cfs));
 }
 
 static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time, unsigned int flags)


