Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427854AbeCBPtX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 10:49:23 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33823 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S936277AbeCBPon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 10:44:43 -0500
From: yannick fertre <yannick.fertre@st.com>
To: Vikas Manocha <vikas.manocha@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Patrick DELAUNAY <patrick.delaunay@st.com>,
        Christophe KERELLO <christophe.kerello@st.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Brian Norris <briannorris@chromium.org>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Albert Aribaud <albert.u.boot@aribaud.net>,
        "Simon Glass" <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>,
        Thierry Reding <thierry.reding@gmail.com>
CC: <u-boot@lists.denx.de>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 06/10] video: add support of STM32 MIPI DSI controller driver
Date: Fri, 2 Mar 2018 16:44:07 +0100
Message-ID: <1520005451-23217-7-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520005451-23217-1-git-send-email-yannick.fertre@st.com>
References: <1520005451-23217-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.68]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-02_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the STM32 DSI controller driver that uses the Synopsys DesignWare
MIPI DSI host controller bridge.

Signed-off-by: yannick fertre <yannick.fertre@st.com>
---
 drivers/video/stm32/Kconfig     |  10 +
 drivers/video/stm32/Makefile    |   1 +
 drivers/video/stm32/stm32_dsi.c | 427 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 438 insertions(+)
 create mode 100644 drivers/video/stm32/stm32_dsi.c

diff --git a/drivers/video/stm32/Kconfig b/drivers/video/stm32/Kconfig
index 113a2bb..2ea6f18 100644
--- a/drivers/video/stm32/Kconfig
+++ b/drivers/video/stm32/Kconfig
@@ -15,6 +15,16 @@ menuconfig VIDEO_STM32
 	  DSI. This option enables these supports which can be used on
 	  devices which have RGB TFT or DSI display connected.
 
+config VIDEO_STM32_DSI
+	bool "Enable STM32 DSI video support"
+	depends on VIDEO_STM32
+	select VIDEO_MIPI_DSI
+	select VIDEO_BRIDGE
+	select VIDEO_DW_MIPI_DSI
+	help
+	  This option enables support DSI internal bridge which can be used on
+	  devices which have DSI display connected.
+
 config VIDEO_STM32_MAX_XRES
 	int "Maximum horizontal resolution (for memory allocation purposes)"
 	depends on VIDEO_STM32
diff --git a/drivers/video/stm32/Makefile b/drivers/video/stm32/Makefile
index 372a2e1..f8c3ff7 100644
--- a/drivers/video/stm32/Makefile
+++ b/drivers/video/stm32/Makefile
@@ -8,3 +8,4 @@
 #
 
 obj-${CONFIG_VIDEO_STM32} = stm32_ltdc.o
