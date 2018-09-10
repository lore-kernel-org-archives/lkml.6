Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4930C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5213A20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5213A20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbeIJPFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:05:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55481 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbeIJPFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:05:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8AABe6r1807509
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 03:11:40 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8AABeT71807506;
        Mon, 10 Sep 2018 03:11:40 -0700
Date:   Mon, 10 Sep 2018 03:11:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Morten Rasmussen <tipbot@zytor.com>
Message-ID: <tip-bb1fbdd3c3fd12b612c7d8cdf13bd6bfeebdefa3@git.kernel.org>
Cc:     hpa@zytor.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org, peterz@infradead.org
Reply-To: torvalds@linux-foundation.org, hpa@zytor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, morten.rasmussen@arm.com,
          peterz@infradead.org, tglx@linutronix.de,
          gregkh@linuxfoundation.org
In-Reply-To: <1532093554-30504-3-git-send-email-morten.rasmussen@arm.com>
References: <1532093554-30504-3-git-send-email-morten.rasmussen@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/topology, drivers/base/arch_topology:
 Rebuild the sched_domain hierarchy when capacities change
Git-Commit-ID: bb1fbdd3c3fd12b612c7d8cdf13bd6bfeebdefa3
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

Commit-ID:  bb1fbdd3c3fd12b612c7d8cdf13bd6bfeebdefa3
Gitweb:     https://git.kernel.org/tip/bb1fbdd3c3fd12b612c7d8cdf13bd6bfeebdefa3
Author:     Morten Rasmussen <morten.rasmussen@arm.com>
AuthorDate: Fri, 20 Jul 2018 14:32:32 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 11:05:47 +0200

sched/topology, drivers/base/arch_topology: Rebuild the sched_domain hierarchy when capacities change

The setting of SD_ASYM_CPUCAPACITY depends on the per-CPU capacities.
These might not have their final values when the hierarchy is initially
built as the values depend on cpufreq to be initialized or the values
being set through sysfs. To ensure that the flags are set correctly we
need to rebuild the sched_domain hierarchy whenever the reported per-CPU
capacity (arch_scale_cpu_capacity()) changes.

This patch ensure that a full sched_domain rebuild happens when CPU
capacity changes occur.

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dietmar.eggemann@arm.com
Cc: valentin.schneider@arm.com
Cc: vincent.guittot@linaro.org
Link: http://lkml.kernel.org/r/1532093554-30504-3-git-send-email-morten.rasmussen@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
