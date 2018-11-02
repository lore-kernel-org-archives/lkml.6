Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4E3C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B5F20657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B5F20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbeKCAIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:08:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49014 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727676AbeKCAIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:08:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 835B13082A34;
        Fri,  2 Nov 2018 15:00:54 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 03CAC610C7;
        Fri,  2 Nov 2018 15:00:43 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 2/4] irq: move 2-stage irq spread into one helper
Date:   Fri,  2 Nov 2018 22:59:49 +0800
Message-Id: <20181102145951.31979-3-ming.lei@redhat.com>
In-Reply-To: <20181102145951.31979-1-ming.lei@redhat.com>
References: <20181102145951.31979-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 02 Nov 2018 15:00:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change, and prepare for the following patch to
support allocating (and affinitizing) sets of IRQs.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/irq/affinity.c | 92 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 56 insertions(+), 36 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index f4f29b9d90ee..a16b601604aa 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -94,7 +94,7 @@ static int get_nodes_in_cpumask(cpumask_var_t *node_to_cpumask,
 	return nodes;
 }
 
-static int irq_build_affinity_masks(const struct irq_affinity *affd,
+static int __irq_build_affinity_masks(const struct irq_affinity *affd,
 				    int startvec, int numvecs,
 				    cpumask_var_t *node_to_cpumask,
 				    const struct cpumask *cpu_mask,
@@ -166,6 +166,58 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
 	return done;
 }
 
+/*
+ * build affinity in two stages:
+ *	1) spread present CPU on these vectors
+ *	2) spread other possible CPUs on these vectors
+ */
+static int irq_build_affinity_masks(const struct irq_affinity *affd,
+				    int startvec, int numvecs,
+				    cpumask_var_t *node_to_cpumask,
+				    struct cpumask *masks)
+{
+	int curvec = startvec, usedvecs = -1;
+	cpumask_var_t nmsk, npresmsk;
+
+	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
+			return usedvecs;
+
+	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
+			goto fail;
+
+	/* Stabilize the cpumasks */
+	get_online_cpus();
+	build_node_to_cpumask(node_to_cpumask);
+
+	/* Spread on present CPUs starting from affd->pre_vectors */
+	usedvecs = __irq_build_affinity_masks(affd, curvec, numvecs,
+					    node_to_cpumask, cpu_present_mask,
+					    nmsk, masks);
+
+	/*
+	 * Spread on non present CPUs starting from the next vector to be
+	 * handled. If the spreading of present CPUs already exhausted the
+	 * vector space, assign the non present CPUs to the already spread
+	 * out vectors.
+	 */
+	if (usedvecs >= numvecs)
+		curvec = affd->pre_vectors;
+	else
+		curvec = affd->pre_vectors + usedvecs;
+	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
+	usedvecs += __irq_build_affinity_masks(affd, curvec, numvecs,
+					     node_to_cpumask, npresmsk,
+					     nmsk, masks);
+	put_online_cpus();
+
+	free_cpumask_var(npresmsk);
+
+ fail:
+	free_cpumask_var(nmsk);
+
+	return usedvecs;
+}
+
 /**
  * irq_create_affinity_masks - Create affinity masks for multiqueue spreading
  * @nvecs:	The total number of vectors
@@ -178,7 +230,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 {
 	int affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
 	int curvec, usedvecs;
-	cpumask_var_t nmsk, npresmsk, *node_to_cpumask;
+	cpumask_var_t *node_to_cpumask;
 	struct cpumask *masks = NULL;
 
 	/*
@@ -188,15 +240,9 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	if (nvecs == affd->pre_vectors + affd->post_vectors)
 		return NULL;
 
-	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
-		return NULL;
-
-	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
-		goto outcpumsk;
-
 	node_to_cpumask = alloc_node_to_cpumask();
 	if (!node_to_cpumask)
-		goto outnpresmsk;
+		return NULL;
 
 	masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
 	if (!masks)
@@ -206,30 +252,8 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
 		cpumask_copy(masks + curvec, irq_default_affinity);
 
-	/* Stabilize the cpumasks */
-	get_online_cpus();
-	build_node_to_cpumask(node_to_cpumask);
-
-	/* Spread on present CPUs starting from affd->pre_vectors */
 	usedvecs = irq_build_affinity_masks(affd, curvec, affvecs,
-					    node_to_cpumask, cpu_present_mask,
-					    nmsk, masks);
-
-	/*
-	 * Spread on non present CPUs starting from the next vector to be
-	 * handled. If the spreading of present CPUs already exhausted the
-	 * vector space, assign the non present CPUs to the already spread
-	 * out vectors.
-	 */
-	if (usedvecs >= affvecs)
-		curvec = affd->pre_vectors;
-	else
-		curvec = affd->pre_vectors + usedvecs;
-	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
-	usedvecs += irq_build_affinity_masks(affd, curvec, affvecs,
-					     node_to_cpumask, npresmsk,
-					     nmsk, masks);
-	put_online_cpus();
+					    node_to_cpumask, masks);
 
 	/* Fill out vectors at the end that don't need affinity */
 	if (usedvecs >= affvecs)
@@ -241,10 +265,6 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 
 outnodemsk:
 	free_node_to_cpumask(node_to_cpumask);
-outnpresmsk:
-	free_cpumask_var(npresmsk);
-outcpumsk:
-	free_cpumask_var(nmsk);
 	return masks;
 }
 
-- 
2.9.5

