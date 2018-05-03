Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbeECEYP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 00:24:15 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:54560 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751940AbeECEYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 00:24:12 -0400
Date: Thu, 03 May 2018 14:24:09 +1000
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-m68k@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH net] macsonic: Set platform device coherent_dma_mask
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-Id: <S1752066AbeECEYP/20180503042416Z+261@vger.kernel.org>

Set the device's coherent_dma_mask to avoid a WARNING splat.
Please see commit 205e1b7f51e4 ("dma-mapping: warn when there is
no coherent_dma_mask").

Cc: linux-m68k@lists.linux-m68k.org
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/net/ethernet/natsemi/macsonic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/natsemi/macsonic.c b/drivers/net/ethernet/natsemi/macsonic.c
index 0937fc2a928e..37b1ffa8bb61 100644
--- a/drivers/net/ethernet/natsemi/macsonic.c
+++ b/drivers/net/ethernet/natsemi/macsonic.c
@@ -523,6 +523,10 @@ static int mac_sonic_platform_probe(struct platform_device *pdev)
 	struct sonic_local *lp;
 	int err;
 
+	err = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (err)
+		return err;
+
 	dev = alloc_etherdev(sizeof(struct sonic_local));
 	if (!dev)
 		return -ENOMEM;
-- 
2.16.1
