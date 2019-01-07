Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00170C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07D72070C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfAGM0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:26:16 -0500
Received: from foss.arm.com ([217.140.101.70]:57700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfAGM0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:26:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 665F41596;
        Mon,  7 Jan 2019 04:26:15 -0800 (PST)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F58B3F5AF;
        Mon,  7 Jan 2019 04:26:14 -0800 (PST)
From:   Quentin Perret <quentin.perret@arm.com>
To:     rafael@kernel.org, peterz@infradead.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com
Subject: [PATCH] PM / EM: Expose the Energy Model in debugfs
Date:   Mon,  7 Jan 2019 12:26:08 +0000
Message-Id: <20190107122608.21913-1-quentin.perret@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recently introduced Energy Model (EM) framework manages power cost
tables of CPUs. These tables are currently only visible from kernel
space. However, in order to debug the behaviour of subsystems that use
the EM, it is often required to know what the power costs are from
userspace.

For this reason, introduce under /sys/kernel/debug/energy_model a set of
directories representing the performance domains of the system. Each
performance domain contains a set of sub-directories representing the
different capacity states (cs) and their attributes, as well as a file
exposing the related CPUs.

The resulting hierarchy is as follows on Arm juno r0 for example:

    /sys/kernel/debug/energy_model
    ├── pd0
    │   ├── cpus
    │   ├── cs:450000
    │   │   ├── cost
    │   │   ├── frequency
    │   │   └── power
    │   ├── cs:575000
    │   │   ├── cost
    │   │   ├── frequency
    │   │   └── power
    │   ├── cs:700000
    │   │   ├── cost
    │   │   ├── frequency
    │   │   └── power
    │   ├── cs:775000
    │   │   ├── cost
    │   │   ├── frequency
    │   │   └── power
    │   └── cs:850000
    │       ├── cost
    │       ├── frequency
    │       └── power
    └── pd1
        ├── cpus
        ├── cs:1100000
        │   ├── cost
        │   ├── frequency
        │   └── power
        ├── cs:450000
        │   ├── cost
        │   ├── frequency
        │   └── power
        ├── cs:625000
        │   ├── cost
        │   ├── frequency
        │   └── power
        ├── cs:800000
        │   ├── cost
        │   ├── frequency
        │   └── power
        └── cs:950000
            ├── cost
            ├── frequency
            └── power

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 kernel/power/energy_model.c | 86 +++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index d9dc2c38764a..8ef48daa62ff 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -10,6 +10,7 @@
 
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
+#include <linux/debugfs.h>
 #include <linux/energy_model.h>
 #include <linux/sched/topology.h>
 #include <linux/slab.h>
@@ -23,6 +24,88 @@ static DEFINE_PER_CPU(struct em_perf_domain *, em_data);
  */
 static DEFINE_MUTEX(em_pd_mutex);
 
+#ifdef CONFIG_DEBUG_FS
+static struct dentry *rootdir;
+
+static int em_debug_create_cs(struct em_cap_state *cs, struct dentry *pd)
+{
+	struct dentry *d;
+	char name[24];
+
+	snprintf(name, sizeof(name), "cs:%lu", cs->frequency);
+
+	d = debugfs_create_dir(name, pd);
+	if (!d)
+		return -ENOMEM;
+
+	if (!debugfs_create_ulong("frequency", 0444, d, &cs->frequency))
+		return -ENOMEM;
+
+	if (!debugfs_create_ulong("power", 0444, d, &cs->power))
+		return -ENOMEM;
+
+	if (!debugfs_create_ulong("cost", 0444, d, &cs->cost))
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int em_debug_cpus_show(struct seq_file *s, void *unused)
+{
+	seq_printf(s, "%*pbl\n", cpumask_pr_args(to_cpumask(s->private)));
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(em_debug_cpus);
+
+static int em_debug_create_pd(struct em_perf_domain *pd, int cpu)
+{
+	struct dentry *d;
+	char name[16];
+	int i;
+
+	if (!rootdir)
+		return -EINVAL;
+
+	snprintf(name, sizeof(name), "pd%d", cpu);
+
+	/* Create the directory of the performance domain */
+	d = debugfs_create_dir(name, rootdir);
+	if (!d)
+		return -ENOMEM;
+
+	/* Create one file per pd to expose the related CPUs */
+	if (!debugfs_create_file("cpus", 0444, d, pd->cpus,
+							&em_debug_cpus_fops))
+		return -ENOMEM;
+
+	/* Create a sub-directory for each capacity state */
+	for (i = 0; i < pd->nr_cap_states; i++) {
+		if (em_debug_create_cs(&pd->table[i], d))
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int __init em_debug_init(void)
+{
+	/* Create /sys/kernel/debug/energy_model directory */
+	rootdir = debugfs_create_dir("energy_model", NULL);
+	if (!rootdir) {
+		pr_err("%s: Failed to create root directory\n", __func__);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+core_initcall(em_debug_init);
+#else /* CONFIG_DEBUG_FS */
+static int em_debug_create_pd(struct em_perf_domain *pd, int cpu)
+{
+	return 0;
+}
+#endif
 static struct em_perf_domain *em_create_pd(cpumask_t *span, int nr_states,
 						struct em_data_callback *cb)
 {
@@ -102,6 +185,9 @@ static struct em_perf_domain *em_create_pd(cpumask_t *span, int nr_states,
 	pd->nr_cap_states = nr_states;
 	cpumask_copy(to_cpumask(pd->cpus), span);
 
+	if (em_debug_create_pd(pd, cpu))
+		pr_err("Failed to create debugfs for pd%d\n", cpu);
+
 	return pd;
 
 free_cs_table:
-- 
2.20.1

