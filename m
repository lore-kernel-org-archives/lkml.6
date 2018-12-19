Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BECC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227C121873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbeLSKiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:38:12 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41925 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbeLSKiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:38:11 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBJAc5B63192586
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 19 Dec 2018 02:38:05 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBJAc5gN3192583;
        Wed, 19 Dec 2018 02:38:05 -0800
Date:   Wed, 19 Dec 2018 02:38:05 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dou Liyang <tipbot@zytor.com>
Message-ID: <tip-c410abbbacb9b378365ba17a30df08b4b9eec64f@git.kernel.org>
Cc:     sumit.saxena@broadcom.com, hpa@zytor.com, tglx@linutronix.de,
        douliyangs@gmail.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, kashyap.desai@broadcom.com
Reply-To: tglx@linutronix.de, hpa@zytor.com, sumit.saxena@broadcom.com,
          kashyap.desai@broadcom.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, douliyangs@gmail.com
In-Reply-To: <20181204155122.6327-3-douliyangs@gmail.com>
References: <20181204155122.6327-3-douliyangs@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/affinity: Add is_managed to struct
 irq_affinity_desc
Git-Commit-ID: c410abbbacb9b378365ba17a30df08b4b9eec64f
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

Commit-ID:  c410abbbacb9b378365ba17a30df08b4b9eec64f
Gitweb:     https://git.kernel.org/tip/c410abbbacb9b378365ba17a30df08b4b9eec64f
Author:     Dou Liyang <douliyangs@gmail.com>
AuthorDate: Tue, 4 Dec 2018 23:51:21 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 19 Dec 2018 11:32:08 +0100

genirq/affinity: Add is_managed to struct irq_affinity_desc

Devices which use managed interrupts usually have two classes of
interrupts:

  - Interrupts for multiple device queues
  - Interrupts for general device management

Currently both classes are treated the same way, i.e. as managed
interrupts. The general interrupts get the default affinity mask assigned
while the device queue interrupts are spread out over the possible CPUs.

Treating the general interrupts as managed is both a limitation and under
certain circumstances a bug. Assume the following situation:

 default_irq_affinity = 4..7

So if CPUs 4-7 are offlined, then the core code will shut down the device
management interrupts because the last CPU in their affinity mask went
offline.

It's also a limitation because it's desired to allow manual placement of
the general device interrupts for various reasons. If they are marked
managed then the interrupt affinity setting from both user and kernel space
is disabled. That limitation was reported by Kashyap and Sumit.

Expand struct irq_affinity_desc with a new bit 'is_managed' which is set
for truly managed interrupts (queue interrupts) and cleared for the general
device interrupts.

[ tglx: Simplify code and massage changelog ]

Reported-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reported-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Dou Liyang <douliyangs@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-pci@vger.kernel.org
Cc: shivasharan.srikanteshwara@broadcom.com
Cc: ming.lei@redhat.com
Cc: hch@lst.de
Cc: bhelgaas@google.com
Cc: douliyang1@huawei.com
Link: https://lkml.kernel.org/r/20181204155122.6327-3-douliyangs@gmail.com

---
 include/linux/interrupt.h |  1 +
 kernel/irq/affinity.c     |  4 ++++
 kernel/irq/irqdesc.c      | 13 ++++++++-----
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index c44b7844dc83..c672f34235e7 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -263,6 +263,7 @@ struct irq_affinity {
  */
 struct irq_affinity_desc {
 	struct cpumask	mask;
+	unsigned int	is_managed : 1;
 };
 
 #if defined(CONFIG_SMP)
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index c0fe591b0dc9..45b68b4ea48b 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -289,6 +289,10 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	for (; curvec < nvecs; curvec++)
 		cpumask_copy(&masks[curvec].mask, irq_default_affinity);
 
+	/* Mark the managed interrupts */
+	for (i = affd->pre_vectors; i < nvecs - affd->post_vectors; i++)
+		masks[i].is_managed = 1;
+
 outnodemsk:
 	free_node_to_cpumask(node_to_cpumask);
 	return masks;
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index cb401d6c5040..ee062b7939d3 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -453,27 +453,30 @@ static int alloc_descs(unsigned int start, unsigned int cnt, int node,
 		       struct module *owner)
 {
 	struct irq_desc *desc;
-	unsigned int flags;
 	int i;
 
 	/* Validate affinity mask(s) */
 	if (affinity) {
-		for (i = 0; i < cnt; i++) {
+		for (i = 0; i < cnt; i++, i++) {
 			if (cpumask_empty(&affinity[i].mask))
 				return -EINVAL;
 		}
 	}
 
-	flags = affinity ? IRQD_AFFINITY_MANAGED | IRQD_MANAGED_SHUTDOWN : 0;
-
 	for (i = 0; i < cnt; i++) {
 		const struct cpumask *mask = NULL;
+		unsigned int flags = 0;
 
 		if (affinity) {
-			node = cpu_to_node(cpumask_first(affinity));
+			if (affinity->is_managed) {
+				flags = IRQD_AFFINITY_MANAGED |
+					IRQD_MANAGED_SHUTDOWN;
+			}
 			mask = &affinity->mask;
+			node = cpu_to_node(cpumask_first(mask));
 			affinity++;
 		}
+
 		desc = alloc_desc(start + i, node, flags, mask, owner);
 		if (!desc)
 			goto err;
