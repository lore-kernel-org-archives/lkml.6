Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3005C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B718220862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixo8w9LW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B718220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388656AbeKGECq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:02:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:38068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388300AbeKGECq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:02:46 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C01F2086B;
        Tue,  6 Nov 2018 18:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541529371;
        bh=q3B12p+wVr/PsBAJxYQnI8sf+UI5V26gVqVsArmjRTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ixo8w9LWtrH5jSV0/9VkrnAYHTeBdpF/PEArvV13tue8eN1ZRlJ1scP2OhpxeGK8n
         2KFPXQFssrRUNt+Q1VZJh2mZrZFoZOQOdJDu7ucSI7YPLfuMzVXBSCWQ5at9f37xiQ
         gXhxLHeUjpkpMHNhHi43M8Dbrx47oY6zCHE8hGOU=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/4] clk: mediatek: Convert to platform_driver_probe_by_match_data()
Date:   Tue,  6 Nov 2018 10:36:07 -0800
Message-Id: <20181106183609.207702-3-sboyd@kernel.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181106183609.207702-1-sboyd@kernel.org>
References: <20181106183609.207702-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use this function to reduce the boiler-plate code that the mediatek clk
driver needs to implement to probe clks for different devices within the
same driver.

Cc: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/mediatek/clk-mt2701.c     | 20 +-------------------
 drivers/clk/mediatek/clk-mt2712.c     | 20 +-------------------
 drivers/clk/mediatek/clk-mt6797.c     | 20 +-------------------
 drivers/clk/mediatek/clk-mt7622-eth.c | 20 +-------------------
 drivers/clk/mediatek/clk-mt7622-hif.c | 20 +-------------------
 drivers/clk/mediatek/clk-mt7622.c     | 20 +-------------------
 6 files changed, 6 insertions(+), 114 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index ab6ab07f53e6..5dd8fb98ce49 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -1009,26 +1009,8 @@ static const struct of_device_id of_match_clk_mt2701[] = {
 	}
 };
 
-static int clk_mt2701_probe(struct platform_device *pdev)
-{
-	int (*clk_init)(struct platform_device *);
-	int r;
-
-	clk_init = of_device_get_match_data(&pdev->dev);
-	if (!clk_init)
-		return -EINVAL;
-
-	r = clk_init(pdev);
-	if (r)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-
-	return r;
-}
-
 static struct platform_driver clk_mt2701_drv = {
-	.probe = clk_mt2701_probe,
+	.probe = platform_driver_probe_by_of_match_data,
 	.driver = {
 		.name = "clk-mt2701",
 		.of_match_table = of_match_clk_mt2701,
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index 991d4093726e..17c031d110ff 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1441,26 +1441,8 @@ static const struct of_device_id of_match_clk_mt2712[] = {
 	}
 };
 
-static int clk_mt2712_probe(struct platform_device *pdev)
-{
-	int (*clk_probe)(struct platform_device *);
-	int r;
-
-	clk_probe = of_device_get_match_data(&pdev->dev);
-	if (!clk_probe)
-		return -EINVAL;
-
-	r = clk_probe(pdev);
-	if (r != 0)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-
-	return r;
-}
-
 static struct platform_driver clk_mt2712_drv = {
-	.probe = clk_mt2712_probe,
+	.probe = platform_driver_probe_by_of_match_data,
 	.driver = {
 		.name = "clk-mt2712",
 		.owner = THIS_MODULE,
diff --git a/drivers/clk/mediatek/clk-mt6797.c b/drivers/clk/mediatek/clk-mt6797.c
index 5702bc974ed9..2d7ff3098cc9 100644
--- a/drivers/clk/mediatek/clk-mt6797.c
+++ b/drivers/clk/mediatek/clk-mt6797.c
@@ -680,26 +680,8 @@ static const struct of_device_id of_match_clk_mt6797[] = {
 	}
 };
 
-static int clk_mt6797_probe(struct platform_device *pdev)
-{
-	int (*clk_init)(struct platform_device *);
-	int r;
-
-	clk_init = of_device_get_match_data(&pdev->dev);
-	if (!clk_init)
-		return -EINVAL;
-
-	r = clk_init(pdev);
-	if (r)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-
-	return r;
-}
-
 static struct platform_driver clk_mt6797_drv = {
-	.probe = clk_mt6797_probe,
+	.probe = platform_driver_probe_by_of_match_data,
 	.driver = {
 		.name = "clk-mt6797",
 		.of_match_table = of_match_clk_mt6797,
diff --git a/drivers/clk/mediatek/clk-mt7622-eth.c b/drivers/clk/mediatek/clk-mt7622-eth.c
index 6328127bbb3c..2ce825f19275 100644
--- a/drivers/clk/mediatek/clk-mt7622-eth.c
+++ b/drivers/clk/mediatek/clk-mt7622-eth.c
@@ -127,26 +127,8 @@ static const struct of_device_id of_match_clk_mt7622_eth[] = {
 	}
 };
 
-static int clk_mt7622_eth_probe(struct platform_device *pdev)
-{
-	int (*clk_init)(struct platform_device *);
-	int r;
-
-	clk_init = of_device_get_match_data(&pdev->dev);
-	if (!clk_init)
-		return -EINVAL;
-
-	r = clk_init(pdev);
-	if (r)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-
-	return r;
-}
-
 static struct platform_driver clk_mt7622_eth_drv = {
-	.probe = clk_mt7622_eth_probe,
+	.probe = platform_driver_probe_by_of_match_data,
 	.driver = {
 		.name = "clk-mt7622-eth",
 		.of_match_table = of_match_clk_mt7622_eth,
diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
index a6e8534276c6..65f13808155d 100644
--- a/drivers/clk/mediatek/clk-mt7622-hif.c
+++ b/drivers/clk/mediatek/clk-mt7622-hif.c
@@ -140,26 +140,8 @@ static const struct of_device_id of_match_clk_mt7622_hif[] = {
 	}
 };
 
-static int clk_mt7622_hif_probe(struct platform_device *pdev)
-{
-	int (*clk_init)(struct platform_device *);
-	int r;
-
-	clk_init = of_device_get_match_data(&pdev->dev);
-	if (!clk_init)
-		return -EINVAL;
-
-	r = clk_init(pdev);
-	if (r)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-
-	return r;
-}
-
 static struct platform_driver clk_mt7622_hif_drv = {
-	.probe = clk_mt7622_hif_probe,
+	.probe = platform_driver_probe_by_of_match_data,
 	.driver = {
 		.name = "clk-mt7622-hif",
 		.of_match_table = of_match_clk_mt7622_hif,
diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 92f7e32770c6..d7310fb5964f 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -746,26 +746,8 @@ static const struct of_device_id of_match_clk_mt7622[] = {
 	}
 };
 
-static int clk_mt7622_probe(struct platform_device *pdev)
-{
-	int (*clk_init)(struct platform_device *);
-	int r;
-
-	clk_init = of_device_get_match_data(&pdev->dev);
-	if (!clk_init)
-		return -EINVAL;
-
-	r = clk_init(pdev);
-	if (r)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-
-	return r;
-}
-
 static struct platform_driver clk_mt7622_drv = {
-	.probe = clk_mt7622_probe,
+	.probe = platform_driver_probe_by_of_match_data,
 	.driver = {
 		.name = "clk-mt7622",
 		.of_match_table = of_match_clk_mt7622,
-- 
Sent by a computer through tubes

