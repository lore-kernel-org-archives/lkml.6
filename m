Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752699AbeEGO24 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 10:28:56 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:47685 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752473AbeEGO2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 10:28:54 -0400
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH RESEND] phy: stm32: fix usbphyc static checker and checkpatch warnings
Date: Mon, 7 May 2018 16:28:08 +0200
Message-ID: <1525703288-26653-1-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following issues:
* warning reported by checkpatch:
WARNING: line over 80 characters
#87: FILE: drivers/phy/st/phy-stm32-usbphyc.c:87:
+static void stm32_usbphyc_get_pll_params(u32 clk_rate, struct pll_params *pll_params)

* bug reported by static checker (Dan Carpenter):
drivers/phy/st/phy-stm32-usbphyc.c:371 stm32_usbphyc_probe()
error: uninitialized symbol 'i'.

* unused stm32_usbphyc structure member: bool pll_enabled.

* unnecessary extra line in stm32_usbphyc_of_xlate

Fixes: 94c358da3a05 "phy: stm32: add support for STM32 USB PHY Controller (USBPHYC)"
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/phy/st/phy-stm32-usbphyc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
index bc4e78a..1255cd1 100644
--- a/drivers/phy/st/phy-stm32-usbphyc.c
+++ b/drivers/phy/st/phy-stm32-usbphyc.c
@@ -71,7 +71,6 @@ struct stm32_usbphyc {
 	struct stm32_usbphyc_phy **phys;
 	int nphys;
 	int switch_setup;
-	bool pll_enabled;
 };
 
 static inline void stm32_usbphyc_set_bits(void __iomem *reg, u32 bits)
@@ -84,7 +83,8 @@ static inline void stm32_usbphyc_clr_bits(void __iomem *reg, u32 bits)
 	writel_relaxed(readl_relaxed(reg) & ~bits, reg);
 }
 
-static void stm32_usbphyc_get_pll_params(u32 clk_rate, struct pll_params *pll_params)
+static void stm32_usbphyc_get_pll_params(u32 clk_rate,
+					 struct pll_params *pll_params)
 {
 	unsigned long long fvco, ndiv, frac;
 
@@ -271,7 +271,6 @@ static struct phy *stm32_usbphyc_of_xlate(struct device *dev,
 	struct stm32_usbphyc *usbphyc = dev_get_drvdata(dev);
 	struct stm32_usbphyc_phy *usbphyc_phy = NULL;
 	struct device_node *phynode = args->np;
-
 	int port = 0;
 
 	for (port = 0; port < usbphyc->nphys; port++) {
@@ -367,8 +366,8 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
 		if (IS_ERR(phy)) {
 			ret = PTR_ERR(phy);
 			if (ret != -EPROBE_DEFER)
-				dev_err(dev,
-					"failed to create phy%d: %d\n", i, ret);
+				dev_err(dev, "failed to create phy%d: %d\n",
+					port, ret);
 			goto put_child;
 		}
 
-- 
2.7.4
