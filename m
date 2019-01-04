Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EF3C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078A9217F5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Yw01xC3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbfADAMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 19:12:53 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1085 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbfADAMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 19:12:53 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c2ea4ee0000>; Thu, 03 Jan 2019 16:12:30 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 03 Jan 2019 16:12:50 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 03 Jan 2019 16:12:50 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 4 Jan
 2019 00:12:50 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 4 Jan
 2019 00:12:49 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Fri, 4 Jan 2019 00:12:50 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c2ea5010000>; Thu, 03 Jan 2019 16:12:49 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V4] i2c: tegra: Fix Maximum transfer size
Date:   Thu, 3 Jan 2019 16:12:47 -0800
Message-ID: <1546560767-9559-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1546560750; bh=NQMMHVzU5xuL/fD/1HbKDWFVKExLhP4LgibR5gydzDE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=Yw01xC3eA0Nxl3dTtJyDN0Dg8w6l9wyrEajLXOPPW3+Lnxyc5sLzusGwZD26R2Gdx
         yux23f2+WH2L0aBg2BMvMzFQEBzErrd6aIIaeAiwKwO5vIj1dpRGMRPMGOzg4qHQC8
         CQik+TQc4cMmHudC9/TXciETO+ooWZJCto2Tc1G34uxxP+NDZf3xEl3/8Qvj7wjeKR
         ZsmF4NzYEHxhlpv4jnNpZLCAGL9tlE/XBSymoOq3APpqb5YjmMXeseXNrwvY/wvCkm
         fqYSYSX38dIFadtKeL2aLer3qcUljkjda2hL36gU9STEnIPJaGI87vV9lYJVoqPKbH
         6FQZqECIPb+XQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra194 supports maximum 64K Bytes transfer per packet.
Tegra186 and prior supports maximum 4K Bytes transfer per packet.

This patch fixes this payload difference between Tegra194 and prior
tegra chipsets using separate i2c_adapter_quirks.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/i2c/busses/i2c-tegra.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 437294ea2f0a..a01834fb2ce6 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -154,6 +154,8 @@ enum msg_end_type {
  * @clk_divisor_std_fast_mode: Clock divisor in standard/fast mode. It is
  *		applicable if there is no fast clock source i.e. single clock
  *		source.
+ * @quirks: i2c adapter quirks for limiting write/read transfer size and not
+ *		allowing 0 length transfers.
  */
 
 struct tegra_i2c_hw_feature {
@@ -167,6 +169,7 @@ struct tegra_i2c_hw_feature {
 	bool has_multi_master_mode;
 	bool has_slcg_override_reg;
 	bool has_mst_fifo;
+	const struct i2c_adapter_quirks *quirks;
 };
 
 /**
@@ -833,6 +836,10 @@ static const struct i2c_adapter_quirks tegra_i2c_quirks = {
 	.max_write_len = 4096,
 };
 
+static const struct i2c_adapter_quirks tegra194_i2c_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN,
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

