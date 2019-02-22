Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07EAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 01:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5482080F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 01:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfBVBHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 20:07:48 -0500
Received: from mga06.intel.com ([134.134.136.31]:22794 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbfBVBHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 20:07:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 17:07:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,397,1544515200"; 
   d="scan'208";a="124288743"
Received: from debian-vmd.lm.intel.com ([10.232.112.218])
  by fmsmga007.fm.intel.com with ESMTP; 21 Feb 2019 17:07:46 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-nvme@lists.infradead.org>
Cc:     Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Alex Gagniuc <alex_gagniuc@dellteam.com>,
        <linux-kernel@vger.kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
Date:   Thu, 21 Feb 2019 18:05:02 -0700
Message-Id: <20190222010502.2434-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms don't seem to easily tolerate non-posted mmio reads on
lost (hot removed) devices. This has been noted in previous
modifications to other layers where an mmio read to a lost device could
cause an undesired firmware intervention [1][2].

This patch reworks the nvme-pci reads to quickly check connectivity
prior to reading the BAR. The intent is to prevent a non-posted mmio
read which would definitely result in an error condition of some sort.
There is, of course, a chance the link becomes disconnected between the
check and the read. Like other similar checks, it is only intended to
reduce the likelihood of encountering these issues and not fully close
the gap.

mmio writes are posted and in the fast path and have been left as-is.

[1] https://lkml.org/lkml/2018/7/30/858
[2] https://lkml.org/lkml/2018/9/18/1546

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/nvme/host/pci.c | 75 ++++++++++++++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f54718b63637..e555ac2afacd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1264,6 +1264,33 @@ static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
 			 csts, result);
 }
 
+static int nvme_reg_readl(struct nvme_dev *dev, u32 off, u32 *val)
+{
+	if (pci_channel_offline(to_pci_dev(dev->dev)))
+		return -ENODEV;
+
+	*val = readl(dev->bar + off);
+	return 0;
+}
+
+static int nvme_reg_readq(struct nvme_dev *dev, u32 off, u64 *val)
+{
+	if (pci_channel_offline(to_pci_dev(dev->dev)))
+		return -ENODEV;
+
+	*val = readq(dev->bar + off);
+	return 0;
+}
+
+static int nvme_reg_lo_hi_readq(struct nvme_dev *dev, u32 off, u64 *val)
+{
+	if (pci_channel_offline(to_pci_dev(dev->dev)))
+		return -ENODEV;
+
+	*val = lo_hi_readq(dev->bar + off);
+	return 0;
+}
+
 static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
@@ -1271,13 +1298,13 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	struct nvme_dev *dev = nvmeq->dev;
 	struct request *abort_req;
 	struct nvme_command cmd;
-	u32 csts = readl(dev->bar + NVME_REG_CSTS);
+	u32 csts;
 
 	/* If PCI error recovery process is happening, we cannot reset or
 	 * the recovery mechanism will surely fail.
 	 */
 	mb();
