Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA8FECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC91206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC91206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388353AbeGPIG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:06:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47422 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbeGPIG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:06:59 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 98367C03;
        Mon, 16 Jul 2018 07:40:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 25/54] genirq/affinity: assign vectors to all possible CPUs
Date:   Mon, 16 Jul 2018 09:35:22 +0200
Message-Id: <20180716073455.651185977@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073450.534886211@linuxfoundation.org>
References: <20180716073450.534886211@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

commit 84676c1f21e8ff54befe985f4f14dc1edc10046b upstream.

Currently we assign managed interrupt vectors to all present CPUs.  This
works fine for systems were we only online/offline CPUs.  But in case of
systems that support physical CPU hotplug (or the virtualized version of
it) this means the additional CPUs covered for in the ACPI tables or on
the command line are not catered for.  To fix this we'd either need to
introduce new hotplug CPU states just for this case, or we can start
assining vectors to possible but not present CPUs.

Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Tested-by: Stefan Haberland <sth@linux.vnet.ibm.com>
Fixes: 4b855ad37194 ("blk-mq: Create hctx for each present CPU")
Cc: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/irq/affinity.c |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -39,7 +39,7 @@ static void irq_spread_init_one(struct c
 	}
 }
 
-static cpumask_var_t *alloc_node_to_present_cpumask(void)
+static cpumask_var_t *alloc_node_to_possible_cpumask(void)
 {
 	cpumask_var_t *masks;
 	int node;
@@ -62,7 +62,7 @@ out_unwind:
 	return NULL;
 }
 
-static void free_node_to_present_cpumask(cpumask_var_t *masks)
+static void free_node_to_possible_cpumask(cpumask_var_t *masks)
 {
 	int node;
 
@@ -71,22 +71,22 @@ static void free_node_to_present_cpumask
 	kfree(masks);
 }
 
-static void build_node_to_present_cpumask(cpumask_var_t *masks)
+static void build_node_to_possible_cpumask(cpumask_var_t *masks)
 {
 	int cpu;
 
-	for_each_present_cpu(cpu)
+	for_each_possible_cpu(cpu)
 		cpumask_set_cpu(cpu, masks[cpu_to_node(cpu)]);
 }
 
-static int get_nodes_in_cpumask(cpumask_var_t *node_to_present_cpumask,
+static int get_nodes_in_cpumask(cpumask_var_t *node_to_possible_cpumask,
 				const struct cpumask *mask, nodemask_t *nodemsk)
 {
 	int n, nodes = 0;
 
 	/* Calculate the number of nodes in the supplied affinity mask */
 	for_each_node(n) {
-		if (cpumask_intersects(mask, node_to_present_cpumask[n])) {
+		if (cpumask_intersects(mask, node_to_possible_cpumask[n])) {
 			node_set(n, *nodemsk);
 			nodes++;
 		}
@@ -109,7 +109,7 @@ irq_create_affinity_masks(int nvecs, con
 	int last_affv = affv + affd->pre_vectors;
 	nodemask_t nodemsk = NODE_MASK_NONE;
 	struct cpumask *masks;
-	cpumask_var_t nmsk, *node_to_present_cpumask;
+	cpumask_var_t nmsk, *node_to_possible_cpumask;
 
 	/*
 	 * If there aren't any vectors left after applying the pre/post
@@ -125,8 +125,8 @@ irq_create_affinity_masks(int nvecs, con
 	if (!masks)
 		goto out;
 
-	node_to_present_cpumask = alloc_node_to_present_cpumask();
-	if (!node_to_present_cpumask)
+	node_to_possible_cpumask = alloc_node_to_possible_cpumask();
+	if (!node_to_possible_cpumask)
 		goto out;
 
 	/* Fill out vectors at the beginning that don't need affinity */
@@ -135,8 +135,8 @@ irq_create_affinity_masks(int nvecs, con
 
 	/* Stabilize the cpumasks */
 	get_online_cpus();
-	build_node_to_present_cpumask(node_to_present_cpumask);
-	nodes = get_nodes_in_cpumask(node_to_present_cpumask, cpu_present_mask,
+	build_node_to_possible_cpumask(node_to_possible_cpumask);
+	nodes = get_nodes_in_cpumask(node_to_possible_cpumask, cpu_possible_mask,
 				     &nodemsk);
 
 	/*
@@ -146,7 +146,7 @@ irq_create_affinity_masks(int nvecs, con
 	if (affv <= nodes) {
 		for_each_node_mask(n, nodemsk) {
 			cpumask_copy(masks + curvec,
-				     node_to_present_cpumask[n]);
+				     node_to_possible_cpumask[n]);
 			if (++curvec == last_affv)
 				break;
 		}
@@ -160,7 +160,7 @@ irq_create_affinity_masks(int nvecs, con
 		vecs_per_node = (affv - (curvec - affd->pre_vectors)) / nodes;
 
 		/* Get the cpus on this node which are in the mask */
-		cpumask_and(nmsk, cpu_present_mask, node_to_present_cpumask[n]);
+		cpumask_and(nmsk, cpu_possible_mask, node_to_possible_cpumask[n]);
 
 		/* Calculate the number of cpus per vector */
 		ncpus = cpumask_weight(nmsk);
@@ -192,7 +192,7 @@ done:
 	/* Fill out vectors at the end that don't need affinity */
 	for (; curvec < nvecs; curvec++)
 		cpumask_copy(masks + curvec, irq_default_affinity);
-	free_node_to_present_cpumask(node_to_present_cpumask);
+	free_node_to_possible_cpumask(node_to_possible_cpumask);
 out:
 	free_cpumask_var(nmsk);
 	return masks;
@@ -214,7 +214,7 @@ int irq_calc_affinity_vectors(int minvec
 		return 0;
 
 	get_online_cpus();
-	ret = min_t(int, cpumask_weight(cpu_present_mask), vecs) + resv;
+	ret = min_t(int, cpumask_weight(cpu_possible_mask), vecs) + resv;
 	put_online_cpus();
 	return ret;
 }


