Return-Path: <neil@brown.name>
X-Google-Smtp-Source: AG47ELs6JAyeE4wvaV49x/jCLTha3YwrQB1skW988bM22RVCM/4DUVReOJrB4VQys6FcSHm/QhmW
ARC-Seal: i=1; a=rsa-sha256; t=1521059056; cv=none;
        d=google.com; s=arc-20160816;
        b=IX147QF6S7VMnhZFDTOdTmXzfPDIKaBpUlgkOLfzulm4iJt1Z5Yw9xr5LxEvS+DF7W
         L9Qu87dUFRUmdGLGbiPtgQAJ3RGxNKFeIBwF/P74a9TwATgujrbthSXFSWXWoa5X5l8S
         PbzzydJDP6M8nSs4CQDwMmLa3tGQHZXGSO18jxZejO9ke4woM4ZIiStKwRIIDbveAWgr
         yN8E5OeVJkGEo40f4OCEIGpQQsm5DmTGbgPaakaNo8okpRh1bAb9Z7XI5zQO/ZitBmcB
         Pk0h3dsfr/WDvL7Q+w/t7zAZT/e3cICOzcdrrobWZdk03Wf+9Wcdt+exvGy1nf71lNJt
         o/XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=f4EGJaFR6x9qHGXZf2kNRO5Pwuy+yAFkMkmmDL7lZbo=;
        b=qtoRofNAZW8iI41LYXyvxrT7OW47S1xmxYlib1StqgBokLlnDRmzlmZJ+g5qneQeS1
         lMz4RcT6ILtalfbbyj+SyxRLebuWboR0qMDAUJ9B6sE+7u04NX88Lh0ehZPu29O0gaoG
         VF7POHbsML+dXEvK9swWRPV8b3E04yWck/cf1KiUw7/4cHwBav4lva5nJka1N9bQpjXd
         R+qd7OKjBVpTRgvEQznvdP5lapStnnX/W8+7PICeG0W7gRWbo0LQlNnoDbU6ts8YSFs0
         KeQDzqsSLI9MCOnDxBEqwh/anOsMhBKtSH/gVQ4F1oMJfjNjGh2BQv9qKFxQcUUm5d9b
         r0Ig==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of neil@brown.name) smtp.mailfrom=neil@brown.name
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of neil@brown.name) smtp.mailfrom=neil@brown.name
From: NeilBrown <neil@brown.name>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 15 Mar 2018 07:22:36 +1100
Subject: [PATCH 11/13] staging: mt7621-eth: add support for mt7621
Cc: devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>,
 John Crispin <blogic@openwrt.org>
Message-ID: <152105895636.22262.8115972610412076241.stgit@noble>
In-Reply-To: <152105892255.22262.1902152685410223215.stgit@noble>
References: <152105892255.22262.1902152685410223215.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594946021150733696?=
X-GMAIL-MSGID: =?utf-8?q?1594946021150733696?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: John Crispin <blogic@openwrt.org>

Add support for SoCs from the mt7621 family. These all have 2 GMAC ports,
both of which are attached to the same internal 1000MBit switch. Currently
we only support GMAC1 as the sole CPU port. MT7621 is very similar to
MT7620 with only a few registers having different offsets. MT7621 is the
first SoC to have the new QDMA engine builtin. The older PDMA engine is
also present. unfortunatley, to get the best performance we need to run RX
on PDMA and TX on QDMA. This SoC is also the first to have TX vlan
offloading and TSO6 support.

NeilBrown: the driver didn't work when I tested, so I changed it
  to match known-working code as much as possible.  This included
  converting to the PDMA engine for TX.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Signed-off-by: Michael Lee <igvtee@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/staging/mt7621-eth/TODO         |    3 +
 drivers/staging/mt7621-eth/soc_mt7621.c |  160 +++++++++++++++++++++++++++++++
 2 files changed, 163 insertions(+)
 create mode 100644 drivers/staging/mt7621-eth/soc_mt7621.c

diff --git a/drivers/staging/mt7621-eth/TODO b/drivers/staging/mt7621-eth/TODO
index 50fb5a959ee8..f9e47d4b4cd4 100644
--- a/drivers/staging/mt7621-eth/TODO
+++ b/drivers/staging/mt7621-eth/TODO
@@ -6,5 +6,8 @@
 - convert gsw code to use switchdev interfaces
 - md7620_mmi_write etc should probably be wrapped
   in a regmap abstraction.
