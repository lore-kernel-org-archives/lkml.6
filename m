Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162374AbeE1Kha (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:37:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162020AbeE1Kh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:37:26 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 248/329] net: bgmac: Fix endian access in bgmac_dma_tx_ring_free()
Date: Mon, 28 May 2018 12:02:57 +0200
Message-Id: <20180528100302.638012195@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 60d6e6f0b9e422dd01aeda39257ee0428e5e2a3f ]

bgmac_dma_tx_ring_free() assigns the ctl1 word which is a litle endian
32-bit word without using proper accessors, fix this, and because a
length cannot be negative, use unsigned int while at it.

Fixes: 9cde94506eac ("bgmac: implement scatter/gather support")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bgmac.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -529,7 +529,8 @@ static void bgmac_dma_tx_ring_free(struc
 	int i;
 
 	for (i = 0; i < BGMAC_TX_RING_SLOTS; i++) {
-		int len = dma_desc[i].ctl1 & BGMAC_DESC_CTL1_LEN;
+		u32 ctl1 = le32_to_cpu(dma_desc[i].ctl1);
+		unsigned int len = ctl1 & BGMAC_DESC_CTL1_LEN;
 
 		slot = &ring->slots[i];
 		dev_kfree_skb(slot->skb);