+obj-${CONFIG_VIDEO_STM32_DSI} += stm32_dsi.o
diff --git a/drivers/video/stm32/stm32_dsi.c b/drivers/video/stm32/stm32_dsi.c
new file mode 100644
index 0000000..3e26433
--- /dev/null
+++ b/drivers/video/stm32/stm32_dsi.c
@@ -0,0 +1,427 @@
+/*
+ * Copyright (C) 2018 STMicroelectronics - All Rights Reserved
+ * Author(s): Philippe Cornu <philippe.cornu@st.com> for STMicroelectronics.
+ *	      Yannick Fertre <yannick.fertre@st.com> for STMicroelectronics.
+ *
+ * This driver is based on the mipi dsi driver from
+ * drivers/gpu/drm/stm/dw_mipi_dsi-stm.c (kernel linux).
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include <asm/io.h>
+#include <asm/arch/gpio.h>
+#include <common.h>
+#include <clk.h>
+#include <dm.h>
+#include <dm/device-internal.h>
+#include <mipi_display.h>
+#include <dw_mipi_dsi.h>
+#include <linux/iopoll.h>
+#include <panel.h>
+#include <reset.h>
+#include <video.h>
+#include <video_bridge.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define HWVER_130			0x31333000	/* IP version 1.30 */
+#define HWVER_131			0x31333100	/* IP version 1.31 */
+
+/* DSI digital registers & bit definitions */
+#define DSI_VERSION			0x00
+#define VERSION				GENMASK(31, 8)
+
+/*
+ * DSI wrapper registers & bit definitions
+ * Note: registers are named as in the Reference Manual
+ */
+#define DSI_WCFGR	0x0400		/* Wrapper ConFiGuration Reg */
+#define WCFGR_DSIM	BIT(0)		/* DSI Mode */
+#define WCFGR_COLMUX	GENMASK(3, 1)	/* COLor MUltipleXing */
+
+#define DSI_WCR		0x0404		/* Wrapper Control Reg */
+#define WCR_DSIEN	BIT(3)		/* DSI ENable */
+
+#define DSI_WISR	0x040C		/* Wrapper Interrupt and Status Reg */
+#define WISR_PLLLS	BIT(8)		/* PLL Lock Status */
+#define WISR_RRS	BIT(12)		/* Regulator Ready Status */
+
+#define DSI_WPCR0	0x0418		/* Wrapper Phy Conf Reg 0 */
+#define WPCR0_UIX4	GENMASK(5, 0)	/* Unit Interval X 4 */
+#define WPCR0_TDDL	BIT(16)		/* Turn Disable Data Lanes */
+
+#define DSI_WRPCR	0x0430		/* Wrapper Regulator & Pll Ctrl Reg */
+#define WRPCR_PLLEN	BIT(0)		/* PLL ENable */
+#define WRPCR_NDIV	GENMASK(8, 2)	/* pll loop DIVision Factor */
+#define WRPCR_IDF	GENMASK(14, 11)	/* pll Input Division Factor */
+#define WRPCR_ODF	GENMASK(17, 16)	/* pll Output Division Factor */
+#define WRPCR_REGEN	BIT(24)		/* REGulator ENable */
+#define WRPCR_BGREN	BIT(28)		/* BandGap Reference ENable */
+#define IDF_MIN		1
+#define IDF_MAX		7
+#define NDIV_MIN	10
+#define NDIV_MAX	125
+#define ODF_MIN		1
+#define ODF_MAX		8
+
+/* dsi color format coding according to the datasheet */
+enum dsi_color {
+	DSI_RGB565_CONF1,
+	DSI_RGB565_CONF2,
+	DSI_RGB565_CONF3,
+	DSI_RGB666_CONF1,
+	DSI_RGB666_CONF2,
+	DSI_RGB888,
+};
+
+#define LANE_MIN_KBPS	31250
+#define LANE_MAX_KBPS	500000
+
+/* Timeout for regulator on/off, pll lock/unlock & fifo empty */
+#define TIMEOUT_US	200000
+
+struct stm32_dsi_priv {
+	struct mipi_dsi_device device;
+	void __iomem *base;
+	struct udevice *panel;
+	u32 pllref_clk;
+	u32 hw_version;
+	int lane_min_kbps;
+	int lane_max_kbps;
+};
+
+static inline void dsi_write(struct stm32_dsi_priv *dsi, u32 reg, u32 val)
+{
+	writel(val, dsi->base + reg);
+}
+
+static inline u32 dsi_read(struct stm32_dsi_priv *dsi, u32 reg)
+{
+	return readl(dsi->base + reg);
+}
+
+static inline void dsi_set(struct stm32_dsi_priv *dsi, u32 reg, u32 mask)
+{
+	dsi_write(dsi, reg, dsi_read(dsi, reg) | mask);
+}
+
+static inline void dsi_clear(struct stm32_dsi_priv *dsi, u32 reg, u32 mask)
+{
+	dsi_write(dsi, reg, dsi_read(dsi, reg) & ~mask);
+}
+
+static inline void dsi_update_bits(struct stm32_dsi_priv *dsi, u32 reg,
+				   u32 mask, u32 val)
+{
+	dsi_write(dsi, reg, (dsi_read(dsi, reg) & ~mask) | val);
+}
+
+static enum dsi_color dsi_color_from_mipi(u32 fmt)
+{
+	switch (fmt) {
+	case MIPI_DSI_FMT_RGB888:
+		return DSI_RGB888;
+	case MIPI_DSI_FMT_RGB666:
+		return DSI_RGB666_CONF2;
+	case MIPI_DSI_FMT_RGB666_PACKED:
+		return DSI_RGB666_CONF1;
+	case MIPI_DSI_FMT_RGB565:
+		return DSI_RGB565_CONF1;
+	default:
+		pr_err("MIPI color invalid, so we use rgb888\n");
+	}
+	return DSI_RGB888;
+}
+
+static int dsi_pll_get_clkout_khz(int clkin_khz, int idf, int ndiv, int odf)
+{
+	int divisor = idf * odf;
+
+	/* prevent from division by 0 */
+	if (!divisor)
+		return 0;
+
+	return DIV_ROUND_CLOSEST(clkin_khz * ndiv, divisor);
+}
+
+static int dsi_pll_get_params(struct stm32_dsi_priv *dsi,
+			      int clkin_khz, int clkout_khz,
+			      int *idf, int *ndiv, int *odf)
+{
+	int i, o, n, n_min, n_max;
+	int fvco_min, fvco_max, delta, best_delta; /* all in khz */
+
+	/* Early checks preventing division by 0 & odd results */
+	if (clkin_khz <= 0 || clkout_khz <= 0)
+		return -EINVAL;
+
+	fvco_min = dsi->lane_min_kbps * 2 * ODF_MAX;
+	fvco_max = dsi->lane_max_kbps * 2 * ODF_MIN;
+
+	best_delta = 1000000; /* big started value (1000000khz) */
+
+	for (i = IDF_MIN; i <= IDF_MAX; i++) {
+		/* Compute ndiv range according to Fvco */
+		n_min = ((fvco_min * i) / (2 * clkin_khz)) + 1;
+		n_max = (fvco_max * i) / (2 * clkin_khz);
+
+		/* No need to continue idf loop if we reach ndiv max */
+		if (n_min >= NDIV_MAX)
+			break;
+
+		/* Clamp ndiv to valid values */
+		if (n_min < NDIV_MIN)
+			n_min = NDIV_MIN;
+		if (n_max > NDIV_MAX)
+			n_max = NDIV_MAX;
+
+		for (o = ODF_MIN; o <= ODF_MAX; o *= 2) {
+			n = DIV_ROUND_CLOSEST(i * o * clkout_khz, clkin_khz);
+			/* Check ndiv according to vco range */
+			if (n < n_min || n > n_max)
+				continue;
+			/* Check if new delta is better & saves parameters */
+			delta = dsi_pll_get_clkout_khz(clkin_khz, i, n, o) -
+				clkout_khz;
+			if (delta < 0)
+				delta = -delta;
+			if (delta < best_delta) {
+				*idf = i;
+				*ndiv = n;
+				*odf = o;
+				best_delta = delta;
+			}
+			/* fast return in case of "perfect result" */
+			if (!delta)
+				return 0;
+		}
+	}
+
+	return 0;
+}
+
+static int dsi_phy_init(void *priv_data)
+{
+	struct mipi_dsi_device *device = priv_data;
+	struct stm32_dsi_priv *dsi = dev_get_priv(device->dev);
+	u32 val;
+	int ret;
+
+	/* Enable the regulator */
+	dsi_set(dsi, DSI_WRPCR, WRPCR_REGEN | WRPCR_BGREN);
+	ret = readl_poll_timeout(dsi->base + DSI_WISR, val, val & WISR_RRS,
+				 TIMEOUT_US);
+	if (ret) {
+		pr_err("!TIMEOUT! waiting REGU\n");
+		return ret;
+	}
+
+	/* Enable the DSI PLL & wait for its lock */
+	dsi_set(dsi, DSI_WRPCR, WRPCR_PLLEN);
+	ret = readl_poll_timeout(dsi->base + DSI_WISR, val, val & WISR_PLLLS,
+				 TIMEOUT_US);
+	if (ret) {
+		pr_err("!TIMEOUT! waiting PLL\n");
+		return ret;
+	}
+
+	/* Enable the DSI wrapper */
+	dsi_set(dsi, DSI_WCR, WCR_DSIEN);
+
+	return 0;
+}
+
+static int dsi_get_lane_mbps(void *priv_data, struct display_timing *timings,
+			     u32 lanes, u32 format, unsigned int *lane_mbps)
+{
+	struct mipi_dsi_device *device = priv_data;
+	struct stm32_dsi_priv *dsi = dev_get_priv(device->dev);
+	int idf, ndiv, odf, pll_in_khz, pll_out_khz;
+	int ret, bpp;
+	u32 val;
+
+	/* Update lane capabilities according to hw version */
+	dsi->hw_version = dsi_read(dsi, DSI_VERSION) & VERSION;
+	dsi->lane_min_kbps = LANE_MIN_KBPS;
+	dsi->lane_max_kbps = LANE_MAX_KBPS;
+	if (dsi->hw_version == HWVER_131) {
+		dsi->lane_min_kbps *= 2;
+		dsi->lane_max_kbps *= 2;
+	}
+
+	pll_in_khz = dsi->pllref_clk / 1000;
+
+	/* Compute requested pll out */
+	bpp = mipi_dsi_pixel_format_to_bpp(format);
+	pll_out_khz = (timings->pixelclock.typ / 1000) * bpp / lanes;
+	/* Add 20% to pll out to be higher than pixel bw (burst mode only) */
+	pll_out_khz = (pll_out_khz * 12) / 10;
+	if (pll_out_khz > dsi->lane_max_kbps) {
+		pll_out_khz = dsi->lane_max_kbps;
+		pr_warn("Warning max phy mbps is used\n");
+	}
+	if (pll_out_khz < dsi->lane_min_kbps) {
+		pll_out_khz = dsi->lane_min_kbps;
+		pr_warn("Warning min phy mbps is used\n");
+	}
+
+	/* Compute best pll parameters */
+	idf = 0;
+	ndiv = 0;
+	odf = 0;
+	ret = dsi_pll_get_params(dsi, pll_in_khz, pll_out_khz,
+				 &idf, &ndiv, &odf);
+	if (ret) {
+		pr_warn("Warning dsi_pll_get_params(): bad params\n");
+		return ret;
+	}
+
+	/* Get the adjusted pll out value */
+	pll_out_khz = dsi_pll_get_clkout_khz(pll_in_khz, idf, ndiv, odf);
+
+	/* Set the PLL division factors */
+	dsi_update_bits(dsi, DSI_WRPCR,	WRPCR_NDIV | WRPCR_IDF | WRPCR_ODF,
+			(ndiv << 2) | (idf << 11) | ((ffs(odf) - 1) << 16));
+
+	/* Compute uix4 & set the bit period in high-speed mode */
+	val = 4000000 / pll_out_khz;
+	dsi_update_bits(dsi, DSI_WPCR0, WPCR0_UIX4, val);
+
+	/* Select video mode by resetting DSIM bit */
+	dsi_clear(dsi, DSI_WCFGR, WCFGR_DSIM);
+
+	/* Select the color coding */
+	dsi_update_bits(dsi, DSI_WCFGR, WCFGR_COLMUX,
+			dsi_color_from_mipi(format) << 1);
+
+	*lane_mbps = pll_out_khz / 1000;
+
+	pr_info("pll_in %ukHz pll_out %ukHz lane_mbps %uMHz\n",
+		pll_in_khz, pll_out_khz, *lane_mbps);
+
+	return 0;
+}
+
+static const struct dw_mipi_dsi_phy_ops dw_mipi_dsi_stm_phy_ops = {
+	.init = dsi_phy_init,
+	.get_lane_mbps = dsi_get_lane_mbps,
+};
+
+static int stm32_dsi_attach(struct udevice *dev)
+{
+	struct stm32_dsi_priv *priv = dev_get_priv(dev);
+	struct dw_mipi_dsi_plat_data *platdata = dev_get_platdata(dev);
+	struct mipi_dsi_device *device = &priv->device;
+	int ret;
+
+	platdata->max_data_lanes = 2;
+	platdata->phy_ops = &dw_mipi_dsi_stm_phy_ops;
+
+	ret = uclass_first_device(UCLASS_PANEL, &platdata->panel);
+	if (ret) {
+		pr_err("%s: panel device error %d\n", __func__, ret);
+		return ret;
+	}
+
+	ret = dw_mipi_dsi_init_bridge(device);
+	if (ret) {
+		pr_err("Failed to initialize mipi dsi host\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int stm32_dsi_set_backlight(struct udevice *dev, int percent)
+{
+	struct dw_mipi_dsi_plat_data *dplat = dev_get_platdata(dev);
+	struct stm32_dsi_priv *priv = dev_get_priv(dev);
+	struct mipi_dsi_device *device = &priv->device;
+	struct udevice *panel = dplat->panel;
+	struct mipi_dsi_panel_plat *mplat;
+	int ret;
+
+	mplat = dev_get_platdata(panel);
+	mplat->device = device;
+
+	ret = panel_enable_backlight(panel);
+	if (ret) {
+		pr_err("%s: panel %s enable backlight error %d\n",
+		       __func__, panel->name, ret);
+		return ret;
+	}
+
+	dw_mipi_dsi_bridge_enable(device);
+
+	return 0;
+}
+
+static int stm32_dsi_probe(struct udevice *dev)
+{
+	struct stm32_dsi_priv *priv = dev_get_priv(dev);
+	struct mipi_dsi_device *device = &priv->device;
+	struct reset_ctl rst;
+	struct clk clk;
+	int ret;
+
+	device->dev = dev;
+
+	priv->base = (void *)dev_read_addr(dev);
+	if ((fdt_addr_t)priv->base == FDT_ADDR_T_NONE) {
+		pr_err("%s: dsi dt register address error\n", __func__);
+		return -EINVAL;
+	}
+
+	ret = clk_get_by_name(device->dev, "pclk", &clk);
+	if (ret) {
+		pr_err("%s: peripheral clock get error %d\n", __func__, ret);
+		return -ENODEV;
+	}
+
+	ret = clk_enable(&clk);
+	if (ret) {
+		pr_err("%s: peripheral clock enable error %d\n", __func__, ret);
+		return -ENODEV;
+	}
+
+	ret = clk_get_by_name(dev, "ref", &clk);
+	if (ret) {
+		pr_err("%s: pll reference clock get error %d\n", __func__, ret);
+		return ret;
+	}
+
+	priv->pllref_clk = (unsigned int)clk_get_rate(&clk);
+
+	ret = reset_get_by_index(device->dev, 0, &rst);
+	if (ret) {
+		pr_err("%s: missing dsi hardware reset\n", __func__);
+		return -ENODEV;
+	}
+
+	/* Reset */
+	reset_deassert(&rst);
+
+	return 0;
+}
+
+struct video_bridge_ops stm32_dsi_ops = {
+	.attach = stm32_dsi_attach,
+	.set_backlight = stm32_dsi_set_backlight,
+};
+
+static const struct udevice_id stm32_dsi_ids[] = {
+	{ .compatible = "st,stm32-dsi"},
+	{ }
+};
+
+U_BOOT_DRIVER(stm32_dsi) = {
+	.name				= "stm32-display-dsi",
+	.id				= UCLASS_VIDEO_BRIDGE,
+	.of_match			= stm32_dsi_ids,
+	.bind				= dm_scan_fdt_dev,
+	.probe				= stm32_dsi_probe,
+	.ops				= &stm32_dsi_ops,
+	.priv_auto_alloc_size		= sizeof(struct stm32_dsi_priv),
+	.platdata_auto_alloc_size	= sizeof(struct dw_mipi_dsi_plat_data),
+};
-- 
1.9.1
