Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669D9ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F700206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F700206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388513AbeGPIHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:07:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47574 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbeGPIHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:07:35 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0DD1CCA1;
        Mon, 16 Jul 2018 07:41:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Laurence Oberman <loberman@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Meelis Roos <mroos@linux.ee>,
        Artem Bityutskiy <artem.bityutskiy@intel.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>
Subject: [PATCH 4.14 30/54] scsi: megaraid_sas: fix selection of reply queue
Date:   Mon, 16 Jul 2018 09:35:27 +0200
Message-Id: <20180716073456.630486984@linuxfoundation.org>
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

From: Ming Lei <ming.lei@redhat.com>

commit adbe552349f2d1e48357a00e564d26135e586634 upstream.

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
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Meelis Roos <mroos@linux.ee>
Cc: Artem Bityutskiy <artem.bityutskiy@intel.com>
Fixes: 84676c1f21e8 ("genirq/affinity: assign vectors to all possible CPUs")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Acked-by: Kashyap Desai <kashyap.desai@broadcom.com>
Tested-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Artem Bityutskiy <artem.bityutskiy@intel.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/megaraid/megaraid_sas.h        |    1 
 drivers/scsi/megaraid/megaraid_sas_base.c   |   39 +++++++++++++++++++++++++---
 drivers/scsi/megaraid/megaraid_sas_fusion.c |   12 ++------
 3 files changed, 41 insertions(+), 11 deletions(-)

--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -2099,6 +2099,7 @@ enum MR_PD_TYPE {
 
 struct megasas_instance {
 
+	unsigned int *reply_map;
 	__le32 *producer;
 	dma_addr_t producer_h;
 	__le32 *consumer;
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5138,6 +5138,26 @@ skip_alloc:
 		instance->use_seqnum_jbod_fp = false;
 }
 
+static void megasas_setup_reply_map(struct megasas_instance *instance)
+{
+	const struct cpumask *mask;
+	unsigned int queue, cpu;
+
+	for (queue = 0; queue < instance->msix_vectors; queue++) {
+		mask = pci_irq_get_affinity(instance->pdev, queue);
+		if (!mask)
+			goto fallback;
+
+		for_each_cpu(cpu, mask)
+			instance->reply_map[cpu] = queue;
+	}
+	return;
+
+fallback:
+	for_each_possible_cpu(cpu)
+		instance->reply_map[cpu] = cpu % instance->msix_vectors;
+}
+
 /**
  * megasas_init_fw -	Initializes the FW
  * @instance:		Adapter soft state
@@ -5303,6 +5323,8 @@ static int megasas_init_fw(struct megasa
 			goto fail_setup_irqs;
 	}
 
+	megasas_setup_reply_map(instance);
+
 	dev_info(&instance->pdev->dev,
 		"firmware supports msix\t: (%d)", fw_msix_count);
 	dev_info(&instance->pdev->dev,
@@ -6046,20 +6068,29 @@ static inline int megasas_alloc_mfi_ctrl
  */
 static int megasas_alloc_ctrl_mem(struct megasas_instance *instance)
 {
+	instance->reply_map = kzalloc(sizeof(unsigned int) * nr_cpu_ids,
+				      GFP_KERNEL);
+	if (!instance->reply_map)
+		return -ENOMEM;
+
 	switch (instance->adapter_type) {
 	case MFI_SERIES:
 		if (megasas_alloc_mfi_ctrl_mem(instance))
-			return -ENOMEM;
+			goto fail;
 		break;
 	case VENTURA_SERIES:
 	case THUNDERBOLT_SERIES:
 	case INVADER_SERIES:
 		if (megasas_alloc_fusion_context(instance))
-			return -ENOMEM;
+			goto fail;
 		break;
 	}
 
 	return 0;
+ fail:
+	kfree(instance->reply_map);
+	instance->reply_map = NULL;
+	return -ENOMEM;
 }
 
 /*
@@ -6071,6 +6102,7 @@ static int megasas_alloc_ctrl_mem(struct
  */
 static inline void megasas_free_ctrl_mem(struct megasas_instance *instance)
 {
+	kfree(instance->reply_map);
 	if (instance->adapter_type == MFI_SERIES) {
 		if (instance->producer)
 			pci_free_consistent(instance->pdev, sizeof(u32),
@@ -6342,7 +6374,6 @@ fail_alloc_dma_buf:
 					instance->tgt_prop_h);
 	megasas_free_ctrl_mem(instance);
 	scsi_host_put(host);
-
 fail_alloc_instance:
 fail_set_dma_mask:
 	pci_disable_device(pdev);
@@ -6548,6 +6579,8 @@ megasas_resume(struct pci_dev *pdev)
 	if (rval < 0)
 		goto fail_reenable_msix;
 
+	megasas_setup_reply_map(instance);
+
 	if (instance->adapter_type != MFI_SERIES) {
 		megasas_reset_reply_desc(instance);
 		if (megasas_ioc_init_fusion(instance)) {
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -2341,11 +2341,8 @@ megasas_build_ldio_fusion(struct megasas
 			fp_possible = (io_info.fpOkForIo > 0) ? true : false;
 	}
 
-	/* Use raw_smp_processor_id() for now until cmd->request->cpu is CPU
-	   id by default, not CPU group id, otherwise all MSI-X queues won't
-	   be utilized */
-	cmd->request_desc->SCSIIO.MSIxIndex = instance->msix_vectors ?
-		raw_smp_processor_id() % instance->msix_vectors : 0;
+	cmd->request_desc->SCSIIO.MSIxIndex =
+		instance->reply_map[raw_smp_processor_id()];
 
 	praid_context = &io_request->RaidContext;
 
@@ -2667,10 +2664,9 @@ megasas_build_syspd_fusion(struct megasa
 	}
 
 	cmd->request_desc->SCSIIO.DevHandle = io_request->DevHandle;
-	cmd->request_desc->SCSIIO.MSIxIndex =
-		instance->msix_vectors ?
-		(raw_smp_processor_id() % instance->msix_vectors) : 0;
 
+	cmd->request_desc->SCSIIO.MSIxIndex =
+		instance->reply_map[raw_smp_processor_id()];
 
 	if (!fp_possible) {
 		/* system pd firmware path */


