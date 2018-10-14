Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1986C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4DA20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4DA20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbeJNXlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:41:52 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35833 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727362AbeJNXLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:48 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLb-0004cd-IH; Sun, 14 Oct 2018 16:30:27 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLZ-0000gg-AS; Sun, 14 Oct 2018 16:30:25 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Alexey Khoroshilov" <khoroshilov@ispras.ru>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.507522024@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 311/366] vmxnet3: avoid assumption about invalid
 dma_pa in vmxnet3_set_mc()
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

From: Alexey Khoroshilov <khoroshilov@ispras.ru>

commit fb5c6cfaec126d9a96b9dd471d4711bf4c737a6f upstream.

vmxnet3_set_mc() checks new_table_pa returned by dma_map_single()
with dma_mapping_error(), but even there it assumes zero is invalid pa
(it assumes dma_mapping_error(...,0) returns true if new_table is NULL).

The patch adds an explicit variable to track status of new_table_pa.

Found by Linux Driver Verification project (linuxtesting.org).

v2: use "bool" and "true"/"false" for boolean variables.
Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2078,6 +2078,7 @@ vmxnet3_set_mc(struct net_device *netdev
 					&adapter->shared->devRead.rxFilterConf;
 	u8 *new_table = NULL;
 	dma_addr_t new_table_pa = 0;
+	bool new_table_pa_valid = false;
 	u32 new_mode = VMXNET3_RXM_UCAST;
 
 	if (netdev->flags & IFF_PROMISC) {
@@ -2105,13 +2106,15 @@ vmxnet3_set_mc(struct net_device *netdev
 							new_table,
 							rxConf->mfTableLen,
 							PCI_DMA_TODEVICE);
+				if (!dma_mapping_error(&adapter->pdev->dev,
+						       new_table_pa)) {
+					new_mode |= VMXNET3_RXM_MCAST;
+					new_table_pa_valid = true;
+					rxConf->mfTablePA = cpu_to_le64(
+								new_table_pa);
+				}
 			}
-
-			if (!dma_mapping_error(&adapter->pdev->dev,
-					       new_table_pa)) {
-				new_mode |= VMXNET3_RXM_MCAST;
-				rxConf->mfTablePA = cpu_to_le64(new_table_pa);
-			} else {
+			if (!new_table_pa_valid) {
 				netdev_info(netdev,
 					    "failed to copy mcast list, setting ALL_MULTI\n");
 				new_mode |= VMXNET3_RXM_ALL_MULTI;
@@ -2136,7 +2139,7 @@ vmxnet3_set_mc(struct net_device *netdev
 			       VMXNET3_CMD_UPDATE_MAC_FILTERS);
 	spin_unlock_irqrestore(&adapter->cmd_lock, flags);
 
-	if (new_table_pa)
+	if (new_table_pa_valid)
 		dma_unmap_single(&adapter->pdev->dev, new_table_pa,
 				 rxConf->mfTableLen, PCI_DMA_TODEVICE);
 	kfree(new_table);

