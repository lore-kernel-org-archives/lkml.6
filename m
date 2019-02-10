Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C595BC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 19:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4CF213F2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 19:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfBJTBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 14:01:49 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34583 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfBJTBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 14:01:48 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1AJ1GEJ3199790
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 10 Feb 2019 11:01:16 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1AJ1G0e3199786;
        Sun, 10 Feb 2019 11:01:16 -0800
Date:   Sun, 10 Feb 2019 11:01:16 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ming Lei <tipbot@zytor.com>
Message-ID: <tip-347253c42d7c673aa2a659d756bc7ff893459247@git.kernel.org>
Cc:     ming.lei@redhat.com, mingo@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, bhelgaas@google.com, hch@lst.de,
        sagi@grimberg.me, hpa@zytor.com, axboe@kernel.dk
Reply-To: sagi@grimberg.me, hpa@zytor.com, axboe@kernel.dk,
          bhelgaas@google.com, hch@lst.de, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, ming.lei@redhat.com,
          mingo@kernel.org
In-Reply-To: <20190125095347.17950-2-ming.lei@redhat.com>
References: <20190125095347.17950-2-ming.lei@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/affinity: Move allocation of
 'node_to_cpumask' to irq_build_affinity_masks()
Git-Commit-ID: 347253c42d7c673aa2a659d756bc7ff893459247
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

Commit-ID:  347253c42d7c673aa2a659d756bc7ff893459247
Gitweb:     https://git.kernel.org/tip/347253c42d7c673aa2a659d756bc7ff893459247
Author:     Ming Lei <ming.lei@redhat.com>
AuthorDate: Fri, 25 Jan 2019 17:53:43 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 10 Feb 2019 19:53:55 +0100

genirq/affinity: Move allocation of 'node_to_cpumask' to irq_build_affinity_masks()

'node_to_cpumask' is just one temparay variable for irq_build_affinity_masks(),
so move it into irq_build_affinity_masks().

No functioanl change.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Cc: linux-pci@vger.kernel.org
Link: https://lkml.kernel.org/r/20190125095347.17950-2-ming.lei@redhat.com

---
 kernel/irq/affinity.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 45b68b4ea48b..118b66d64a53 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -175,18 +175,22 @@ out:
  */
 static int irq_build_affinity_masks(const struct irq_affinity *affd,
 				    int startvec, int numvecs, int firstvec,
-				    cpumask_var_t *node_to_cpumask,
 				    struct irq_affinity_desc *masks)
 {
 	int curvec = startvec, nr_present, nr_others;
 	int ret = -ENOMEM;
 	cpumask_var_t nmsk, npresmsk;
+	cpumask_var_t *node_to_cpumask;
 
 	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
 		return ret;
 
 	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
-		goto fail;
+		goto fail_nmsk;
+
+	node_to_cpumask = alloc_node_to_cpumask();
+	if (!node_to_cpumask)
+		goto fail_npresmsk;
 
 	ret = 0;
 	/* Stabilize the cpumasks */
@@ -217,9 +221,12 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
 	if (nr_present < numvecs)
 		WARN_ON(nr_present + nr_others < numvecs);
 
+	free_node_to_cpumask(node_to_cpumask);
+
+ fail_npresmsk:
 	free_cpumask_var(npresmsk);
 
- fail:
+ fail_nmsk:
 	free_cpumask_var(nmsk);
 	return ret;
 }
@@ -236,7 +243,6 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 {
 	int affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
 	int curvec, usedvecs;
-	cpumask_var_t *node_to_cpumask;
 	struct irq_affinity_desc *masks = NULL;
 	int i, nr_sets;
 
@@ -247,13 +253,9 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	if (nvecs == affd->pre_vectors + affd->post_vectors)
 		return NULL;
 
-	node_to_cpumask = alloc_node_to_cpumask();
-	if (!node_to_cpumask)
-		return NULL;
-
 	masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
 	if (!masks)
-		goto outnodemsk;
+		return NULL;
 
 	/* Fill out vectors at the beginning that don't need affinity */
 	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
@@ -271,11 +273,10 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 		int ret;
 
 		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
-						curvec, node_to_cpumask, masks);
+						curvec, masks);
 		if (ret) {
 			kfree(masks);
-			masks = NULL;
-			goto outnodemsk;
+			return NULL;
 		}
 		curvec += this_vecs;
 		usedvecs += this_vecs;
@@ -293,8 +294,6 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	for (i = affd->pre_vectors; i < nvecs - affd->post_vectors; i++)
 		masks[i].is_managed = 1;
 
-outnodemsk:
-	free_node_to_cpumask(node_to_cpumask);
 	return masks;
 }
 
