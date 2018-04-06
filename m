Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752312AbeDFVyU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 17:54:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56497 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbeDFVyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 17:54:19 -0400
Date: Fri, 6 Apr 2018 14:53:51 -0700
From: tip-bot for Ming Lei <tipbot@zytor.com>
Message-ID: <tip-1a2d0914e23aab386f5d5acb689777e24151c2c8@git.kernel.org>
Cc: axboe@kernel.dk, mingo@kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, hpa@zytor.com, ming.lei@redhat.com, hch@lst.de,
        loberman@redhat.com, tglx@linutronix.de
Reply-To: loberman@redhat.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk, ming.lei@redhat.com,
        hch@lst.de, hpa@zytor.com, hch@infradead.org
In-Reply-To: <20180308105358.1506-4-ming.lei@redhat.com>
References: <20180308105358.1506-4-ming.lei@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/affinity: Allow irq spreading from a given
 starting point
Git-Commit-ID: 1a2d0914e23aab386f5d5acb689777e24151c2c8
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

Commit-ID:  1a2d0914e23aab386f5d5acb689777e24151c2c8
Gitweb:     https://git.kernel.org/tip/1a2d0914e23aab386f5d5acb689777e24151c2c8
Author:     Ming Lei <ming.lei@redhat.com>
AuthorDate: Thu, 8 Mar 2018 18:53:57 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 6 Apr 2018 12:19:51 +0200

genirq/affinity: Allow irq spreading from a given starting point

To support two stage irq vector spreading, it's required to add a starting
point to the spreading function. No functional change, just preparatory
work for the actual two stage change.

[ tglx: Renamed variables, tidied up the code and massaged changelog ]

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: Laurence Oberman <loberman@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>
Link: https://lkml.kernel.org/r/20180308105358.1506-4-ming.lei@redhat.com

---
 kernel/irq/affinity.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index a9c36904500c..213695a27ddb 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -94,17 +94,17 @@ static int get_nodes_in_cpumask(cpumask_var_t *node_to_cpumask,
 	return nodes;
 }
 
-static int irq_build_affinity_masks(int nvecs, const struct irq_affinity *affd,
+static int irq_build_affinity_masks(const struct irq_affinity *affd,
+				    int startvec, int numvecs,
 				    cpumask_var_t *node_to_cpumask,
 				    const struct cpumask *cpu_mask,
 				    struct cpumask *nmsk,
 				    struct cpumask *masks)
 {
-	int affv = nvecs - affd->pre_vectors - affd->post_vectors;
-	int last_affv = affv + affd->pre_vectors;
-	int curvec = affd->pre_vectors;
+	int n, nodes, cpus_per_vec, extra_vecs, done = 0;
+	int last_affv = affd->pre_vectors + numvecs;
+	int curvec = startvec;
 	nodemask_t nodemsk = NODE_MASK_NONE;
-	int n, nodes, cpus_per_vec, extra_vecs;
 
 	nodes = get_nodes_in_cpumask(node_to_cpumask, cpu_mask, &nodemsk);
 
@@ -112,12 +112,13 @@ static int irq_build_affinity_masks(int nvecs, const struct irq_affinity *affd,
 	 * If the number of nodes in the mask is greater than or equal the
 	 * number of vectors we just spread the vectors across the nodes.
 	 */
-	if (affv <= nodes) {
+	if (numvecs <= nodes) {
 		for_each_node_mask(n, nodemsk) {
-			cpumask_copy(masks + curvec,
-				     node_to_cpumask[n]);
-			if (++curvec == last_affv)
+			cpumask_copy(masks + curvec, node_to_cpumask[n]);
+			if (++done == numvecs)
 				break;
+			if (++curvec == last_affv)
+				curvec = affd->pre_vectors;
 		}
 		goto out;
 	}
@@ -126,7 +127,7 @@ static int irq_build_affinity_masks(int nvecs, const struct irq_affinity *affd,
 		int ncpus, v, vecs_to_assign, vecs_per_node;
 
 		/* Spread the vectors per node */
-		vecs_per_node = (affv - (curvec - affd->pre_vectors)) / nodes;
+		vecs_per_node = (numvecs - (curvec - affd->pre_vectors)) / nodes;
 
 		/* Get the cpus on this node which are in the mask */
 		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
@@ -150,13 +151,16 @@ static int irq_build_affinity_masks(int nvecs, const struct irq_affinity *affd,
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
 
 out:
-	return curvec - affd->pre_vectors;
+	return done;
 }
 
 /**
@@ -169,9 +173,9 @@ out:
 struct cpumask *
 irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 {
+	int curvec, affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
 	cpumask_var_t nmsk, *node_to_cpumask;
 	struct cpumask *masks = NULL;
-	int curvec;
 
 	/*
 	 * If there aren't any vectors left after applying the pre/post
@@ -198,8 +202,9 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	/* Stabilize the cpumasks */
 	get_online_cpus();
 	build_node_to_cpumask(node_to_cpumask);
-	curvec += irq_build_affinity_masks(nvecs, affd, node_to_cpumask,
-					   cpu_possible_mask, nmsk, masks);
+	curvec += irq_build_affinity_masks(affd, curvec, affvecs,
+					   node_to_cpumask, cpu_possible_mask,
+					   nmsk, masks);
 	put_online_cpus();
 
 	/* Fill out vectors at the end that don't need affinity */
