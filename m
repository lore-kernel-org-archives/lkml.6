Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53537C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DEEA20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbfBRK3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:29:16 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50695 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbfBRK3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:29:16 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1IARkve2531052
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 18 Feb 2019 02:27:46 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1IARjoP2531049;
        Mon, 18 Feb 2019 02:27:45 -0800
Date:   Mon, 18 Feb 2019 02:27:45 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ming Lei <tipbot@zytor.com>
Message-ID: <tip-612b72862b4dd7f3f5e42651522daac6733b8ea6@git.kernel.org>
Cc:     marc.zyngier@arm.com, tglx@linutronix.de, hch@lst.de,
        mingo@kernel.org, ming.lei@redhat.com, sumit.saxena@broadcom.com,
        hpa@zytor.com, shivasharan.srikanteshwara@broadcom.com,
        keith.busch@intel.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, sagi@grimberg.me,
        kashyap.desai@broadcom.com, helgaas@kernel.org
Reply-To: helgaas@kernel.org, sagi@grimberg.me, kashyap.desai@broadcom.com,
          linux-kernel@vger.kernel.org, axboe@kernel.dk,
          keith.busch@intel.com, shivasharan.srikanteshwara@broadcom.com,
          sumit.saxena@broadcom.com, hpa@zytor.com, ming.lei@redhat.com,
          mingo@kernel.org, hch@lst.de, tglx@linutronix.de,
          marc.zyngier@arm.com
In-Reply-To: <20190216172228.602546658@linutronix.de>
References: <20190216172228.602546658@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] nvme-pci: Simplify interrupt allocation
Git-Commit-ID: 612b72862b4dd7f3f5e42651522daac6733b8ea6
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

Commit-ID:  612b72862b4dd7f3f5e42651522daac6733b8ea6
Gitweb:     https://git.kernel.org/tip/612b72862b4dd7f3f5e42651522daac6733b8ea6
Author:     Ming Lei <ming.lei@redhat.com>
AuthorDate: Sat, 16 Feb 2019 18:13:10 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 18 Feb 2019 11:21:28 +0100

nvme-pci: Simplify interrupt allocation

The NVME PCI driver contains a tedious mechanism for interrupt
allocation, which is necessary to adjust the number and size of interrupt
sets to the maximum available number of interrupts which depends on the
underlying PCI capabilities and the available CPU resources.

It works around the former short comings of the PCI and core interrupt
allocation mechanims in combination with interrupt sets.

The PCI interrupt allocation function allows to provide a maximum and a
minimum number of interrupts to be allocated and tries to allocate as
many as possible. This worked without driver interaction as long as there
was only a single set of interrupts to handle.

With the addition of support for multiple interrupt sets in the generic
affinity spreading logic, which is invoked from the PCI interrupt
allocation, the adaptive loop in the PCI interrupt allocation did not
work for multiple interrupt sets. The reason is that depending on the
total number of interrupts which the PCI allocation adaptive loop tries
to allocate in each step, the number and the size of the interrupt sets
need to be adapted as well. Due to the way the interrupt sets support was
implemented there was no way for the PCI interrupt allocation code or the
core affinity spreading mechanism to invoke a driver specific function
for adapting the interrupt sets configuration.

As a consequence the driver had to implement another adaptive loop around
the PCI interrupt allocation function and calling that with maximum and
minimum interrupts set to the same value. This ensured that the
allocation either succeeded or immediately failed without any attempt to
adjust the number of interrupts in the PCI code.

The core code now allows drivers to provide a callback to recalculate the
number and the size of interrupt sets during PCI interrupt allocation,
which in turn allows the PCI interrupt allocation function to be called
in the same way as with a single set of interrupts. The PCI code handles
the adaptive loop and the interrupt affinity spreading mechanism invokes
the driver callback to adapt the interrupt set configuration to the
current loop value. This replaces the adaptive loop in the driver
completely.

Implement the NVME specific callback which adjusts the interrupt sets
configuration and remove the adaptive allocation loop.

[ tglx: Simplify the callback further and restore the dropped adjustment of
  	number of sets ]

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Cc: linux-pci@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>
Cc: Sumit Saxena <sumit.saxena@broadcom.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Shivasharan Srikanteshwara <shivasharan.srikanteshwara@broadcom.com>
Link: https://lkml.kernel.org/r/20190216172228.602546658@linutronix.de


---
 drivers/nvme/host/pci.c | 114 ++++++++++++++++--------------------------------
 1 file changed, 38 insertions(+), 76 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 21ffd671b6ed..a0fdd5fb4e7a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2041,41 +2041,42 @@ static int nvme_setup_host_mem(struct nvme_dev *dev)
 	return ret;
 }
 
