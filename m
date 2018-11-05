Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A82AC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208FD2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208FD2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbeKEUnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:43:04 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51125 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbeKEUnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:43:04 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA5BNcId309856
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 5 Nov 2018 03:23:38 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA5BNcOT309853;
        Mon, 5 Nov 2018 03:23:38 -0800
Date:   Mon, 5 Nov 2018 03:23:38 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jens Axboe <tipbot@zytor.com>
Message-ID: <tip-6da4b3ab9a6e9b1b5f90322ab3fa3a7dd18edb19@git.kernel.org>
Cc:     hare@suse.com, ming.lei@redhat.com, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, mingo@kernel.org, tglx@linutronix.de,
        keith.busch@intel.com, sagi@grimberg.me, hpa@zytor.com
Reply-To: hare@suse.com, ming.lei@redhat.com, linux-kernel@vger.kernel.org,
          axboe@kernel.dk, tglx@linutronix.de, mingo@kernel.org,
          keith.busch@intel.com, sagi@grimberg.me, hpa@zytor.com
In-Reply-To: <20181102145951.31979-5-ming.lei@redhat.com>
References: <20181102145951.31979-5-ming.lei@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/affinity: Add support for allocating
 interrupt sets
Git-Commit-ID: 6da4b3ab9a6e9b1b5f90322ab3fa3a7dd18edb19
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

Commit-ID:  6da4b3ab9a6e9b1b5f90322ab3fa3a7dd18edb19
Gitweb:     https://git.kernel.org/tip/6da4b3ab9a6e9b1b5f90322ab3fa3a7dd18edb19
Author:     Jens Axboe <axboe@kernel.dk>
AuthorDate: Fri, 2 Nov 2018 22:59:51 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 5 Nov 2018 12:16:27 +0100

genirq/affinity: Add support for allocating interrupt sets

A driver may have a need to allocate multiple sets of MSI/MSI-X interrupts,
and have them appropriately affinitized.

Add support for defining a number of sets in the irq_affinity structure, of
varying sizes, and get each set affinitized correctly across the machine.

[ tglx: Minor changelog tweaks ]

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org
Link: https://lkml.kernel.org/r/20181102145951.31979-5-ming.lei@redhat.com

---
 drivers/pci/msi.c         | 14 +++++++++
 include/linux/interrupt.h |  4 +++
 kernel/irq/affinity.c     | 77 +++++++++++++++++++++++++++++++++--------------
 3 files changed, 72 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index af24ed50a245..265ed3e4c920 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1036,6 +1036,13 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 	if (maxvec < minvec)
 		return -ERANGE;
 
+	/*
+	 * If the caller is passing in sets, we can't support a range of
+	 * vectors. The caller needs to handle that.
+	 */
+	if (affd && affd->nr_sets && minvec != maxvec)
+		return -EINVAL;
+
 	if (WARN_ON_ONCE(dev->msi_enabled))
 		return -EINVAL;
 
@@ -1087,6 +1094,13 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 	if (maxvec < minvec)
 		return -ERANGE;
 
