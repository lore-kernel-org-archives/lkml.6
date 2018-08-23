Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F7EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE8F208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE8F208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388569AbeHWMlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:41:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57186 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbeHWMlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:41:16 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6636B941;
        Thu, 23 Aug 2018 09:12:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 029/130] net: stmmac: socfpga: add additional ocp reset line for Stratix10
Date:   Thu, 23 Aug 2018 09:52:25 +0200
Message-Id: <20180823074929.126784913@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074927.161454870@linuxfoundation.org>
References: <20180823074927.161454870@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dinh Nguyen <dinguyen@kernel.org>

[ Upstream commit bc8a2d9bcbf1ca548b1deb315d14e1da81945bea ]

The Stratix10 platform has an additional reset line, OCP(Open Core Protocol),
that also needs to get deasserted for the stmmac ethernet controller to work.
Thus we need to update the Kconfig to include ARCH_STRATIX10 in order to build
dwmac-socfpga.

Also, remove the redundant check for the reset controller pointer. The
reset driver already checks for the pointer and returns 0 if the pointer
is NULL.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig         |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c |   18 ++++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -83,7 +83,7 @@ config DWMAC_ROCKCHIP
 config DWMAC_SOCFPGA
 	tristate "SOCFPGA dwmac support"
 	default ARCH_SOCFPGA
-	depends on OF && (ARCH_SOCFPGA || COMPILE_TEST)
+	depends on OF && (ARCH_SOCFPGA || ARCH_STRATIX10 || COMPILE_TEST)
 	select MFD_SYSCON
 	help
 	  Support for ethernet controller on Altera SOCFPGA
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
@@ -262,8 +263,8 @@ static int socfpga_dwmac_set_phy_mode(st
 		val = SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_GMII_MII;
 
 	/* Assert reset to the enet controller before changing the phy mode */
-	if (dwmac->stmmac_rst)
-		reset_control_assert(dwmac->stmmac_rst);
+	reset_control_assert(dwmac->stmmac_ocp_rst);
+	reset_control_assert(dwmac->stmmac_rst);
 
 	regmap_read(sys_mgr_base_addr, reg_offset, &ctrl);
 	ctrl &= ~(SYSMGR_EMACGRP_CTRL_PHYSEL_MASK << reg_shift);
@@ -285,8 +286,8 @@ static int socfpga_dwmac_set_phy_mode(st
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
@@ -321,6 +322,15 @@ static int socfpga_dwmac_probe(struct pl
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


