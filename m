Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966725AbeBNJDC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 04:03:02 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:38456 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752297AbeBNJDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 04:03:00 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID w1E92wDM005572, This message is accepted by code: ctloc85258
From: Chunhao Lin <hau@realtek.com>
To: <netdev@vger.kernel.org>
CC: <nic_swsd@realtek.com>, <linux-kernel@vger.kernel.org>,
        Chunhao Lin <hau@realtek.com>
Subject: [RESEND PATCH net-next] r8169: add module param for control of ASPM disable.
Date: Wed, 14 Feb 2018 17:02:45 +0800
Message-ID: <1518598965-3593-1-git-send-email-hau@realtek.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.177.216]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch is from Todd Broch <tbroch@chromium.org>.
	ASPM has been disabled in this driver by default as its been
	implicated in stability issues on at least one platform.  This CL adds
	a module parameter to allow control of ASPM disable.  The default
	value is to enable ASPM again as its provides signficant (200mW) power
	savings on the platform I tested.

I make some modification that let this patch only for RTL8168G and later.

Signed-off-by: Chunhao Lin <hau@realtek.com>
---
 drivers/net/ethernet/realtek/r8169.c | 73 ++++++++++++++++++++++++------------
 1 file changed, 50 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index 0bf7d17..87d3136 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -346,6 +346,7 @@ static const struct pci_device_id rtl8169_pci_tbl[] = {
 MODULE_DEVICE_TABLE(pci, rtl8169_pci_tbl);
 
 static int rx_buf_sz = 16383;
+static int aspm_disable = 0;
 static int use_dac = -1;
 static struct {
 	u32 msg_enable;
@@ -867,6 +868,8 @@ struct rtl8169_private {
 
 MODULE_AUTHOR("Realtek and the Linux r8169 crew <netdev@vger.kernel.org>");
 MODULE_DESCRIPTION("RealTek RTL-8169 Gigabit Ethernet driver");
+module_param(aspm_disable, int, 0444);
+MODULE_PARM_DESC(aspm_disable, "Disable ASPM completely.");
 module_param(use_dac, int, 0);
 MODULE_PARM_DESC(use_dac, "Enable PCI DAC. Unsafe on 32 bit PCI slot.");
 module_param_named(debug, debug.msg_enable, int, 0);
@@ -5878,6 +5881,20 @@ static void rtl_pcie_state_l2l3_enable(struct rtl8169_private *tp, bool enable)
 	RTL_W8(Config3, data);
 }
 
+static void rtl_hw_internal_aspm_clkreq_enable(struct rtl8169_private *tp,
+				bool enable)
+{
+	void __iomem *ioaddr = tp->mmio_addr;
+
+	if (enable) {
+		RTL_W8(Config2, RTL_R8(Config2) | ClkReqEn);
+		RTL_W8(Config5, RTL_R8(Config5) | ASPM_en);
+	} else {
+		RTL_W8(Config2, RTL_R8(Config2) & ~ClkReqEn);
+		RTL_W8(Config5, RTL_R8(Config5) & ~ASPM_en);
+	}
+}
+
 #define R8168_CPCMD_QUIRK_MASK (\
 	EnableBist | \
 	Mac_dbgo_oe | \
@@ -6264,7 +6281,6 @@ static void rtl_hw_start_8168g(struct rtl8169_private *tp)
 
 static void rtl_hw_start_8168g_1(struct rtl8169_private *tp)
 {
-	void __iomem *ioaddr = tp->mmio_addr;
 	static const struct ephy_info e_info_8168g_1[] = {
 		{ 0x00, 0x0000,	0x0008 },
 		{ 0x0c, 0x37d0,	0x0820 },
@@ -6275,14 +6291,14 @@ static void rtl_hw_start_8168g_1(struct rtl8169_private *tp)
 	rtl_hw_start_8168g(tp);
 
 	/* disable aspm and clock request before access ephy */
-	RTL_W8(Config2, RTL_R8(Config2) & ~ClkReqEn);
-	RTL_W8(Config5, RTL_R8(Config5) & ~ASPM_en);
+	rtl_hw_internal_aspm_clkreq_enable(tp, false);
 	rtl_ephy_init(tp, e_info_8168g_1, ARRAY_SIZE(e_info_8168g_1));
+	if (!aspm_disable)
+		rtl_hw_internal_aspm_clkreq_enable(tp, true);
 }
 
 static void rtl_hw_start_8168g_2(struct rtl8169_private *tp)
 {
-	void __iomem *ioaddr = tp->mmio_addr;
 	static const struct ephy_info e_info_8168g_2[] = {
 		{ 0x00, 0x0000,	0x0008 },
 		{ 0x0c, 0x3df0,	0x0200 },
@@ -6293,14 +6309,14 @@ static void rtl_hw_start_8168g_2(struct rtl8169_private *tp)
 	rtl_hw_start_8168g(tp);
 
 	/* disable aspm and clock request before access ephy */
-	RTL_W8(Config2, RTL_R8(Config2) & ~ClkReqEn);
-	RTL_W8(Config5, RTL_R8(Config5) & ~ASPM_en);
+	rtl_hw_internal_aspm_clkreq_enable(tp, false);
 	rtl_ephy_init(tp, e_info_8168g_2, ARRAY_SIZE(e_info_8168g_2));
+	if (!aspm_disable)
+		rtl_hw_internal_aspm_clkreq_enable(tp, true);
 }
 
 static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
 {
-	void __iomem *ioaddr = tp->mmio_addr;
 	static const struct ephy_info e_info_8411_2[] = {
 		{ 0x00, 0x0000,	0x0008 },
 		{ 0x0c, 0x3df0,	0x0200 },
@@ -6312,9 +6328,10 @@ static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
 	rtl_hw_start_8168g(tp);
 
 	/* disable aspm and clock request before access ephy */
-	RTL_W8(Config2, RTL_R8(Config2) & ~ClkReqEn);
-	RTL_W8(Config5, RTL_R8(Config5) & ~ASPM_en);
+	rtl_hw_internal_aspm_clkreq_enable(tp, false);
 	rtl_ephy_init(tp, e_info_8411_2, ARRAY_SIZE(e_info_8411_2));
+	if (!aspm_disable)
+		rtl_hw_internal_aspm_clkreq_enable(tp, true);
 }
 
 static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
@@ -6333,8 +6350,7 @@ static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
 	};
 
 	/* disable aspm and clock request before access ephy */
-	RTL_W8(Config2, RTL_R8(Config2) & ~ClkReqEn);
-	RTL_W8(Config5, RTL_R8(Config5) & ~ASPM_en);
+	rtl_hw_internal_aspm_clkreq_enable(tp, false);
 	rtl_ephy_init(tp, e_info_8168h_1, ARRAY_SIZE(e_info_8168h_1));
 
 	RTL_W32(TxConfig, RTL_R32(TxConfig) | TXCFG_AUTO_FIFO);
@@ -6413,6 +6429,9 @@ static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
 	r8168_mac_ocp_write(tp, 0xe63e, 0x0000);
 	r8168_mac_ocp_write(tp, 0xc094, 0x0000);
 	r8168_mac_ocp_write(tp, 0xc09e, 0x0000);
+
+	if (!aspm_disable)
+		rtl_hw_internal_aspm_clkreq_enable(tp, true);
 }
 
 static void rtl_hw_start_8168ep(struct rtl8169_private *tp)
@@ -6458,7 +6477,6 @@ static void rtl_hw_start_8168ep(struct rtl8169_private *tp)
 
 static void rtl_hw_start_8168ep_1(struct rtl8169_private *tp)
 {
-	void __iomem *ioaddr = tp->mmio_addr;
 	static const struct ephy_info e_info_8168ep_1[] = {
 		{ 0x00, 0xffff,	0x10ab },
 		{ 0x06, 0xffff,	0xf030 },
@@ -6468,11 +6486,13 @@ static void rtl_hw_start_8168ep_1(struct rtl8169_private *tp)
 	};
 
 	/* disable aspm and clock request before access ephy */
-	RTL_W8(Config2, RTL_R8(Config2) & ~ClkReqEn);
-	RTL_W8(Config5, RTL_R8(Config5) & ~ASPM_en);
+	rtl_hw_internal_aspm_clkreq_enable(tp, false);
 	rtl_ephy_init(tp, e_info_8168ep_1, ARRAY_SIZE(e_info_8168ep_1));
 
 	rtl_hw_start_8168ep(tp);
+
+	if (!aspm_disable)
+		rtl_hw_internal_aspm_clkreq_enable(tp, true);
 }
 
 static void rtl_hw_start_8168ep_2(struct rtl8169_private *tp)
@@ -6485,14 +6505,16 @@ static void rtl_hw_start_8168ep_2(struct rtl8169_private *tp)
 	};
 
 	/* disable aspm and clock request before access ephy */
-	RTL_W8(Config2, RTL_R8(Config2) & ~ClkReqEn);
-	RTL_W8(Config5, RTL_R8(Config5) & ~ASPM_en);
+	rtl_hw_internal_aspm_clkreq_enable(tp, false);
 	rtl_ephy_init(tp, e_info_8168ep_2, ARRAY_SIZE(e_info_8168ep_2));
 
 	rtl_hw_start_8168ep(tp);
 
 	RTL_W8(DLLPR, RTL_R8(DLLPR) & ~PFM_EN);
 	RTL_W8(MISC_1, RTL_R8(MISC_1) & ~PFM_D3COLD_EN);
+
+	if (!aspm_disable)
+		rtl_hw_internal_aspm_clkreq_enable(tp, true);
 }
 
 static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
@@ -6507,8 +6529,7 @@ static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
 	};
 
 	/* disable aspm and clock request before access ephy */
