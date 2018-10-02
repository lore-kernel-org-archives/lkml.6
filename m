Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5C2C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6908206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6908206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbeJBULI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:11:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60520 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728795AbeJBULI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:11:08 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 75882266;
        Tue,  2 Oct 2018 13:27:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kamal Heib <kamalheib1@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 074/228] staging: mt7621-eth: Fix memory leak in mtk_add_mac() error path
Date:   Tue,  2 Oct 2018 06:22:51 -0700
Message-Id: <20181002132504.326727824@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kamal Heib <kamalheib1@gmail.com>

[ Upstream commit 85e1d42663a0c163002961d2685be952067b0dc2 ]

Fix memory leak in error path of mtk_add_mac() by make sure to free
the allocated netdev.

Fixes: e3cbf478f846 ('staging: mt7621-eth: add the drivers core files')
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/mt7621-eth/mtk_eth_soc.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/drivers/staging/mt7621-eth/mtk_eth_soc.c
+++ b/drivers/staging/mt7621-eth/mtk_eth_soc.c
@@ -2012,8 +2012,10 @@ static int mtk_add_mac(struct mtk_eth *e
 		mac->hw_stats = devm_kzalloc(eth->dev,
 					     sizeof(*mac->hw_stats),
 					     GFP_KERNEL);
-		if (!mac->hw_stats)
-			return -ENOMEM;
+		if (!mac->hw_stats) {
+			err = -ENOMEM;
+			goto free_netdev;
+		}
 		spin_lock_init(&mac->hw_stats->stats_lock);
 		mac->hw_stats->reg_offset = id * MTK_STAT_OFFSET;
 	}
@@ -2037,7 +2039,8 @@ static int mtk_add_mac(struct mtk_eth *e
 	err = register_netdev(eth->netdev[id]);
 	if (err) {
 		dev_err(eth->dev, "error bringing up device\n");
-		return err;
+		err = -ENOMEM;
+		goto free_netdev;
 	}
 	eth->netdev[id]->irq = eth->irq;
 	netif_info(eth, probe, eth->netdev[id],
@@ -2045,6 +2048,10 @@ static int mtk_add_mac(struct mtk_eth *e
 		   eth->netdev[id]->base_addr, eth->netdev[id]->irq);
 
 	return 0;
+
+free_netdev:
+	free_netdev(eth->netdev[id]);
+	return err;
 }
 
 static int mtk_probe(struct platform_device *pdev)


