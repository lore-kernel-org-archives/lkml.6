Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE460C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 03:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789B920821
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 03:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789B920821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeKAMPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 08:15:54 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:60874
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726095AbeKAMPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 08:15:54 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id I3QdgYPGaWzu3I3QdgTeaL; Wed, 31 Oct 2018 20:13:51 -0700
x-originating-ip: 107.180.71.197
Received: from longli by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <longli@linuxonhyperv2.linuxonhyperv.com>)
        id 1gI3Qd-0001w7-Ff; Wed, 31 Oct 2018 20:13:51 -0700
From:   Long Li <longli@linuxonhyperv.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [Patch v2] genirq/matrix: Choose CPU for assigning interrupts based on allocated IRQs
Date:   Thu,  1 Nov 2018 03:13:32 +0000
Message-Id: <20181101031332.7404-1-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfGO+COburQtBu/4c9c9vRLUUz5BWNQFLHGjnFgH3+AzMe5qXAyQRdyh/2NAWlgUwwumIDJvM0o7svPDcM7kDG5gaEJYLc+RCwO+EtePdqJmwwtNGoMYL
 BqfFPUdP/TeF74GgMwJKDSo7GAOhg9dStlQE65sfYCmx5UZSWKxR0SXCghizexQ5XCCjY7ksTilirDnPDTMTcbchuiusU1WIWhlMevhtj2KSIgFWprR0k199
 GcOHfzvC+F1y2RVl/vxIHh+AYCx6F/V9Mx64fX2ZbfOhLmd1V0YZue2oG8CpsJJPgcQvE/niI6MzO/X6PpAMNRv8E/7esS65LRCj+Gcow1M=
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

In irq_matrix->cpumap, "available" is set when IRQs are allocated earlier
in the IRQ allocation process. This value is caculated based on
1. how many unmanaged IRQs are allocated on this CPU
2. how many managed IRQs are reserved on this CPU

But "available" is not accurate in accouting the real IRQs load on a given CPU.

For a managed IRQ, it tends to reserve more than one CPU, based on cpumask in
irq_matrix_reserve_managed. But later when actually allocating CPU for this
IRQ, only one CPU is allocated. Because "available" is calculated at the time
managed IRQ is reserved, it tends to indicate a CPU has more IRQs than it's
actually assigned.

When a managed IRQ is assigned to a CPU in irq_matrix_alloc_managed(), it
decreases "allocated" based on the actually assignment of this IRQ to this CPU.
Unmanaged IRQ also decreases "allocated" after allocating an IRQ on this CPU.
For this reason, checking "allocated" is more accurate than checking
"available" for a given CPU, and result in a more evenly distributed IRQ
across all CPUs.

Signed-off-by: Long Li <longli@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 kernel/irq/matrix.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 6e6d467f3dec..a51689e3e7c0 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -128,7 +128,7 @@ static unsigned int matrix_alloc_area(struct irq_matrix *m, struct cpumap *cm,
 static unsigned int matrix_find_best_cpu(struct irq_matrix *m,
 					const struct cpumask *msk)
 {
-	unsigned int cpu, best_cpu, maxavl = 0;
+	unsigned int cpu, best_cpu, min_allocated = UINT_MAX;
 	struct cpumap *cm;
 
 	best_cpu = UINT_MAX;
@@ -136,11 +136,11 @@ static unsigned int matrix_find_best_cpu(struct irq_matrix *m,
 	for_each_cpu(cpu, msk) {
 		cm = per_cpu_ptr(m->maps, cpu);
 
-		if (!cm->online || cm->available <= maxavl)
+		if (!cm->online || cm->allocated > min_allocated)
 			continue;
 
 		best_cpu = cpu;
-		maxavl = cm->available;
+		min_allocated = cm->allocated;
 	}
 	return best_cpu;
 }
-- 
2.14.1

