Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EA0C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E60E20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="czHs1Tc4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E60E20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966754AbeFSPfx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:35:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966516AbeFSPfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:35:50 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2777220661;
        Tue, 19 Jun 2018 15:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529422550;
        bh=SV8HNHHiRsbtHk0JxBrovgtlXJw3AkNfnFRq0gN0vkQ=;
        h=From:To:Cc:Subject:Date:From;
        b=czHs1Tc4NED2GI6+ImSiOR3EPCMz/Ss1mc5la8uVO6Gmj3prTezMlHNELfnQE0o+7
         zhkD6gFFWyCy1txKdO44X1s/Cw/3gR4u/UODM+j4n9LT21ra31LU8r6zg7xjJSmvzN
         h0qkuFtV81SMGGfKgTtEeGbg5jsX2AHpYP2bSKrs=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     netdev@vger.kernel.org
Cc:     dinguyen@kernel.org, davem@davemloft.net, joabreu@synopsys.com,
        alexandre.torgue@st.com, peppe.cavallaro@st.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: stmmac: socfpga: add additional ocp reset line for Stratix10
Date:   Tue, 19 Jun 2018 10:35:38 -0500
Message-Id: <1529422538-8447-1-git-send-email-dinguyen@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Stratix10 platform has an additional reset line, OCP(Open Core Protocol),
that also needs to get deasserted for the stmmac ethernet controller to work.
Thus we need to update the Kconfig to include ARCH_STRATIX10 in order to build
dwmac-socfpga.

Also, remove the redundant check for the reset controller pointer. The
reset driver already checks for the pointer and returns 0 if the pointer
is NULL.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig         |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 18 ++++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index cb5b0f5..edf2036 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -111,7 +111,7 @@ config DWMAC_ROCKCHIP
 config DWMAC_SOCFPGA
 	tristate "SOCFPGA dwmac support"
 	default ARCH_SOCFPGA
-	depends on OF && (ARCH_SOCFPGA || COMPILE_TEST)
+	depends on OF && (ARCH_SOCFPGA || ARCH_STRATIX10 || COMPILE_TEST)
 	select MFD_SYSCON
 	help
 	  Support for ethernet controller on Altera SOCFPGA
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 6e35957..5b3b06a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -55,6 +55,7 @@ struct socfpga_dwmac {
 	struct	device *dev;
 	struct regmap *sys_mgr_base_addr;
 	struct reset_control *stmmac_rst;
+	struct reset_control *stmmac_ocp_rst;
 	void __iomem *splitter_base;
 	bool f2h_ptp_ref_clk;
 	struct tse_pcs pcs;
@@ -262,8 +263,8 @@ static int socfpga_dwmac_set_phy_mode(struct socfpga_dwmac *dwmac)
 		val = SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_GMII_MII;
 
 	/* Assert reset to the enet controller before changing the phy mode */
-	if (dwmac->stmmac_rst)
-		reset_control_assert(dwmac->stmmac_rst);
+	reset_control_assert(dwmac->stmmac_ocp_rst);
+	reset_control_assert(dwmac->stmmac_rst);
 
 	regmap_read(sys_mgr_base_addr, reg_offset, &ctrl);
 	ctrl &= ~(SYSMGR_EMACGRP_CTRL_PHYSEL_MASK << reg_shift);
@@ -288,8 +289,8 @@ static int socfpga_dwmac_set_phy_mode(struct socfpga_dwmac *dwmac)
 	/* Deassert reset for the phy configuration to be sampled by
 	 * the enet controller, and operation to start in requested mode
 	 */
-	if (dwmac->stmmac_rst)
-		reset_control_deassert(dwmac->stmmac_rst);
+	reset_control_deassert(dwmac->stmmac_ocp_rst);
+	reset_control_deassert(dwmac->stmmac_rst);
 	if (phymode == PHY_INTERFACE_MODE_SGMII) {
 		if (tse_pcs_init(dwmac->pcs.tse_pcs_base, &dwmac->pcs) != 0) {
 			dev_err(dwmac->dev, "Unable to initialize TSE PCS");
@@ -324,6 +325,15 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 		goto err_remove_config_dt;
 	}
 
+	dwmac->stmmac_ocp_rst = devm_reset_control_get_optional(dev, "stmmaceth-ocp");
+	if (IS_ERR(dwmac->stmmac_ocp_rst)) {
+		ret = PTR_ERR(dwmac->stmmac_ocp_rst);
+		dev_err(dev, "error getting reset control of ocp %d\n", ret);
+		goto err_remove_config_dt;
+	}
+
+	reset_control_deassert(dwmac->stmmac_ocp_rst);
+
 	ret = socfpga_dwmac_parse_data(dwmac, dev);
 	if (ret) {
 		dev_err(dev, "Unable to parse OF data\n");
-- 
2.7.4