+	/*
+	 * If the caller is passing in sets, we can't support a range of
+	 * supported vectors. The caller needs to handle that.
+	 */
+	if (affd && affd->nr_sets && minvec != maxvec)
+		return -EINVAL;
+
 	if (WARN_ON_ONCE(dev->msix_enabled))
 		return -EINVAL;
 
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 1d6711c28271..ca397ff40836 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -247,10 +247,14 @@ struct irq_affinity_notify {
  *			the MSI(-X) vector space
  * @post_vectors:	Don't apply affinity to @post_vectors at end of
  *			the MSI(-X) vector space
+ * @nr_sets:		Length of passed in *sets array
+ * @sets:		Number of affinitized sets
  */
 struct irq_affinity {
 	int	pre_vectors;
 	int	post_vectors;
+	int	nr_sets;
+	int	*sets;
 };
 
 #if defined(CONFIG_SMP)
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index e028b773e38a..08c904eb7279 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -171,28 +171,29 @@ out:
  *	2) spread other possible CPUs on these vectors
  */
 static int irq_build_affinity_masks(const struct irq_affinity *affd,
-				    int startvec, int numvecs,
+				    int startvec, int numvecs, int firstvec,
 				    cpumask_var_t *node_to_cpumask,
 				    struct cpumask *masks)
 {
-	int curvec = startvec, usedvecs = -1;
+	int curvec = startvec, nr_present, nr_others;
+	int ret = -ENOMEM;
 	cpumask_var_t nmsk, npresmsk;
 
 	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
-			return usedvecs;
+			return ret;
 
 	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
 			goto fail;
 
+	ret = 0;
 	/* Stabilize the cpumasks */
 	get_online_cpus();
 	build_node_to_cpumask(node_to_cpumask);
 
 	/* Spread on present CPUs starting from affd->pre_vectors */
-	usedvecs = __irq_build_affinity_masks(affd, curvec, numvecs,
-					      affd->pre_vectors,
-					      node_to_cpumask,
-					      cpu_present_mask, nmsk, masks);
+	nr_present = __irq_build_affinity_masks(affd, curvec, numvecs,
+						firstvec, node_to_cpumask,
+						cpu_present_mask, nmsk, masks);
 
 	/*
 	 * Spread on non present CPUs starting from the next vector to be
@@ -200,23 +201,24 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
 	 * vector space, assign the non present CPUs to the already spread
 	 * out vectors.
 	 */
-	if (usedvecs >= numvecs)
-		curvec = affd->pre_vectors;
+	if (nr_present >= numvecs)
+		curvec = firstvec;
 	else
-		curvec = affd->pre_vectors + usedvecs;
+		curvec = firstvec + nr_present;
 	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
-	usedvecs += __irq_build_affinity_masks(affd, curvec, numvecs,
-					       affd->pre_vectors,
-					       node_to_cpumask, npresmsk,
-					       nmsk, masks);
+	nr_others = __irq_build_affinity_masks(affd, curvec, numvecs,
+					       firstvec, node_to_cpumask,
+					       npresmsk, nmsk, masks);
 	put_online_cpus();
 
+	if (nr_present < numvecs)
+			WARN_ON(nr_present + nr_others < numvecs);
+
 	free_cpumask_var(npresmsk);
 
  fail:
 	free_cpumask_var(nmsk);
-
-	return usedvecs;
+	return ret;
 }
 
 /**
@@ -233,6 +235,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	int curvec, usedvecs;
 	cpumask_var_t *node_to_cpumask;
 	struct cpumask *masks = NULL;
+	int i, nr_sets;
 
 	/*
 	 * If there aren't any vectors left after applying the pre/post
@@ -253,8 +256,28 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
 		cpumask_copy(masks + curvec, irq_default_affinity);
 
-	usedvecs = irq_build_affinity_masks(affd, curvec, affvecs,
-					    node_to_cpumask, masks);
+	/*
+	 * Spread on present CPUs starting from affd->pre_vectors. If we
+	 * have multiple sets, build each sets affinity mask separately.
+	 */
+	nr_sets = affd->nr_sets;
+	if (!nr_sets)
+		nr_sets = 1;
+
+	for (i = 0, usedvecs = 0; i < nr_sets; i++) {
+		int this_vecs = affd->sets ? affd->sets[i] : affvecs;
+		int ret;
+
+		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
+						curvec, node_to_cpumask, masks);
+		if (ret) {
+				kfree(masks);
+				masks = NULL;
+				goto outnodemsk;
+		}
+		curvec += this_vecs;
+		usedvecs += this_vecs;
+	}
 
 	/* Fill out vectors at the end that don't need affinity */
 	if (usedvecs >= affvecs)
@@ -279,13 +302,21 @@ int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity
 {
 	int resv = affd->pre_vectors + affd->post_vectors;
 	int vecs = maxvec - resv;
-	int ret;
+	int set_vecs;
 
 	if (resv > minvec)
 		return 0;
 
-	get_online_cpus();
-	ret = min_t(int, cpumask_weight(cpu_possible_mask), vecs) + resv;
-	put_online_cpus();
-	return ret;
+	if (affd->nr_sets) {
+		int i;
+
+		for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
+			set_vecs += affd->sets[i];
+	} else {
+		get_online_cpus();
+		set_vecs = cpumask_weight(cpu_possible_mask);
+		put_online_cpus();
+	}
+
+	return resv + min(set_vecs, vecs);
 }
