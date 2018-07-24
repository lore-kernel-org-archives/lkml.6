Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED593ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D5120852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D5120852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388746AbeGXPmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:42:52 -0400
Received: from bran.ispras.ru ([83.149.199.196]:16389 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388448AbeGXPmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:42:51 -0400
Received: from myklebust.intra.ispras.ru (unknown [10.10.2.207])
        by smtp.ispras.ru (Postfix) with ESMTP id E7056203C6;
        Tue, 24 Jul 2018 17:36:02 +0300 (MSK)
From:   Anton Vasilyev <vasilyev@ispras.ru>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Anton Vasilyev <vasilyev@ispras.ru>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Even Xu <even.xu@intel.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] HID: intel_ish-hid: tx_buf memory leak on probe/remove
Date:   Tue, 24 Jul 2018 17:34:55 +0300
Message-Id: <20180724143455.13770-1-vasilyev@ispras.ru>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <fbac7919db6874c76ef3ac628c8356968bb55d7a.camel@linux.intel.com>
References: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ish_dev_init() allocates 512*176 bytes memory for tx_buf and stores it at
&dev->wr_free_list_head.link list on ish_probe().
But there is no deallocation of this memory in ish_remove() and in
ish_probe() error path.
So current intel-ish-ipc provides 88 KB memory leak for each
probe/release.

The patch replaces kzalloc allocation by devm_kzalloc and removes
ishtp_device *dev deallocation by kfree.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
 drivers/hid/intel-ish-hid/ipc/ipc.c     | 7 +++++--
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 2 --
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-ish-hid/ipc/ipc.c
index 9a60ec13cb10..2f8e5402b450 100644
--- a/drivers/hid/intel-ish-hid/ipc/ipc.c
+++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
@@ -907,7 +907,8 @@ struct ishtp_device *ish_dev_init(struct pci_dev *pdev)
 	struct ishtp_device *dev;
 	int	i;
 
-	dev = kzalloc(sizeof(struct ishtp_device) + sizeof(struct ish_hw),
+	dev = devm_kzalloc(&pdev->dev,
+		sizeof(struct ishtp_device) + sizeof(struct ish_hw),
 		GFP_KERNEL);
 	if (!dev)
 		return NULL;
@@ -925,7 +926,9 @@ struct ishtp_device *ish_dev_init(struct pci_dev *pdev)
 	for (i = 0; i < IPC_TX_FIFO_SIZE; ++i) {
 		struct wr_msg_ctl_info	*tx_buf;
 
-		tx_buf = kzalloc(sizeof(struct wr_msg_ctl_info), GFP_KERNEL);
+		tx_buf = devm_kzalloc(&pdev->dev,
+			sizeof(struct wr_msg_ctl_info),
+			GFP_KERNEL);
 		if (!tx_buf) {
 			/*
 			 * IPC buffers may be limited or not available
diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index a2c53ea3b5ed..81d035a480bc 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -172,7 +172,6 @@ static int ish_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	free_irq(pdev->irq, dev);
 free_device:
 	pci_iounmap(pdev, hw->mem_addr);
-	kfree(dev);
 release_regions:
 	pci_release_regions(pdev);
 disable_device:
@@ -202,7 +201,6 @@ static void ish_remove(struct pci_dev *pdev)
 	pci_release_regions(pdev);
 	pci_clear_master(pdev);
 	pci_disable_device(pdev);
-	kfree(ishtp_dev);
 }
 
 static struct device __maybe_unused *ish_resume_device;
-- 
2.18.0

