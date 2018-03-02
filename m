Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427884AbeCBPtm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 10:49:42 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:15790 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S936276AbeCBPom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 10:44:42 -0500
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
Subject: [PATCH v2 04/10] video: add support of panel OTM8009A
Date: Fri, 2 Mar 2018 16:44:05 +0100
Message-ID: <1520005451-23217-5-git-send-email-yannick.fertre@st.com>
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

Support for Orise Tech otm8009a 480p dsi 2dl video mode panel.

Signed-off-by: yannick fertre <yannick.fertre@st.com>
---
 drivers/video/Kconfig              |   8 +
 drivers/video/Makefile             |   1 +
 drivers/video/orisetech_otm8009a.c | 329 +++++++++++++++++++++++++++++++++++++
 3 files changed, 338 insertions(+)
 create mode 100644 drivers/video/orisetech_otm8009a.c

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 1981298..b5fc535 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -320,6 +320,14 @@ config VIDEO_LCD_ANX9804
 	from a parallel LCD interface and translate it on the fy into a DP
 	interface for driving eDP TFT displays. It uses I2C for configuration.
 
+config VIDEO_LCD_ORISETECH_OTM8009A
+	bool "OTM8009A DSI LCD panel support"
+	depends on DM_VIDEO
+	select VIDEO_MIPI_DSI
+	default n
+	---help---
+	Support for Orise Tech otm8009a 480p dsi 2dl video mode panel.
+
 config VIDEO_LCD_SSD2828
 	bool "SSD2828 bridge chip"
 	default n
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 6f42cca..65002af 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_VIDEO_COREBOOT) += coreboot.o
 obj-$(CONFIG_VIDEO_DA8XX) += da8xx-fb.o videomodes.o
 obj-$(CONFIG_VIDEO_LCD_ANX9804) += anx9804.o
 obj-$(CONFIG_VIDEO_LCD_HITACHI_TX18D42VM) += hitachi_tx18d42vm_lcd.o
+obj-$(CONFIG_VIDEO_LCD_ORISETECH_OTM8009A) += orisetech_otm8009a.o
 obj-$(CONFIG_VIDEO_LCD_SSD2828) += ssd2828.o
 obj-$(CONFIG_VIDEO_MB862xx) += mb862xx.o videomodes.o
 obj-$(CONFIG_VIDEO_MX3) += mx3fb.o videomodes.o
