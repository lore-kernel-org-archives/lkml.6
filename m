Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B398ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4AEB20864
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4AEB20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388506AbeGPIHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:07:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47566 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbeGPIHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:07:33 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6F67CC03;
        Mon, 16 Jul 2018 07:41:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 29/54] scsi: megaraid_sas: Create separate functions to allocate ctrl memory
Date:   Mon, 16 Jul 2018 09:35:26 +0200
Message-Id: <20180716073456.423290314@linuxfoundation.org>
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

From: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>

commit 49a7a4adb0167b656b8dfb6ccb83220d553a1860 upstream.

No functional change. Code refactoring to improve readability.  Move the
code to allocate and free controller memory into separate functions.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/megaraid/megaraid_sas_base.c |  122 ++++++++++++++++++------------
 1 file changed, 76 insertions(+), 46 deletions(-)

--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -6016,6 +6016,75 @@ static inline void megasas_set_adapter_t
 	}
 }
 
+static inline int megasas_alloc_mfi_ctrl_mem(struct megasas_instance *instance)
+{
+	instance->producer = pci_alloc_consistent(instance->pdev, sizeof(u32),
+						  &instance->producer_h);
+	instance->consumer = pci_alloc_consistent(instance->pdev, sizeof(u32),
+						  &instance->consumer_h);
+
+	if (!instance->producer || !instance->consumer) {
+		dev_err(&instance->pdev->dev,
+			"Failed to allocate memory for producer, consumer\n");
+		return -1;
+	}
+
+	*instance->producer = 0;
+	*instance->consumer = 0;
+	return 0;
+}
+
+/**
+ * megasas_alloc_ctrl_mem -	Allocate per controller memory for core data
+ *				structures which are not common across MFI
+ *				adapters and fusion adapters.
+ *				For MFI based adapters, allocate producer and
+ *				consumer buffers. For fusion adapters, allocate
+ *				memory for fusion context.
+ * @instance:			Adapter soft state
+ * return:			0 for SUCCESS
+ */
+static int megasas_alloc_ctrl_mem(struct megasas_instance *instance)
+{
+	switch (instance->adapter_type) {
+	case MFI_SERIES:
+		if (megasas_alloc_mfi_ctrl_mem(instance))
+			return -ENOMEM;
+		break;
+	case VENTURA_SERIES:
+	case THUNDERBOLT_SERIES:
+	case INVADER_SERIES:
+		if (megasas_alloc_fusion_context(instance))
+			return -ENOMEM;
+		break;
+	}
+
+	return 0;
+}
+
+/*
+ * megasas_free_ctrl_mem -	Free fusion context for fusion adapters and
+ *				producer, consumer buffers for MFI adapters
+ *
+ * @instance -			Adapter soft instance
+ *
+ */
+static inline void megasas_free_ctrl_mem(struct megasas_instance *instance)
+{
+	if (instance->adapter_type == MFI_SERIES) {
+		if (instance->producer)
+			pci_free_consistent(instance->pdev, sizeof(u32),
+					    instance->producer,
+					    instance->producer_h);
+		if (instance->consumer)
+			pci_free_consistent(instance->pdev, sizeof(u32),
+					    instance->consumer,
+					    instance->consumer_h);
+	} else {
+		megasas_free_fusion_context(instance);
+	}
+}
+
 /**
  * megasas_probe_one -	PCI hotplug entry point
  * @pdev:		PCI device structure
@@ -6074,33 +6143,8 @@ static int megasas_probe_one(struct pci_
 
 	megasas_set_adapter_type(instance);
 
-	switch (instance->adapter_type) {
-	case MFI_SERIES:
-		instance->producer =
-			pci_alloc_consistent(pdev, sizeof(u32),
-					     &instance->producer_h);
-		instance->consumer =
-			pci_alloc_consistent(pdev, sizeof(u32),
-					     &instance->consumer_h);
-
-		if (!instance->producer || !instance->consumer) {
-			dev_printk(KERN_DEBUG, &pdev->dev, "Failed to allocate "
-			       "memory for producer, consumer\n");
-			goto fail_alloc_dma_buf;
-		}
-
-		*instance->producer = 0;
-		*instance->consumer = 0;
-
-		break;
-	case VENTURA_SERIES:
-	case THUNDERBOLT_SERIES:
-	case INVADER_SERIES:
-		if (megasas_alloc_fusion_context(instance)) {
-			megasas_free_fusion_context(instance);
-			goto fail_alloc_dma_buf;
-		}
-	}
+	if (megasas_alloc_ctrl_mem(instance))
+		goto fail_alloc_dma_buf;
 
 	/* Crash dump feature related initialisation*/
 	instance->drv_buf_index = 0;
@@ -6296,12 +6340,7 @@ fail_alloc_dma_buf:
 		pci_free_consistent(pdev, sizeof(struct MR_TARGET_PROPERTIES),
 					instance->tgt_prop,
 					instance->tgt_prop_h);
-	if (instance->producer)
-		pci_free_consistent(pdev, sizeof(u32), instance->producer,
-				    instance->producer_h);
-	if (instance->consumer)
-		pci_free_consistent(pdev, sizeof(u32), instance->consumer,
-				    instance->consumer_h);
+	megasas_free_ctrl_mem(instance);
 	scsi_host_put(host);
 
 fail_alloc_instance:
@@ -6572,12 +6611,8 @@ fail_init_mfi:
 		pci_free_consistent(pdev, sizeof(struct MR_TARGET_PROPERTIES),
 					instance->tgt_prop,
 					instance->tgt_prop_h);
-	if (instance->producer)
-		pci_free_consistent(pdev, sizeof(u32), instance->producer,
-				instance->producer_h);
-	if (instance->consumer)
-		pci_free_consistent(pdev, sizeof(u32), instance->consumer,
-				instance->consumer_h);
+
+	megasas_free_ctrl_mem(instance);
 	scsi_host_put(host);
 
 fail_set_dma_mask:
@@ -6718,15 +6753,8 @@ skip_firing_dcmds:
 					fusion->pd_seq_sync[i],
 					fusion->pd_seq_phys[i]);
 		}
-		megasas_free_fusion_context(instance);
 	} else {
 		megasas_release_mfi(instance);
-		pci_free_consistent(pdev, sizeof(u32),
-				    instance->producer,
-				    instance->producer_h);
-		pci_free_consistent(pdev, sizeof(u32),
-				    instance->consumer,
-				    instance->consumer_h);
 	}
 
 	kfree(instance->ctrl_info);
@@ -6767,6 +6795,8 @@ skip_firing_dcmds:
 		pci_free_consistent(pdev, sizeof(struct MR_DRV_SYSTEM_INFO),
 				    instance->system_info_buf, instance->system_info_h);
 
+	megasas_free_ctrl_mem(instance);
+
 	scsi_host_put(host);
 
 	pci_disable_device(pdev);


