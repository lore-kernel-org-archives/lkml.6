Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754570AbeDWIg7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:36:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54839 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754460AbeDWIgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:36:35 -0400
X-UUID: ea6e97b907a74487a11894dbaee5705f-20180423
From: <sean.wang@mediatek.com>
To: <matthias.bgg@gmail.com>, <rjw@rjwysocki.net>, <khilman@baylibre.com>
CC: <ulf.hansson@linaro.org>, <linux-mediatek@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v2 2/2] soc: mediatek: add a fixed wait for SRAM stable
Date: Mon, 23 Apr 2018 16:36:22 +0800
Message-ID: <0ef8e87ba7156e626d1a1a48388f222ce917099b.1524472331.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <2e16481e1477dfae0cfb24568d8111da81d92628.1524472331.git.sean.wang@mediatek.com>
References: <2e16481e1477dfae0cfb24568d8111da81d92628.1524472331.git.sean.wang@mediatek.com>
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

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index b1b45e4..d4f1a63 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -32,6 +32,7 @@
 #define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
 
 #define MTK_SCPD_ACTIVE_WAKEUP		BIT(0)
+#define MTK_SCPD_FWAIT_SRAM		BIT(1)
 #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
 
 #define SPM_VDE_PWR_CON			0x0210
@@ -237,11 +238,22 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	val &= ~scpd->data->sram_pdn_bits;
 	writel(val, ctl_addr);
 
-	/* wait until SRAM_PDN_ACK all 0 */
-	ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == 0,
-				 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
-	if (ret < 0)
-		goto err_pwr_ack;
+	/* Either wait until SRAM_PDN_ACK all 0 or have a force wait */
+	if (!MTK_SCPD_CAPS(scpd, MTK_SCPD_FWAIT_SRAM)) {
+		ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == 0,
+					 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+		if (ret < 0)
+			goto err_pwr_ack;
+	} else {
+		/*
+		 * Currently, MTK_SCPD_FWAIT_SRAM is necessary only for
+		 * MT7622_POWER_DOMAIN_WB and thus just a trivial setup is
+		 * applied here. If there're more domains which need to force
+		 * waiting for its own pre-defined value, the duration should
+		 * be coded in the caps field.
+		 */
+		usleep_range(12000, 12100);
+	};
 
 	if (scpd->data->bus_prot_mask) {
 		ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
@@ -785,7 +797,7 @@ static const struct scp_domain_data scp_domain_data_mt7622[] = {
 		.sram_pdn_ack_bits = 0,
 		.clk_id = {CLK_NONE},
 		.bus_prot_mask = MT7622_TOP_AXI_PROT_EN_WB,
-		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP | MTK_SCPD_FWAIT_SRAM,
 	},
 };
 
-- 
2.7.4
