Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F0FC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 00:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D12A20661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 00:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D12A20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeH3Et1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 00:49:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42061 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbeH3Et1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 00:49:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id l9-v6so3046556pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 17:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NShTzSlFYlqtga5d7M/J1wLZLiAga3Nbz09nG1fvud0=;
        b=c5NSCJBreId8Mm6qL3uOcgndmZXy6DDos4v3PmeP22CIbnBHuhYQezckRrQaibWk21
         ySbLEaVyNGWammRWBeAvxfNbsEs11uSD1LI8KS8xgUb9Cqx+scJX0f5msVJK+XMGn1oL
         kmRXArT8jb/6sKeDl9uWcuAL1Mu3ICSUjioEb21j/9ZWc/MtOR386807kqld/0NqdyAJ
         9uJbQsLC/339Aze9PS8e/wqFuRr9K7N5rJGiadl3Chrc9vfP/ypY5MAGy2WRMpGdC4Ln
         bJ37PdTCkoMgdSsnNBdC+hVzDW3gEaXFkFn9P2/Fbl4Ba3SOATbJq7z20T/Wli2M3Blu
         QUkQ==
X-Gm-Message-State: APzg51AKZk1bR4sGazh8hLTmD0jAVKSdhzgO3kJzKxwaALH8ptGYmChe
        Jo/fjM9CjFNtJzaTXvfGIpJ9tg==
X-Google-Smtp-Source: ANB0VdYaAvlMtvwEj/UTMyZC0S4pswjiBy76pneVoc3OadgIYggBoKFK5nSe4WhVWbwBUxWDSm5GzQ==
X-Received: by 2002:a62:858c:: with SMTP id m12-v6mr8159709pfk.173.1535590197251;
        Wed, 29 Aug 2018 17:49:57 -0700 (PDT)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id a15-v6sm8736529pfe.32.2018.08.29.17.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 17:49:56 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     davem@davemloft.net
Cc:     keescook@chromium.org, f.fainelli@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        alex.williams@ni.com, Moritz Fischer <mdf@kernel.org>
Subject: [PATCH net-next 3/3] net: nixge: Use sysdev instead of ndev->dev.parent for DMA
Date:   Wed, 29 Aug 2018 17:40:46 -0700
Message-Id: <20180830004046.9417-4-mdf@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830004046.9417-1-mdf@kernel.org>
References: <20180830004046.9417-1-mdf@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sysdev instead of ndev->dev.parent for DMA in order to
enable usecases where an IOMMU might get in the way otherwise.
In the PCIe wrapper case on x86 the IOMMU group is not inherited
by the platform device that is created as a subdevice of the
PCI wrapper driver.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---

Hi,

not this patch is still in the early stages,
and as the rest of this series goes on top of [1].

The actual parent device might still change since
the parent device driver is still under development.

If there are clever suggestions on how to generalize
the assignment of sysdev, I'm all ears.

Thanks for your time,

Moritz


[1] https://lkml.org/lkml/2018/8/28/1011

---
 drivers/net/ethernet/ni/nixge.c | 50 +++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index fd8e5b02c459..25fb1642d558 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -16,6 +16,7 @@
 #include <linux/of_irq.h>
 #include <linux/skbuff.h>
 #include <linux/phy.h>
+#include <linux/pci.h>
 #include <linux/mii.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/ethtool.h>
