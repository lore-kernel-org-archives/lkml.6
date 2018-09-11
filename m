Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F5FC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED6B20865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED6B20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbeILEqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 00:46:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:5845 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728250AbeILEqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 00:46:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 16:45:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,362,1531810800"; 
   d="scan'208";a="72208242"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.116.215])
  by orsmga007.jf.intel.com with ESMTP; 11 Sep 2018 16:45:02 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hong Liu <hong.liu@intel.com>
Subject: [PATCH 9/9] HID: intel-ish-hid: using list_head for ipc write queue
Date:   Tue, 11 Sep 2018 16:44:21 -0700
Message-Id: <20180911234421.10691-10-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180911234421.10691-1-srinivas.pandruvada@linux.intel.com>
References: <20180911234421.10691-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hong Liu <hong.liu@intel.com>

Currently wr_msg_ctl_info is used in ishtp_device just for list head
purpose, using list_head directly can save ~150 bytes size for
each replacement.

Also this patch can save ~170 bytes of code size in intel-ish-ipc.ko.

Signed-off-by: Hong Liu <hong.liu@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ipc/ipc.c         | 32 +++++++++------------
 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h |  2 +-
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-ish-hid/ipc/ipc.c
index bfbca7ec54ce..742191bb24c6 100644
--- a/drivers/hid/intel-ish-hid/ipc/ipc.c
+++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
@@ -280,14 +280,14 @@ static int write_ipc_from_queue(struct ishtp_device *dev)
 	 * if tx send list is empty - return 0;
 	 * may happen, as RX_COMPLETE handler doesn't check list emptiness.
 	 */
-	if (list_empty(&dev->wr_processing_list_head.link)) {
+	if (list_empty(&dev->wr_processing_list)) {
 		spin_unlock_irqrestore(&dev->wr_processing_spinlock, flags);
 		out_ipc_locked = 0;
 		return	0;
 	}
 
-	ipc_link = list_entry(dev->wr_processing_list_head.link.next,
-			      struct wr_msg_ctl_info, link);
+	ipc_link = list_first_entry(&dev->wr_processing_list,
+				    struct wr_msg_ctl_info, link);
 	/* first 4 bytes of the data is the doorbell value (IPC header) */
 	length = ipc_link->length - sizeof(uint32_t);
 	doorbell_val = *(uint32_t *)ipc_link->inline_data;
@@ -338,7 +338,7 @@ static int write_ipc_from_queue(struct ishtp_device *dev)
 	ipc_send_compl = ipc_link->ipc_send_compl;
 	ipc_send_compl_prm = ipc_link->ipc_send_compl_prm;
 	list_del_init(&ipc_link->link);
-	list_add_tail(&ipc_link->link, &dev->wr_free_list_head.link);
+	list_add(&ipc_link->link, &dev->wr_free_list);
 	spin_unlock_irqrestore(&dev->wr_processing_spinlock, flags);
 
 	/*
@@ -372,18 +372,18 @@ static int write_ipc_to_queue(struct ishtp_device *dev,
 	unsigned char *msg, int length)
 {
 	struct wr_msg_ctl_info *ipc_link;
-	unsigned long	flags;
+	unsigned long flags;
 
 	if (length > IPC_FULL_MSG_SIZE)
 		return -EMSGSIZE;
 
 	spin_lock_irqsave(&dev->wr_processing_spinlock, flags);
-	if (list_empty(&dev->wr_free_list_head.link)) {
+	if (list_empty(&dev->wr_free_list)) {
 		spin_unlock_irqrestore(&dev->wr_processing_spinlock, flags);
 		return -ENOMEM;
 	}
-	ipc_link = list_entry(dev->wr_free_list_head.link.next,
-		struct wr_msg_ctl_info, link);
+	ipc_link = list_first_entry(&dev->wr_free_list,
+				    struct wr_msg_ctl_info, link);
 	list_del_init(&ipc_link->link);
 
 	ipc_link->ipc_send_compl = ipc_send_compl;
@@ -391,7 +391,7 @@ static int write_ipc_to_queue(struct ishtp_device *dev,
 	ipc_link->length = length;
 	memcpy(ipc_link->inline_data, msg, length);
 
-	list_add_tail(&ipc_link->link, &dev->wr_processing_list_head.link);
+	list_add_tail(&ipc_link->link, &dev->wr_processing_list);
 	spin_unlock_irqrestore(&dev->wr_processing_spinlock, flags);
 
 	write_ipc_from_queue(dev);
@@ -487,17 +487,13 @@ static int ish_fw_reset_handler(struct ishtp_device *dev)
 {
 	uint32_t	reset_id;
 	unsigned long	flags;
-	struct wr_msg_ctl_info *processing, *next;
 
 	/* Read reset ID */
 	reset_id = ish_reg_read(dev, IPC_REG_ISH2HOST_MSG) & 0xFFFF;
 
 	/* Clear IPC output queue */
 	spin_lock_irqsave(&dev->wr_processing_spinlock, flags);
-	list_for_each_entry_safe(processing, next,
-			&dev->wr_processing_list_head.link, link) {
-		list_move_tail(&processing->link, &dev->wr_free_list_head.link);
-	}
+	list_splice_init(&dev->wr_processing_list, &dev->wr_free_list);
 	spin_unlock_irqrestore(&dev->wr_processing_spinlock, flags);
 
 	/* ISHTP notification in IPC_RESET */
@@ -921,9 +917,9 @@ struct ishtp_device *ish_dev_init(struct pci_dev *pdev)
 	spin_lock_init(&dev->out_ipc_spinlock);
 
 	/* Init IPC processing and free lists */
-	INIT_LIST_HEAD(&dev->wr_processing_list_head.link);
-	INIT_LIST_HEAD(&dev->wr_free_list_head.link);
-	for (i = 0; i < IPC_TX_FIFO_SIZE; ++i) {
+	INIT_LIST_HEAD(&dev->wr_processing_list);
+	INIT_LIST_HEAD(&dev->wr_free_list);
+	for (i = 0; i < IPC_TX_FIFO_SIZE; i++) {
 		struct wr_msg_ctl_info	*tx_buf;
 
 		tx_buf = devm_kzalloc(&pdev->dev,
@@ -939,7 +935,7 @@ struct ishtp_device *ish_dev_init(struct pci_dev *pdev)
 				i);
 			break;
 		}
-		list_add_tail(&tx_buf->link, &dev->wr_free_list_head.link);
+		list_add_tail(&tx_buf->link, &dev->wr_free_list);
 	}
 
 	dev->ops = &ish_hw_ops;
diff --git a/drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h b/drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h
index 6a6d927b78b0..e7c6bfefaf9e 100644
--- a/drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h
+++ b/drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h
@@ -207,7 +207,7 @@ struct ishtp_device {
 	struct work_struct bh_hbm_work;
 
 	/* IPC write queue */
-	struct wr_msg_ctl_info wr_processing_list_head, wr_free_list_head;
+	struct list_head wr_processing_list, wr_free_list;
 	/* For both processing list  and free list */
 	spinlock_t wr_processing_spinlock;
 
-- 
2.17.1

