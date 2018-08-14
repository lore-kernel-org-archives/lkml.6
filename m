Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448B1C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B6521727
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B6521727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbeHNUW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:22:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57066 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeHNUW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:22:58 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A4467E1A;
        Tue, 14 Aug 2018 17:34:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Laurence Oberman <loberman@redhat.com>,
        Meelis Roos <mroos@linux.ee>,
        Artem Bityutskiy <artem.bityutskiy@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>
Subject: [PATCH 4.14 003/104] scsi: hpsa: fix selection of reply queue
Date:   Tue, 14 Aug 2018 19:16:17 +0200
Message-Id: <20180814171515.480060510@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171515.270692185@linuxfoundation.org>
References: <20180814171515.270692185@linuxfoundation.org>
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

From: Ming Lei <ming.lei@redhat.com>

commit 8b834bff1b73dce46f4e9f5e84af6f73fed8b0ef upstream.

Since commit 84676c1f21e8 ("genirq/affinity: assign vectors to all
possible CPUs") we could end up with an MSI-X vector that did not have
any online CPUs mapped. This would lead to I/O hangs since there was no
CPU to receive the completion.

Retrieve IRQ affinity information using pci_irq_get_affinity() and use
this mapping to choose a reply queue.

[mkp: tweaked commit desc]

Cc: Hannes Reinecke <hare@suse.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
Cc: James Bottomley <james.bottomley@hansenpartnership.com>,
Cc: Christoph Hellwig <hch@lst.de>,
Cc: Don Brace <don.brace@microsemi.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Laurence Oberman <loberman@redhat.com>
Cc: Meelis Roos <mroos@linux.ee>
Cc: Artem Bityutskiy <artem.bityutskiy@intel.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Fixes: 84676c1f21e8 ("genirq/affinity: assign vectors to all possible CPUs")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
Tested-by: Don Brace <don.brace@microsemi.com>
Tested-by: Artem Bityutskiy <artem.bityutskiy@intel.com>
Acked-by: Don Brace <don.brace@microsemi.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/hpsa.c |   73 ++++++++++++++++++++++++++++++++++++++--------------
 drivers/scsi/hpsa.h |    1 
 2 files changed, 55 insertions(+), 19 deletions(-)

--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -1040,11 +1040,7 @@ static void set_performant_mode(struct c
 		c->busaddr |= 1 | (h->blockFetchTable[c->Header.SGList] << 1);
 		if (unlikely(!h->msix_vectors))
 			return;
-		if (likely(reply_queue == DEFAULT_REPLY_QUEUE))
-			c->Header.ReplyQueue =
-				raw_smp_processor_id() % h->nreply_queues;
-		else
-			c->Header.ReplyQueue = reply_queue % h->nreply_queues;
+		c->Header.ReplyQueue = reply_queue;
 	}
 }
 
@@ -1058,10 +1054,7 @@ static void set_ioaccel1_performant_mode
 	 * Tell the controller to post the reply to the queue for this
 	 * processor.  This seems to give the best I/O throughput.
 	 */
-	if (likely(reply_queue == DEFAULT_REPLY_QUEUE))
-		cp->ReplyQueue = smp_processor_id() % h->nreply_queues;
-	else
-		cp->ReplyQueue = reply_queue % h->nreply_queues;
+	cp->ReplyQueue = reply_queue;
 	/*
 	 * Set the bits in the address sent down to include:
 	 *  - performant mode bit (bit 0)
@@ -1082,10 +1075,7 @@ static void set_ioaccel2_tmf_performant_
 	/* Tell the controller to post the reply to the queue for this
 	 * processor.  This seems to give the best I/O throughput.
 	 */
-	if (likely(reply_queue == DEFAULT_REPLY_QUEUE))
-		cp->reply_queue = smp_processor_id() % h->nreply_queues;
-	else
-		cp->reply_queue = reply_queue % h->nreply_queues;
+	cp->reply_queue = reply_queue;
 	/* Set the bits in the address sent down to include:
 	 *  - performant mode bit not used in ioaccel mode 2
 	 *  - pull count (bits 0-3)
@@ -1104,10 +1094,7 @@ static void set_ioaccel2_performant_mode
 	 * Tell the controller to post the reply to the queue for this
 	 * processor.  This seems to give the best I/O throughput.
 	 */
