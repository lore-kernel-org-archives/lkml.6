Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753908AbeDAR06 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 13:26:58 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44588 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753849AbeDAR0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 13:26:44 -0400
X-Google-Smtp-Source: AIpwx4/9LTbgzpEztWh1PBrMRWusJKHpgsCJKnKeDvS+FZKH7yCiaJ8jbhofByFdEuj1YPAgqjob4Q==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Scott Branden <scott.branden@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        linux-kernel@vger.kernel.org (open list), jon.mason@broadcom.com,
        nbd@nbd.name
Subject: [PATCH net 2/2] net: bgmac: Fix endian access in bgmac_dma_tx_ring_free()
Date: Sun,  1 Apr 2018 10:26:30 -0700
Message-Id: <20180401172630.12883-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180401172630.12883-1-f.fainelli@gmail.com>
References: <20180401172630.12883-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bgmac_dma_tx_ring_free() assigns the ctl1 word which is a litle endian
32-bit word without using proper accessors, fix this, and because a
length cannot be negative, use unsigned int while at it.

Fixes: 9cde94506eac ("bgmac: implement scatter/gather support")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/broadcom/bgmac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 8eef9fb6b1fe..ad8195b0d161 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -533,7 +533,8 @@ static void bgmac_dma_tx_ring_free(struct bgmac *bgmac,
 	int i;
 
 	for (i = 0; i < BGMAC_TX_RING_SLOTS; i++) {
-		int len = dma_desc[i].ctl1 & BGMAC_DESC_CTL1_LEN;
+		u32 ctl1 = le32_to_cpu(dma_desc[i].ctl1);
+		unsigned int len = ctl1 & BGMAC_DESC_CTL1_LEN;
 
 		slot = &ring->slots[i];
 		dev_kfree_skb(slot->skb);
-- 
2.14.1
