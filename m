Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754913AbeDCHQV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 03:16:21 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:54659 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754883AbeDCHQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 03:16:16 -0400
X-UUID: dd47b214ec2c4ee1a3cf74ba3863241b-20180403
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <marcel@holtmann.org>,
        <johan.hedberg@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v1 5/7] soc: mediatek: add a fixed wait for SRAM stable
Date: Tue, 3 Apr 2018 15:15:55 +0800
Message-ID: <0fc10b2498c6dbe20141831c722c32cc74330d3d.1522736996.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1522736996.git.sean.wang@mediatek.com>
References: <cover.1522736996.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23760.005
X-TM-AS-Result: No-6.489900-8.000000-10
X-TMASE-MatchedRID: Ei0WBMmFdJhQlz7zzALRPkKcYi5Qw/RVVo4lwLFUdiuctWHPLT5FfaqP
        oyh3F974T52TJZnqxBpO62v+OrztwJx6Ilif8OzGA9lly13c/gH0O7M3lSnTW8eQfu6iwSfsYRW
        GTChXyt1vx7UZ9PwSfR0XwFnoQFewHxPMjOKY7A8LbigRnpKlKWxlRJiH4397tbn3XmfSRVqoOh
        OBMiYLVDUjphbdGeFINbEv6hywEg3pCdnFKFqrOQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.489900-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23760.005
X-TMASE-POSTMAN: 2-d;
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

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index f9b7248..19aceb8 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -121,6 +121,7 @@ struct scp_domain_data {
 	u32 bus_prot_mask;
 	enum clk_id clk_id[MAX_CLKS];
 	bool active_wakeup;
+	u32 us_sram_fwait;
 };
 
 struct scp;
@@ -234,11 +235,16 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	val &= ~scpd->data->sram_pdn_bits;
 	writel(val, ctl_addr);
 
-	/* wait until SRAM_PDN_ACK all 0 */
-	ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == 0,
-				 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
-	if (ret < 0)
-		goto err_pwr_ack;
+	/* Either wait until SRAM_PDN_ACK all 0 or have a force wait */
+	if (!scpd->data->us_sram_fwait) {
+		ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == 0,
+					 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+		if (ret < 0)
+			goto err_pwr_ack;
+	} else {
+		usleep_range(scpd->data->us_sram_fwait,
+			     scpd->data->us_sram_fwait + 100);
+	};
 
 	if (scpd->data->bus_prot_mask) {
 		ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
@@ -783,6 +789,7 @@ static const struct scp_domain_data scp_domain_data_mt7622[] = {
 		.clk_id = {CLK_NONE},
 		.bus_prot_mask = MT7622_TOP_AXI_PROT_EN_WB,
 		.active_wakeup = true,
+		.us_sram_fwait = 12000,
 	},
 };
 
-- 
2.7.4
