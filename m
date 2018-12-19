Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3653C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979E821852
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=areca-com-tw.20150623.gappssmtp.com header.i=@areca-com-tw.20150623.gappssmtp.com header.b="NJUaUTgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbeLSIbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:31:05 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:33435 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbeLSIbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:31:05 -0500
Received: by mail-io1-f68.google.com with SMTP id t24so14985608ioi.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 00:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WeSLew23ZXvkRzyHSNTK06KLlWcVzwNVbnboM67i9jE=;
        b=NJUaUTgmFopHSji30Jtx8blx2j6U2eXYxqnOccebEGqSUKbQsdjjuxSgNclLOzWxQL
         mMQBcPD71niEnaHn+srXvTBWT3kdLF+HL080hk5fGP3wbHTVJfDz2ZoP8ZdK9rJwpmQv
         FJC3lBvCxOyl6eL8M9SRiHaJEs/F0S1n6FmLgzSyAi/hrhN/3yucXT7KltCXeIRB8Snf
         hAbtJgEsmhbtMAf02LLutd/pw12WCW/OFNLOPY0Bggnc5GlJMZgiz9fUdj4TNUX6iIie
         vp4g73SYaeWNNsduRVsKBkqk6CQZoGUqcOOFu9zTyMqFBkpqGUhYEgxR9cnEQ8B+X/mn
         fJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WeSLew23ZXvkRzyHSNTK06KLlWcVzwNVbnboM67i9jE=;
        b=n3ffJhqsgVfOF5Ldp2bYf546QGvQnUbGUEjI1NYIvuKzQI8wi0BEI8Mphyx4K7M29v
         CTBhDneNHJCLaqVK09Dlq8VZdYBEYZHvNOmPoxgfDjjcFYDlyP0xgyBKTy/wZTHa8ooB
         kYGdrvDfhUFsIwuQhZl1Ku1e1pPwIulEtfmYM0DXpmXzx7nPZoUmm8HebIR+7e/FWMPX
         voUSPuOmaT0vf2vK6qhnecMxuhR18vT2m81WmGsujJrxE5fxoqQRDAuyFe3ip0aljxDO
         8SdMpjHhgx8XYOUSDLnYtm4XMtI2U9YkWW+6dAAI5caNOhkPCZCfVoA+LnjPsY3IsE1T
         Ck8w==
X-Gm-Message-State: AJcUukeMNH9gXEce1Q15W7OhwpUk7+AUGZiXiXqiQpXF4wfsi4VhDml/
        C45fvP5TMHycStwrB2Bxw4pnzg==
X-Google-Smtp-Source: ALg8bN7b9zBqirEdGGFEQDDu3EtYlFwZbMYpu8FOB9oRly0HC3+TXM37vXX20J/MSkyP/SBlX7MPng==
X-Received: by 2002:a6b:2b95:: with SMTP id r143mr201506ior.217.1545208264137;
        Wed, 19 Dec 2018 00:31:04 -0800 (PST)
Received: from [192.168.0.130] (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id d21sm175833ioc.14.2018.12.19.00.31.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 00:31:03 -0800 (PST)
Subject: [PATCH 3/12] scsi: arcmsr: Merge arcmsr_alloc_io_queue to
 arcmsr_alloc_ccb_pool
From:   Ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, hch@infradead.org,
        colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 19 Dec 2018 16:31:00 +0800
Message-ID: <1545208260.4457.22.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Ching Huang <ching2048@areca.com.tw>

Merge arcmsr_alloc_io_queue to arcmsr_alloc_ccb_pool

Signed-off-by: Ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index f831c13..e1c75ca 100755
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -576,6 +576,58 @@ static void arcmsr_flush_adapter_cache(struct AdapterControlBlock *acb)
 	}
 }
 
