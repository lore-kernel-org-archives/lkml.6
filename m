Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3825CC38A24
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560FE20C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 560FE20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbeIYDbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 23:31:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44607 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbeIYDbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 23:31:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so9657764pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 14:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=POvph3xI7S9H6HCIhAK8R7p9ttT/ADpFNjKoB4vGEaA=;
        b=Qrq0nTVqSTPS1OqMqX+Z1KFCbXabukB0jhw/jBnGlsDUXZYcVvdzgkk74SlQtuXIQt
         rzaaFkHknMNVFygoFbUq0GdJhYRlpErrjgKUYkdmb23MrPX3KbyaMNULJG/U54SiN0Sd
         l+qWugr9koW3OnbEaA0gC01Nm3NV1Swy2GMMEYa0z+muy5WzWHr3IPaIY6XvF/LjORAP
         euwIQeRwhdRynjIDe0Cm5/MvOynyh175wp+BJUFTXWdwhNQVZWOtToReFC6tlMHwhWxH
         wnqDBFKdlbOAsIF4KcEjdWcViOoiYmlG1inQnUAi14N4ViShOvIdh3sYzPdDfFgfQ2eL
         mKdQ==
X-Gm-Message-State: ABuFfoiflPUfv1FCKoMkXT1gGluqOihDovIy742vu0I4RF2AcqnRmVVS
        LR30w+1vG0KpM8F1uUD3zxtOMabP+es=
X-Google-Smtp-Source: ACcGV62ekCofnrespS2IuHl1zk53u8yujsv3JaSoIkzOXQ1Wx9iqRZldA17HGnCp/1av1xL2IyD4kw==
X-Received: by 2002:a63:1516:: with SMTP id v22-v6mr544393pgl.150.1537824442902;
        Mon, 24 Sep 2018 14:27:22 -0700 (PDT)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id v83-v6sm340980pfa.103.2018.09.24.14.27.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 14:27:22 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, keescook@chromium.org, davem@davemloft.net,
        moritz.fischer@ettus.com, f.fainelli@gmail.com,
        alex.williams@ni.com, Moritz Fischer <mdf@kernel.org>
Subject: [PATCH] net: nixge: Address compiler warnings when building for i386
Date:   Mon, 24 Sep 2018 14:27:12 -0700
Message-Id: <20180924212712.1790-1-mdf@kernel.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Address compiler warnings reported by kbuild autobuilders
when building for i386 as a result of dma_addr_t size on
different architectures.

warning: cast to pointer from integer of different size
	[-Wint-to-pointer-cast]

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/net/ethernet/ni/nixge.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 74cf52e3fb09..0611f2335b4a 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -127,8 +127,8 @@ struct nixge_hw_dma_bd {
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
 #define nixge_hw_dma_bd_set_addr(bd, field, addr) \
 	do { \
-		(bd)->field##_lo = lower_32_bits(((u64)addr)); \
-		(bd)->field##_hi = upper_32_bits(((u64)addr)); \
+		(bd)->field##_lo = lower_32_bits((addr)); \
+		(bd)->field##_hi = upper_32_bits((addr)); \
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
@@ -323,7 +323,7 @@ static int nixge_hw_dma_bd_init(struct net_device *ndev)
 		if (!skb)
 			goto out;
 
-		nixge_hw_dma_bd_set_offset(&priv->rx_bd_v[i], skb);
+		nixge_hw_dma_bd_set_offset(&priv->rx_bd_v[i], (uintptr_t)skb);
 		phys = dma_map_single(ndev->dev.parent, skb->data,
 				      NIXGE_MAX_JUMBO_FRAME_SIZE,
 				      DMA_FROM_DEVICE);
@@ -601,8 +601,8 @@ static int nixge_recv(struct net_device *ndev, int budget)
 		tail_p = priv->rx_bd_p + sizeof(*priv->rx_bd_v) *
 			 priv->rx_bd_ci;
 
-		skb = (struct sk_buff *)nixge_hw_dma_bd_get_addr(cur_p,
-								 sw_id_offset);
+		skb = (struct sk_buff *)(uintptr_t)
+			nixge_hw_dma_bd_get_addr(cur_p, sw_id_offset);
 
 		length = cur_p->status & XAXIDMA_BD_STS_ACTUAL_LEN_MASK;
 		if (length > NIXGE_MAX_JUMBO_FRAME_SIZE)
@@ -643,7 +643,7 @@ static int nixge_recv(struct net_device *ndev, int budget)
 		nixge_hw_dma_bd_set_phys(cur_p, cur_phys);
 		cur_p->cntrl = NIXGE_MAX_JUMBO_FRAME_SIZE;
 		cur_p->status = 0;
-		nixge_hw_dma_bd_set_offset(cur_p, new_skb);
+		nixge_hw_dma_bd_set_offset(cur_p, (uintptr_t)new_skb);
 
 		++priv->rx_bd_ci;
 		priv->rx_bd_ci %= RX_BD_NUM;
-- 
2.18.0

