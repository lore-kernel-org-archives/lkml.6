Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C29C070C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C082086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C082086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeJPSFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:05:50 -0400
Received: from foss.arm.com ([217.140.101.70]:33986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeJPSFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:05:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB655A78;
        Tue, 16 Oct 2018 03:16:07 -0700 (PDT)
Received: from queper01-lin.local (unknown [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA1EF3F59C;
        Tue, 16 Oct 2018 03:16:03 -0700 (PDT)
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
Subject: [PATCH v8 10/15] sched: Introduce a sysctl for Energy Aware Scheduling
Date:   Tue, 16 Oct 2018 11:15:08 +0100
Message-Id: <20181016101513.26919-11-quentin.perret@arm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016101513.26919-1-quentin.perret@arm.com>
References: <20181016101513.26919-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In its current state, Energy Aware Scheduling (EAS) starts automatically
on asymmetric platforms having an Energy Model (EM). However, there are
users who want to have an EM (for thermal management for example), but
don't want EAS with it.

In order to let users disable EAS explicitly, introduce a new sysctl
called 'sched_energy_aware'. It is enabled by default so that EAS can
start automatically on platforms where it makes sense. Flipping it to 0
rebuilds the scheduling domains and disables EAS.

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 include/linux/sched/sysctl.h |  7 +++++++
 kernel/sched/topology.c      | 29 +++++++++++++++++++++++++++++
 kernel/sysctl.c              | 11 +++++++++++
 3 files changed, 47 insertions(+)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index a9c32daeb9d8..99ce6d728df7 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -83,4 +83,11 @@ extern int sysctl_schedstats(struct ctl_table *table, int write,
 				 void __user *buffer, size_t *lenp,
 				 loff_t *ppos);
 
+#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
+extern unsigned int sysctl_sched_energy_aware;
+extern int sched_energy_aware_handler(struct ctl_table *table, int write,
+				 void __user *buffer, size_t *lenp,
+				 loff_t *ppos);
+#endif
+
 #endif /* _LINUX_SCHED_SYSCTL_H */
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 58bfda46ac07..e31f732d6ee7 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -203,9 +203,35 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 
 DEFINE_STATIC_KEY_FALSE(sched_energy_present);
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
+unsigned int sysctl_sched_energy_aware = 1;
 DEFINE_MUTEX(sched_energy_mutex);
 bool sched_energy_update;
 
+#ifdef CONFIG_PROC_SYSCTL
+int sched_energy_aware_handler(struct ctl_table *table, int write,
+			 void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret, state;
+
+	if (write && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	if (!ret && write) {
+		state = static_branch_unlikely(&sched_energy_present);
+		if (state != sysctl_sched_energy_aware) {
+			mutex_lock(&sched_energy_mutex);
+			sched_energy_update = 1;
+			rebuild_sched_domains();
+			sched_energy_update = 0;
+			mutex_unlock(&sched_energy_mutex);
+		}
+	}
+
+	return ret;
+}
+#endif
+
 static void free_pd(struct perf_domain *pd)
 {
 	struct perf_domain *tmp;
@@ -338,6 +364,9 @@ static void build_perf_domains(const struct cpumask *cpu_map)
 	struct cpufreq_policy *policy;
 	struct cpufreq_governor *gov;
 
+	if (!sysctl_sched_energy_aware)
+		goto free;
+
 	/* EAS is enabled for asymmetric CPU capacity topologies. */
 	if (!per_cpu(sd_asym_cpucapacity, cpu)) {
 		if (sched_debug()) {
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index cc02050fd0c4..481309a11174 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -466,6 +466,17 @@ static struct ctl_table kern_table[] = {
 		.extra1		= &one,
 	},
 #endif
+#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
+	{
+		.procname	= "sched_energy_aware",
+		.data		= &sysctl_sched_energy_aware,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= sched_energy_aware_handler,
+		.extra1		= &zero,
+		.extra2		= &one,
+	},
+#endif
 #ifdef CONFIG_PROVE_LOCKING
 	{
 		.procname	= "prove_locking",
-- 
2.19.1