+static void arcmsr_hbaB_assign_regAddr(struct AdapterControlBlock *acb)
+{
+	struct MessageUnit_B *reg = acb->pmuB;
+
+	if (acb->pdev->device == PCI_DEVICE_ID_ARECA_1203) {
+		reg->drv2iop_doorbell = MEM_BASE0(ARCMSR_DRV2IOP_DOORBELL_1203);
+		reg->drv2iop_doorbell_mask = MEM_BASE0(ARCMSR_DRV2IOP_DOORBELL_MASK_1203);
+		reg->iop2drv_doorbell = MEM_BASE0(ARCMSR_IOP2DRV_DOORBELL_1203);
+		reg->iop2drv_doorbell_mask = MEM_BASE0(ARCMSR_IOP2DRV_DOORBELL_MASK_1203);
+	} else {
+		reg->drv2iop_doorbell= MEM_BASE0(ARCMSR_DRV2IOP_DOORBELL);
+		reg->drv2iop_doorbell_mask = MEM_BASE0(ARCMSR_DRV2IOP_DOORBELL_MASK);
+		reg->iop2drv_doorbell = MEM_BASE0(ARCMSR_IOP2DRV_DOORBELL);
+		reg->iop2drv_doorbell_mask = MEM_BASE0(ARCMSR_IOP2DRV_DOORBELL_MASK);
+	}
+	reg->message_wbuffer = MEM_BASE1(ARCMSR_MESSAGE_WBUFFER);
+	reg->message_rbuffer =  MEM_BASE1(ARCMSR_MESSAGE_RBUFFER);
+	reg->message_rwbuffer = MEM_BASE1(ARCMSR_MESSAGE_RWBUFFER);
+}
+
+static void arcmsr_hbaD_assign_regAddr(struct AdapterControlBlock *acb)
+{
+	struct MessageUnit_D *reg = acb->pmuD;
+
+	reg->chip_id = MEM_BASE0(ARCMSR_ARC1214_CHIP_ID);
+	reg->cpu_mem_config = MEM_BASE0(ARCMSR_ARC1214_CPU_MEMORY_CONFIGURATION);
+	reg->i2o_host_interrupt_mask = MEM_BASE0(ARCMSR_ARC1214_I2_HOST_INTERRUPT_MASK);
+	reg->sample_at_reset = MEM_BASE0(ARCMSR_ARC1214_SAMPLE_RESET);
+	reg->reset_request = MEM_BASE0(ARCMSR_ARC1214_RESET_REQUEST);
+	reg->host_int_status = MEM_BASE0(ARCMSR_ARC1214_MAIN_INTERRUPT_STATUS);
+	reg->pcief0_int_enable = MEM_BASE0(ARCMSR_ARC1214_PCIE_F0_INTERRUPT_ENABLE);
+	reg->inbound_msgaddr0 = MEM_BASE0(ARCMSR_ARC1214_INBOUND_MESSAGE0);
+	reg->inbound_msgaddr1 = MEM_BASE0(ARCMSR_ARC1214_INBOUND_MESSAGE1);
+	reg->outbound_msgaddr0 = MEM_BASE0(ARCMSR_ARC1214_OUTBOUND_MESSAGE0);
+	reg->outbound_msgaddr1 = MEM_BASE0(ARCMSR_ARC1214_OUTBOUND_MESSAGE1);
+	reg->inbound_doorbell = MEM_BASE0(ARCMSR_ARC1214_INBOUND_DOORBELL);
+	reg->outbound_doorbell = MEM_BASE0(ARCMSR_ARC1214_OUTBOUND_DOORBELL);
+	reg->outbound_doorbell_enable = MEM_BASE0(ARCMSR_ARC1214_OUTBOUND_DOORBELL_ENABLE);
+	reg->inboundlist_base_low = MEM_BASE0(ARCMSR_ARC1214_INBOUND_LIST_BASE_LOW);
+	reg->inboundlist_base_high = MEM_BASE0(ARCMSR_ARC1214_INBOUND_LIST_BASE_HIGH);
+	reg->inboundlist_write_pointer = MEM_BASE0(ARCMSR_ARC1214_INBOUND_LIST_WRITE_POINTER);
+	reg->outboundlist_base_low = MEM_BASE0(ARCMSR_ARC1214_OUTBOUND_LIST_BASE_LOW);
+	reg->outboundlist_base_high = MEM_BASE0(ARCMSR_ARC1214_OUTBOUND_LIST_BASE_HIGH);
+	reg->outboundlist_copy_pointer = MEM_BASE0(ARCMSR_ARC1214_OUTBOUND_LIST_COPY_POINTER);
+	reg->outboundlist_read_pointer = MEM_BASE0(ARCMSR_ARC1214_OUTBOUND_LIST_READ_POINTER);
+	reg->outboundlist_interrupt_cause = MEM_BASE0(ARCMSR_ARC1214_OUTBOUND_INTERRUPT_CAUSE);
+	reg->outboundlist_interrupt_enable = MEM_BASE0(ARCMSR_ARC1214_OUTBOUND_INTERRUPT_ENABLE);
+	reg->message_wbuffer = MEM_BASE0(ARCMSR_ARC1214_MESSAGE_WBUFFER);
+	reg->message_rbuffer = MEM_BASE0(ARCMSR_ARC1214_MESSAGE_RBUFFER);
+	reg->msgcode_rwbuffer = MEM_BASE0(ARCMSR_ARC1214_MESSAGE_RWBUFFER);
+}
+
 static bool arcmsr_alloc_io_queue(struct AdapterControlBlock *acb)
 {
 	bool rtn = true;
@@ -585,7 +637,6 @@ static bool arcmsr_alloc_io_queue(struct AdapterControlBlock *acb)
 
 	switch (acb->adapter_type) {
 	case ACB_ADAPTER_TYPE_B: {
-		struct MessageUnit_B *reg;
 		acb->ioqueue_size = roundup(sizeof(struct MessageUnit_B), 32);
 		dma_coherent = dma_zalloc_coherent(&pdev->dev, acb->ioqueue_size,
 			&dma_coherent_handle, GFP_KERNEL);
@@ -595,27 +646,11 @@ static bool arcmsr_alloc_io_queue(struct AdapterControlBlock *acb)
 		}
 		acb->dma_coherent_handle2 = dma_coherent_handle;
 		acb->dma_coherent2 = dma_coherent;
-		reg = (struct MessageUnit_B *)dma_coherent;
-		acb->pmuB = reg;
-		if (acb->pdev->device == PCI_DEVICE_ID_ARECA_1203) {
-			reg->drv2iop_doorbell = MEM_BASE0(ARCMSR_DRV2IOP_DOORBELL_1203);
-			reg->drv2iop_doorbell_mask = MEM_BASE0(ARCMSR_DRV2IOP_DOORBELL_MASK_1203);
-			reg->iop2drv_doorbell = MEM_BASE0(ARCMSR_IOP2DRV_DOORBELL_1203);
-			reg->iop2drv_doorbell_mask = MEM_BASE0(ARCMSR_IOP2DRV_DOORBELL_MASK_1203);
-		} else {
-			reg->drv2iop_doorbell = MEM_BASE0(ARCMSR_DRV2IOP_DOORBELL);
-			reg->drv2iop_doorbell_mask = MEM_BASE0(ARCMSR_DRV2IOP_DOORBELL_MASK);
-			reg->iop2drv_doorbell = MEM_BASE0(ARCMSR_IOP2DRV_DOORBELL);
-			reg->iop2drv_doorbell_mask = MEM_BASE0(ARCMSR_IOP2DRV_DOORBELL_MASK);
-		}
-		reg->message_wbuffer = MEM_BASE1(ARCMSR_MESSAGE_WBUFFER);
-		reg->message_rbuffer = MEM_BASE1(ARCMSR_MESSAGE_RBUFFER);
-		reg->message_rwbuffer = MEM_BASE1(ARCMSR_MESSAGE_RWBUFFER);
+		acb->pmuB = (struct MessageUnit_B *)dma_coherent;
+		arcmsr_hbaB_assign_regAddr(acb);
 		}
 		break;
 	case ACB_ADAPTER_TYPE_D: {
-		struct MessageUnit_D *reg;
-
 		acb->ioqueue_size = roundup(sizeof(struct MessageUnit_D), 32);
 		dma_coherent = dma_zalloc_coherent(&pdev->dev, acb->ioqueue_size,
 			&dma_coherent_handle, GFP_KERNEL);
@@ -625,34 +660,8 @@ static bool arcmsr_alloc_io_queue(struct AdapterControlBlock *acb)
 		}
 		acb->dma_coherent_handle2 = dma_coherent_handle;
 		acb->dma_coherent2 = dma_coherent;
-		reg = (struct MessageUnit_D *)dma_coherent;
-		acb->pmuD = reg;
-		reg->chip_id = MEM_BASE0(ARCMSR_ARC1214_CHIP_ID);
-		reg->cpu_mem_config = MEM_BASE0(ARCMSR_ARC1214_CPU_MEMORY_CONFIGURATION);
-		reg->i2o_host_interrupt_mask = MEM_BASE0(ARCMSR_ARC1214_I2_HOST_INTERRUPT_MASK);
-		reg->sample_at_reset = MEM_BASE0(ARCMSR_ARC1214_SAMPLE_RESET);
-		reg->reset_request = MEM_BASE0(ARCMSR_ARC1214_RESET_REQUEST);
-		reg->host_int_status = MEM_BASE0(ARCMSR_ARC1214_MAIN_INTERRUPT_STATUS);
-		reg->pcief0_int_enable = MEM_BASE0(ARCMSR_ARC1214_PCIE_F0_INTERRUPT_ENABLE);
-		reg->inbound_msgaddr0 = MEM_BASE0(ARCMSR_ARC1214_INBOUND_MESSAGE0);
-		reg->inbound_msgaddr1 = MEM_BASE0(ARCMSR_ARC1214_INBOUND_MESSAGE1);
-		reg->outbound_msgaddr0 = MEM_BASE0(ARCMSR_ARC1214_OUTBOUND_MESSAGE0);
-		reg->outbound_msgaddr1 = MEM_BASE0(ARCMSR_ARC1214_OUTBOUND_MESSAGE1);
-		reg->inbound_doorbell = MEM_BASE0(ARCMSR_ARC1214_INBOUND_DOORBELL);
-		reg->outbound_doorbell = MEM_BASE0(ARCMSR_ARC1214_OUTBOUND_DOORBELL);
-		reg->outbound_doorbell_enable = MEM_BASE0(ARCMSR_ARC1214_OUTBOUND_DOORBELL_ENABLE);
-		reg->inboundlist_base_low = MEM_BASE0(ARCMSR_ARC1214_INBOUND_LIST_BASE_LOW);
-		reg->inboundlist_base_high = MEM_BASE0(ARCMSR_ARC1214_INBOUND_LIST_BASE_HIGH);
-		reg->inboundlist_write_pointer = MEM_BASE0(ARCMSR_ARC1214_INBOUND_LIST_WRITE_POINTER);
-		reg->outboundlist_base_low = MEM_BASE0(ARCMSR_ARC1214_OUTBOUND_LIST_BASE_LOW);
-		reg->outboundlist_base_high = MEM_BASE0(ARCMSR_ARC1214_OUTBOUND_LIST_BASE_HIGH);
-		reg->outboundlist_copy_pointer = MEM_BASE0(ARCMSR_ARC1214_OUTBOUND_LIST_COPY_POINTER);
-		reg->outboundlist_read_pointer = MEM_BASE0(ARCMSR_ARC1214_OUTBOUND_LIST_READ_POINTER);
-		reg->outboundlist_interrupt_cause = MEM_BASE0(ARCMSR_ARC1214_OUTBOUND_INTERRUPT_CAUSE);
-		reg->outboundlist_interrupt_enable = MEM_BASE0(ARCMSR_ARC1214_OUTBOUND_INTERRUPT_ENABLE);
-		reg->message_wbuffer = MEM_BASE0(ARCMSR_ARC1214_MESSAGE_WBUFFER);
-		reg->message_rbuffer = MEM_BASE0(ARCMSR_ARC1214_MESSAGE_RBUFFER);
-		reg->msgcode_rwbuffer = MEM_BASE0(ARCMSR_ARC1214_MESSAGE_RWBUFFER);
+		acb->pmuD = (struct MessageUnit_D *)dma_coherent;
+		arcmsr_hbaD_assign_regAddr(acb);
 		}
 		break;
 	case ACB_ADAPTER_TYPE_E: {
@@ -706,6 +715,7 @@ static int arcmsr_alloc_ccb_pool(struct AdapterControlBlock *acb)
 	acb->host->sg_tablesize = max_sg_entrys;
 	roundup_ccbsize = roundup(sizeof(struct CommandControlBlock) + (max_sg_entrys - 1) * sizeof(struct SG64ENTRY), 32);
 	acb->uncache_size = roundup_ccbsize * acb->maxFreeCCB;
+	acb->uncache_size += acb->ioqueue_size;
 	dma_coherent = dma_alloc_coherent(&pdev->dev, acb->uncache_size, &dma_coherent_handle, GFP_KERNEL);
 	if(!dma_coherent){
 		printk(KERN_NOTICE "arcmsr%d: dma_alloc_coherent got error\n", acb->host->host_no);
@@ -738,6 +748,23 @@ static int arcmsr_alloc_ccb_pool(struct AdapterControlBlock *acb)
 		ccb_tmp = (struct CommandControlBlock *)((unsigned long)ccb_tmp + roundup_ccbsize);
 		dma_coherent_handle = dma_coherent_handle + roundup_ccbsize;
 	}
+	acb->dma_coherent_handle2 = dma_coherent_handle;
+	acb->dma_coherent2 = ccb_tmp;
+	switch (acb->adapter_type) {
+	case ACB_ADAPTER_TYPE_B:
+		acb->pmuB = (struct MessageUnit_B *)acb->dma_coherent2;
+		arcmsr_hbaB_assign_regAddr(acb);
+		break;
+	case ACB_ADAPTER_TYPE_D:
+		acb->pmuD = (struct MessageUnit_D *)acb->dma_coherent2;
+		arcmsr_hbaD_assign_regAddr(acb);
+		break;
+	case ACB_ADAPTER_TYPE_E:
+		acb->pCompletionQ = acb->dma_coherent2;
+		acb->completionQ_entry = acb->ioqueue_size / sizeof(struct deliver_completeQ);
+		acb->doneq_index = 0;
+		break;
+	}	
 	return 0;
 }
 
