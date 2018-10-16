Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5450C070C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733242086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 733242086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeJPSFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:05:46 -0400
Received: from foss.arm.com ([217.140.101.70]:33962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeJPSFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:05:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74F43ED1;
        Tue, 16 Oct 2018 03:16:03 -0700 (PDT)
Received: from queper01-lin.local (unknown [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 637C93F59C;
        Tue, 16 Oct 2018 03:15:59 -0700 (PDT)
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
Subject: [PATCH v8 09/15] sched: Introduce sched_energy_present static key
Date:   Tue, 16 Oct 2018 11:15:07 +0100
Message-Id: <20181016101513.26919-10-quentin.perret@arm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016101513.26919-1-quentin.perret@arm.com>
References: <20181016101513.26919-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make sure Energy Aware Scheduling (EAS) will not impact
systems where no Energy Model is available, introduce a static key
guarding the access to EAS code. Since EAS is enabled on a
per-root-domain basis, the static key is enabled when at least one root
domain meets all conditions for EAS.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 kernel/sched/sched.h    |  4 ++++
 kernel/sched/topology.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index cba77f619e4e..9d6cf58a8aff 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2278,3 +2278,7 @@ unsigned long scale_irq_capacity(unsigned long util, unsigned long irq, unsigned
 #else
 #define perf_domain_span(pd) NULL
 #endif
+
+#ifdef CONFIG_SMP
+extern struct static_key_false sched_energy_present;
+#endif
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8f5efab1c058..58bfda46ac07 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -201,6 +201,7 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 	return 1;
 }
 
+DEFINE_STATIC_KEY_FALSE(sched_energy_present);
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 DEFINE_MUTEX(sched_energy_mutex);
 bool sched_energy_update;
@@ -273,6 +274,35 @@ static void destroy_perf_domain_rcu(struct rcu_head *rp)
 	free_pd(pd);
 }
 
+static void sched_energy_start(int ndoms_new, cpumask_var_t doms_new[])
+{
+	/*
+	 * The conditions for EAS to start are checked during the creation of
+	 * root domains. If one of them meets all conditions, it will have a
+	 * non-null list of performance domains.
+	 */
+	while (ndoms_new) {
+		if (cpu_rq(cpumask_first(doms_new[ndoms_new - 1]))->rd->pd)
+			goto enable;
+		ndoms_new--;
+	}
+
+	if (static_branch_unlikely(&sched_energy_present)) {
+		if (sched_debug())
+			pr_info("%s: stopping EAS\n", __func__);
+		static_branch_disable_cpuslocked(&sched_energy_present);
+	}
+
+	return;
+
+enable:
+	if (!static_branch_unlikely(&sched_energy_present)) {
+		if (sched_debug())
+			pr_info("%s: starting EAS\n", __func__);
+		static_branch_enable_cpuslocked(&sched_energy_present);
+	}
+}
+
 /*
  * EAS can be used on a root domain if it meets all the following conditions:
  *    1. an Energy Model (EM) is available;
@@ -2187,6 +2217,7 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 match3:
 		;
 	}
+	sched_energy_start(ndoms_new, doms_new);
 #endif
 
 	/* Remember the new sched domains: */
-- 
2.19.1

