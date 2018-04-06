Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752202AbeDFVxt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 17:53:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57971 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbeDFVxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 17:53:48 -0400
Date: Fri, 6 Apr 2018 14:53:20 -0700
From: tip-bot for Ming Lei <tipbot@zytor.com>
Message-ID: <tip-b3e6aaa8d94d618e685c4df08bef991a4fb43923@git.kernel.org>
Cc: mingo@kernel.org, hch@lst.de, loberman@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, ming.lei@redhat.com,
        axboe@kernel.dk, tglx@linutronix.de, hch@infradead.org
Reply-To: loberman@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        hch@lst.de, axboe@kernel.dk, hpa@zytor.com, ming.lei@redhat.com,
        hch@infradead.org, tglx@linutronix.de
In-Reply-To: <20180308105358.1506-3-ming.lei@redhat.com>
References: <20180308105358.1506-3-ming.lei@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/affinity: Move actual irq vector spreading
 into a helper function
Git-Commit-ID: b3e6aaa8d94d618e685c4df08bef991a4fb43923
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

Commit-ID:  b3e6aaa8d94d618e685c4df08bef991a4fb43923
Gitweb:     https://git.kernel.org/tip/b3e6aaa8d94d618e685c4df08bef991a4fb43923
Author:     Ming Lei <ming.lei@redhat.com>
AuthorDate: Thu, 8 Mar 2018 18:53:56 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 6 Apr 2018 12:19:51 +0200

genirq/affinity: Move actual irq vector spreading into a helper function

No functional change, just prepare for converting to 2-stage irq vector
spreading.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: Laurence Oberman <loberman@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>
Link: https://lkml.kernel.org/r/20180308105358.1506-3-ming.lei@redhat.com

---
 kernel/irq/affinity.c | 97 +++++++++++++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 42 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 272c968d9ef1..a9c36904500c 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -94,50 +94,19 @@ static int get_nodes_in_cpumask(cpumask_var_t *node_to_cpumask,
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
+static int irq_build_affinity_masks(int nvecs, const struct irq_affinity *affd,
+				    cpumask_var_t *node_to_cpumask,
+				    const struct cpumask *cpu_mask,
+				    struct cpumask *nmsk,
+				    struct cpumask *masks)
 {
-	int n, nodes, cpus_per_vec, extra_vecs, curvec;
 	int affv = nvecs - affd->pre_vectors - affd->post_vectors;
 	int last_affv = affv + affd->pre_vectors;
+	int curvec = affd->pre_vectors;
 	nodemask_t nodemsk = NODE_MASK_NONE;
-	struct cpumask *masks = NULL;
-	cpumask_var_t nmsk, *node_to_cpumask;
+	int n, nodes, cpus_per_vec, extra_vecs;
 
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
-	node_to_cpumask = alloc_node_to_cpumask();
-	if (!node_to_cpumask)
-		goto outcpumsk;
-
-	masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
-	if (!masks)
-		goto outnodemsk;
-
-	/* Fill out vectors at the beginning that don't need affinity */
-	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
-		cpumask_copy(masks + curvec, irq_default_affinity);
-
-	/* Stabilize the cpumasks */
-	get_online_cpus();
-	build_node_to_cpumask(node_to_cpumask);
-	nodes = get_nodes_in_cpumask(node_to_cpumask, cpu_possible_mask,
-				     &nodemsk);
+	nodes = get_nodes_in_cpumask(node_to_cpumask, cpu_mask, &nodemsk);
 
 	/*
 	 * If the number of nodes in the mask is greater than or equal the
@@ -150,7 +119,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 			if (++curvec == last_affv)
 				break;
 		}
-		goto done;
+		goto out;
 	}
 
 	for_each_node_mask(n, nodemsk) {
@@ -160,7 +129,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 		vecs_per_node = (affv - (curvec - affd->pre_vectors)) / nodes;
 
 		/* Get the cpus on this node which are in the mask */
-		cpumask_and(nmsk, cpu_possible_mask, node_to_cpumask[n]);
+		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
 
 		/* Calculate the number of cpus per vector */
 		ncpus = cpumask_weight(nmsk);
@@ -186,7 +155,51 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 		--nodes;
 	}
 
-done:
+out:
+	return curvec - affd->pre_vectors;
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
+	cpumask_var_t nmsk, *node_to_cpumask;
+	struct cpumask *masks = NULL;
+	int curvec;
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
+	node_to_cpumask = alloc_node_to_cpumask();
+	if (!node_to_cpumask)
+		goto outcpumsk;
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
+	curvec += irq_build_affinity_masks(nvecs, affd, node_to_cpumask,
+					   cpu_possible_mask, nmsk, masks);
 	put_online_cpus();
 
 	/* Fill out vectors at the end that don't need affinity */
