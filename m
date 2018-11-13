Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9601DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1CC20685
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1CC20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731806AbeKNDlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:41:39 -0500
Received: from out03.smtpout.orange.fr ([193.252.22.212]:48203 "EHLO
        out.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730730AbeKNDlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:41:39 -0500
Received: from localhost.localdomain ([77.136.39.130])
        by mwinf5d12 with ME
        id zViT1y00S2oVPad03ViUZc; Tue, 13 Nov 2018 18:42:29 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 13 Nov 2018 18:42:29 +0100
X-ME-IP: 77.136.39.130
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     hauke@hauke-m.de, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] net: lantiq: Fix returned value in case of error in 'xrx200_probe()'
Date:   Tue, 13 Nov 2018 18:42:24 +0100
Message-Id: <20181113174224.7884-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return 'err' in the error handling path instead of 0.
Return explicitly 0 in the normal path, instead of 'err', which is known
to be 0 at this point.

Fixes: fe1a56420cf2 ("net: lantiq: Add Lantiq / Intel VRX200 Ethernet driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/lantiq_xrx200.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/lantiq_xrx200.c b/drivers/net/ethernet/lantiq_xrx200.c
index 8c5ba4b81fb7..2d4d10a017e5 100644
--- a/drivers/net/ethernet/lantiq_xrx200.c
+++ b/drivers/net/ethernet/lantiq_xrx200.c
@@ -512,7 +512,8 @@ static int xrx200_probe(struct platform_device *pdev)
 	err = register_netdev(net_dev);
 	if (err)
 		goto err_unprepare_clk;
-	return err;
+
+	return 0;
 
 err_unprepare_clk:
 	clk_disable_unprepare(priv->clk);
@@ -520,7 +521,7 @@ static int xrx200_probe(struct platform_device *pdev)
 err_uninit_dma:
 	xrx200_hw_cleanup(priv);
 
-	return 0;
+	return err;
 }
 
 static int xrx200_remove(struct platform_device *pdev)
-- 
2.17.1