+- Get soc_mt7621 to work with QDMA TX if possible.
+- Ensure phys are correctly configured when a cable
+  is plugged in.
 
 Cc: NeilBrown <neil@brown.name>
diff --git a/drivers/staging/mt7621-eth/soc_mt7621.c b/drivers/staging/mt7621-eth/soc_mt7621.c
new file mode 100644
index 000000000000..743c0eed89b6
--- /dev/null
+++ b/drivers/staging/mt7621-eth/soc_mt7621.c
@@ -0,0 +1,160 @@
+/*   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; version 2 of the License
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   Copyright (C) 2009-2016 John Crispin <blogic@openwrt.org>
+ *   Copyright (C) 2009-2016 Felix Fietkau <nbd@openwrt.org>
+ *   Copyright (C) 2013-2016 Michael Lee <igvtee@gmail.com>
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/if_vlan.h>
+#include <linux/of_net.h>
+
+#include <asm/mach-ralink/ralink_regs.h>
+
+#include "mtk_eth_soc.h"
+#include "gsw_mt7620.h"
+#include "mdio.h"
+
+#define MT7620_CDMA_CSG_CFG	0x400
+#define MT7621_CDMP_IG_CTRL	(MT7620_CDMA_CSG_CFG + 0x00)
+#define MT7621_CDMP_EG_CTRL	(MT7620_CDMA_CSG_CFG + 0x04)
+#define MT7621_RESET_FE		BIT(6)
+#define MT7621_L4_VALID		BIT(24)
+
+#define MT7621_TX_DMA_UDF	BIT(19)
+
+#define CDMA_ICS_EN		BIT(2)
+#define CDMA_UCS_EN		BIT(1)
+#define CDMA_TCS_EN		BIT(0)
+
+#define GDMA_ICS_EN		BIT(22)
+#define GDMA_TCS_EN		BIT(21)
+#define GDMA_UCS_EN		BIT(20)
+
+/* frame engine counters */
+#define MT7621_REG_MIB_OFFSET	0x2000
+#define MT7621_PPE_AC_BCNT0	(MT7621_REG_MIB_OFFSET + 0x00)
+#define MT7621_GDM1_TX_GBCNT	(MT7621_REG_MIB_OFFSET + 0x400)
+#define MT7621_GDM2_TX_GBCNT	(MT7621_GDM1_TX_GBCNT + 0x40)
+
+#define GSW_REG_GDMA1_MAC_ADRL	0x508
+#define GSW_REG_GDMA1_MAC_ADRH	0x50C
+#define GSW_REG_GDMA2_MAC_ADRL	0x1508
+#define GSW_REG_GDMA2_MAC_ADRH	0x150C
+
+
+#define MT7621_MTK_RST_GL	0x04
+#define MT7620_MTK_INT_STATUS2	0x08
+
+/* MTK_INT_STATUS reg on mt7620 define CNT_GDM1_AF at BIT(29)
+ * but after test it should be BIT(13).
+ */
+#define MT7621_MTK_GDM1_AF	BIT(28)
+#define MT7621_MTK_GDM2_AF	BIT(29)
+
+static const u16 mt7621_reg_table[MTK_REG_COUNT] = {
+	[MTK_REG_PDMA_GLO_CFG] = RT5350_PDMA_GLO_CFG,
+	[MTK_REG_PDMA_RST_CFG] = RT5350_PDMA_RST_CFG,
+	[MTK_REG_DLY_INT_CFG] = RT5350_DLY_INT_CFG,
+	[MTK_REG_TX_BASE_PTR0] = RT5350_TX_BASE_PTR0,
+	[MTK_REG_TX_MAX_CNT0] = RT5350_TX_MAX_CNT0,
+	[MTK_REG_TX_CTX_IDX0] = RT5350_TX_CTX_IDX0,
+	[MTK_REG_TX_DTX_IDX0] = RT5350_TX_DTX_IDX0,
+	[MTK_REG_RX_BASE_PTR0] = RT5350_RX_BASE_PTR0,
+	[MTK_REG_RX_MAX_CNT0] = RT5350_RX_MAX_CNT0,
+	[MTK_REG_RX_CALC_IDX0] = RT5350_RX_CALC_IDX0,
+	[MTK_REG_RX_DRX_IDX0] = RT5350_RX_DRX_IDX0,
+	[MTK_REG_MTK_INT_ENABLE] = RT5350_MTK_INT_ENABLE,
+	[MTK_REG_MTK_INT_STATUS] = RT5350_MTK_INT_STATUS,
+	[MTK_REG_MTK_DMA_VID_BASE] = 0,
+	[MTK_REG_MTK_COUNTER_BASE] = MT7621_GDM1_TX_GBCNT,
+	[MTK_REG_MTK_RST_GL] = MT7621_MTK_RST_GL,
+	[MTK_REG_MTK_INT_STATUS2] = MT7620_MTK_INT_STATUS2,
+};
+
+static void mt7621_mtk_reset(struct mtk_eth *eth)
+{
+	mtk_reset(eth, MT7621_RESET_FE);
+}
+
+static int mt7621_fwd_config(struct mtk_eth *eth)
+{
+	/* Setup GMAC1 only, there is no support for GMAC2 yet */
+	mtk_w32(eth, mtk_r32(eth, MT7620_GDMA1_FWD_CFG) & ~0xffff,
+		MT7620_GDMA1_FWD_CFG);
+
+	/* Enable RX checksum */
+	mtk_w32(eth, mtk_r32(eth, MT7620_GDMA1_FWD_CFG) | (GDMA_ICS_EN |
+		       GDMA_TCS_EN | GDMA_UCS_EN),
+		       MT7620_GDMA1_FWD_CFG);
+
+	/* Enable RX VLan Offloading */
+	mtk_w32(eth, 0, MT7621_CDMP_EG_CTRL);
+
+	return 0;
+}
+
+static void mt7621_set_mac(struct mtk_mac *mac, unsigned char *hwaddr)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&mac->hw->page_lock, flags);
+	if (mac->id == 0) {
+		mtk_w32(mac->hw, (hwaddr[0] << 8) | hwaddr[1], GSW_REG_GDMA1_MAC_ADRH);
+		mtk_w32(mac->hw, (hwaddr[2] << 24) | (hwaddr[3] << 16) |
+			(hwaddr[4] << 8) | hwaddr[5],
+			GSW_REG_GDMA1_MAC_ADRL);
+	}
+	if (mac->id == 1) {
+		mtk_w32(mac->hw, (hwaddr[0] << 8) | hwaddr[1], GSW_REG_GDMA2_MAC_ADRH);
+		mtk_w32(mac->hw, (hwaddr[2] << 24) | (hwaddr[3] << 16) |
+			(hwaddr[4] << 8) | hwaddr[5],
+			GSW_REG_GDMA2_MAC_ADRL);
+	}
+	spin_unlock_irqrestore(&mac->hw->page_lock, flags);
+}
+
+static struct mtk_soc_data mt7621_data = {
+	.hw_features = NETIF_F_IP_CSUM | NETIF_F_RXCSUM |
+		       NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
+		       NETIF_F_SG | NETIF_F_TSO | NETIF_F_TSO6 |
+		       NETIF_F_IPV6_CSUM,
+	.dma_type = MTK_PDMA,
+	.dma_ring_size = 256,
+	.napi_weight = 64,
+	.new_stats = 1,
+	.padding_64b = 1,
+	.rx_2b_offset = 1,
+	.rx_sg_dma = 1,
+	.has_switch = 1,
+	.mac_count = 2,
+	.reset_fe = mt7621_mtk_reset,
+	.set_mac = mt7621_set_mac,
+	.fwd_config = mt7621_fwd_config,
+	.switch_init = mtk_gsw_init,
+	.reg_table = mt7621_reg_table,
+	.pdma_glo_cfg = MTK_PDMA_SIZE_16DWORDS,
+	.rx_int = RT5350_RX_DONE_INT,
+	.tx_int = RT5350_TX_DONE_INT,
+	.status_int = MT7621_MTK_GDM1_AF | MT7621_MTK_GDM2_AF,
+	.checksum_bit = MT7621_L4_VALID,
+	.has_carrier = mt7620_has_carrier,
+	.mdio_read = mt7620_mdio_read,
+	.mdio_write = mt7620_mdio_write,
+	.mdio_adjust_link = mt7620_mdio_link_adjust,
+};
+
+const struct of_device_id of_mtk_match[] = {
+	{ .compatible = "mediatek,mt7621-eth", .data = &mt7621_data },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, of_mtk_match);
