Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09856C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD70F2083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD70F2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbeKGHz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:55:28 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37821 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbeKGHz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:55:28 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA6MRr1H986470
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Nov 2018 14:27:53 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA6MRrGc986467;
        Tue, 6 Nov 2018 14:27:53 -0800
Date:   Tue, 6 Nov 2018 14:27:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Long Li <tipbot@zytor.com>
Message-ID: <tip-e8da8794a7fd9eef1ec9a07f0d4897c68581c72b@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@kernel.org, longli@microsoft.com, mikelley@microsoft.com
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, hpa@zytor.com, mikelley@microsoft.com,
          longli@microsoft.com
In-Reply-To: <20181106040000.27316-1-longli@linuxonhyperv.com>
References: <20181106040000.27316-1-longli@linuxonhyperv.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/matrix: Improve target CPU selection for
 managed interrupts.
Git-Commit-ID: e8da8794a7fd9eef1ec9a07f0d4897c68581c72b
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

Commit-ID:  e8da8794a7fd9eef1ec9a07f0d4897c68581c72b
Gitweb:     https://git.kernel.org/tip/e8da8794a7fd9eef1ec9a07f0d4897c68581c72b
Author:     Long Li <longli@microsoft.com>
AuthorDate: Tue, 6 Nov 2018 04:00:00 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 6 Nov 2018 23:20:13 +0100

genirq/matrix: Improve target CPU selection for managed interrupts.

On large systems with multiple devices of the same class (e.g. NVMe disks,
using managed interrupts), the kernel can affinitize these interrupts to a
small subset of CPUs instead of spreading them out evenly.

irq_matrix_alloc_managed() tries to select the CPU in the supplied cpumask
of possible target CPUs which has the lowest number of interrupt vectors
allocated.

This is done by searching the CPU with the highest number of available
vectors. While this is correct for non-managed CPUs it can select the wrong
CPU for managed interrupts. Under certain constellations this results in
affinitizing the managed interrupts of several devices to a single CPU in
a set.

The book keeping of available vectors works the following way:

 1) Non-managed interrupts:

    available is decremented when the interrupt is actually requested by
    the device driver and a vector is assigned. It's incremented when the
    interrupt and the vector are freed.

 2) Managed interrupts:

    Managed interrupts guarantee vector reservation when the MSI/MSI-X
    functionality of a device is enabled, which is achieved by reserving
    vectors in the bitmaps of the possible target CPUs. This reservation
    decrements the available count on each possible target CPU.

    When the interrupt is requested by the device driver then a vector is
    allocated from the reserved region. The operation is reversed when the
    interrupt is freed by the device driver. Neither of these operations
    affect the available count.

    The reservation persist up to the point where the MSI/MSI-X
    functionality is disabled and only this operation increments the
    available count again.

For non-managed interrupts the available count is the correct selection
criterion because the guaranteed reservations need to be taken into
account. Using the allocated counter could lead to a failing allocation in
the following situation (total vector space of 10 assumed):

		 CPU0	CPU1
 available:	    2	   0
 allocated:	    5	   3   <--- CPU1 is selected, but available space = 0
 managed reserved:  3	   7

 while available yields the correct result.

For managed interrupts the available count is not the appropriate
selection criterion because as explained above the available count is not
affected by the actual vector allocation.

The following example illustrates that. Total vector space of 10
assumed. The starting point is:

		 CPU0	CPU1
 available:	    5	   4
 allocated:	    2	   3
 managed reserved:  3	   3

 Allocating vectors for three non-managed interrupts will result in
 affinitizing the first two to CPU0 and the third one to CPU1 because the
 available count is adjusted with each allocation:

		  CPU0	CPU1
 available:	     5	   4	<- Select CPU0 for 1st allocation
 --> allocated:	     3	   3

 available:	     4	   4	<- Select CPU0 for 2nd allocation
 --> allocated:	     4	   3

 available:	     3	   4	<- Select CPU1 for 3rd allocation
 --> allocated:	     4	   4

 But the allocation of three managed interrupts starting from the same
 point will affinitize all of them to CPU0 because the available count is
 not affected by the allocation (see above). So the end result is:

		  CPU0	CPU1
 available:	     5	   4
 allocated:	     5	   3

Introduce a "managed_allocated" field in struct cpumap to track the vector
allocation for managed interrupts separately. Use this information to
select the target CPU when a vector is allocated for a managed interrupt,
which results in more evenly distributed vector assignments. The above
example results in the following allocations:

		 CPU0	CPU1
 managed_allocated: 0	   0	<- Select CPU0 for 1st allocation
 --> allocated:	    3	   3

 managed_allocated: 1	   0	<- Select CPU1 for 2nd allocation
 --> allocated:	    3	   4

 managed_allocated: 1	   1	<- Select CPU0 for 3rd allocation
 --> allocated:	    4	   4

The allocation of non-managed interrupts is not affected by this change and
is still evaluating the available count.

The overall distribution of interrupt vectors for both types of interrupts
might still not be perfectly even depending on the number of non-managed
and managed interrupts in a system, but due to the reservation guarantee
for managed interrupts this cannot be avoided.

Expose the new field in debugfs as well.

[ tglx: Clarified the background of the problem in the changelog and
  	described it independent of NVME ]

Signed-off-by: Long Li <longli@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Kelley <mikelley@microsoft.com>
Link: https://lkml.kernel.org/r/20181106040000.27316-1-longli@linuxonhyperv.com
---
 kernel/irq/matrix.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 1f0985adf193..30cc217b8631 100644
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
