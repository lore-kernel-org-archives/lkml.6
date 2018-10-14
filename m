Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8615C7112B
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A2C20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A2C20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbeJNXmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:42:35 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35813 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727343AbeJNXLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:48 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLb-0004cW-J7; Sun, 14 Oct 2018 16:30:27 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLZ-0000gG-9A; Sun, 14 Oct 2018 16:30:25 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Shelley Gong" <shelleygong@vmware.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>,
        "Bhavesh Davda" <bhavesh@vmware.com>,
        "Andy King" <acking@vmware.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.89327805@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 309/366] VMXNET3: Check for map error in vmxnet3_set_mc
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andy King <acking@vmware.com>

commit 4ad9a64f53c619969dede1143d56ccda1a453c39 upstream.

We should check if the map of the table actually succeeds, and also free
resources accordingly.

Version bumped to 1.2.1.0

Acked-by: Shelley Gong <shelleygong@vmware.com>
Acked-by: Bhavesh Davda <bhavesh@vmware.com>
Signed-off-by: Andy King <acking@vmware.com>
Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 15 ++++++++-------
 drivers/net/vmxnet3/vmxnet3_int.h |  4 ++--
 2 files changed, 10 insertions(+), 9 deletions(-)

--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2056,7 +2056,6 @@ vmxnet3_set_mc(struct net_device *netdev
 		if (!netdev_mc_empty(netdev)) {
 			new_table = vmxnet3_copy_mc(netdev);
 			if (new_table) {
-				new_mode |= VMXNET3_RXM_MCAST;
 				rxConf->mfTableLen = cpu_to_le16(
 					netdev_mc_count(netdev) * ETH_ALEN);
 				new_table_pa = dma_map_single(
@@ -2064,15 +2063,18 @@ vmxnet3_set_mc(struct net_device *netdev
 							new_table,
 							rxConf->mfTableLen,
 							PCI_DMA_TODEVICE);
+			}
+
+			if (new_table_pa) {
+				new_mode |= VMXNET3_RXM_MCAST;
 				rxConf->mfTablePA = cpu_to_le64(new_table_pa);
 			} else {
-				netdev_info(netdev, "failed to copy mcast list"
-					    ", setting ALL_MULTI\n");
+				netdev_info(netdev,
+					    "failed to copy mcast list, setting ALL_MULTI\n");
 				new_mode |= VMXNET3_RXM_ALL_MULTI;
 			}
 		}
 
-
 	if (!(new_mode & VMXNET3_RXM_MCAST)) {
 		rxConf->mfTableLen = 0;
 		rxConf->mfTablePA = 0;
@@ -2091,11 +2093,10 @@ vmxnet3_set_mc(struct net_device *netdev
 			       VMXNET3_CMD_UPDATE_MAC_FILTERS);
 	spin_unlock_irqrestore(&adapter->cmd_lock, flags);
 
-	if (new_table) {
+	if (new_table_pa)
 		dma_unmap_single(&adapter->pdev->dev, new_table_pa,
 				 rxConf->mfTableLen, PCI_DMA_TODEVICE);
-		kfree(new_table);
-	}
+	kfree(new_table);
 }
 
 void
--- a/drivers/net/vmxnet3/vmxnet3_int.h
+++ b/drivers/net/vmxnet3/vmxnet3_int.h
@@ -69,10 +69,10 @@
 /*
  * Version numbers
  */
-#define VMXNET3_DRIVER_VERSION_STRING   "1.2.0.0-k"
+#define VMXNET3_DRIVER_VERSION_STRING   "1.2.1.0-k"
 
 /* a 32-bit int, each byte encode a verion number in VMXNET3_DRIVER_VERSION */
-#define VMXNET3_DRIVER_VERSION_NUM      0x01020000
+#define VMXNET3_DRIVER_VERSION_NUM      0x01020100
 
 #if defined(CONFIG_PCI_MSI)
 	/* RSS only makes sense if MSI-X is supported. */

