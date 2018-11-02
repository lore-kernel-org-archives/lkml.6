Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9BCC0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB2020820
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB2020820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbeKBJka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 05:40:30 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:44974
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728058AbeKBJka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 05:40:30 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id INPlglKPuWzu3INPlgdaND; Thu, 01 Nov 2018 17:34:17 -0700
x-originating-ip: 107.180.71.197
Received: from longli by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <longli@linuxonhyperv2.linuxonhyperv.com>)
        id 1gINPl-0007M0-0c; Thu, 01 Nov 2018 17:34:17 -0700
From:   Long Li <longli@linuxonhyperv.com>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [PATCH v3] genirq/matrix: Choose CPU for managed IRQs based on how many of them are allocated
Date:   Fri,  2 Nov 2018 00:34:12 +0000
Message-Id: <20181102003412.28229-1-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfCtw8H3JJ6jyyZdirV48suyhNZtRYiJ5T5WqORK6FGxG3fl9OEK7YRGSEvNOqQFws9MvXNXhNI56ITGnojsokoWCXeiqtNzvZ0UhsRrjeOB7npmQvt5y
 bTuxwMcQIeoxDzi542TDthIGUC1NRTrdrismzelz6XNAEgb8qesgpKUiVHOWImKv2NhUOiiE2stuCsEJT0LZP8Rm2JMdHNsidUpVCsZ+rtsTzCZIIwSIQ0t5
 eNNR2yMa1UP8D1wgE1poSXlT5E9Z4sMtxt5a7zj9L1aoY9c8imBF72+pByBrfvLp
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

On a large system with multiple devices of the same class (e.g. NVMe disks,
using managed IRQs), the kernel tends to concentrate their IRQs on several
CPUs.

The issue is that when NVMe calls irq_matrix_alloc_managed(), the assigned
CPU tends to be the first several CPUs in the cpumask, because they check for
cpumap->available that will not change after managed IRQs are reserved.

For a managed IRQ, it tends to reserve more than one CPU, based on cpumask in
irq_matrix_reserve_managed. But later when actually allocating CPU for this
IRQ, only one CPU is allocated. Because "available" is calculated at the time
managed IRQ is reserved, it tends to indicate a CPU has more IRQs than the actual
number it's assigned.

To get a more even distribution for allocating managed IRQs, we need to keep track
of how many of them are allocated on a given CPU. Introduce "managed_allocated"
in struct cpumap to track those managed IRQs that are allocated on this CPU, and
change the code to use this information for deciding how to allocate CPU for
managed IRQs.

Signed-off-by: Long Li <longli@microsoft.com>
---
 kernel/irq/matrix.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 6e6d467f3dec..94dd173f24d6 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -14,6 +14,7 @@ struct cpumap {
 	unsigned int		available;
 	unsigned int		allocated;
 	unsigned int		managed;
+	unsigned int		managed_allocated;
 	bool			initialized;
 	bool			online;
 	unsigned long		alloc_map[IRQ_MATRIX_SIZE];
@@ -145,6 +146,27 @@ static unsigned int matrix_find_best_cpu(struct irq_matrix *m,
 	return best_cpu;
 }
 
+/* Find the best CPU which has the lowest number of managed IRQs allocated */
+static unsigned int matrix_find_best_cpu_managed(struct irq_matrix *m,
+						const struct cpumask *msk)
+{
+	unsigned int cpu, best_cpu, allocated = UINT_MAX;
+	struct cpumap *cm;
+
+	best_cpu = UINT_MAX;
+
+	for_each_cpu(cpu, msk) {
+		cm = per_cpu_ptr(m->maps, cpu);
+
+		if (!cm->online || cm->managed_allocated > allocated)
+			continue;
+
+		best_cpu = cpu;
+		allocated = cm->managed_allocated;
+	}
+	return best_cpu;
+}
+
 /**
  * irq_matrix_assign_system - Assign system wide entry in the matrix
  * @m:		Matrix pointer
@@ -269,7 +291,7 @@ int irq_matrix_alloc_managed(struct irq_matrix *m, const struct cpumask *msk,
 	if (cpumask_empty(msk))
 		return -EINVAL;
 
-	cpu = matrix_find_best_cpu(m, msk);
+	cpu = matrix_find_best_cpu_managed(m, msk);
 	if (cpu == UINT_MAX)
 		return -ENOSPC;
 
@@ -282,6 +304,7 @@ int irq_matrix_alloc_managed(struct irq_matrix *m, const struct cpumask *msk,
 		return -ENOSPC;
 	set_bit(bit, cm->alloc_map);
 	cm->allocated++;
+	cm->managed_allocated++;
 	m->total_allocated++;
 	*mapped_cpu = cpu;
 	trace_irq_matrix_alloc_managed(bit, cpu, m, cm);
-- 
2.14.1

