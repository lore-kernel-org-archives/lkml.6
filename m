Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFDCC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 04:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FC420827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 04:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1FC420827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbeKFNYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 08:24:19 -0500
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:52174
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729700AbeKFNYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 08:24:19 -0500
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id JsX9gIe23bOGjJsX9g12Fy; Mon, 05 Nov 2018 21:00:08 -0700
x-originating-ip: 107.180.71.197
Received: from longli by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <longli@linuxonhyperv2.linuxonhyperv.com>)
        id 1gJsX9-00077R-QQ; Mon, 05 Nov 2018 21:00:07 -0700
From:   Long Li <longli@linuxonhyperv.com>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [Patch v4] genirq/matrix: Choose CPU for managed IRQs based on how many of them are allocated
Date:   Tue,  6 Nov 2018 04:00:00 +0000
Message-Id: <20181106040000.27316-1-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfBAqu3DbtyqM5Auuc2Fnrl85M87wdUaFI5f6blHUkWrrufnBjmPeIgd3Zn9Vwql4Zbx32bpoPZEjWYvLXiQ3iMUgm4Ybl/EYTCU6G0afqK2TwZ4F65vn
 Bh6yPE5rlCAMnDGkc/5jWwmShGfjki7euMB2zqRWudBVU9FxIiu2XVlyQTaxvWJdq9mcAQA5fbO0xhm2S1wrDYrawqwQKNtFyS8FR1q3parVdWiLOk8DfU16
 xnMdb9bH9NwK8wMbQevVyLaU1ahgKk8M1MwzX37RwoUhVUZ4Iw6fAsUQyilMCSfE
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
 kernel/irq/matrix.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 6e6d467f3dec..92337703ca9f 100644
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
@@ -395,6 +418,8 @@ void irq_matrix_free(struct irq_matrix *m, unsigned int cpu,
 
 	clear_bit(bit, cm->alloc_map);
 	cm->allocated--;
+	if(managed)
+		cm->managed_allocated--;
 
 	if (cm->online)
 		m->total_allocated--;
@@ -464,13 +489,14 @@ void irq_matrix_debug_show(struct seq_file *sf, struct irq_matrix *m, int ind)
 	seq_printf(sf, "Total allocated:  %6u\n", m->total_allocated);
 	seq_printf(sf, "System: %u: %*pbl\n", nsys, m->matrix_bits,
 		   m->system_map);
-	seq_printf(sf, "%*s| CPU | avl | man | act | vectors\n", ind, " ");
+	seq_printf(sf, "%*s| CPU | avl | man | mac | act | vectors\n", ind, " ");
 	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		struct cpumap *cm = per_cpu_ptr(m->maps, cpu);
 
-		seq_printf(sf, "%*s %4d  %4u  %4u  %4u  %*pbl\n", ind, " ",
-			   cpu, cm->available, cm->managed, cm->allocated,
+		seq_printf(sf, "%*s %4d  %4u  %4u  %4u %4u  %*pbl\n", ind, " ",
+			   cpu, cm->available, cm->managed,
+			   cm->managed_allocated, cm->allocated,
 			   m->matrix_bits, cm->alloc_map);
 	}
 	cpus_read_unlock();
-- 
2.14.1