-	if (pci_channel_offline(to_pci_dev(dev->dev)))
+	if (nvme_reg_readl(dev, NVME_REG_CSTS, &csts))
 		return BLK_EH_RESET_TIMER;
 
 	/*
@@ -1692,18 +1719,24 @@ static int nvme_remap_bar(struct nvme_dev *dev, unsigned long size)
 static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 {
 	int result;
-	u32 aqa;
+	u32 csts, vs, aqa;
 	struct nvme_queue *nvmeq;
 
 	result = nvme_remap_bar(dev, db_bar_size(dev, 0));
 	if (result < 0)
 		return result;
 
-	dev->subsystem = readl(dev->bar + NVME_REG_VS) >= NVME_VS(1, 1, 0) ?
-				NVME_CAP_NSSRC(dev->ctrl.cap) : 0;
+	result = nvme_reg_readl(dev, NVME_REG_CSTS, &csts);
+	if (result)
+		return result;
+
+	result = nvme_reg_readl(dev, NVME_REG_VS, &vs);
+	if (result)
+		return result;
 
-	if (dev->subsystem &&
-	    (readl(dev->bar + NVME_REG_CSTS) & NVME_CSTS_NSSRO))
+	dev->subsystem = (vs >= NVME_VS(1, 1, 0)) ?
+				NVME_CAP_NSSRC(dev->ctrl.cap) : 0;
+	if (dev->subsystem && (csts & NVME_CSTS_NSSRO))
 		writel(NVME_CSTS_NSSRO, dev->bar + NVME_REG_CSTS);
 
 	result = nvme_disable_ctrl(&dev->ctrl, dev->ctrl.cap);
@@ -1808,10 +1841,11 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 	if (dev->cmb_size)
 		return;
 
-	dev->cmbsz = readl(dev->bar + NVME_REG_CMBSZ);
-	if (!dev->cmbsz)
+	if (nvme_reg_readl(dev, NVME_REG_CMBSZ, &dev->cmbsz) || !dev->cmbsz)
+		return;
+
+	if (nvme_reg_readl(dev, NVME_REG_CMBLOC, &dev->cmbloc))
 		return;
-	dev->cmbloc = readl(dev->bar + NVME_REG_CMBLOC);
 
 	size = nvme_cmb_size_unit(dev) * nvme_cmb_size(dev);
 	offset = nvme_cmb_size_unit(dev) * NVME_CMB_OFST(dev->cmbloc);
@@ -2357,6 +2391,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 {
 	int result = -ENOMEM;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	u32 csts;
 
 	if (pci_enable_device_mem(pdev))
 		return result;
@@ -2367,7 +2402,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	    dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(32)))
 		goto disable;
 
-	if (readl(dev->bar + NVME_REG_CSTS) == -1) {
+	if (nvme_reg_readl(dev, NVME_REG_CSTS, &csts) || csts == -1) {
 		result = -ENODEV;
 		goto disable;
 	}
@@ -2381,7 +2416,9 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	if (result < 0)
 		return result;
 
-	dev->ctrl.cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
+	result = nvme_reg_lo_hi_readq(dev, NVME_REG_CAP, &dev->ctrl.cap);
+	if (result)
+		return result;
 
 	dev->q_depth = min_t(int, NVME_CAP_MQES(dev->ctrl.cap) + 1,
 				io_queue_depth);
@@ -2442,13 +2479,15 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 
 	mutex_lock(&dev->shutdown_lock);
 	if (pci_is_enabled(pdev)) {
-		u32 csts = readl(dev->bar + NVME_REG_CSTS);
+		u32 csts;
 
 		if (dev->ctrl.state == NVME_CTRL_LIVE ||
 		    dev->ctrl.state == NVME_CTRL_RESETTING)
 			nvme_start_freeze(&dev->ctrl);
-		dead = !!((csts & NVME_CSTS_CFS) || !(csts & NVME_CSTS_RDY) ||
-			pdev->error_state  != pci_channel_io_normal);
+
+		if (nvme_reg_readl(dev, NVME_REG_CSTS, &csts) == 0)
+			dead = !!((csts & NVME_CSTS_CFS) ||
+				!(csts & NVME_CSTS_RDY));
 	}
 
 	/*
@@ -2661,8 +2700,7 @@ static void nvme_remove_dead_ctrl_work(struct work_struct *work)
 
 static int nvme_pci_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 {
-	*val = readl(to_nvme_dev(ctrl)->bar + off);
-	return 0;
+	return nvme_reg_readl(to_nvme_dev(ctrl), off, val);
 }
 
 static int nvme_pci_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
@@ -2673,8 +2711,7 @@ static int nvme_pci_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 
 static int nvme_pci_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 {
-	*val = readq(to_nvme_dev(ctrl)->bar + off);
-	return 0;
+	return nvme_reg_readq(to_nvme_dev(ctrl), off, val);
 }
 
 static int nvme_pci_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
-- 
2.19.1

