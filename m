Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F52EC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C63208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C63208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965498AbeFRJwR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:52:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55212 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935702AbeFRIVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:21:01 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A8DADC7A;
        Mon, 18 Jun 2018 08:21:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 126/279] net: mvpp2: Fix clk error path in mvpp2_probe
Date:   Mon, 18 Jun 2018 10:11:51 +0200
Message-Id: <20180618080614.048590357@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maxime Chevallier <maxime.chevallier@bootlin.com>

[ Upstream commit 45f972adb7f4db2d7f02af728ccd104113336074 ]

When clk_prepare_enable fails for the axi_clk, the mg_clk isn't properly
cleaned up. Add another jump label to handle that case, and make sure we
jump to it in the later error cases.

Fixes: 4792ea04bcd0 ("net: mvpp2: Fix clock resource by adding an optional bus clock")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/mvpp2.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -8332,12 +8332,12 @@ static int mvpp2_probe(struct platform_d
 		if (IS_ERR(priv->axi_clk)) {
 			err = PTR_ERR(priv->axi_clk);
 			if (err == -EPROBE_DEFER)
-				goto err_gop_clk;
+				goto err_mg_clk;
 			priv->axi_clk = NULL;
 		} else {
 			err = clk_prepare_enable(priv->axi_clk);
 			if (err < 0)
-				goto err_gop_clk;
+				goto err_mg_clk;
 		}
 
 		/* Get system's tclk rate */
@@ -8351,7 +8351,7 @@ static int mvpp2_probe(struct platform_d
 	if (priv->hw_version == MVPP22) {
 		err = dma_set_mask(&pdev->dev, MVPP2_DESC_DMA_MASK);
 		if (err)
-			goto err_mg_clk;
+			goto err_axi_clk;
 		/* Sadly, the BM pools all share the same register to
 		 * store the high 32 bits of their address. So they
 		 * must all have the same high 32 bits, which forces
@@ -8359,14 +8359,14 @@ static int mvpp2_probe(struct platform_d
 		 */
 		err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
 		if (err)
-			goto err_mg_clk;
+			goto err_axi_clk;
 	}
 
 	/* Initialize network controller */
 	err = mvpp2_init(pdev, priv);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to initialize controller\n");
-		goto err_mg_clk;
+		goto err_axi_clk;
 	}
 
 	/* Initialize ports */
@@ -8379,7 +8379,7 @@ static int mvpp2_probe(struct platform_d
 	if (priv->port_count == 0) {
 		dev_err(&pdev->dev, "no ports enabled\n");
 		err = -ENODEV;
-		goto err_mg_clk;
+		goto err_axi_clk;
 	}
 
 	/* Statistics must be gathered regularly because some of them (like
@@ -8407,8 +8407,9 @@ err_port_probe:
 			mvpp2_port_remove(priv->port_list[i]);
 		i++;
 	}
-err_mg_clk:
+err_axi_clk:
 	clk_disable_unprepare(priv->axi_clk);
+err_mg_clk:
 	if (priv->hw_version == MVPP22)
 		clk_disable_unprepare(priv->mg_clk);
 err_gop_clk:


