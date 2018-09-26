Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17856C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF14C214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF14C214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbeIZTBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:01:09 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:50963 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeIZTBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:01:09 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MN67J-1gNe7r3yIH-00J3Yv; Wed, 26 Sep 2018 14:48:11 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Moritz Fischer <mdf@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: nixge: fix warnings on 32-bit platforms
Date:   Wed, 26 Sep 2018 14:47:24 +0200
Message-Id: <20180926124808.1867468-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:+m0u6MbUQU2M7jZW9luw6tcoPEbGHLx5EJeZuMcyRH4UbyfgC+x
 IaHEUcKZDWrTfRbgBV3FmELZqbuhLhBwMA2fghP6e4YUMZmetyy816RowxbchFiNSCfpi0R
 +cL0zHUSiO7yF9ZfzAXQz+g2hZIpY/RqJBnfqxm50nYVf8Yy8TwBCyrFANa60ifZXWmy7Nc
 hl1SSdXHTIb9pefIrDpwg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YIPCpvXZHMU=:z2NlL/0Zfe0TodzLWw2SUc
 E2tV+EqBzi6HaejRgpHTu6F40Jipo6VPKFW5r3ndg8c+8ONKZkvCKp7YF+G40b6g/naYH0UdZ
 XB9k2kj6v+ku49h9eWKRppTDZTImmYE0LUnERHKGs9Lyk8VPEYT61n23fmmqLgoHYzCiw+Gw5
 bGzF+qphSbMOjRe1zCfovmZ8R1+24rMv50cHWvxTxf8r92P+eFza6Hpkbp+jVeIg63FiFkfX8
 YNNPpuD/j467lCWJBXqcNwZ0AgsVW0loPKea6ftER+ebrlY6MCNcpXJTT+aqagfDMLUREMo91
 APqSvAlbeA1ikuI+h4g/Iw3apZcQtMfTN329coPWE1ZccF4RIMNjU5ZlHVzIqHVT6ad0kIPhI
 JeZy+qvoBNDHzd0z4s053eV35cl5sFYPPhThywxTigmqNGIaGEarE01Atrxy2RLMCPdGAmfc8
 dLDNqIf77mA95mCMV3pteKg8MDbyIHRaKCCV/9Y+48326uJ/qMA8X//rzLUTuFTMWUt+NMsdl
 4o5K7fZpm4Ja3AUE1KDBBTD7HdhNU45J9nu681CQKIj217ZY++LogK1CFoz06+5W6Ut6K8yOC
 S5mhMWdzLZ3Ipj0ljWB+9xYiGroPtz1S0ZaDddTzJMgpoRzh1NHyCxWg8KosNZAsYKdaQiSVe
 U8akbTkrHYZOAdgyvBxlcm4BhJj5zxRxAJ4p7wSTniz5ZoGu+ilq/WrEa9F9cFzkeSnE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Making it work on 64-bit caused 32-bit builds to regress:

drivers/net/ethernet/ni/nixge.c: In function 'nixge_hw_dma_bd_release':
drivers/net/ethernet/ni/nixge.c:254:9: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
   skb = (struct sk_buff *)
         ^
In file included from include/linux/skbuff.h:17,
                 from include/linux/if_ether.h:23,
                 from include/linux/etherdevice.h:25,
                 from drivers/net/ethernet/ni/nixge.c:7:
drivers/net/ethernet/ni/nixge.c: In function 'nixge_hw_dma_bd_init':
drivers/net/ethernet/ni/nixge.c:130:37: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
   (bd)->field##_lo = lower_32_bits(((u64)addr)); \
                                     ^
include/linux/kernel.h:234:33: note: in definition of macro 'lower_32_bits'
 #define lower_32_bits(n) ((u32)(n))
                                 ^

Casting to a uintptr_t avoids all these warnings.

Fixes: 7e8d5755be0e ("net: nixge: Add support for 64-bit platforms")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/ni/nixge.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 74cf52e3fb09..2e132f6a7c36 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -127,8 +127,8 @@ struct nixge_hw_dma_bd {
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
 #define nixge_hw_dma_bd_set_addr(bd, field, addr) \
 	do { \
-		(bd)->field##_lo = lower_32_bits(((u64)addr)); \
-		(bd)->field##_hi = upper_32_bits(((u64)addr)); \
+		(bd)->field##_lo = lower_32_bits(((uintptr_t)addr)); \
+		(bd)->field##_hi = upper_32_bits(((uintptr_t)addr)); \
 	} while (0)
 #else
 #define nixge_hw_dma_bd_set_addr(bd, field, addr) \
@@ -251,7 +251,7 @@ static void nixge_hw_dma_bd_release(struct net_device *ndev)
 				 NIXGE_MAX_JUMBO_FRAME_SIZE,
 				 DMA_FROM_DEVICE);
 
-		skb = (struct sk_buff *)
+		skb = (struct sk_buff *)(uintptr_t)
 			nixge_hw_dma_bd_get_addr(&priv->rx_bd_v[i],
 						 sw_id_offset);
 		dev_kfree_skb(skb);
@@ -601,8 +601,8 @@ static int nixge_recv(struct net_device *ndev, int budget)
 		tail_p = priv->rx_bd_p + sizeof(*priv->rx_bd_v) *
 			 priv->rx_bd_ci;
 
-		skb = (struct sk_buff *)nixge_hw_dma_bd_get_addr(cur_p,
-								 sw_id_offset);
+		skb = (struct sk_buff *)(uintptr_t)
+			nixge_hw_dma_bd_get_addr(cur_p, sw_id_offset);
 
 		length = cur_p->status & XAXIDMA_BD_STS_ACTUAL_LEN_MASK;
 		if (length > NIXGE_MAX_JUMBO_FRAME_SIZE)
-- 
2.18.0