@@ -165,6 +166,7 @@ struct nixge_priv {
 	struct net_device *ndev;
 	struct napi_struct napi;
 	struct device *dev;
+	struct device *sysdev;
 
 	/* Connection to PHY device */
 	struct device_node *phy_node;
@@ -250,7 +252,7 @@ static void nixge_hw_dma_bd_release(struct net_device *ndev)
 		phys_addr = nixge_hw_dma_bd_get_addr(&priv->rx_bd_v[i],
 						     phys);
 
-		dma_unmap_single(ndev->dev.parent, phys_addr,
+		dma_unmap_single(priv->sysdev, phys_addr,
 				 NIXGE_MAX_JUMBO_FRAME_SIZE,
 				 DMA_FROM_DEVICE);
 
@@ -261,16 +263,16 @@ static void nixge_hw_dma_bd_release(struct net_device *ndev)
 	}
 
 	if (priv->rx_bd_v)
-		dma_free_coherent(ndev->dev.parent,
+		dma_free_coherent(priv->sysdev,
 				  sizeof(*priv->rx_bd_v) * RX_BD_NUM,
 				  priv->rx_bd_v,
 				  priv->rx_bd_p);
 
 	if (priv->tx_skb)
-		devm_kfree(ndev->dev.parent, priv->tx_skb);
+		devm_kfree(priv->sysdev, priv->tx_skb);
 
 	if (priv->tx_bd_v)
-		dma_free_coherent(ndev->dev.parent,
+		dma_free_coherent(priv->sysdev,
 				  sizeof(*priv->tx_bd_v) * TX_BD_NUM,
 				  priv->tx_bd_v,
 				  priv->tx_bd_p);
@@ -290,19 +292,19 @@ static int nixge_hw_dma_bd_init(struct net_device *ndev)
 	priv->rx_bd_ci = 0;
 
 	/* Allocate the Tx and Rx buffer descriptors. */
-	priv->tx_bd_v = dma_zalloc_coherent(ndev->dev.parent,
+	priv->tx_bd_v = dma_zalloc_coherent(priv->sysdev,
 					    sizeof(*priv->tx_bd_v) * TX_BD_NUM,
 					    &priv->tx_bd_p, GFP_KERNEL);
 	if (!priv->tx_bd_v)
 		goto out;
 
-	priv->tx_skb = devm_kcalloc(ndev->dev.parent,
+	priv->tx_skb = devm_kcalloc(priv->sysdev,
 				    TX_BD_NUM, sizeof(*priv->tx_skb),
 				    GFP_KERNEL);
 	if (!priv->tx_skb)
 		goto out;
 
-	priv->rx_bd_v = dma_zalloc_coherent(ndev->dev.parent,
+	priv->rx_bd_v = dma_zalloc_coherent(priv->sysdev,
 					    sizeof(*priv->rx_bd_v) * RX_BD_NUM,
 					    &priv->rx_bd_p, GFP_KERNEL);
 	if (!priv->rx_bd_v)
@@ -327,7 +329,7 @@ static int nixge_hw_dma_bd_init(struct net_device *ndev)
 			goto out;
 
 		nixge_hw_dma_bd_set_offset(&priv->rx_bd_v[i], skb);
-		phys = dma_map_single(ndev->dev.parent, skb->data,
+		phys = dma_map_single(priv->sysdev, skb->data,
 				      NIXGE_MAX_JUMBO_FRAME_SIZE,
 				      DMA_FROM_DEVICE);
 
@@ -438,10 +440,10 @@ static void nixge_tx_skb_unmap(struct nixge_priv *priv,
 {
 	if (tx_skb->mapping) {
 		if (tx_skb->mapped_as_page)
-			dma_unmap_page(priv->ndev->dev.parent, tx_skb->mapping,
+			dma_unmap_page(priv->sysdev, tx_skb->mapping,
 				       tx_skb->size, DMA_TO_DEVICE);
 		else
-			dma_unmap_single(priv->ndev->dev.parent,
+			dma_unmap_single(priv->sysdev,
 					 tx_skb->mapping,
 					 tx_skb->size, DMA_TO_DEVICE);
 		tx_skb->mapping = 0;
@@ -519,9 +521,9 @@ static int nixge_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		return NETDEV_TX_OK;
 	}
 
-	cur_phys = dma_map_single(ndev->dev.parent, skb->data,
+	cur_phys = dma_map_single(priv->sysdev, skb->data,
 				  skb_headlen(skb), DMA_TO_DEVICE);
-	if (dma_mapping_error(ndev->dev.parent, cur_phys))
+	if (dma_mapping_error(priv->sysdev, cur_phys))
 		goto drop;
 	nixge_hw_dma_bd_set_phys(cur_p, cur_phys);
 
@@ -539,10 +541,10 @@ static int nixge_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		tx_skb = &priv->tx_skb[priv->tx_bd_tail];
 		frag = &skb_shinfo(skb)->frags[ii];
 
-		cur_phys = skb_frag_dma_map(ndev->dev.parent, frag, 0,
+		cur_phys = skb_frag_dma_map(priv->sysdev, frag, 0,
 					    skb_frag_size(frag),
 					    DMA_TO_DEVICE);
-		if (dma_mapping_error(ndev->dev.parent, cur_phys))
+		if (dma_mapping_error(priv->sysdev, cur_phys))
 			goto frag_err;
 		nixge_hw_dma_bd_set_phys(cur_p, cur_phys);
 
@@ -579,7 +581,7 @@ static int nixge_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		cur_p = &priv->tx_bd_v[priv->tx_bd_tail];
 		cur_p->status = 0;
 	}
-	dma_unmap_single(priv->ndev->dev.parent,
+	dma_unmap_single(priv->sysdev,
 			 tx_skb->mapping,
 			 tx_skb->size, DMA_TO_DEVICE);
 drop:
@@ -611,7 +613,7 @@ static int nixge_recv(struct net_device *ndev, int budget)
 		if (length > NIXGE_MAX_JUMBO_FRAME_SIZE)
 			length = NIXGE_MAX_JUMBO_FRAME_SIZE;
 
-		dma_unmap_single(ndev->dev.parent,
+		dma_unmap_single(priv->sysdev,
 				 nixge_hw_dma_bd_get_addr(cur_p, phys),
 				 NIXGE_MAX_JUMBO_FRAME_SIZE,
 				 DMA_FROM_DEVICE);
@@ -636,10 +638,10 @@ static int nixge_recv(struct net_device *ndev, int budget)
 		if (!new_skb)
 			return packets;
 
-		cur_phys = dma_map_single(ndev->dev.parent, new_skb->data,
+		cur_phys = dma_map_single(priv->sysdev, new_skb->data,
 					  NIXGE_MAX_JUMBO_FRAME_SIZE,
 					  DMA_FROM_DEVICE);
-		if (dma_mapping_error(ndev->dev.parent, cur_phys)) {
+		if (dma_mapping_error(priv->sysdev, cur_phys)) {
 			/* FIXME: bail out and clean up */
 			netdev_err(ndev, "Failed to map ...\n");
 		}
@@ -1303,6 +1305,7 @@ static int nixge_probe(struct platform_device *pdev)
 	struct net_device *ndev;
 	struct resource *dmares;
 	struct device_node *np;
+	struct device *sysdev;
 	const u8 *mac_addr;
 	int err;
 
@@ -1331,9 +1334,20 @@ static int nixge_probe(struct platform_device *pdev)
 		eth_hw_addr_random(ndev);
 	}
 
+	sysdev = &pdev->dev;
+#ifdef CONFIG_PCI
+	/* if this is a subdevice of a PCI device we'll have to
+	 * make sure we'll use parent instead of our own platform
+	 * device to make sure  the DMA API if we use an IOMMU
+	 */
+	if (sysdev->parent && sysdev->parent->bus == &pci_bus_type)
+		sysdev = sysdev->parent;
+#endif
+
 	priv = netdev_priv(ndev);
 	priv->ndev = ndev;
 	priv->dev = &pdev->dev;
+	priv->sysdev = sysdev;
 
 	netif_napi_add(ndev, &priv->napi, nixge_poll, NAPI_POLL_WEIGHT);
 
-- 
2.18.0

