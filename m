Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CED6C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90BE272AA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90BE272AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934322AbeF1LmY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 07:42:24 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45988 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965628AbeF1Lls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 07:41:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D08215AD;
        Thu, 28 Jun 2018 04:41:48 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5686A3F266;
        Thu, 28 Jun 2018 04:41:44 -0700 (PDT)
From:   Quentin Perret <quentin.perret@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org, quentin.perret@arm.com
Subject: [RFC PATCH v4 11/12] OPTIONAL: arch_topology: Start Energy Aware Scheduling
Date:   Thu, 28 Jun 2018 12:40:42 +0100
Message-Id: <20180628114043.24724-12-quentin.perret@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628114043.24724-1-quentin.perret@arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Energy Aware Scheduling (EAS) starts when the scheduling domains are
built if the Energy Model (EM) is present. However, in the typical case
of Arm/Arm64 systems, the EM is provided after the scheduling domains
are first built at boot time, which results in EAS staying disabled.

Fix this issue by re-building the scheduling domain from the arch
topology driver, once CPUfreq is up and running and when the CPU
capacities have been updated to their final value.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 drivers/base/arch_topology.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index e7cb0c6ade81..2022174f5ac5 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -10,7 +10,9 @@
 #include <linux/arch_topology.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
+#include <linux/cpuset.h>
 #include <linux/device.h>
+#include <linux/energy_model.h>
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -173,6 +175,9 @@ static cpumask_var_t cpus_to_visit;
 static void parsing_done_workfn(struct work_struct *work);
 static DECLARE_WORK(parsing_done_work, parsing_done_workfn);
 
+static void start_eas_workfn(struct work_struct *work);
+static DECLARE_WORK(start_eas_work, start_eas_workfn);
+
 static int
 init_cpu_capacity_callback(struct notifier_block *nb,
 			   unsigned long val,
@@ -204,6 +209,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 		free_raw_capacity();
 		pr_debug("cpu_capacity: parsing done\n");
 		schedule_work(&parsing_done_work);
+		schedule_work(&start_eas_work);
 	}
 
 	return 0;
@@ -249,6 +255,15 @@ static void parsing_done_workfn(struct work_struct *work)
 	free_cpumask_var(cpus_to_visit);
 }
 
+static void start_eas_workfn(struct work_struct *work)
+{
+	/* Make sure the EM knows about the updated CPU capacities. */
+	em_rescale_cpu_capacity();
+
+	/* Inform the scheduler about the EM availability. */
+	rebuild_sched_domains();
+}
+
 #else
 core_initcall(free_raw_capacity);
 #endif
-- 
2.17.1