diff --git a/drivers/video/orisetech_otm8009a.c b/drivers/video/orisetech_otm8009a.c
new file mode 100644
index 0000000..79f2da8
--- /dev/null
+++ b/drivers/video/orisetech_otm8009a.c
@@ -0,0 +1,329 @@
+/*
+ * Copyright (C) 2018 STMicroelectronics - All Rights Reserved
+ * Author(s): Yannick Fertre <yannick.fertre@st.com> for STMicroelectronics.
+ *	      Philippe Cornu <philippe.cornu@st.com> for STMicroelectronics.
+ *
+ * This otm8009a panel driver is based on the panel driver from
+ * drivers/gpu/drm/panel/panel-orisetech-otm8009a.c (kernel linux)
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+#include <asm/gpio.h>
+#include <backlight.h>
+#include <common.h>
+#include <dm.h>
+#include <panel.h>
+#include <power/regulator.h>
+#include <mipi_display.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define DRV_NAME "orisetech_otm8009a"
+
+#define OTM8009A_BACKLIGHT_DEFAULT	240
+#define OTM8009A_BACKLIGHT_MAX		255
+
+/* Manufacturer Command Set */
+#define MCS_ADRSFT	0x0000	/* Address Shift Function */
+#define MCS_PANSET	0xB3A6	/* Panel Type Setting */
+#define MCS_SD_CTRL	0xC0A2	/* Source Driver Timing Setting */
+#define MCS_P_DRV_M	0xC0B4	/* Panel Driving Mode */
+#define MCS_OSC_ADJ	0xC181	/* Oscillator Adjustment for Idle/Normal mode */
+#define MCS_RGB_VID_SET	0xC1A1	/* RGB Video Mode Setting */
+#define MCS_SD_PCH_CTRL	0xC480	/* Source Driver Precharge Control */
+#define MCS_NO_DOC1	0xC48A	/* Command not documented */
+#define MCS_PWR_CTRL1	0xC580	/* Power Control Setting 1 */
+#define MCS_PWR_CTRL2	0xC590	/* Power Control Setting 2 for Normal Mode */
+#define MCS_PWR_CTRL4	0xC5B0	/* Power Control Setting 4 for DC Voltage */
+#define MCS_PANCTRLSET1	0xCB80	/* Panel Control Setting 1 */
+#define MCS_PANCTRLSET2	0xCB90	/* Panel Control Setting 2 */
+#define MCS_PANCTRLSET3	0xCBA0	/* Panel Control Setting 3 */
+#define MCS_PANCTRLSET4	0xCBB0	/* Panel Control Setting 4 */
+#define MCS_PANCTRLSET5	0xCBC0	/* Panel Control Setting 5 */
+#define MCS_PANCTRLSET6	0xCBD0	/* Panel Control Setting 6 */
+#define MCS_PANCTRLSET7	0xCBE0	/* Panel Control Setting 7 */
+#define MCS_PANCTRLSET8	0xCBF0	/* Panel Control Setting 8 */
+#define MCS_PANU2D1	0xCC80	/* Panel U2D Setting 1 */
+#define MCS_PANU2D2	0xCC90	/* Panel U2D Setting 2 */
+#define MCS_PANU2D3	0xCCA0	/* Panel U2D Setting 3 */
+#define MCS_PAND2U1	0xCCB0	/* Panel D2U Setting 1 */
+#define MCS_PAND2U2	0xCCC0	/* Panel D2U Setting 2 */
+#define MCS_PAND2U3	0xCCD0	/* Panel D2U Setting 3 */
+#define MCS_GOAVST	0xCE80	/* GOA VST Setting */
+#define MCS_GOACLKA1	0xCEA0	/* GOA CLKA1 Setting */
+#define MCS_GOACLKA3	0xCEB0	/* GOA CLKA3 Setting */
+#define MCS_GOAECLK	0xCFC0	/* GOA ECLK Setting */
+#define MCS_NO_DOC2	0xCFD0	/* Command not documented */
+#define MCS_GVDDSET	0xD800	/* GVDD/NGVDD */
+#define MCS_VCOMDC	0xD900	/* VCOM Voltage Setting */
+#define MCS_GMCT2_2P	0xE100	/* Gamma Correction 2.2+ Setting */
+#define MCS_GMCT2_2N	0xE200	/* Gamma Correction 2.2- Setting */
+#define MCS_NO_DOC3	0xF5B6	/* Command not documented */
+#define MCS_CMD2_ENA1	0xFF00	/* Enable Access Command2 "CMD2" */
+#define MCS_CMD2_ENA2	0xFF80	/* Enable Access Orise Command2 */
+
+struct otm8009a_panel_priv {
+	struct udevice *reg;
+	struct gpio_desc reset;
+};
+
+static void otm8009a_dcs_write_buf(struct udevice *dev, const void *data,
+				   size_t len)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_platdata(dev);
+	struct mipi_dsi_device *device = plat->device;
+
+	if (mipi_dsi_dcs_write_buffer(device, data, len) < 0)
+		pr_err("mipi dsi dcs write buffer failed\n");
+}
+
+#define dcs_write_seq(dev, seq...)				\
+({								\
+	static const u8 d[] = { seq };				\
+	otm8009a_dcs_write_buf(dev, d, ARRAY_SIZE(d));		\
+})
+
+#define dcs_write_cmd_at(dev, cmd, seq...)		\
+({							\
+	static const u16 c = cmd;			\
+	struct udevice *device = dev;			\
+	dcs_write_seq(device, MCS_ADRSFT, (c) & 0xFF);	\
+	dcs_write_seq(device, (c) >> 8, seq);		\
+})
+
+static int otm8009a_init_sequence(struct udevice *dev)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_platdata(dev);
+	struct mipi_dsi_device *device = plat->device;
+	int ret;
+
+	/* Enter CMD2 */
+	dcs_write_cmd_at(dev, MCS_CMD2_ENA1, 0x80, 0x09, 0x01);
+
+	/* Enter Orise Command2 */
+	dcs_write_cmd_at(dev, MCS_CMD2_ENA2, 0x80, 0x09);
+
+	dcs_write_cmd_at(dev, MCS_SD_PCH_CTRL, 0x30);
+	mdelay(10);
+
+	dcs_write_cmd_at(dev, MCS_NO_DOC1, 0x40);
+	mdelay(10);
+
+	dcs_write_cmd_at(dev, MCS_PWR_CTRL4 + 1, 0xA9);
+	dcs_write_cmd_at(dev, MCS_PWR_CTRL2 + 1, 0x34);
+	dcs_write_cmd_at(dev, MCS_P_DRV_M, 0x50);
+	dcs_write_cmd_at(dev, MCS_VCOMDC, 0x4E);
+	dcs_write_cmd_at(dev, MCS_OSC_ADJ, 0x66); /* 65Hz */
+	dcs_write_cmd_at(dev, MCS_PWR_CTRL2 + 2, 0x01);
+	dcs_write_cmd_at(dev, MCS_PWR_CTRL2 + 5, 0x34);
+	dcs_write_cmd_at(dev, MCS_PWR_CTRL2 + 4, 0x33);
+	dcs_write_cmd_at(dev, MCS_GVDDSET, 0x79, 0x79);
+	dcs_write_cmd_at(dev, MCS_SD_CTRL + 1, 0x1B);
+	dcs_write_cmd_at(dev, MCS_PWR_CTRL1 + 2, 0x83);
+	dcs_write_cmd_at(dev, MCS_SD_PCH_CTRL + 1, 0x83);
+	dcs_write_cmd_at(dev, MCS_RGB_VID_SET, 0x0E);
+	dcs_write_cmd_at(dev, MCS_PANSET, 0x00, 0x01);
+
+	dcs_write_cmd_at(dev, MCS_GOAVST, 0x85, 0x01, 0x00, 0x84, 0x01, 0x00);
+	dcs_write_cmd_at(dev, MCS_GOACLKA1, 0x18, 0x04, 0x03, 0x39, 0x00, 0x00,
+			 0x00, 0x18, 0x03, 0x03, 0x3A, 0x00, 0x00, 0x00);
+	dcs_write_cmd_at(dev, MCS_GOACLKA3, 0x18, 0x02, 0x03, 0x3B, 0x00, 0x00,
+			 0x00, 0x18, 0x01, 0x03, 0x3C, 0x00, 0x00, 0x00);
+	dcs_write_cmd_at(dev, MCS_GOAECLK, 0x01, 0x01, 0x20, 0x20, 0x00, 0x00,
+			 0x01, 0x02, 0x00, 0x00);
+
+	dcs_write_cmd_at(dev, MCS_NO_DOC2, 0x00);
+
+	dcs_write_cmd_at(dev, MCS_PANCTRLSET1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
+	dcs_write_cmd_at(dev, MCS_PANCTRLSET2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+			 0, 0, 0, 0, 0);
+	dcs_write_cmd_at(dev, MCS_PANCTRLSET3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+			 0, 0, 0, 0, 0);
+	dcs_write_cmd_at(dev, MCS_PANCTRLSET4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
+	dcs_write_cmd_at(dev, MCS_PANCTRLSET5, 0, 4, 4, 4, 4, 4, 0, 0, 0, 0,
+			 0, 0, 0, 0, 0);
+	dcs_write_cmd_at(dev, MCS_PANCTRLSET6, 0, 0, 0, 0, 0, 0, 4, 4, 4, 4,
+			 4, 0, 0, 0, 0);
+	dcs_write_cmd_at(dev, MCS_PANCTRLSET7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
+	dcs_write_cmd_at(dev, MCS_PANCTRLSET8, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+			 0xFF, 0xFF, 0xFF, 0xFF, 0xFF);
+
+	dcs_write_cmd_at(dev, MCS_PANU2D1, 0x00, 0x26, 0x09, 0x0B, 0x01, 0x25,
+			 0x00, 0x00, 0x00, 0x00);
+	dcs_write_cmd_at(dev, MCS_PANU2D2, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			 0x00, 0x00, 0x00, 0x00, 0x00, 0x26, 0x0A, 0x0C, 0x02);
+	dcs_write_cmd_at(dev, MCS_PANU2D3, 0x25, 0x00, 0x00, 0x00, 0x00, 0x00,
+			 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
+	dcs_write_cmd_at(dev, MCS_PAND2U1, 0x00, 0x25, 0x0C, 0x0A, 0x02, 0x26,
+			 0x00, 0x00, 0x00, 0x00);
+	dcs_write_cmd_at(dev, MCS_PAND2U2, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			 0x00, 0x00, 0x00, 0x00, 0x00, 0x25, 0x0B, 0x09, 0x01);
+	dcs_write_cmd_at(dev, MCS_PAND2U3, 0x26, 0x00, 0x00, 0x00, 0x00, 0x00,
+			 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
+
+	dcs_write_cmd_at(dev, MCS_PWR_CTRL1 + 1, 0x66);
+
+	dcs_write_cmd_at(dev, MCS_NO_DOC3, 0x06);
+
+	dcs_write_cmd_at(dev, MCS_GMCT2_2P, 0x00, 0x09, 0x0F, 0x0E, 0x07, 0x10,
+			 0x0B, 0x0A, 0x04, 0x07, 0x0B, 0x08, 0x0F, 0x10, 0x0A,
+			 0x01);
+	dcs_write_cmd_at(dev, MCS_GMCT2_2N, 0x00, 0x09, 0x0F, 0x0E, 0x07, 0x10,
+			 0x0B, 0x0A, 0x04, 0x07, 0x0B, 0x08, 0x0F, 0x10, 0x0A,
+			 0x01);
+
+	/* Exit CMD2 */
+	dcs_write_cmd_at(dev, MCS_CMD2_ENA1, 0xFF, 0xFF, 0xFF);
+
+	ret =  mipi_dsi_dcs_nop(device);
+	if (ret)
+		return ret;
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(device);
+	if (ret)
+		return ret;
+
+	/* Wait for sleep out exit */
+	mdelay(120);
+
+	/* Default portrait 480x800 rgb24 */
+	dcs_write_seq(dev, MIPI_DCS_SET_ADDRESS_MODE, 0x00);
+
+	ret =  mipi_dsi_dcs_set_column_address(device, 0, 479);
+	if (ret)
+		return ret;
+
+	ret =  mipi_dsi_dcs_set_page_address(device, 0, 799);
+	if (ret)
+		return ret;
+
+	/* See otm8009a driver documentation for pixel format descriptions */
+	ret =  mipi_dsi_dcs_set_pixel_format(device, MIPI_DCS_PIXEL_FMT_24BIT |
+					     MIPI_DCS_PIXEL_FMT_24BIT << 4);
+	if (ret)
+		return ret;
+
+	/* Disable CABC feature */
+	dcs_write_seq(dev, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
+
+	ret = mipi_dsi_dcs_set_display_on(device);
+	if (ret)
+		return ret;
+
+	ret = mipi_dsi_dcs_nop(device);
+	if (ret)
+		return ret;
+
+	/* Send Command GRAM memory write (no parameters) */
+	dcs_write_seq(dev, MIPI_DCS_WRITE_MEMORY_START);
+
+	return 0;
+}
+
+static int otm8009a_panel_enable_backlight(struct udevice *dev)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_platdata(dev);
+	struct mipi_dsi_device *device = plat->device;
+	int ret;
+
+	device->lanes = 2;
+	device->format = MIPI_DSI_FMT_RGB888;
+	device->mode_flags = MIPI_DSI_MODE_VIDEO |
+			     MIPI_DSI_MODE_VIDEO_BURST |
+			     MIPI_DSI_MODE_LPM;
+
+	ret = mipi_dsi_attach(device);
+	if (ret < 0)
+		return ret;
+
+	pr_info("%s: initialize panel\n", __func__);
+	ret = otm8009a_init_sequence(dev);
+	if (ret)
+		return ret;
+
+	/*
+	 * Power on the backlight with the requested brightness
+	 * Note We can not use mipi_dsi_dcs_set_display_brightness()
+	 * as otm8009a driver support only 8-bit brightness (1 param).
+	 */
+	pr_info("%s: start, backlight\n", __func__);
+
+	dcs_write_seq(dev, MIPI_DCS_SET_DISPLAY_BRIGHTNESS,
+		      OTM8009A_BACKLIGHT_DEFAULT);
+
+	/* Update Brightness Control & Backlight */
+	dcs_write_seq(dev, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x24);
+
+	/*  need to wait a few time before set the DSI bridge in video mode */
+	mdelay(10);
+
+	return 0;
+}
+
+static int otm8009a_panel_ofdata_to_platdata(struct udevice *dev)
+{
+	struct otm8009a_panel_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	if (IS_ENABLED(CONFIG_DM_REGULATOR)) {
+		ret = uclass_get_device_by_phandle(UCLASS_REGULATOR, dev,
+						   "power-supply", &priv->reg);
+		if (ret) {
+			pr_err("%s: Warning: cannot get power supply\n",
+			       __func__);
+			if (ret != -ENOENT)
+				return ret;
+		}
+	}
+
+	ret = gpio_request_by_name(dev, "reset-gpios", 0, &priv->reset,
+				   GPIOD_IS_OUT);
+	if (ret) {
+		pr_err("%s: Warning: cannot get reset GPIO\n", __func__);
+		if (ret != -ENOENT)
+			return ret;
+	}
+
+	/* reset panel must be done before probe */
+	dm_gpio_set_value(&priv->reset, true);
+
+	return 0;
+}
+
+static int otm8009a_panel_probe(struct udevice *dev)
+{
+	struct otm8009a_panel_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	if (IS_ENABLED(CONFIG_DM_REGULATOR) && priv->reg) {
+		pr_err("%s: Enable regulator '%s'\n", __func__,
+		       priv->reg->name);
+		ret = regulator_set_enable(priv->reg, true);
+		if (ret)
+			return ret;
+	}
+
+	dm_gpio_set_value(&priv->reset, false);
+
+	return 0;
+}
+
+static const struct panel_ops otm8009a_panel_ops = {
+	.enable_backlight = otm8009a_panel_enable_backlight,
+};
+
+static const struct udevice_id otm8009a_panel_ids[] = {
+	{ .compatible = "orisetech,otm8009a" },
+	{ }
+};
+
+U_BOOT_DRIVER(otm8009a_panel) = {
+	.name			  = "otm8009a_panel",
+	.id			  = UCLASS_PANEL,
+	.of_match		  = otm8009a_panel_ids,
+	.ops			  = &otm8009a_panel_ops,
+	.ofdata_to_platdata	  = otm8009a_panel_ofdata_to_platdata,
+	.probe			  = otm8009a_panel_probe,
+	.platdata_auto_alloc_size = sizeof(struct mipi_dsi_panel_plat),
+	.priv_auto_alloc_size	= sizeof(struct otm8009a_panel_priv),
+};
-- 
1.9.1