@@ -959,9 +986,10 @@ static int arcmsr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if(!error){
 		goto free_hbb_mu;
 	}
+	arcmsr_free_io_queue(acb);
 	error = arcmsr_alloc_ccb_pool(acb);
 	if(error){
-		goto free_hbb_mu;
+		goto unmap_pci_region;
 	}
 	error = scsi_add_host(host, &pdev->dev);
 	if(error){
@@ -989,6 +1017,7 @@ scsi_host_remove:
 	scsi_remove_host(host);
 free_ccb_pool:
 	arcmsr_free_ccb_pool(acb);
+	goto unmap_pci_region;
 free_hbb_mu:
 	arcmsr_free_io_queue(acb);
 unmap_pci_region:
@@ -1500,7 +1529,6 @@ static void arcmsr_free_pcidev(struct AdapterControlBlock *acb)
 	pdev = acb->pdev;
 	arcmsr_free_irq(pdev, acb);
 	arcmsr_free_ccb_pool(acb);
-	arcmsr_free_io_queue(acb);
 	arcmsr_unmap_pciregion(acb);
 	pci_release_regions(pdev);
 	scsi_host_put(host);
@@ -1558,7 +1586,6 @@ static void arcmsr_remove(struct pci_dev *pdev)
 	}
 	arcmsr_free_irq(pdev, acb);
 	arcmsr_free_ccb_pool(acb);
-	arcmsr_free_io_queue(acb);
 	arcmsr_unmap_pciregion(acb);
 	pci_release_regions(pdev);
 	scsi_host_put(host);