-	if (likely(reply_queue == DEFAULT_REPLY_QUEUE))
-		cp->reply_queue = smp_processor_id() % h->nreply_queues;
-	else
-		cp->reply_queue = reply_queue % h->nreply_queues;
+	cp->reply_queue = reply_queue;
 	/*
 	 * Set the bits in the address sent down to include:
 	 *  - performant mode bit not used in ioaccel mode 2
@@ -1152,6 +1139,8 @@ static void __enqueue_cmd_and_start_io(s
 {
 	dial_down_lockup_detection_during_fw_flash(h, c);
 	atomic_inc(&h->commands_outstanding);
+
+	reply_queue = h->reply_map[raw_smp_processor_id()];
 	switch (c->cmd_type) {
 	case CMD_IOACCEL1:
 		set_ioaccel1_performant_mode(h, c, reply_queue);
@@ -7244,6 +7233,26 @@ static void hpsa_disable_interrupt_mode(
 	h->msix_vectors = 0;
 }
 
+static void hpsa_setup_reply_map(struct ctlr_info *h)
+{
+	const struct cpumask *mask;
+	unsigned int queue, cpu;
+
+	for (queue = 0; queue < h->msix_vectors; queue++) {
+		mask = pci_irq_get_affinity(h->pdev, queue);
+		if (!mask)
+			goto fallback;
+
+		for_each_cpu(cpu, mask)
+			h->reply_map[cpu] = queue;
+	}
+	return;
+
+fallback:
+	for_each_possible_cpu(cpu)
+		h->reply_map[cpu] = 0;
+}
+
 /* If MSI/MSI-X is supported by the kernel we will try to enable it on
  * controllers that are capable. If not, we use legacy INTx mode.
  */
@@ -7639,6 +7648,10 @@ static int hpsa_pci_init(struct ctlr_inf
 	err = hpsa_interrupt_mode(h);
 	if (err)
 		goto clean1;
+
+	/* setup mapping between CPU and reply queue */
+	hpsa_setup_reply_map(h);
+
 	err = hpsa_pci_find_memory_BAR(h->pdev, &h->paddr);
 	if (err)
 		goto clean2;	/* intmode+region, pci */
@@ -8284,6 +8297,28 @@ static struct workqueue_struct *hpsa_cre
 	return wq;
 }
 
+static void hpda_free_ctlr_info(struct ctlr_info *h)
+{
+	kfree(h->reply_map);
+	kfree(h);
+}
+
+static struct ctlr_info *hpda_alloc_ctlr_info(void)
+{
+	struct ctlr_info *h;
+
+	h = kzalloc(sizeof(*h), GFP_KERNEL);
+	if (!h)
+		return NULL;
+
+	h->reply_map = kzalloc(sizeof(*h->reply_map) * nr_cpu_ids, GFP_KERNEL);
+	if (!h->reply_map) {
+		kfree(h);
+		return NULL;
+	}
+	return h;
+}
+
 static int hpsa_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	int dac, rc;
@@ -8321,7 +8356,7 @@ reinit_after_soft_reset:
 	 * the driver.  See comments in hpsa.h for more info.
 	 */
 	BUILD_BUG_ON(sizeof(struct CommandList) % COMMANDLIST_ALIGNMENT);
-	h = kzalloc(sizeof(*h), GFP_KERNEL);
+	h = hpda_alloc_ctlr_info();
 	if (!h) {
 		dev_err(&pdev->dev, "Failed to allocate controller head\n");
 		return -ENOMEM;
@@ -8726,7 +8761,7 @@ static void hpsa_remove_one(struct pci_d
 	h->lockup_detected = NULL;			/* init_one 2 */
 	/* (void) pci_disable_pcie_error_reporting(pdev); */	/* init_one 1 */
 
-	kfree(h);					/* init_one 1 */
+	hpda_free_ctlr_info(h);				/* init_one 1 */
 }
 
 static int hpsa_suspend(__attribute__((unused)) struct pci_dev *pdev,
--- a/drivers/scsi/hpsa.h
+++ b/drivers/scsi/hpsa.h
@@ -158,6 +158,7 @@ struct bmic_controller_parameters {
 #pragma pack()
 
 struct ctlr_info {
+	unsigned int *reply_map;
 	int	ctlr;
 	char	devname[8];
 	char    *product_name;


