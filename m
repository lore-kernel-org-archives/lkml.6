Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855EEC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2067B2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2067B2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbeKEUmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:42:05 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55807 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbeKEUmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:42:05 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA5BMUC8309753
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 5 Nov 2018 03:22:30 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA5BMU8r309750;
        Mon, 5 Nov 2018 03:22:30 -0800
Date:   Mon, 5 Nov 2018 03:22:30 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ming Lei <tipbot@zytor.com>
Message-ID: <tip-5c903e108d0b005cf59904ca3520934fca4b9439@git.kernel.org>
Cc:     sagi@grimberg.me, hare@suse.com, hpa@zytor.com, mingo@kernel.org,
        ming.lei@redhat.com, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, tglx@linutronix.de, axboe@kernel.dk
Reply-To: sagi@grimberg.me, hare@suse.com, hpa@zytor.com,
          ming.lei@redhat.com, mingo@kernel.org, keith.busch@intel.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org, axboe@kernel.dk
In-Reply-To: <20181102145951.31979-3-ming.lei@redhat.com>
References: <20181102145951.31979-3-ming.lei@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/affinity: Move two stage affinity spreading
 into a helper function
Git-Commit-ID: 5c903e108d0b005cf59904ca3520934fca4b9439
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

Commit-ID:  5c903e108d0b005cf59904ca3520934fca4b9439
Gitweb:     https://git.kernel.org/tip/5c903e108d0b005cf59904ca3520934fca4b9439
Author:     Ming Lei <ming.lei@redhat.com>
AuthorDate: Fri, 2 Nov 2018 22:59:49 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 5 Nov 2018 12:16:26 +0100

genirq/affinity: Move two stage affinity spreading into a helper function

No functional change. Prepares for supporting allocating and affinitizing
interrupt sets.

[ tglx: Minor changelog tweaks ]

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Link: https://lkml.kernel.org/r/20181102145951.31979-3-ming.lei@redhat.com

---
 kernel/irq/affinity.c | 92 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 56 insertions(+), 36 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index e12cdf637c71..2f9812b6035e 100644
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
@@ -165,6 +165,58 @@ out:
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
@@ -177,7 +229,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 {
 	int affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
 	int curvec, usedvecs;
-	cpumask_var_t nmsk, npresmsk, *node_to_cpumask;
+	cpumask_var_t *node_to_cpumask;
 	struct cpumask *masks = NULL;
 
 	/*
@@ -187,15 +239,9 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
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
@@ -205,30 +251,8 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
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
@@ -240,10 +264,6 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 
 outnodemsk:
 	free_node_to_cpumask(node_to_cpumask);
-outnpresmsk:
-	free_cpumask_var(npresmsk);
-outcpumsk:
-	free_cpumask_var(nmsk);
 	return masks;
 }
 
