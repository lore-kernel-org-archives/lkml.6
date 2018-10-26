Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0F1ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC54A20868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SF4nY1Ps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC54A20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeJ0CN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:13:59 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40245 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbeJ0CN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 22:13:57 -0400
Received: by mail-pl1-f193.google.com with SMTP id b9-v6so823126pls.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 10:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YkV3X3/V4QwVkG48IL/OZO017nMuodLCT9WX1lTdkgc=;
        b=SF4nY1PsjiUI837wzba+PwguEp80VzmMGbdyGH+VmYhKs9aAMc6U2ofjWwePS841tt
         OUM6dgPIn7pzUzovaCrFxJVQfUPqUqIVd0G4eWlkZxHfihEfUrDxq/pXNPNynutUGgCU
         cVr6ErhA7LxTB9THv0sPhRZNwR5sSJmZPVPaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YkV3X3/V4QwVkG48IL/OZO017nMuodLCT9WX1lTdkgc=;
        b=ZQvrhoKETMs2tH1iz/LESUD2f1b4WJHjSK5hTYcWFjU09+OxBRIO/AGULV/dyI4XoL
         L14M4GqFGrDFbDFBSrZXjdlvItyrm/2Cro+LIGYPf3W+Hn2VoNSoqNiRKlRAj460UusI
         OS6nGH2A2PzTnywQw22yxPDtsOASZ1LCSK3e5MtK+BPx3DgvKXlRFxqwzKFApfI/7SDw
         C8+CGdqSgtqsBDqyOsMJ8gy32KUwzXMUre01EoRk9BIIrDDwyhvbgLNCvwFjNTDkem5F
         Fbyl4eXHkxmvh5ju1b8mrSxAwaxZGL3Ojj20KtBqaC63TogwzTHvdIHIpoChXkui81kO
         f2Xw==
X-Gm-Message-State: AGRZ1gLppbU0FylRnj/71w9Z8PyC0hwmLvkMMkY+Y42HCSjaxWLgK5nV
        HeYOFWUjzkTtjwEE9zxYdphCJw==
X-Google-Smtp-Source: AJdET5f7iwOxQCJNFoVRatM2vME9NJznoFrfKJAh5+jJV5+x+xclPrry7E6ivQR1MPwZVE/MK2xgkQ==
X-Received: by 2002:a17:902:6801:: with SMTP id h1-v6mr4365274plk.177.1540575364095;
        Fri, 26 Oct 2018 10:36:04 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id b29-v6sm20164448pfj.183.2018.10.26.10.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Oct 2018 10:36:02 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Rob Herring <robh@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Can Guo <cang@codeaurora.org>, linux-kernel@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>
Subject: [PATCH v5 2/5] phy: qcom-qmp: Utilize fully-specified DT registers
Date:   Fri, 26 Oct 2018 10:35:41 -0700
Message-Id: <20181026173544.136037-3-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181026173544.136037-1-evgreen@chromium.org>
References: <20181026173544.136037-1-evgreen@chromium.org>
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

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/phy/qualcomm/phy-qcom-qmp.c | 51 +++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index a83332411026..61d5fe115d9d 100644
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

