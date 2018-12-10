Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FC5C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF542081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lc9EzU24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF542081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbeLJT2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:28:55 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35981 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbeLJT2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:28:52 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so5707251plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 11:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QZ0tyfZnGvjpbWtr89ZKYBzaN6Xe9Xhg1mJsVCa/ksM=;
        b=Lc9EzU24knz08asR/2bms8b39TemF10gfZ4o3wNYCYZnNMpDEOp2+JF5FewmXDtC3+
         th5zfEs3SzkEfpbgbNYhmnA26/3gJID3pLXobilkbywT7pJ/M0svtbs/7QCTJM5GNhuO
         z6fYkGTxVFgzigHsYlSY5AvoceqYx8CWyzfTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QZ0tyfZnGvjpbWtr89ZKYBzaN6Xe9Xhg1mJsVCa/ksM=;
        b=JenlFb6D0NgEjLJAZtLlEPmHTf8zMN7XKlcdGT82siOSLymeI1FAGCHBei8kEKnu7c
         huroe93SYI3OWdpYLoTHOKhOK4Q8KtkxN2/BwQMgML9WW1EIG3iIleGQi6uYxlFojxNz
         kpiWDVuj9Rrj/05qDCE8uir99zh4Y+em+Q6Sl/zfrG6ReNDMWFIy6sOG7tDWdhGyMtdu
         tfcLO6n04aqtQFJbpmMiimKwYpCNjWeS0wUfRKaEpEW9uRIotjKX1qEHsDqAh8zN/XuP
         O/vAu2lPRs7JXj5J0aIVv3RuQadp+vwZ3Ffb1ZHV8SiumaAXkgrw9pn8dXFVjTTJH7FN
         kQtQ==
X-Gm-Message-State: AA+aEWYLX2D18HmyMKQ6JlmZcaqCnnc+Z3+qmNe6UvLZ/sGiKD39sDph
        um0jb17YYHoxgdwLsFImbOMs5Q==
X-Google-Smtp-Source: AFSGD/WN+ftgH6xDdXlgm+0jsupDe6kboXmaYdHdqlVVX5QFOknSEe1OzNOP6stjgcM3wdnGVmoRBQ==
X-Received: by 2002:a17:902:b112:: with SMTP id q18mr13260675plr.255.1544470132025;
        Mon, 10 Dec 2018 11:28:52 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id v12sm18318674pgg.41.2018.12.10.11.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 11:28:51 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Rob Herring <robh@kernel.org>, Can Guo <cang@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>
Subject: [PATCH v7 2/5] phy: qcom-qmp: Utilize fully-specified DT registers
Date:   Mon, 10 Dec 2018 11:28:23 -0800
Message-Id: <20181210192826.241350-3-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181210192826.241350-1-evgreen@chromium.org>
References: <20181210192826.241350-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Utilize the newly fixed up DT bindings to get the tx2 and rx2 register
regions for the second lane of dual-lane PHYs. Before this change,
the driver was simply using lane one's register region and adding
0x400, which reached well beyond the DT-specified register
allocation. This would have been a crash were it not for the page size
on ARM64. Fix the driver not to rely on the magic of virtual memory by
using the newly specified DT register regions for tx2 and rx2.

In order to support existing device trees, this change also contains a
fallback mode for when those new register regions don't exist, which
reverts to the original behavior of overreaching and prints a complaint.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
As Doug mentioned, this should land before the dts patches land, otherwise
the old driver code will use the tx2 register region as pcs_misc.

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/phy/qualcomm/phy-qcom-qmp.c | 51 +++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 514db7248a5d0..8204d55e2d650 100644
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
@@ -1615,8 +1614,9 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id)
 
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
@@ -1630,7 +1630,32 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id)
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
2.18.1

