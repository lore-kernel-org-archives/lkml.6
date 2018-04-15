Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751789AbeDOHue (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 03:50:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45223 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751039AbeDOHud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 03:50:33 -0400
Date: Sun, 15 Apr 2018 09:50:28 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] irq updates for 4.17
Message-ID: <alpine.DEB.2.21.1804150943330.2633@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-for-linus

Another set of updates for the irq core:

  - Fix error path handling in the affinity spreading code

  - Make affinity spreading smarter to avoid issues on systems which claim
    to have hotpluggable CPUs while in fact they can't hotplug anything. So
    instead of trying to spread the vectors (and thereby the associated
    device queues) to all possibe CPUs, spread them on all present CPUs
    first. If there are left over vectors after that first step they are
    spread among the possible, but not present CPUs which keeps the code
    backwards compatible for virtual decives and NVME which allocate a
    queue per possible CPU, but makes the spreading smarter for devices
    which have less queues than possible or present CPUs.

Thanks,

	tglx

------------------>
Ming Lei (4):
      genirq/affinity: Rename *node_to_possible_cpumask as *node_to_cpumask
      genirq/affinity: Move actual irq vector spreading into a helper function
      genirq/affinity: Allow irq spreading from a given starting point
      genirq/affinity: Spread irq vectors among present CPUs as far as possible

Thomas Gleixner (1):
      genirq/affinity: Don't return with empty affinity masks on error


 kernel/irq/affinity.c | 162 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 106 insertions(+), 56 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index a37a3b4b6342..f4f29b9d90ee 100644
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
@@ -62,7 +62,7 @@ static cpumask_var_t *alloc_node_to_possible_cpumask(void)
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
@@ -94,73 +94,46 @@ static int get_nodes_in_cpumask(cpumask_var_t *node_to_possible_cpumask,
 	return nodes;
 }
 
-/**
- * irq_create_affinity_masks - Create affinity masks for multiqueue spreading
- * @nvecs:	The total number of vectors
- * @affd:	Description of the affinity requirements
- *
- * Returns the masks pointer or NULL if allocation failed.
- */
-struct cpumask *
-irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
+static int irq_build_affinity_masks(const struct irq_affinity *affd,
+				    int startvec, int numvecs,
+				    cpumask_var_t *node_to_cpumask,
+				    const struct cpumask *cpu_mask,
+				    struct cpumask *nmsk,
+				    struct cpumask *masks)
 {
-	int n, nodes, cpus_per_vec, extra_vecs, curvec;
-	int affv = nvecs - affd->pre_vectors - affd->post_vectors;
-	int last_affv = affv + affd->pre_vectors;
+	int n, nodes, cpus_per_vec, extra_vecs, done = 0;
+	int last_affv = affd->pre_vectors + numvecs;
+	int curvec = startvec;
 	nodemask_t nodemsk = NODE_MASK_NONE;
-	struct cpumask *masks;
-	cpumask_var_t nmsk, *node_to_possible_cpumask;
-
-	/*
-	 * If there aren't any vectors left after applying the pre/post
-	 * vectors don't bother with assigning affinity.
-	 */
-	if (!affv)
-		return NULL;
-
-	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
-		return NULL;
-
-	masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
-	if (!masks)
-		goto out;
 
-	node_to_possible_cpumask = alloc_node_to_possible_cpumask();
-	if (!node_to_possible_cpumask)
-		goto out;
+	if (!cpumask_weight(cpu_mask))
+		return 0;
 
-	/* Fill out vectors at the beginning that don't need affinity */
-	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
-		cpumask_copy(masks + curvec, irq_default_affinity);
-
-	/* Stabilize the cpumasks */
-	get_online_cpus();
-	build_node_to_possible_cpumask(node_to_possible_cpumask);
-	nodes = get_nodes_in_cpumask(node_to_possible_cpumask, cpu_possible_mask,
-				     &nodemsk);
+	nodes = get_nodes_in_cpumask(node_to_cpumask, cpu_mask, &nodemsk);
 
 	/*
 	 * If the number of nodes in the mask is greater than or equal the
 	 * number of vectors we just spread the vectors across the nodes.
 	 */
-	if (affv <= nodes) {
+	if (numvecs <= nodes) {
 		for_each_node_mask(n, nodemsk) {
-			cpumask_copy(masks + curvec,
-				     node_to_possible_cpumask[n]);
-			if (++curvec == last_affv)
+			cpumask_copy(masks + curvec, node_to_cpumask[n]);
+			if (++done == numvecs)
 				break;
+			if (++curvec == last_affv)
+				curvec = affd->pre_vectors;
 		}
-		goto done;
+		goto out;
 	}
 
 	for_each_node_mask(n, nodemsk) {
 		int ncpus, v, vecs_to_assign, vecs_per_node;
 
 		/* Spread the vectors per node */
-		vecs_per_node = (affv - (curvec - affd->pre_vectors)) / nodes;
+		vecs_per_node = (numvecs - (curvec - affd->pre_vectors)) / nodes;
 
 		/* Get the cpus on this node which are in the mask */
-		cpumask_and(nmsk, cpu_possible_mask, node_to_possible_cpumask[n]);
+		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
 
 		/* Calculate the number of cpus per vector */
 		ncpus = cpumask_weight(nmsk);
@@ -181,19 +154,96 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 			irq_spread_init_one(masks + curvec, nmsk, cpus_per_vec);
 		}
 
-		if (curvec >= last_affv)
+		done += v;
+		if (done >= numvecs)
 			break;
+		if (curvec >= last_affv)
+			curvec = affd->pre_vectors;
 		--nodes;
 	}
 
-done:
+out:
+	return done;
+}
+
+/**
+ * irq_create_affinity_masks - Create affinity masks for multiqueue spreading
+ * @nvecs:	The total number of vectors
+ * @affd:	Description of the affinity requirements
+ *
+ * Returns the masks pointer or NULL if allocation failed.
+ */
+struct cpumask *
+irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
+{
+	int affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
+	int curvec, usedvecs;
+	cpumask_var_t nmsk, npresmsk, *node_to_cpumask;
+	struct cpumask *masks = NULL;
+
+	/*
+	 * If there aren't any vectors left after applying the pre/post
+	 * vectors don't bother with assigning affinity.
+	 */
+	if (nvecs == affd->pre_vectors + affd->post_vectors)
+		return NULL;
+
+	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
+		return NULL;
+
+	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
+		goto outcpumsk;
+
+	node_to_cpumask = alloc_node_to_cpumask();
+	if (!node_to_cpumask)
+		goto outnpresmsk;
+
+	masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
+	if (!masks)
+		goto outnodemsk;
+
+	/* Fill out vectors at the beginning that don't need affinity */
+	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
+		cpumask_copy(masks + curvec, irq_default_affinity);
+
+	/* Stabilize the cpumasks */
+	get_online_cpus();
+	build_node_to_cpumask(node_to_cpumask);
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
-	free_node_to_possible_cpumask(node_to_possible_cpumask);
-out:
+
+outnodemsk:
+	free_node_to_cpumask(node_to_cpumask);
+outnpresmsk:
+	free_cpumask_var(npresmsk);
+outcpumsk:
 	free_cpumask_var(nmsk);
 	return masks;
 }
