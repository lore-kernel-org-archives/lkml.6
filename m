Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFB9C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E232086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E232086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbeJPSFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:05:11 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33710 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbeJPSFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:05:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A56780D;
        Tue, 16 Oct 2018 03:15:28 -0700 (PDT)
Received: from queper01-lin.local (unknown [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68FCA3F59C;
        Tue, 16 Oct 2018 03:15:24 -0700 (PDT)
From:   Quentin Perret <quentin.perret@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@codeaurora.org, skannan@codeaurora.org,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org,
        quentin.perret@arm.com
Subject: [PATCH v8 01/15] sched: Relocate arch_scale_cpu_capacity
Date:   Tue, 16 Oct 2018 11:14:59 +0100
Message-Id: <20181016101513.26919-2-quentin.perret@arm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016101513.26919-1-quentin.perret@arm.com>
References: <20181016101513.26919-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, arch_scale_cpu_capacity() is only visible from within the
kernel/sched folder. Relocate it to include/linux/sched/topology.h to
make it visible to other clients needing to know about the capacity of
CPUs, such as the Energy Model framework.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 include/linux/sched/topology.h | 19 +++++++++++++++++++
 kernel/sched/sched.h           | 21 ---------------------
 2 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 6b9976180c1e..5e56d6b1e217 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -202,6 +202,17 @@ extern void set_sched_topology(struct sched_domain_topology_level *tl);
 # define SD_INIT_NAME(type)
 #endif
 
+#ifndef arch_scale_cpu_capacity
+static __always_inline
+unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
+{
+	if (sd && (sd->flags & SD_SHARE_CPUCAPACITY) && (sd->span_weight > 1))
+		return sd->smt_gain / sd->span_weight;
+
+	return SCHED_CAPACITY_SCALE;
+}
+#endif
+
 #else /* CONFIG_SMP */
 
 struct sched_domain_attr;
@@ -217,6 +228,14 @@ static inline bool cpus_share_cache(int this_cpu, int that_cpu)
 	return true;
 }
 
+#ifndef arch_scale_cpu_capacity
+static __always_inline
+unsigned long arch_scale_cpu_capacity(void __always_unused *sd, int cpu)
+{
+	return SCHED_CAPACITY_SCALE;
+}
+#endif
+
 #endif	/* !CONFIG_SMP */
 
 static inline int task_node(const struct task_struct *p)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 798b1afd5092..ad12d11af0b2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1761,27 +1761,6 @@ unsigned long arch_scale_freq_capacity(int cpu)
 }
 #endif
 
-#ifdef CONFIG_SMP
-#ifndef arch_scale_cpu_capacity
-static __always_inline
-unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
-{
-	if (sd && (sd->flags & SD_SHARE_CPUCAPACITY) && (sd->span_weight > 1))
-		return sd->smt_gain / sd->span_weight;
-
-	return SCHED_CAPACITY_SCALE;
-}
-#endif
-#else
-#ifndef arch_scale_cpu_capacity
-static __always_inline
-unsigned long arch_scale_cpu_capacity(void __always_unused *sd, int cpu)
-{
-	return SCHED_CAPACITY_SCALE;
-}
-#endif
-#endif
-
 struct rq *__task_rq_lock(struct task_struct *p, struct rq_flags *rf)
 	__acquires(rq->lock);
 
-- 
2.19.1

