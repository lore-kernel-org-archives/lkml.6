Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032149AbeBNQHh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:07:37 -0500
Received: from mail.phycore.de ([217.6.246.34]:46605 "EHLO root.phytec.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032044AbeBNQHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:07:15 -0500
From: Daniel Schultz <d.schultz@phytec.de>
To: robh+dt@kernel.org, mark.rutland@arm.com, andrew@lunn.ch,
        f.fainelli@gmail.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: w.egorov@phytec.de
Subject: [PATCH v3 1/2] net: phy: dp83867: Add binding for the CLK_OUT pin muxing option
Date: Wed, 14 Feb 2018 17:07:11 +0100
Message-Id: <1518624432-15110-1-git-send-email-d.schultz@phytec.de>
X-Mailer: git-send-email 2.7.4
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 14.02.2018 17:07:12,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 14.02.2018 17:07:12,
        Serialize complete at 14.02.2018 17:07:12
X-TNEFEvaluated: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wadim Egorov <w.egorov@phytec.de>

The DP83867 has a muxing option for the CLK_OUT pin. It is possible
to set CLK_OUT for different channels.
Create a binding to select a specific clock for CLK_OUT pin.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
Changes:
	v2:
	  Added check if clk_output_sel has a valid value
	  Only write the clock ouput register if a musing is desired
	v3:
	  -

 drivers/net/phy/dp83867.c            | 19 +++++++++++++++++++
 include/dt-bindings/net/ti-dp83867.h | 14 ++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index c1ab976..a862194 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -75,6 +75,8 @@
 
 #define DP83867_IO_MUX_CFG_IO_IMPEDANCE_MAX	0x0
 #define DP83867_IO_MUX_CFG_IO_IMPEDANCE_MIN	0x1f
+#define DP83867_IO_MUX_CFG_CLK_O_SEL_MASK	(0x1f << 8)
+#define DP83867_IO_MUX_CFG_CLK_O_SEL_SHIFT	8
 
 /* CFG4 bits */
 #define DP83867_CFG4_PORT_MIRROR_EN              BIT(0)
@@ -92,6 +94,7 @@ struct dp83867_private {
 	int io_impedance;
 	int port_mirroring;
 	bool rxctrl_strap_quirk;
+	int clk_output_sel;
 };
 
 static int dp83867_ack_interrupt(struct phy_device *phydev)
@@ -160,6 +163,14 @@ static int dp83867_of_init(struct phy_device *phydev)
 	dp83867->io_impedance = -EINVAL;
 
 	/* Optional configuration */
+	ret = of_property_read_u32(of_node, "ti,clk-output-sel",
+				   &dp83867->clk_output_sel);
+	if (ret || dp83867->clk_output_sel > DP83867_CLK_O_SEL_REF_CLK)
+		/* Keep the default value if ti,clk-output-sel is not set
+		 * or too high
+		 */
+		dp83867->clk_output_sel = DP83867_CLK_O_SEL_REF_CLK;
+
 	if (of_property_read_bool(of_node, "ti,max-output-impedance"))
 		dp83867->io_impedance = DP83867_IO_MUX_CFG_IO_IMPEDANCE_MAX;
 	else if (of_property_read_bool(of_node, "ti,min-output-impedance"))
@@ -295,6 +306,14 @@ static int dp83867_config_init(struct phy_device *phydev)
 	if (dp83867->port_mirroring != DP83867_PORT_MIRROING_KEEP)
 		dp83867_config_port_mirroring(phydev);
 
+	/* Clock output selection if muxing property is set */
+	if (dp83867->clk_output_sel != DP83867_CLK_O_SEL_REF_CLK) {
+		val = phy_read_mmd(phydev, DP83867_DEVADDR, DP83867_IO_MUX_CFG);
+		val &= ~DP83867_IO_MUX_CFG_CLK_O_SEL_MASK;
+		val |= (dp83867->clk_output_sel << DP83867_IO_MUX_CFG_CLK_O_SEL_SHIFT);
+		phy_write_mmd(phydev, DP83867_DEVADDR, DP83867_IO_MUX_CFG, val);
+	}
+
 	return 0;
 }
 
diff --git a/include/dt-bindings/net/ti-dp83867.h b/include/dt-bindings/net/ti-dp83867.h
index 172744a..7b16564 100644
--- a/include/dt-bindings/net/ti-dp83867.h
+++ b/include/dt-bindings/net/ti-dp83867.h
@@ -42,4 +42,18 @@
 #define	DP83867_RGMIIDCTL_3_75_NS	0xe
 #define	DP83867_RGMIIDCTL_4_00_NS	0xf
 
+/* IO_MUX_CFG - Clock output selection */
+#define DP83867_CLK_O_SEL_CHN_A_RCLK		0x0
+#define DP83867_CLK_O_SEL_CHN_B_RCLK		0x1
+#define DP83867_CLK_O_SEL_CHN_C_RCLK		0x2
+#define DP83867_CLK_O_SEL_CHN_D_RCLK		0x3
+#define DP83867_CLK_O_SEL_CHN_A_RCLK_DIV5	0x4
+#define DP83867_CLK_O_SEL_CHN_B_RCLK_DIV5	0x5
+#define DP83867_CLK_O_SEL_CHN_C_RCLK_DIV5	0x6
+#define DP83867_CLK_O_SEL_CHN_D_RCLK_DIV5	0x7
+#define DP83867_CLK_O_SEL_CHN_A_TCLK		0x8
+#define DP83867_CLK_O_SEL_CHN_B_TCLK		0x9
+#define DP83867_CLK_O_SEL_CHN_C_TCLK		0xA
+#define DP83867_CLK_O_SEL_CHN_D_TCLK		0xB
+#define DP83867_CLK_O_SEL_REF_CLK		0xC
 #endif
-- 
2.7.4