-/* irq_queues covers admin queue */
-static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int irq_queues)
+/*
+ * nirqs is the number of interrupts available for write and read
+ * queues. The core already reserved an interrupt for the admin queue.
+ */
+static void nvme_calc_irq_sets(struct irq_affinity *affd, unsigned int nrirqs)
 {
-	unsigned int this_w_queues = write_queues;
-
-	WARN_ON(!irq_queues);
-
-	/*
-	 * Setup read/write queue split, assign admin queue one independent
-	 * irq vector if irq_queues is > 1.
-	 */
-	if (irq_queues <= 2) {
-		dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
-		dev->io_queues[HCTX_TYPE_READ] = 0;
-		return;
-	}
-
-	/*
-	 * If 'write_queues' is set, ensure it leaves room for at least
-	 * one read queue and one admin queue
-	 */
-	if (this_w_queues >= irq_queues)
-		this_w_queues = irq_queues - 2;
+	struct nvme_dev *dev = affd->priv;
+	unsigned int nr_read_queues;
 
 	/*
-	 * If 'write_queues' is set to zero, reads and writes will share
-	 * a queue set.
+	 * If there is no interupt available for queues, ensure that
+	 * the default queue is set to 1. The affinity set size is
+	 * also set to one, but the irq core ignores it for this case.
+	 *
+	 * If only one interrupt is available or 'write_queue' == 0, combine
+	 * write and read queues.
+	 *
+	 * If 'write_queues' > 0, ensure it leaves room for at least one read
+	 * queue.
 	 */
-	if (!this_w_queues) {
-		dev->io_queues[HCTX_TYPE_DEFAULT] = irq_queues - 1;
-		dev->io_queues[HCTX_TYPE_READ] = 0;
+	if (!nrirqs) {
+		nrirqs = 1;
+		nr_read_queues = 0;
+	} else if (nrirqs == 1 || !write_queues) {
+		nr_read_queues = 0;
+	} else if (write_queues >= nrirqs) {
+		nr_read_queues = 1;
 	} else {
-		dev->io_queues[HCTX_TYPE_DEFAULT] = this_w_queues;
-		dev->io_queues[HCTX_TYPE_READ] = irq_queues - this_w_queues - 1;
+		nr_read_queues = nrirqs - write_queues;
 	}
+
+	dev->io_queues[HCTX_TYPE_DEFAULT] = nrirqs - nr_read_queues;
+	affd->set_size[HCTX_TYPE_DEFAULT] = nrirqs - nr_read_queues;
+	dev->io_queues[HCTX_TYPE_READ] = nr_read_queues;
+	affd->set_size[HCTX_TYPE_READ] = nr_read_queues;
+	affd->nr_sets = nr_read_queues ? 2 : 1;
 }
 
 static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
@@ -2083,10 +2084,9 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	struct irq_affinity affd = {
 		.pre_vectors	= 1,
-		.nr_sets	= 2,
+		.calc_sets	= nvme_calc_irq_sets,
+		.priv		= dev,
 	};
-	unsigned int *irq_sets = affd.set_size;
-	int result = 0;
 	unsigned int irq_queues, this_p_queues;
 
 	/*
@@ -2102,51 +2102,12 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 	}
 	dev->io_queues[HCTX_TYPE_POLL] = this_p_queues;
 
-	/*
-	 * For irq sets, we have to ask for minvec == maxvec. This passes
-	 * any reduction back to us, so we can adjust our queue counts and
-	 * IRQ vector needs.
-	 */
-	do {
-		nvme_calc_io_queues(dev, irq_queues);
-		irq_sets[0] = dev->io_queues[HCTX_TYPE_DEFAULT];
-		irq_sets[1] = dev->io_queues[HCTX_TYPE_READ];
-		if (!irq_sets[1])
-			affd.nr_sets = 1;
-
-		/*
-		 * If we got a failure and we're down to asking for just
-		 * 1 + 1 queues, just ask for a single vector. We'll share
-		 * that between the single IO queue and the admin queue.
-		 * Otherwise, we assign one independent vector to admin queue.
-		 */
-		if (irq_queues > 1)
-			irq_queues = irq_sets[0] + irq_sets[1] + 1;
+	/* Initialize for the single interrupt case */
+	dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
+	dev->io_queues[HCTX_TYPE_READ] = 0;
 
-		result = pci_alloc_irq_vectors_affinity(pdev, irq_queues,
-				irq_queues,
-				PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
-
-		/*
-		 * Need to reduce our vec counts. If we get ENOSPC, the
-		 * platform should support mulitple vecs, we just need
-		 * to decrease our ask. If we get EINVAL, the platform
-		 * likely does not. Back down to ask for just one vector.
-		 */
-		if (result == -ENOSPC) {
-			irq_queues--;
-			if (!irq_queues)
-				return result;
-			continue;
-		} else if (result == -EINVAL) {
-			irq_queues = 1;
-			continue;
-		} else if (result <= 0)
-			return -EIO;
-		break;
-	} while (1);
-
-	return result;
+	return pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues,
+			      PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
 }
 
 static void nvme_disable_io_queues(struct nvme_dev *dev)
@@ -3019,6 +2980,7 @@ static struct pci_driver nvme_driver = {
 
 static int __init nvme_init(void)
 {
+	BUILD_BUG_ON(IRQ_AFFINITY_MAX_SETS < 2);
 	return pci_register_driver(&nvme_driver);
 }
 
