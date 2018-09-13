Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA71C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FB8213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="f+Wg/ALb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37FB8213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeIMISL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 04:18:11 -0400
Received: from m12-18.163.com ([220.181.12.18]:35504 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbeIMISL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 04:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=jR0ANHsLe9cIzVF67K
        DnHJmwjC8PTvrH2QOMNeE9VFw=; b=f+Wg/ALbnG9B2AzyK+SCwUyLRp81vyaSvr
        wgtdBm/nWjn5L2QY0mWlFFiq0TqlDts6npWyzk7WVxdwDKQQckz9bJlYQFVVBuvN
        Eb3uWXTiXT0XRnx3NXCTLXD4fIhx7hP1Qh/qXP4MMqPLKScVj1u/Ch84ZqAOTR23
        rlVBQ8Shk=
Received: from localhost.localdomain (unknown [49.65.59.196])
        by smtp14 (Coremail) with SMTP id EsCowACXkQMa1ZlbCiuETA--.54041S4;
        Thu, 13 Sep 2018 11:10:19 +0800 (CST)
From:   Dou Liyang <dou_liyang@163.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, kashyap.desai@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, sumit.saxena@broadcom.com,
        ming.lei@redhat.com, hch@lst.de, douly.fnst@cn.fujitsu.com
Subject: [RFC PATCH] irq/affinity: Mark the pre/post vectors as regular interrupts
Date:   Thu, 13 Sep 2018 11:10:11 +0800
Message-Id: <20180913031011.17376-1-dou_liyang@163.com>
X-Mailer: git-send-email 2.14.3
X-CM-TRANSID: EsCowACXkQMa1ZlbCiuETA--.54041S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr1DZr1fXFyfXw4UGFyrXrb_yoW5uw1kpr
        4UKFyfWrW8JF4fWw1kKan7AFy3Cas3X39FyFnrX3WfCrZag3WqqryFqF1fXF1UGrW3CF1U
        AFy2qr4I9w1UJFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jTSoJUUUUU=
X-Originating-IP: [49.65.59.196]
X-CM-SenderInfo: pgrxszxl1d0wi6rwjhhfrp/1tbiLhvAolSIcR8m1wAAsU
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dou Liyang <douly.fnst@cn.fujitsu.com>

As Kashyap and Sumit reported, in MSI/-x subsystem, the pre/post vectors
may be used to some extra reply queues for performance. the best way to
map the pre/post vectors is map them to the local numa node.

But, current Linux can't do that, because

  The pre and post vectors are marked managed and their affinity mask
  is set to the irq default affinity mask.

  The default affinity mask is by default ALL cpus, but it can be tweaked
  both on the kernel command line and via proc.

  If that mask is only a subset of CPUs and all of them go offline
  then these vectors are shutdown in managed mode.

So, clear these affinity mask and check it in alloc_desc() to leave them
as regular interrupts which can be affinity controlled and also can move
freely on hotplug.

Note: will break the validation of affinity mask(s)

Reported-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reported-by: Sumit Saxena <sumit.saxena@broadcom.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 kernel/irq/affinity.c |  9 ++++++---
 kernel/irq/irqdesc.c  | 24 ++++++++++--------------
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index f4f29b9d90ee..ba35a5050dd2 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -204,7 +204,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 
 	/* Fill out vectors at the beginning that don't need affinity */
 	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
-		cpumask_copy(masks + curvec, irq_default_affinity);
+		cpumask_clear(masks + curvec);
 
 	/* Stabilize the cpumasks */
 	get_online_cpus();
@@ -234,10 +234,13 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	/* Fill out vectors at the end that don't need affinity */
 	if (usedvecs >= affvecs)
 		curvec = affd->pre_vectors + affvecs;
-	else
+	else {
 		curvec = affd->pre_vectors + usedvecs;
+		for (; curvec < affd->pre_vectors + affvecs; curvec++)
+			cpumask_copy(masks + curvec, irq_default_affinity);
+	}
 	for (; curvec < nvecs; curvec++)
-		cpumask_copy(masks + curvec, irq_default_affinity);
+		cpumask_clear(masks + curvec);
 
 outnodemsk:
 	free_node_to_cpumask(node_to_cpumask);
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 578d0e5f1b5b..5cffa791a20b 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -453,24 +453,20 @@ static int alloc_descs(unsigned int start, unsigned int cnt, int node,
 {
 	const struct cpumask *mask = NULL;
 	struct irq_desc *desc;
-	unsigned int flags;
+	unsigned int flags = 0;
 	int i;
 
-	/* Validate affinity mask(s) */
-	if (affinity) {
-		for (i = 0, mask = affinity; i < cnt; i++, mask++) {
-			if (cpumask_empty(mask))
-				return -EINVAL;
-		}
-	}
-
-	flags = affinity ? IRQD_AFFINITY_MANAGED | IRQD_MANAGED_SHUTDOWN : 0;
-	mask = NULL;
-
 	for (i = 0; i < cnt; i++) {
 		if (affinity) {
-			node = cpu_to_node(cpumask_first(affinity));
-			mask = affinity;
+			if (cpumask_empty(affinity)) {
+				flags = 0;
+				mask = NULL;
+			} else {
+				flags = IRQD_AFFINITY_MANAGED |
+					IRQD_MANAGED_SHUTDOWN;
+				mask = affinity;
+				node = cpu_to_node(cpumask_first(affinity));
+			}
 			affinity++;
 		}
 		desc = alloc_desc(start + i, node, flags, mask, owner);
-- 
2.14.3


