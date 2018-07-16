Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9862AECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D15C206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D15C206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388957AbeGPIJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:09:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47932 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730161AbeGPIJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:09:11 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F0778C03;
        Mon, 16 Jul 2018 07:43:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Black <christian.d.black@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Scott Bauer <scott.bauer@intel.com>
Subject: [PATCH 4.9 25/32] nvme-pci: Remap CMB SQ entries on every controller reset
Date:   Mon, 16 Jul 2018 09:36:33 +0200
Message-Id: <20180716073507.676609755@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073504.433996952@linuxfoundation.org>
References: <20180716073504.433996952@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keith Busch <keith.busch@intel.com>

commit 815c6704bf9f1c59f3a6be380a4032b9c57b12f1 upstream.

The controller memory buffer is remapped into a kernel address on each
reset, but the driver was setting the submission queue base address
only on the very first queue creation. The remapped address is likely to
change after a reset, so accessing the old address will hit a kernel bug.

This patch fixes that by setting the queue's CMB base address each time
the queue is created.

Fixes: f63572dff1421 ("nvme: unmap CMB and remove sysfs file in reset path")
Reported-by: Christian Black <christian.d.black@intel.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>
Cc: <stable@vger.kernel.org> # 4.9+
Signed-off-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Scott Bauer <scott.bauer@intel.com>
Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvme/host/pci.c |   27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1034,17 +1034,15 @@ static int nvme_cmb_qdepth(struct nvme_d
 static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 				int qid, int depth)
 {
-	if (qid && dev->cmb && use_cmb_sqes && NVME_CMB_SQS(dev->cmbsz)) {
-		unsigned offset = (qid - 1) * roundup(SQ_SIZE(depth),
-						      dev->ctrl.page_size);
-		nvmeq->sq_dma_addr = dev->cmb_bus_addr + offset;
-		nvmeq->sq_cmds_io = dev->cmb + offset;
-	} else {
-		nvmeq->sq_cmds = dma_alloc_coherent(dev->dev, SQ_SIZE(depth),
-					&nvmeq->sq_dma_addr, GFP_KERNEL);
-		if (!nvmeq->sq_cmds)
-			return -ENOMEM;
-	}
+
+	/* CMB SQEs will be mapped before creation */
+	if (qid && dev->cmb && use_cmb_sqes && NVME_CMB_SQS(dev->cmbsz))
+		return 0;
+
+	nvmeq->sq_cmds = dma_alloc_coherent(dev->dev, SQ_SIZE(depth),
+					    &nvmeq->sq_dma_addr, GFP_KERNEL);
+	if (!nvmeq->sq_cmds)
+		return -ENOMEM;
 
 	return 0;
 }
@@ -1117,6 +1115,13 @@ static int nvme_create_queue(struct nvme
 	struct nvme_dev *dev = nvmeq->dev;
 	int result;
 
+	if (qid && dev->cmb && use_cmb_sqes && NVME_CMB_SQS(dev->cmbsz)) {
+		unsigned offset = (qid - 1) * roundup(SQ_SIZE(nvmeq->q_depth),
+						      dev->ctrl.page_size);
+		nvmeq->sq_dma_addr = dev->cmb_bus_addr + offset;
+		nvmeq->sq_cmds_io = dev->cmb + offset;
+	}
+
 	nvmeq->cq_vector = qid - 1;
 	result = adapter_alloc_cq(dev, qid, nvmeq);
 	if (result < 0)


