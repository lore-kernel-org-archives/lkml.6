Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C4EECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC8C2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC8C2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733013AbeGTOWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:22:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36264 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728252AbeGTOWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:22:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5F8415AD;
        Fri, 20 Jul 2018 06:33:46 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (e105550-lin.cambridge.arm.com [10.1.211.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 080B73F73C;
        Fri, 20 Jul 2018 06:33:44 -0700 (PDT)
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/4] drivers/base/arch_topology: Rebuild sched_domain hierarchy when capacities change
Date:   Fri, 20 Jul 2018 14:32:32 +0100
Message-Id: <1532093554-30504-3-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532093554-30504-1-git-send-email-morten.rasmussen@arm.com>
References: <1532093554-30504-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The setting of SD_ASYM_CPUCAPACITY depends on the per-cpu capacities.
These might not have their final values when the hierarchy is initially
built as the values depend on cpufreq to be initialized or the values
being set through sysfs. To ensure that the flags are set correctly we
need to rebuild the sched_domain hierarchy whenever the reported per-cpu
capacity (arch_scale_cpu_capacity()) changes.

This patch ensure that a full sched_domain rebuild happens when cpu
capacity changes occur.

cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 drivers/base/arch_topology.c  | 26 ++++++++++++++++++++++++++
 include/linux/arch_topology.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index e7cb0c6ade81..edfcf8d982e4 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/sched/topology.h>
+#include <linux/cpuset.h>
 
 DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
 
@@ -47,6 +48,9 @@ static ssize_t cpu_capacity_show(struct device *dev,
 	return sprintf(buf, "%lu\n", topology_get_cpu_scale(NULL, cpu->dev.id));
 }
 
+static void update_topology_flags_workfn(struct work_struct *work);
+static DECLARE_WORK(update_topology_flags_work, update_topology_flags_workfn);
+
 static ssize_t cpu_capacity_store(struct device *dev,
 				  struct device_attribute *attr,
 				  const char *buf,
@@ -72,6 +76,8 @@ static ssize_t cpu_capacity_store(struct device *dev,
 		topology_set_cpu_scale(i, new_capacity);
 	mutex_unlock(&cpu_scale_mutex);
 
+	schedule_work(&update_topology_flags_work);
+
 	return count;
 }
 
@@ -96,6 +102,25 @@ static int register_cpu_capacity_sysctl(void)
 }
 subsys_initcall(register_cpu_capacity_sysctl);
 
+static int update_topology;
+
+int topology_update_cpu_topology(void)
+{
+	return update_topology;
+}
+
+/*
+ * Updating the sched_domains can't be done directly from cpufreq callbacks
+ * due to locking, so queue the work for later.
+ */
+static void update_topology_flags_workfn(struct work_struct *work)
+{
+	update_topology = 1;
+	rebuild_sched_domains();
+	pr_debug("sched_domain hierarchy rebuilt, flags updated\n");
+	update_topology = 0;
+}
+
 static u32 capacity_scale;
 static u32 *raw_capacity;
 
@@ -201,6 +226,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 
 	if (cpumask_empty(cpus_to_visit)) {
 		topology_normalize_cpu_scale();
+		schedule_work(&update_topology_flags_work);
 		free_raw_capacity();
 		pr_debug("cpu_capacity: parsing done\n");
 		schedule_work(&parsing_done_work);
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 2b709416de05..d9bdc1a7f4e7 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -9,6 +9,7 @@
 #include <linux/percpu.h>
 
 void topology_normalize_cpu_scale(void);
+int topology_update_cpu_topology(void);
 
 struct device_node;
 bool topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu);
-- 
2.7.4

