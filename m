Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DD0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F3D20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F3D20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbeKTAnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:43:42 -0500
Received: from foss.arm.com ([217.140.101.70]:58368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726235AbeKTAnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:43:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FB1215AB;
        Mon, 19 Nov 2018 06:19:57 -0800 (PST)
Received: from queper01-lin.local (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 230C83F5AF;
        Mon, 19 Nov 2018 06:19:52 -0800 (PST)
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
Subject: [PATCH v9 10/15] sched: Introduce a sysctl for Energy Aware Scheduling
Date:   Mon, 19 Nov 2018 14:18:52 +0000
Message-Id: <20181119141857.8625-11-quentin.perret@arm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119141857.8625-1-quentin.perret@arm.com>
References: <20181119141857.8625-1-quentin.perret@arm.com>
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
 Documentation/sysctl/kernel.txt | 12 ++++++++++++
 include/linux/sched/sysctl.h    |  7 +++++++
 kernel/sched/topology.c         | 29 +++++++++++++++++++++++++++++
 kernel/sysctl.c                 | 11 +++++++++++
 4 files changed, 59 insertions(+)

diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
index 37a679501ddc..36bee799ee9e 100644
--- a/Documentation/sysctl/kernel.txt
+++ b/Documentation/sysctl/kernel.txt
@@ -78,6 +78,7 @@ show up in /proc/sys/kernel:
 - reboot-cmd                  [ SPARC only ]
 - rtsig-max
 - rtsig-nr
+- sched_energy_aware
 - seccomp/                    ==> Documentation/userspace-api/seccomp_filter.rst
 - sem
 - sem_next_id		      [ sysv ipc ]
@@ -872,6 +873,17 @@ rtsig-nr shows the number of RT signals currently queued.
 
 ==============================================================
 
+sched_energy_aware:
+
+Enables/disables Energy Aware Scheduling (EAS). EAS starts
+automatically on platforms where it can run (that is,
+platforms with asymmetric CPU topologies and having an Energy
+Model available). If your platform happens to meet the
+requirements for EAS but you do not want to use it, change
+this value to 0.
+
+==============================================================
+
 sched_schedstats:
 
 Enables/disables scheduler statistics. Enabling this feature
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
index 1457ef80ee94..8f9dfea60344 100644
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

