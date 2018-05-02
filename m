Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750928AbeEBEDk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 00:03:40 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:31821 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750836AbeEBEDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 00:03:39 -0400
X-UUID: 1a5377590c8b4d779a8a206bbb826be4-20180502
From: <sean.wang@mediatek.com>
To: <matthias.bgg@gmail.com>, <rjw@rjwysocki.net>, <khilman@baylibre.com>
CC: <ulf.hansson@linaro.org>, <linux-mediatek@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v3] soc: mediatek: add a fixed wait for SRAM stable
Date: Wed, 2 May 2018 12:03:29 +0800
Message-ID: <90f83c1bd359bb39cdae334e489037d6fb8ac69b.1525233544.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

MT7622_POWER_DOMAIN_WB doesn't send an ACK when its managed SRAM becomes
stable, which is not like the behavior the other power domains should
have. Therefore, it's necessary for such a power domain to have a fixed
and well-predefined duration to wait until its managed SRAM can be allowed
to access by all functions running on the top.

v1 -> v2:
 - use MTK_SCPD_FWAIT_SRAM flag as an indication requiring force waiting.

v2 -> v3:
 - change the order for condition judgment with we check an existence of
   the MTK_SCPD_FWAIT_SRAM first to get rid of any oversight on negative
   condition.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index b1b45e4..2080c8f 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -32,6 +32,7 @@
 #define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
 
 #define MTK_SCPD_ACTIVE_WAKEUP		BIT(0)
+#define MTK_SCPD_FWAIT_SRAM		BIT(1)
 #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
 
 #define SPM_VDE_PWR_CON			0x0210
@@ -237,11 +238,21 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	val &= ~scpd->data->sram_pdn_bits;
 	writel(val, ctl_addr);
 
-	/* wait until SRAM_PDN_ACK all 0 */
-	ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == 0,
-				 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
-	if (ret < 0)
-		goto err_pwr_ack;
+	/* Either wait until SRAM_PDN_ACK all 0 or have a force wait */
+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_FWAIT_SRAM)) {
+		/*
+		 * Currently, MTK_SCPD_FWAIT_SRAM is necessary only for
+		 * MT7622_POWER_DOMAIN_WB and thus just a trivial setup is
+		 * applied here.
+		 */
+		usleep_range(12000, 12100);
+
+	} else {
+		ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == 0,
+					 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+		if (ret < 0)
+			goto err_pwr_ack;
+	};
 
 	if (scpd->data->bus_prot_mask) {
 		ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
@@ -785,7 +796,7 @@ static const struct scp_domain_data scp_domain_data_mt7622[] = {
 		.sram_pdn_ack_bits = 0,
 		.clk_id = {CLK_NONE},
 		.bus_prot_mask = MT7622_TOP_AXI_PROT_EN_WB,
-		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP | MTK_SCPD_FWAIT_SRAM,
 	},
 };
 
-- 
2.7.4
