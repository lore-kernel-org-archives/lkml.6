Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E58ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 21:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192FF21476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 21:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W9rvfQkn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192FF21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeJSFMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 01:12:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45369 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbeJSFMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 01:12:45 -0400
Received: by mail-pl1-f194.google.com with SMTP id y15-v6so14857594plr.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 14:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=49D7Ak9Jei7nFdcm9ZwsYdkJxoXvirHyD82k9717FfE=;
        b=W9rvfQkn2/I1v/sFVQAiJdk1YU9XqUP8LO+c+8u22e5PCjWt2PzGkad1PkfhYWbHGl
         rCSlHQ0vBQmioqK/MObGd4KgkT9tV7vaAZ958h1VWVkwKAuQi6pevf+PY7WOSe3wI77U
         MgD80zrXD08jUCNmfq/MMJsBoLRteEzqQ693M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=49D7Ak9Jei7nFdcm9ZwsYdkJxoXvirHyD82k9717FfE=;
        b=YBiX2xOHqXvPN5JUdQ5oebpIHzw1IdZQIRUQWkqtur7E6K4tTz2kmbj7JO1S4S3M1C
         NVtJrwCoBvaeK0xMMHs8pgVNILMNnCz0TiS7v0DzSUepJDTmkDtWF+5umF5er0rrWfuk
         s7knWVWgSCQ9AAoowgZxfNST4xJSO7iOQipP7WXO6GqcY01WQ8DmG8HFgxD6JhCDqrBL
         UO/9ZZo/HRYQy31j6NIwX97b5Q42VHq6fLEFfWro/qsZZBTWYBvCgYzU/xCruCxFwygn
         f5UozNy7zDM8TmmXcYFPDAAxTgd3+0T1SASkzoLAvDVTWsJgpxnaTFv+31vTwEgrg0G2
         IZ0A==
X-Gm-Message-State: ABuFfoi79yRKFKzPa0qGNb1h+gxxofXyk6WQqx2qiP4nNKwhHTfL/BbY
        PeiOIhmzQKJaFjBX8ektMHYpdQ==
X-Google-Smtp-Source: ACcGV60yCrXOZTxqWhcSEw5Zo6R+eMzBiKvl8ic7TiGpw4Y8bYnHywk+sJOUQnXYtpyy4STq7SU5EA==
X-Received: by 2002:a17:902:6b82:: with SMTP id p2-v6mr31635729plk.50.1539896993892;
        Thu, 18 Oct 2018 14:09:53 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id i29-v6sm35133678pfj.82.2018.10.18.14.09.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 14:09:52 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        swboyd@chromium.org
Cc:     Evan Green <evgreen@chromium.org>
Subject: [PATCH v2 2/5] phy: qcom-qmp: Utilize fully-specified DT registers
Date:   Thu, 18 Oct 2018 14:09:30 -0700
Message-Id: <20181018210933.113592-3-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181018210933.113592-1-evgreen@chromium.org>
References: <20181018210933.113592-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change utilizes the newly fixed up DT bindings to get the tx2
and rx2 register regions for the second lane of dual-lane PHYs. Before
this change, the driver was simply using lane one's register region and
adding 0x400, which reached well beyond the DT-specified register
allocation. This would have been a crash were it not for the page size on
ARM64. Fix the driver not to rely on the magic of virtual memory by using
the newly specified DT register regions for tx2 and rx2.

In order to support existing device trees, this change also contains a
fallback mode for when those new register regions don't exist, which
reverts to the original behavior of overreaching and prints a complaint.

Signed-off-by: Evan Green <evgreen@chromium.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 51 +++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index a83332411026..957da2ef37c1 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -72,6 +72,9 @@
 
 #define MAX_PROP_NAME				32
 
