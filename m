Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7414CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3D320862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WG/v+jSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3D320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388722AbeKGECy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:02:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:38092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388600AbeKGECq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:02:46 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3163E20881;
        Tue,  6 Nov 2018 18:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541529372;
        bh=+9J3ejrJhvN91DXb6pD9tMuM96sMeF+VM5wZyYshQfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WG/v+jSLtJ+9GQpzRJpzep9xSa1/GXoI2fqtDYW7DfBbWX42OJcuUBxKtkPUuhiJP
         yeTyYcwEPKkaQLPn0pUC2k75DB18lJGb7yE53a6Z9PnCqjgoPf1hQtGrSD+BA1Pj0h
         kNB7mODeHn+C/iC4OOgGnhIjV6IHuPg+hTEtNXiU=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 4/4] clk: mediatek: Simplify single driver probes
Date:   Tue,  6 Nov 2018 10:36:09 -0800
Message-Id: <20181106183609.207702-5-sboyd@kernel.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181106183609.207702-1-sboyd@kernel.org>
References: <20181106183609.207702-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to do the multiplex probe design here when we only have
one compatible string. Just setup probe to point at the one probe
function for now.

Cc: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/mediatek/clk-mt2701-g3d.c | 28 +++------------------------
 drivers/clk/mediatek/clk-mt7622-aud.c | 28 +++------------------------
 2 files changed, 6 insertions(+), 50 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
index 1328c112a38f..58b13f12051a 100644
--- a/drivers/clk/mediatek/clk-mt2701-g3d.c
+++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
@@ -58,34 +58,12 @@ static int clk_mt2701_g3dsys_init(struct platform_device *pdev)
 }
 
 static const struct of_device_id of_match_clk_mt2701_g3d[] = {
-	{
-		.compatible = "mediatek,mt2701-g3dsys",
-		.data = clk_mt2701_g3dsys_init,
-	}, {
-		/* sentinel */
-	}
+	{ .compatible = "mediatek,mt2701-g3dsys", },
+	{ /* sentinel */ }
 };
 
-static int clk_mt2701_g3d_probe(struct platform_device *pdev)
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
 static struct platform_driver clk_mt2701_g3d_drv = {
-	.probe = clk_mt2701_g3d_probe,
+	.probe = clk_mt2701_g3dsys_init,
 	.driver = {
 		.name = "clk-mt2701-g3d",
 		.of_match_table = of_match_clk_mt2701_g3d,
diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
index 4f3d47b41b3e..2b10d13a8a37 100644
--- a/drivers/clk/mediatek/clk-mt7622-aud.c
+++ b/drivers/clk/mediatek/clk-mt7622-aud.c
@@ -171,34 +171,12 @@ static int clk_mt7622_audiosys_init(struct platform_device *pdev)
 }
 
 static const struct of_device_id of_match_clk_mt7622_aud[] = {
-	{
-		.compatible = "mediatek,mt7622-audsys",
-		.data = clk_mt7622_audiosys_init,
-	}, {
-		/* sentinel */
-	}
+	{ .compatible = "mediatek,mt7622-audsys", },
+	{ /* sentinel */ }
 };
 
-static int clk_mt7622_aud_probe(struct platform_device *pdev)
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
 static struct platform_driver clk_mt7622_aud_drv = {
-	.probe = clk_mt7622_aud_probe,
+	.probe = clk_mt7622_audiosys_init,
 	.driver = {
 		.name = "clk-mt7622-aud",
 		.of_match_table = of_match_clk_mt7622_aud,
-- 
Sent by a computer through tubes

