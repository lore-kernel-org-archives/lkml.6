Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752509AbeDFVyt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 17:54:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41785 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751679AbeDFVys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 17:54:48 -0400
Date: Fri, 6 Apr 2018 14:54:20 -0700
From: tip-bot for Ming Lei <tipbot@zytor.com>
Message-ID: <tip-d3056812e7dfe6bf4f8ad9e397a9116dd5d32d15@git.kernel.org>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org, hch@infradead.org,
        mingo@kernel.org, tglx@linutronix.de, axboe@kernel.dk,
        loberman@redhat.com, hch@lst.de, ming.lei@redhat.com
Reply-To: ming.lei@redhat.com, loberman@redhat.com, hch@lst.de,
        axboe@kernel.dk, tglx@linutronix.de, mingo@kernel.org,
        hch@infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20180308105358.1506-5-ming.lei@redhat.com>
References: <20180308105358.1506-5-ming.lei@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/affinity: Spread irq vectors among present
 CPUs as far as possible
Git-Commit-ID: d3056812e7dfe6bf4f8ad9e397a9116dd5d32d15
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d3056812e7dfe6bf4f8ad9e397a9116dd5d32d15
Gitweb:     https://git.kernel.org/tip/d3056812e7dfe6bf4f8ad9e397a9116dd5d32d15
Author:     Ming Lei <ming.lei@redhat.com>
AuthorDate: Thu, 8 Mar 2018 18:53:58 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 6 Apr 2018 12:19:51 +0200

genirq/affinity: Spread irq vectors among present CPUs as far as possible

Commit 84676c1f21 ("genirq/affinity: assign vectors to all possible CPUs")
tried to spread the interrupts accross all possible CPUs to make sure that
in case of phsyical hotplug (e.g. virtualization) the CPUs which get
plugged in after the device was initialized are targeted by a hardware
queue and the corresponding interrupt.

This has a downside in cases where the ACPI tables claim that there are
more possible CPUs than present CPUs and the number of interrupts to spread
out is smaller than the number of possible CPUs. These bogus ACPI tables
are unfortunately not uncommon.

In such a case the vector spreading algorithm assigns interrupts to CPUs
which can never be utilized and as a consequence these interrupts are
unused instead of being mapped to present CPUs. As a result the performance
of the device is suboptimal.

To fix this spread the interrupt vectors in two stages:

 1) Spread as many interrupts as possible among the present CPUs

 2) Spread the remaining vectors among non present CPUs

On a 8 core system, where CPU 0-3 are present and CPU 4-7 are not present,
for a device with 4 queues the resulting interrupt affinity is:

  1) Before 84676c1f21 ("genirq/affinity: assign vectors to all possible CPUs")
	irq 39, cpu list 0
	irq 40, cpu list 1
	irq 41, cpu list 2
	irq 42, cpu list 3

  2) With 84676c1f21 ("genirq/affinity: assign vectors to all possible CPUs")
	irq 39, cpu list 0-2
	irq 40, cpu list 3-4,6
	irq 41, cpu list 5
	irq 42, cpu list 7

  3) With the refined vector spread applied:
	irq 39, cpu list 0,4
	irq 40, cpu list 1,6
	irq 41, cpu list 2,5
	irq 42, cpu list 3,7

On a 8 core system, where all CPUs are present the resulting interrupt
affinity for the 4 queues is:

	irq 39, cpu list 0,1
	irq 40, cpu list 2,3
	irq 41, cpu list 4,5
	irq 42, cpu list 6,7

This is independent of the number of CPUs which are online at the point of
initialization because in such a system the offline CPUs can be easily
onlined afterwards, while in non-present CPUs need to be plugged physically
or virtually which requires external interaction.

The downside of this approach is that in case of physical hotplug the
interrupt vector spreading might be suboptimal when CPUs 4-7 are physically
plugged. Suboptimal from a NUMA point of view and due to the single target
nature of interrupt affinities the later plugged CPUs might not be targeted
by interrupts at all.

Though, physical hotplug systems are not the common case while the broken
ACPI table disease is wide spread. So it's preferred to have as many
interrupts as possible utilized at the point where the device is
initialized.

Block multi-queue devices like NVME create a hardware queue per possible
CPU, so the goal of commit 84676c1f21 to assign one interrupt vector per
possible CPU is still achieved even with physical/virtual hotplug.

[ tglx: Changed from online to present CPUs for the first spreading stage,
  	renamed variables for readability sake, added comments and massaged
  	changelog ]

Reported-by: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>
Link: https://lkml.kernel.org/r/20180308105358.1506-5-ming.lei@redhat.com

---
 kernel/irq/affinity.c | 43 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 213695a27ddb..f4f29b9d90ee 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -106,6 +106,9 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
 	int curvec = startvec;
 	nodemask_t nodemsk = NODE_MASK_NONE;
 
+	if (!cpumask_weight(cpu_mask))
+		return 0;
+
 	nodes = get_nodes_in_cpumask(node_to_cpumask, cpu_mask, &nodemsk);
 
 	/*
@@ -173,8 +176,9 @@ out:
 struct cpumask *
 irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 {
-	int curvec, affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
-	cpumask_var_t nmsk, *node_to_cpumask;
+	int affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
+	int curvec, usedvecs;
+	cpumask_var_t nmsk, npresmsk, *node_to_cpumask;
 	struct cpumask *masks = NULL;
 
 	/*
@@ -187,9 +191,12 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
 		return NULL;
 
+	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
+		goto outcpumsk;
+
 	node_to_cpumask = alloc_node_to_cpumask();
 	if (!node_to_cpumask)
-		goto outcpumsk;
+		goto outnpresmsk;
 
 	masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
 	if (!masks)
@@ -202,16 +209,40 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	/* Stabilize the cpumasks */
 	get_online_cpus();
 	build_node_to_cpumask(node_to_cpumask);
-	curvec += irq_build_affinity_masks(affd, curvec, affvecs,
-					   node_to_cpumask, cpu_possible_mask,
-					   nmsk, masks);
+
+	/* Spread on present CPUs starting from affd->pre_vectors */
+	usedvecs = irq_build_affinity_masks(affd, curvec, affvecs,
+					    node_to_cpumask, cpu_present_mask,
+					    nmsk, masks);
+
+	/*
+	 * Spread on non present CPUs starting from the next vector to be
+	 * handled. If the spreading of present CPUs already exhausted the
+	 * vector space, assign the non present CPUs to the already spread
+	 * out vectors.
+	 */
+	if (usedvecs >= affvecs)
+		curvec = affd->pre_vectors;
+	else
+		curvec = affd->pre_vectors + usedvecs;
+	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
+	usedvecs += irq_build_affinity_masks(affd, curvec, affvecs,
+					     node_to_cpumask, npresmsk,
+					     nmsk, masks);
 	put_online_cpus();
 
 	/* Fill out vectors at the end that don't need affinity */
+	if (usedvecs >= affvecs)
+		curvec = affd->pre_vectors + affvecs;
+	else
+		curvec = affd->pre_vectors + usedvecs;
 	for (; curvec < nvecs; curvec++)
 		cpumask_copy(masks + curvec, irq_default_affinity);
+
 outnodemsk:
 	free_node_to_cpumask(node_to_cpumask);
+outnpresmsk:
+	free_cpumask_var(npresmsk);
 outcpumsk:
 	free_cpumask_var(nmsk);
 	return masks;