+/* Define the assumed distance between lanes for underspecified device trees. */
+#define QMP_PHY_LEGACY_LANE_STRIDE		0x400
+
 struct qmp_phy_init_tbl {
 	unsigned int offset;
 	unsigned int val;
@@ -733,9 +736,6 @@ struct qmp_phy_cfg {
 	bool has_phy_dp_com_ctrl;
 	/* true, if PHY has secondary tx/rx lanes to be configured */
 	bool is_dual_lane_phy;
-	/* Register offset of secondary tx/rx lanes for USB DP combo PHY */
-	unsigned int tx_b_lane_offset;
-	unsigned int rx_b_lane_offset;
 
 	/* true, if PCS block has no separate SW_RESET register */
 	bool no_pcs_sw_reset;
@@ -748,6 +748,8 @@ struct qmp_phy_cfg {
  * @tx: iomapped memory space for lane's tx
  * @rx: iomapped memory space for lane's rx
  * @pcs: iomapped memory space for lane's pcs
+ * @tx2: iomapped memory space for second lane's tx (in dual lane PHYs)
+ * @rx2: iomapped memory space for second lane's rx (in dual lane PHYs)
  * @pcs_misc: iomapped memory space for lane's pcs_misc
  * @pipe_clk: pipe lock
  * @index: lane index
@@ -759,6 +761,8 @@ struct qmp_phy {
 	void __iomem *tx;
 	void __iomem *rx;
 	void __iomem *pcs;
+	void __iomem *tx2;
+	void __iomem *rx2;
 	void __iomem *pcs_misc;
 	struct clk *pipe_clk;
 	unsigned int index;
@@ -975,8 +979,6 @@ static const struct qmp_phy_cfg qmp_v3_usb3phy_cfg = {
 
 	.has_phy_dp_com_ctrl	= true,
 	.is_dual_lane_phy	= true,
-	.tx_b_lane_offset	= 0x400,
-	.rx_b_lane_offset	= 0x400,
 };
 
 static const struct qmp_phy_cfg qmp_v3_usb3_uniphy_cfg = {
@@ -1031,9 +1033,6 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
 	.mask_pcs_ready		= PCS_READY,
 
 	.is_dual_lane_phy	= true,
-	.tx_b_lane_offset	= 0x400,
-	.rx_b_lane_offset	= 0x400,
-
 	.no_pcs_sw_reset	= true,
 };
 
@@ -1238,12 +1237,12 @@ static int qcom_qmp_phy_init(struct phy *phy)
 	qcom_qmp_phy_configure(tx, cfg->regs, cfg->tx_tbl, cfg->tx_tbl_num);
 	/* Configuration for other LANE for USB-DP combo PHY */
 	if (cfg->is_dual_lane_phy)
-		qcom_qmp_phy_configure(tx + cfg->tx_b_lane_offset, cfg->regs,
+		qcom_qmp_phy_configure(qphy->tx2, cfg->regs,
 				       cfg->tx_tbl, cfg->tx_tbl_num);
 
 	qcom_qmp_phy_configure(rx, cfg->regs, cfg->rx_tbl, cfg->rx_tbl_num);
 	if (cfg->is_dual_lane_phy)
-		qcom_qmp_phy_configure(rx + cfg->rx_b_lane_offset, cfg->regs,
+		qcom_qmp_phy_configure(qphy->rx2, cfg->regs,
 				       cfg->rx_tbl, cfg->rx_tbl_num);
 
 	qcom_qmp_phy_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
@@ -1614,8 +1613,9 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id)
 
 	/*
 	 * Get memory resources for each phy lane:
-	 * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2; and
-	 * pcs_misc (optional) -> 3.
+	 * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2.
+	 * For dual lane PHYs: tx2 -> 3, rx2 -> 4, pcs_misc (optional) -> 5
+	 * For single lane PHYs: pcs_misc (optional) -> 3.
 	 */
 	qphy->tx = of_iomap(np, 0);
 	if (!qphy->tx)
@@ -1629,7 +1629,32 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id)
 	if (!qphy->pcs)
 		return -ENOMEM;
 
-	qphy->pcs_misc = of_iomap(np, 3);
+	/*
+	 * If this is a dual-lane PHY, then there should be registers for the
+	 * second lane. Some old device trees did not specify this, so fall
+	 * back to old legacy behavior of assuming they can be reached at an
+	 * offset from the first lane.
+	 */
+	if (qmp->cfg->is_dual_lane_phy) {
+		qphy->tx2 = of_iomap(np, 3);
+		qphy->rx2 = of_iomap(np, 4);
+		if (!qphy->tx2 || !qphy->rx2) {
+			dev_warn(dev,
+				 "Underspecified device tree, falling back to legacy register regions\n");
+
+			/* In the old version, pcs_misc is at index 3. */
+			qphy->pcs_misc = qphy->tx2;
+			qphy->tx2 = qphy->tx + QMP_PHY_LEGACY_LANE_STRIDE;
+			qphy->rx2 = qphy->rx + QMP_PHY_LEGACY_LANE_STRIDE;
+
+		} else {
+			qphy->pcs_misc = of_iomap(np, 5);
+		}
+
+	} else {
+		qphy->pcs_misc = of_iomap(np, 3);
+	}
+
 	if (!qphy->pcs_misc)
 		dev_vdbg(dev, "PHY pcs_misc-reg not used\n");
 
-- 
2.16.4

