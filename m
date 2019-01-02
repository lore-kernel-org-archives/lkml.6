Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17DEC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C6F217D9
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XC72H91D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfABVsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 16:48:45 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8436 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfABVsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 16:48:45 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c2d31ae0000>; Wed, 02 Jan 2019 13:48:30 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 02 Jan 2019 13:48:43 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 02 Jan 2019 13:48:43 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 2 Jan
 2019 21:48:43 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 2 Jan
 2019 21:48:42 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 2 Jan 2019 21:48:42 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c2d31ba0002>; Wed, 02 Jan 2019 13:48:42 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V1] i2c: tegra: Fix Maximum transfer size
Date:   Wed, 2 Jan 2019 13:48:41 -0800
Message-ID: <1546465721-12108-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1546465710; bh=oAov22G7E4MpEfDLpDUQXVs46dBVU2hXuiNZ2KWl7IQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=XC72H91DjdBP2T935nS5ZS6YY3JbMMe0uiCnFFxQtm6iAz/G15Qejpw59dYQzdWZY
         ulFIDLQOlAYMbgA+xLE7NJdd8oE3FqRN2n94Rja8wyz+5MZgBpie3NRl9NBj1xRKc9
         HzakjuWgOCDf7ttV45/Bu8ATZxmG/tDfeK50o8p7nvBWtoVZO8QfnoDILxmTCqmtt4
         I7RXlvu405Exn+dwmGNRE02VQyJFniVUWa17hcQ6bc/aRDKgnyLlAYCFwUUN0sYQ+f
         MzDMCDr8i2tiB5Xec6EGy7BGU15+oZOeyEU/6yoiS8oIl+ggZafcNYPm/KdcgvbKkk
         6ZJTn0SeTKn3Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra194 supports maximum 64K Bytes transfer per packet.
Tegra186 and prior supports maximum 4K Bytes transfer per packet.

This patch fixes this payload difference between Tegra194 and prior
tegra chipsets.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/i2c/busses/i2c-tegra.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 437294ea2f0a..0c08ed8b6c94 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -167,6 +167,7 @@ struct tegra_i2c_hw_feature {
 	bool has_multi_master_mode;
 	bool has_slcg_override_reg;
 	bool has_mst_fifo;
+	struct i2c_adapter_quirks *quirks;
 };
 
 /**
@@ -833,6 +834,12 @@ static const struct i2c_adapter_quirks tegra_i2c_quirks = {
 	.max_write_len = 4096,
 };
 
+static const struct i2c_adapter_quirks tegra194_i2c_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN,
+	.max_read_len = 65536,
+	.max_write_len = 65536,
+};
+
 static const struct tegra_i2c_hw_feature tegra20_i2c_hw = {
 	.has_continue_xfer_support = false,
 	.has_per_pkt_xfer_complete_irq = false,
@@ -844,6 +851,7 @@ static const struct tegra_i2c_hw_feature tegra20_i2c_hw = {
 	.has_multi_master_mode = false,
 	.has_slcg_override_reg = false,
 	.has_mst_fifo = false,
+	.quirks = &tegra_i2c_quirks,
 };
 
 static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
@@ -857,6 +865,7 @@ static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
 	.has_multi_master_mode = false,
 	.has_slcg_override_reg = false,
 	.has_mst_fifo = false,
+	.quirks = &tegra_i2c_quirks,
 };
 
 static const struct tegra_i2c_hw_feature tegra114_i2c_hw = {
@@ -870,6 +879,7 @@ static const struct tegra_i2c_hw_feature tegra114_i2c_hw = {
 	.has_multi_master_mode = false,
 	.has_slcg_override_reg = false,
 	.has_mst_fifo = false,
+	.quirks = &tegra_i2c_quirks,
 };
 
 static const struct tegra_i2c_hw_feature tegra124_i2c_hw = {
@@ -883,6 +893,7 @@ static const struct tegra_i2c_hw_feature tegra124_i2c_hw = {
 	.has_multi_master_mode = false,
 	.has_slcg_override_reg = true,
 	.has_mst_fifo = false,
+	.quirks = &tegra_i2c_quirks,
 };
 
 static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
@@ -896,6 +907,7 @@ static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
 	.has_multi_master_mode = true,
 	.has_slcg_override_reg = true,
 	.has_mst_fifo = false,
+	.quirks = &tegra_i2c_quirks,
 };
 
 static const struct tegra_i2c_hw_feature tegra194_i2c_hw = {
@@ -909,6 +921,7 @@ static const struct tegra_i2c_hw_feature tegra194_i2c_hw = {
 	.has_multi_master_mode = true,
 	.has_slcg_override_reg = true,
 	.has_mst_fifo = true,
+	.quirks = &tegra194_i2c_quirks,
 };
 
 /* Match table for of_platform binding */
@@ -960,7 +973,6 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	i2c_dev->base = base;
 	i2c_dev->div_clk = div_clk;
 	i2c_dev->adapter.algo = &tegra_i2c_algo;
-	i2c_dev->adapter.quirks = &tegra_i2c_quirks;
 	i2c_dev->irq = irq;
 	i2c_dev->cont_id = pdev->id;
 	i2c_dev->dev = &pdev->dev;
@@ -976,6 +988,8 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	i2c_dev->hw = of_device_get_match_data(&pdev->dev);
 	i2c_dev->is_dvc = of_device_is_compatible(pdev->dev.of_node,
 						  "nvidia,tegra20-i2c-dvc");
+	i2c_dev->adapter.quirks = i2c_dev->hw->quirks;
+
 	init_completion(&i2c_dev->msg_complete);
 	spin_lock_init(&i2c_dev->xfer_lock);
 
-- 
2.7.4

