Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CF5ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9892A2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9892A2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbeKEUmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:42:32 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39963 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbeKEUmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:42:32 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA5BN4YW309802
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 5 Nov 2018 03:23:04 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA5BN3WS309799;
        Mon, 5 Nov 2018 03:23:03 -0800
Date:   Mon, 5 Nov 2018 03:23:03 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ming Lei <tipbot@zytor.com>
Message-ID: <tip-060746d9e394084b7401e7532f2de528ecbfb521@git.kernel.org>
Cc:     axboe@kernel.dk, hare@suse.com, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, sagi@grimberg.me, hpa@zytor.com,
        keith.busch@intel.com, mingo@kernel.org, tglx@linutronix.de
Reply-To: sagi@grimberg.me, axboe@kernel.dk, ming.lei@redhat.com,
          hare@suse.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, hpa@zytor.com, keith.busch@intel.com
In-Reply-To: <20181102145951.31979-4-ming.lei@redhat.com>
References: <20181102145951.31979-4-ming.lei@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/affinity: Pass first vector to
 __irq_build_affinity_masks()
Git-Commit-ID: 060746d9e394084b7401e7532f2de528ecbfb521
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

Commit-ID:  060746d9e394084b7401e7532f2de528ecbfb521
Gitweb:     https://git.kernel.org/tip/060746d9e394084b7401e7532f2de528ecbfb521
Author:     Ming Lei <ming.lei@redhat.com>
AuthorDate: Fri, 2 Nov 2018 22:59:50 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 5 Nov 2018 12:16:26 +0100

genirq/affinity: Pass first vector to __irq_build_affinity_masks()

No functional change.

Prepares for support of allocating and affinitizing sets of interrupts, in
which each set of interrupts needs a full two stage spreading. The first
vector argument is necessary for this so the affinitizing starts from the
first vector of each set.

[ tglx: Minor changelog tweaks ]

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Link: https://lkml.kernel.org/r/20181102145951.31979-4-ming.lei@redhat.com

---
 kernel/irq/affinity.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 2f9812b6035e..e028b773e38a 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -95,14 +95,14 @@ static int get_nodes_in_cpumask(cpumask_var_t *node_to_cpumask,
 }
 
 static int __irq_build_affinity_masks(const struct irq_affinity *affd,
-				    int startvec, int numvecs,
+				    int startvec, int numvecs, int firstvec,
 				    cpumask_var_t *node_to_cpumask,
 				    const struct cpumask *cpu_mask,
 				    struct cpumask *nmsk,
 				    struct cpumask *masks)
 {
 	int n, nodes, cpus_per_vec, extra_vecs, done = 0;
-	int last_affv = affd->pre_vectors + numvecs;
+	int last_affv = firstvec + numvecs;
 	int curvec = startvec;
 	nodemask_t nodemsk = NODE_MASK_NONE;
 
@@ -119,7 +119,7 @@ static int __irq_build_affinity_masks(const struct irq_affinity *affd,
 		for_each_node_mask(n, nodemsk) {
 			cpumask_or(masks + curvec, masks + curvec, node_to_cpumask[n]);
 			if (++curvec == last_affv)
-				curvec = affd->pre_vectors;
+				curvec = firstvec;
 		}
 		done = numvecs;
 		goto out;
@@ -129,7 +129,7 @@ static int __irq_build_affinity_masks(const struct irq_affinity *affd,
 		int ncpus, v, vecs_to_assign, vecs_per_node;
 
 		/* Spread the vectors per node */
-		vecs_per_node = (numvecs - (curvec - affd->pre_vectors)) / nodes;
+		vecs_per_node = (numvecs - (curvec - firstvec)) / nodes;
 
 		/* Get the cpus on this node which are in the mask */
 		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
@@ -157,7 +157,7 @@ static int __irq_build_affinity_masks(const struct irq_affinity *affd,
 		if (done >= numvecs)
 			break;
 		if (curvec >= last_affv)
-			curvec = affd->pre_vectors;
+			curvec = firstvec;
 		--nodes;
 	}
 
@@ -190,8 +190,9 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
 
 	/* Spread on present CPUs starting from affd->pre_vectors */
 	usedvecs = __irq_build_affinity_masks(affd, curvec, numvecs,
-					    node_to_cpumask, cpu_present_mask,
-					    nmsk, masks);
+					      affd->pre_vectors,
+					      node_to_cpumask,
+					      cpu_present_mask, nmsk, masks);
 
 	/*
 	 * Spread on non present CPUs starting from the next vector to be
@@ -205,8 +206,9 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
 		curvec = affd->pre_vectors + usedvecs;
 	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
 	usedvecs += __irq_build_affinity_masks(affd, curvec, numvecs,
-					     node_to_cpumask, npresmsk,
-					     nmsk, masks);
+					       affd->pre_vectors,
+					       node_to_cpumask, npresmsk,
+					       nmsk, masks);
 	put_online_cpus();
 
 	free_cpumask_var(npresmsk);
