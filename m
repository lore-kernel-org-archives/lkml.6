Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752034AbeDFVxQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 17:53:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60641 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751442AbeDFVxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 17:53:14 -0400
Date: Fri, 6 Apr 2018 14:52:45 -0700
From: tip-bot for Ming Lei <tipbot@zytor.com>
Message-ID: <tip-47778f33dcba7feb92031643b37e477892f82b62@git.kernel.org>
Cc: ming.lei@redhat.com, hch@infradead.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
        mingo@kernel.org, hch@lst.de, loberman@redhat.com
Reply-To: hch@infradead.org, ming.lei@redhat.com, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
        hch@lst.de, loberman@redhat.com
In-Reply-To: <20180308105358.1506-2-ming.lei@redhat.com>
References: <20180308105358.1506-2-ming.lei@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/affinity: Rename *node_to_possible_cpumask as
 *node_to_cpumask
Git-Commit-ID: 47778f33dcba7feb92031643b37e477892f82b62
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

Commit-ID:  47778f33dcba7feb92031643b37e477892f82b62
Gitweb:     https://git.kernel.org/tip/47778f33dcba7feb92031643b37e477892f82b62
Author:     Ming Lei <ming.lei@redhat.com>
AuthorDate: Thu, 8 Mar 2018 18:53:55 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 6 Apr 2018 12:19:50 +0200

genirq/affinity: Rename *node_to_possible_cpumask as *node_to_cpumask

The following patches will introduce two stage irq spreading for improving
irq spread on all possible CPUs.

No functional change.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: Laurence Oberman <loberman@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>
Link: https://lkml.kernel.org/r/20180308105358.1506-2-ming.lei@redhat.com

---
 kernel/irq/affinity.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index e0665549af59..272c968d9ef1 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -39,7 +39,7 @@ static void irq_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 	}
 }
 
-static cpumask_var_t *alloc_node_to_possible_cpumask(void)
+static cpumask_var_t *alloc_node_to_cpumask(void)
 {
 	cpumask_var_t *masks;
 	int node;
@@ -62,7 +62,7 @@ out_unwind:
 	return NULL;
 }
 
-static void free_node_to_possible_cpumask(cpumask_var_t *masks)
+static void free_node_to_cpumask(cpumask_var_t *masks)
 {
 	int node;
 
@@ -71,7 +71,7 @@ static void free_node_to_possible_cpumask(cpumask_var_t *masks)
 	kfree(masks);
 }
 
-static void build_node_to_possible_cpumask(cpumask_var_t *masks)
+static void build_node_to_cpumask(cpumask_var_t *masks)
 {
 	int cpu;
 
@@ -79,14 +79,14 @@ static void build_node_to_possible_cpumask(cpumask_var_t *masks)
 		cpumask_set_cpu(cpu, masks[cpu_to_node(cpu)]);
 }
 
-static int get_nodes_in_cpumask(cpumask_var_t *node_to_possible_cpumask,
+static int get_nodes_in_cpumask(cpumask_var_t *node_to_cpumask,
 				const struct cpumask *mask, nodemask_t *nodemsk)
 {
 	int n, nodes = 0;
 
 	/* Calculate the number of nodes in the supplied affinity mask */
 	for_each_node(n) {
-		if (cpumask_intersects(mask, node_to_possible_cpumask[n])) {
+		if (cpumask_intersects(mask, node_to_cpumask[n])) {
 			node_set(n, *nodemsk);
 			nodes++;
 		}
@@ -109,7 +109,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	int last_affv = affv + affd->pre_vectors;
 	nodemask_t nodemsk = NODE_MASK_NONE;
 	struct cpumask *masks = NULL;
-	cpumask_var_t nmsk, *node_to_possible_cpumask;
+	cpumask_var_t nmsk, *node_to_cpumask;
 
 	/*
 	 * If there aren't any vectors left after applying the pre/post
@@ -121,8 +121,8 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
 		return NULL;
 
-	node_to_possible_cpumask = alloc_node_to_possible_cpumask();
-	if (!node_to_possible_cpumask)
+	node_to_cpumask = alloc_node_to_cpumask();
+	if (!node_to_cpumask)
 		goto outcpumsk;
 
 	masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
@@ -135,8 +135,8 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 
 	/* Stabilize the cpumasks */
 	get_online_cpus();
-	build_node_to_possible_cpumask(node_to_possible_cpumask);
-	nodes = get_nodes_in_cpumask(node_to_possible_cpumask, cpu_possible_mask,
+	build_node_to_cpumask(node_to_cpumask);
+	nodes = get_nodes_in_cpumask(node_to_cpumask, cpu_possible_mask,
 				     &nodemsk);
 
 	/*
@@ -146,7 +146,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	if (affv <= nodes) {
 		for_each_node_mask(n, nodemsk) {
 			cpumask_copy(masks + curvec,
-				     node_to_possible_cpumask[n]);
+				     node_to_cpumask[n]);
 			if (++curvec == last_affv)
 				break;
 		}
@@ -160,7 +160,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 		vecs_per_node = (affv - (curvec - affd->pre_vectors)) / nodes;
 
 		/* Get the cpus on this node which are in the mask */
-		cpumask_and(nmsk, cpu_possible_mask, node_to_possible_cpumask[n]);
+		cpumask_and(nmsk, cpu_possible_mask, node_to_cpumask[n]);
 
 		/* Calculate the number of cpus per vector */
 		ncpus = cpumask_weight(nmsk);
@@ -193,7 +193,7 @@ done:
 	for (; curvec < nvecs; curvec++)
 		cpumask_copy(masks + curvec, irq_default_affinity);
 outnodemsk:
-	free_node_to_possible_cpumask(node_to_possible_cpumask);
+	free_node_to_cpumask(node_to_cpumask);
 outcpumsk:
 	free_cpumask_var(nmsk);
 	return masks;