-	RTL_W8(Config2, RTL_R8(Config2) & ~ClkReqEn);
-	RTL_W8(Config5, RTL_R8(Config5) & ~ASPM_en);
+	rtl_hw_internal_aspm_clkreq_enable(tp, false);
 	rtl_ephy_init(tp, e_info_8168ep_3, ARRAY_SIZE(e_info_8168ep_3));
 
 	rtl_hw_start_8168ep(tp);
@@ -6528,6 +6549,9 @@ static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
 	data = r8168_mac_ocp_read(tp, 0xe860);
 	data |= 0x0080;
 	r8168_mac_ocp_write(tp, 0xe860, data);
+
+	if (!aspm_disable)
+		rtl_hw_internal_aspm_clkreq_enable(tp, true);
 }
 
 static void rtl_hw_start_8168(struct net_device *dev)
@@ -8425,11 +8449,6 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	mii->reg_num_mask = 0x1f;
 	mii->supports_gmii = !!(cfg->features & RTL_FEATURE_GMII);
 
-	/* disable ASPM completely as that cause random device stop working
-	 * problems as well as full system hangs for some PCIe devices users */
-	pci_disable_link_state(pdev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1 |
-				     PCIE_LINK_STATE_CLKPM);
-
 	/* enable device (incl. PCI PM wakeup and hotplug setup) */
 	rc = pcim_enable_device(pdev);
 	if (rc < 0) {
@@ -8476,6 +8495,14 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Identify chip attached to board */
 	rtl8169_get_mac_version(tp, dev, cfg->default_ver);
 
+	/* disable ASPM completely as that cause random device stop working
+	 * problems as well as full system hangs for some PCIe devices users */
+	if (aspm_disable || tp->mac_version < RTL_GIGA_MAC_VER_40) {
+		pci_disable_link_state(pdev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1 |
+						PCIE_LINK_STATE_CLKPM);
+		netif_info(tp, probe, dev, "ASPM disabled\n");
+	}
+
 	tp->cp_cmd = 0;
 
 	if ((sizeof(dma_addr_t) > 4) &&
-- 
2.7.4
