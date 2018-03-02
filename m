Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946404AbeCBPqr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 10:46:47 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33943 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1425031AbeCBPqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 10:46:42 -0500
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
Subject: [PATCH v2 05/10] video: add MIPI DSI host controller bridge
Date: Fri, 2 Mar 2018 16:44:06 +0100
Message-ID: <1520005451-23217-6-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520005451-23217-1-git-send-email-yannick.fertre@st.com>
References: <1520005451-23217-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="a"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.68]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-02_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a Synopsys Designware MIPI DSI host bridge driver, based on the
Rockchip version from rockchip/dw-mipi-dsi.c with phy & bridge APIs.

Signed-off-by: yannick fertre <yannick.fertre@st.com>
---
 drivers/video/Kconfig       |   9 +
 drivers/video/Makefile      |   1 +
 drivers/video/dw_mipi_dsi.c | 822 ++++++++++++++++++++++++++++++++++++++++++++
 include/dw_mipi_dsi.h       |  32 ++
 4 files changed, 864 insertions(+)
 create mode 100644 drivers/video/dw_mipi_dsi.c
 create mode 100644 include/dw_mipi_dsi.h

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index b5fc535..0f641d7 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -657,6 +657,15 @@ config VIDEO_DW_HDMI
 	  rather requires a SoC-specific glue driver to call it), it
 	  can not be enabled from the configuration menu.
 
+config VIDEO_DW_MIPI_DSI
+	bool
+	help
+	  Enables the common driver code for the Designware MIPI DSI
+	  block found in SoCs from various vendors.
+	  As this does not provide any functionality by itself (but
+	  rather requires a SoC-specific glue driver to call it), it
+	  can not be enabled from the configuration menu.
+
 config VIDEO_SIMPLE
 	bool "Simple display driver for preconfigured display"
 	help
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 65002af..50be569 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_FORMIKE) += formike.o
 obj-$(CONFIG_LG4573) += lg4573.o
 obj-$(CONFIG_AM335X_LCD) += am335x-fb.o
 obj-$(CONFIG_VIDEO_DW_HDMI) += dw_hdmi.o
+obj-$(CONFIG_VIDEO_DW_MIPI_DSI) += dw_mipi_dsi.o
 obj-${CONFIG_VIDEO_MIPI_DSI} += mipi_display.o
 obj-$(CONFIG_VIDEO_SIMPLE) += simplefb.o
 obj-${CONFIG_VIDEO_TEGRA124} += tegra124/
diff --git a/drivers/video/dw_mipi_dsi.c b/drivers/video/dw_mipi_dsi.c
new file mode 100644
index 0000000..d7bd92d
--- /dev/null
+++ b/drivers/video/dw_mipi_dsi.c
@@ -0,0 +1,822 @@
+/*
+ * Copyright (C) 2016, Fuzhou Rockchip Electronics Co., Ltd
+ * Copyright (C) 2018, STMicroelectronics - All Rights Reserved
+ * Author(s): Philippe Cornu <philippe.cornu@st.com> for STMicroelectronics.
+ *	      Yannick Fertre <yannick.fertre@st.com> for STMicroelectronics.
+ *
+ * Modified by Yannick Fertre <yannick.fertre@st.com>
+ * This generic Synopsys DesignWare MIPI DSI host driver is based on the
+ * bridge synopsys from drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c (kernel
+ * linux).
+ */
+
+#include <common.h>
+#include <clk.h>
+#include <dm.h>
+#include <errno.h>
+#include <mipi_display.h>
+#include <panel.h>
+#include <video.h>
+#include <asm/io.h>
+#include <asm/arch/gpio.h>
+#include <dm/device-internal.h>
+#include <dw_mipi_dsi.h>
+#include <linux/iopoll.h>
+#include <video_bridge.h>
+
+#define HWVER_131			0x31333100	/* IP version 1.31 */
+
+#define DSI_VERSION			0x00
+#define VERSION				GENMASK(31, 8)
+
+#define DSI_PWR_UP			0x04
+#define RESET				0
+#define POWERUP				BIT(0)
+
+#define DSI_CLKMGR_CFG			0x08
+#define TO_CLK_DIVISION(div)		(((div) & 0xff) << 8)
+#define TX_ESC_CLK_DIVISION(div)	((div) & 0xff)
+
+#define DSI_DPI_VCID			0x0c
+#define DPI_VCID(vcid)			((vcid) & 0x3)
+
+#define DSI_DPI_COLOR_CODING		0x10
+#define LOOSELY18_EN			BIT(8)
+#define DPI_COLOR_CODING_16BIT_1	0x0
+#define DPI_COLOR_CODING_16BIT_2	0x1
+#define DPI_COLOR_CODING_16BIT_3	0x2
+#define DPI_COLOR_CODING_18BIT_1	0x3
+#define DPI_COLOR_CODING_18BIT_2	0x4
+#define DPI_COLOR_CODING_24BIT		0x5
+
+#define DSI_DPI_CFG_POL			0x14
+#define COLORM_ACTIVE_LOW		BIT(4)
+#define SHUTD_ACTIVE_LOW		BIT(3)
+#define HSYNC_ACTIVE_LOW		BIT(2)
+#define VSYNC_ACTIVE_LOW		BIT(1)
+#define DATAEN_ACTIVE_LOW		BIT(0)
+
+#define DSI_DPI_LP_CMD_TIM		0x18
+#define OUTVACT_LPCMD_TIME(p)		(((p) & 0xff) << 16)
+#define INVACT_LPCMD_TIME(p)		((p) & 0xff)
+
+#define DSI_DBI_VCID			0x1c
+#define DSI_DBI_CFG			0x20
+#define DSI_DBI_PARTITIONING_EN		0x24
+#define DSI_DBI_CMDSIZE			0x28
+
+#define DSI_PCKHDL_CFG			0x2c
+#define CRC_RX_EN			BIT(4)
+#define ECC_RX_EN			BIT(3)
+#define BTA_EN				BIT(2)
+#define EOTP_RX_EN			BIT(1)
+#define EOTP_TX_EN			BIT(0)
+
+#define DSI_GEN_VCID			0x30
+
+#define DSI_MODE_CFG			0x34
+#define ENABLE_VIDEO_MODE		0
+#define ENABLE_CMD_MODE			BIT(0)
+
+#define DSI_VID_MODE_CFG		0x38
+#define ENABLE_LOW_POWER		(0x3f << 8)
+#define ENABLE_LOW_POWER_MASK		(0x3f << 8)
+#define VID_MODE_TYPE_NON_BURST_SYNC_PULSES	0x0
+#define VID_MODE_TYPE_NON_BURST_SYNC_EVENTS	0x1
+#define VID_MODE_TYPE_BURST			0x2
+#define VID_MODE_TYPE_MASK			0x3
+
+#define DSI_VID_PKT_SIZE		0x3c
+#define VID_PKT_SIZE(p)			((p) & 0x3fff)
+
+#define DSI_VID_NUM_CHUNKS		0x40
+#define VID_NUM_CHUNKS(c)		((c) & 0x1fff)
+
+#define DSI_VID_NULL_SIZE		0x44
+#define VID_NULL_SIZE(b)		((b) & 0x1fff)
+
+#define DSI_VID_HSA_TIME		0x48
+#define DSI_VID_HBP_TIME		0x4c
+#define DSI_VID_HLINE_TIME		0x50
+#define DSI_VID_VSA_LINES		0x54
+#define DSI_VID_VBP_LINES		0x58
+#define DSI_VID_VFP_LINES		0x5c
+#define DSI_VID_VACTIVE_LINES		0x60
+#define DSI_EDPI_CMD_SIZE		0x64
+
+#define DSI_CMD_MODE_CFG		0x68
+#define MAX_RD_PKT_SIZE_LP		BIT(24)
+#define DCS_LW_TX_LP			BIT(19)
+#define DCS_SR_0P_TX_LP			BIT(18)
+#define DCS_SW_1P_TX_LP			BIT(17)
+#define DCS_SW_0P_TX_LP			BIT(16)
+#define GEN_LW_TX_LP			BIT(14)
+#define GEN_SR_2P_TX_LP			BIT(13)
+#define GEN_SR_1P_TX_LP			BIT(12)
+#define GEN_SR_0P_TX_LP			BIT(11)
+#define GEN_SW_2P_TX_LP			BIT(10)
+#define GEN_SW_1P_TX_LP			BIT(9)
+#define GEN_SW_0P_TX_LP			BIT(8)
+#define ACK_RQST_EN			BIT(1)
+#define TEAR_FX_EN			BIT(0)
+
+#define CMD_MODE_ALL_LP			(MAX_RD_PKT_SIZE_LP | \
+					 DCS_LW_TX_LP | \
+					 DCS_SR_0P_TX_LP | \
+					 DCS_SW_1P_TX_LP | \
+					 DCS_SW_0P_TX_LP | \
+					 GEN_LW_TX_LP | \
+					 GEN_SR_2P_TX_LP | \
+					 GEN_SR_1P_TX_LP | \
+					 GEN_SR_0P_TX_LP | \
+					 GEN_SW_2P_TX_LP | \
+					 GEN_SW_1P_TX_LP | \
+					 GEN_SW_0P_TX_LP)
+
+#define DSI_GEN_HDR			0x6c
+#define DSI_GEN_PLD_DATA		0x70
+
+#define DSI_CMD_PKT_STATUS		0x74
+#define GEN_RD_CMD_BUSY			BIT(6)
+#define GEN_PLD_R_FULL			BIT(5)
+#define GEN_PLD_R_EMPTY			BIT(4)
+#define GEN_PLD_W_FULL			BIT(3)
+#define GEN_PLD_W_EMPTY			BIT(2)
+#define GEN_CMD_FULL			BIT(1)
+#define GEN_CMD_EMPTY			BIT(0)
+
+#define DSI_TO_CNT_CFG			0x78
+#define HSTX_TO_CNT(p)			(((p) & 0xffff) << 16)
+#define LPRX_TO_CNT(p)			((p) & 0xffff)
+
+#define DSI_HS_RD_TO_CNT		0x7c
+#define DSI_LP_RD_TO_CNT		0x80
+#define DSI_HS_WR_TO_CNT		0x84
+#define DSI_LP_WR_TO_CNT		0x88
+#define DSI_BTA_TO_CNT			0x8c
+
+#define DSI_LPCLK_CTRL			0x94
+#define AUTO_CLKLANE_CTRL		BIT(1)
+#define PHY_TXREQUESTCLKHS		BIT(0)
+
+#define DSI_PHY_TMR_LPCLK_CFG		0x98
+#define PHY_CLKHS2LP_TIME(lbcc)		(((lbcc) & 0x3ff) << 16)
+#define PHY_CLKLP2HS_TIME(lbcc)		((lbcc) & 0x3ff)
+
+#define DSI_PHY_TMR_CFG			0x9c
+#define PHY_HS2LP_TIME(lbcc)		(((lbcc) & 0xff) << 24)
+#define PHY_LP2HS_TIME(lbcc)		(((lbcc) & 0xff) << 16)
+#define MAX_RD_TIME(lbcc)		((lbcc) & 0x7fff)
+#define PHY_HS2LP_TIME_V131(lbcc)	(((lbcc) & 0x3ff) << 16)
+#define PHY_LP2HS_TIME_V131(lbcc)	((lbcc) & 0x3ff)
+
+#define DSI_PHY_RSTZ			0xa0
+#define PHY_DISFORCEPLL			0
+#define PHY_ENFORCEPLL			BIT(3)
+#define PHY_DISABLECLK			0
+#define PHY_ENABLECLK			BIT(2)
+#define PHY_RSTZ			0
+#define PHY_UNRSTZ			BIT(1)
+#define PHY_SHUTDOWNZ			0
+#define PHY_UNSHUTDOWNZ			BIT(0)
+
+#define DSI_PHY_IF_CFG			0xa4
+#define PHY_STOP_WAIT_TIME(cycle)	(((cycle) & 0xff) << 8)
+#define N_LANES(n)			(((n) - 1) & 0x3)
+
+#define DSI_PHY_ULPS_CTRL		0xa8
+#define DSI_PHY_TX_TRIGGERS		0xac
+
+#define DSI_PHY_STATUS			0xb0
+#define PHY_STOP_STATE_CLK_LANE		BIT(2)
+#define PHY_LOCK			BIT(0)
+
+#define DSI_PHY_TST_CTRL0		0xb4
+#define PHY_TESTCLK			BIT(1)
+#define PHY_UNTESTCLK			0
+#define PHY_TESTCLR			BIT(0)
+#define PHY_UNTESTCLR			0
+
+#define DSI_PHY_TST_CTRL1		0xb8
+#define PHY_TESTEN			BIT(16)
+#define PHY_UNTESTEN			0
+#define PHY_TESTDOUT(n)			(((n) & 0xff) << 8)
+#define PHY_TESTDIN(n)			((n) & 0xff)
+
+#define DSI_INT_ST0			0xbc
+#define DSI_INT_ST1			0xc0
+#define DSI_INT_MSK0			0xc4
+#define DSI_INT_MSK1			0xc8
+
+#define DSI_PHY_TMR_RD_CFG		0xf4
+#define MAX_RD_TIME_V131(lbcc)		((lbcc) & 0x7fff)
+
+#define PHY_STATUS_TIMEOUT_US		10000
+#define CMD_PKT_STATUS_TIMEOUT_US	20000
+
+#define MSEC_PER_SEC			1000
+
+struct dw_mipi_dsi {
+	struct mipi_dsi_host dsi_host;
+	struct mipi_dsi_device *device;
+	void __iomem *base;
+	unsigned int lane_mbps; /* per lane */
+	u32 channel;
+	u32 lanes;
+	u32 format;
+	unsigned long mode_flags;
+	unsigned int max_data_lanes;
+	const struct dw_mipi_dsi_phy_ops *phy_ops;
+};
+
+static int dsi_mode_vrefresh(struct display_timing *timings)
+{
+	int refresh = 0;
+	unsigned int calc_val;
+	u32 htotal = timings->hactive.typ + timings->hfront_porch.typ +
+		     timings->hback_porch.typ + timings->hsync_len.typ;
+	u32 vtotal = timings->vactive.typ + timings->vfront_porch.typ +
+		     timings->vback_porch.typ + timings->vsync_len.typ;
+
+	if (htotal > 0 && vtotal > 0) {
+		calc_val = timings->pixelclock.typ;
+		calc_val /= htotal;
+		refresh = (calc_val + vtotal / 2) / vtotal;
+	}
+
+	return refresh;
+}
+
+/*
+ * The controller should generate 2 frames before
+ * preparing the peripheral.
+ */
+static void dw_mipi_dsi_wait_for_two_frames(struct display_timing *timings)
+{
+	int refresh, two_frames;
+
+	refresh = dsi_mode_vrefresh(timings);
+	two_frames = DIV_ROUND_UP(MSEC_PER_SEC, refresh) * 2;
+	mdelay(two_frames);
+}
+
+static inline struct dw_mipi_dsi *host_to_dsi(struct mipi_dsi_host *host)
+{
+	return container_of(host, struct dw_mipi_dsi, dsi_host);
+}
+
+static inline void dsi_write(struct dw_mipi_dsi *dsi, u32 reg, u32 val)
+{
+	writel(val, dsi->base + reg);
+}
+
+static inline u32 dsi_read(struct dw_mipi_dsi *dsi, u32 reg)
+{
+	return readl(dsi->base + reg);
+}
+
+static int dw_mipi_dsi_host_attach(struct mipi_dsi_host *host,
+				   struct mipi_dsi_device *device)
+{
+	struct dw_mipi_dsi *dsi = host_to_dsi(host);
+
+	if (device->lanes > dsi->max_data_lanes) {
+		pr_err("the number of data lanes(%u) is too many\n",
+		       device->lanes);
+		return -EINVAL;
+	}
+
+	dsi->lanes = device->lanes;
+	dsi->channel = device->channel;
+	dsi->format = device->format;
+	dsi->mode_flags = device->mode_flags;
+
+	return 0;
+}
+
+static void dw_mipi_message_config(struct dw_mipi_dsi *dsi,
+				   const struct mipi_dsi_msg *msg)
+{
+	bool lpm = msg->flags & MIPI_DSI_MSG_USE_LPM;
+	u32 val = 0;
+
+	if (msg->flags & MIPI_DSI_MSG_REQ_ACK)
+		val |= ACK_RQST_EN;
+	if (lpm)
+		val |= CMD_MODE_ALL_LP;
+
+	dsi_write(dsi, DSI_LPCLK_CTRL, lpm ? 0 : PHY_TXREQUESTCLKHS);
+	dsi_write(dsi, DSI_CMD_MODE_CFG, val);
+}
+
+static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hdr_val)
+{
+	int ret;
+	u32 val, mask;
+
+	ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
+				 val, !(val & GEN_CMD_FULL),
+				 CMD_PKT_STATUS_TIMEOUT_US);
+	if (ret < 0) {
+		pr_err("failed to get available command FIFO\n");
+		return ret;
+	}
+
+	dsi_write(dsi, DSI_GEN_HDR, hdr_val);
+
+	mask = GEN_CMD_EMPTY | GEN_PLD_W_EMPTY;
+	ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
+				 val, (val & mask) == mask,
+				 CMD_PKT_STATUS_TIMEOUT_US);
+	if (ret < 0) {
+		pr_err("failed to write command FIFO\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int dw_mipi_dsi_write(struct dw_mipi_dsi *dsi,
+			     const struct mipi_dsi_packet *packet)
+{
+	const u8 *tx_buf = packet->payload;
+	int len = packet->payload_length, pld_data_bytes = sizeof(u32), ret;
+	__le32 word;
+	u32 val;
+
+	while (len) {
+		if (len < pld_data_bytes) {
+			word = 0;
+			memcpy(&word, tx_buf, len);
+			dsi_write(dsi, DSI_GEN_PLD_DATA, le32_to_cpu(word));
+			len = 0;
+		} else {
+			memcpy(&word, tx_buf, pld_data_bytes);
+			dsi_write(dsi, DSI_GEN_PLD_DATA, le32_to_cpu(word));
+			tx_buf += pld_data_bytes;
+			len -= pld_data_bytes;
+		}
+
+		ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
+					 val, !(val & GEN_PLD_W_FULL),
+					 CMD_PKT_STATUS_TIMEOUT_US);
+		if (ret < 0) {
+			dev_err(dsi->dev,
+				"failed to get available write payload FIFO\n");
+			return ret;
+		}
+	}
+
+	word = 0;
+	memcpy(&word, packet->header, sizeof(packet->header));
+	return dw_mipi_dsi_gen_pkt_hdr_write(dsi, le32_to_cpu(word));
+}
+
+static int dw_mipi_dsi_read(struct dw_mipi_dsi *dsi,
+			    const struct mipi_dsi_msg *msg)
+{
+	int i, j, ret, len = msg->rx_len;
+	u8 *buf = msg->rx_buf;
+	u32 val;
+
+	/* Wait end of the read operation */
+	ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
+				 val, !(val & GEN_RD_CMD_BUSY),
+				 CMD_PKT_STATUS_TIMEOUT_US);
+	if (ret) {
+		dev_err(dsi->dev, "Timeout during read operation\n");
+		return ret;
+	}
+
+	for (i = 0; i < len; i += 4) {
+		/* Read fifo must not be empty before all bytes are read */
+		ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
+					 val, !(val & GEN_PLD_R_EMPTY),
+					 CMD_PKT_STATUS_TIMEOUT_US);
+		if (ret) {
+			dev_err(dsi->dev, "Read payload FIFO is empty\n");
+			return ret;
+		}
+
+		val = dsi_read(dsi, DSI_GEN_PLD_DATA);
+		for (j = 0; j < 4 && j + i < len; j++)
+			buf[i + j] = val >> (8 * j);
+	}
+
+	return ret;
+}
+
+static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
+					 const struct mipi_dsi_msg *msg)
+{
+	struct dw_mipi_dsi *dsi = host_to_dsi(host);
+	struct mipi_dsi_packet packet;
+	int ret, nb_bytes;
+
+	ret = mipi_dsi_create_packet(&packet, msg);
+	if (ret) {
+		dev_err(dsi->dev, "failed to create packet: %d\n", ret);
+		return ret;
+	}
+
+	dw_mipi_message_config(dsi, msg);
+
+	ret = dw_mipi_dsi_write(dsi, &packet);
+	if (ret)
+		return ret;
+
+	if (msg->rx_buf && msg->rx_len) {
+		ret = dw_mipi_dsi_read(dsi, msg);
+		if (ret)
+			return ret;
+		nb_bytes = msg->rx_len;
+	} else {
+		nb_bytes = packet.size;
+	}
+
+	return nb_bytes;
+}
+
+static const struct mipi_dsi_host_ops dw_mipi_dsi_host_ops = {
+	.attach = dw_mipi_dsi_host_attach,
+	.transfer = dw_mipi_dsi_host_transfer,
+};
+
+static void dw_mipi_dsi_video_mode_config(struct dw_mipi_dsi *dsi)
+{
+	u32 val;
+
+	/*
+	 * TODO dw drv improvements
+	 * enabling low power is panel-dependent, we should use the
+	 * panel configuration here...
+	 */
+	val = ENABLE_LOW_POWER;
+
+	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
+		val |= VID_MODE_TYPE_BURST;
+	else if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
+		val |= VID_MODE_TYPE_NON_BURST_SYNC_PULSES;
+	else
+		val |= VID_MODE_TYPE_NON_BURST_SYNC_EVENTS;
+
+	dsi_write(dsi, DSI_VID_MODE_CFG, val);
+}
+
+static void dw_mipi_dsi_set_mode(struct dw_mipi_dsi *dsi,
+				 unsigned long mode_flags)
+{
+	dsi_write(dsi, DSI_PWR_UP, RESET);
+
+	if (mode_flags & MIPI_DSI_MODE_VIDEO) {
+		dsi_write(dsi, DSI_MODE_CFG, ENABLE_VIDEO_MODE);
+		dw_mipi_dsi_video_mode_config(dsi);
+		dsi_write(dsi, DSI_LPCLK_CTRL, PHY_TXREQUESTCLKHS);
+	} else {
+		dsi_write(dsi, DSI_MODE_CFG, ENABLE_CMD_MODE);
+	}
+
+	dsi_write(dsi, DSI_PWR_UP, POWERUP);
+}
+
+static void dw_mipi_dsi_init(struct dw_mipi_dsi *dsi)
+{
+	/*
+	 * The maximum permitted escape clock is 20MHz and it is derived from
+	 * lanebyteclk, which is running at "lane_mbps / 8".  Thus we want:
+	 *
+	 *     (lane_mbps >> 3) / esc_clk_division < 20
+	 * which is:
+	 *     (lane_mbps >> 3) / 20 > esc_clk_division
+	 */
+	u32 esc_clk_division = (dsi->lane_mbps >> 3) / 20 + 1;
+
+	dsi_write(dsi, DSI_PWR_UP, RESET);
+
+	/*
+	 * TODO dw drv improvements
+	 * timeout clock division should be computed with the
+	 * high speed transmission counter timeout and byte lane...
+	 */
+	dsi_write(dsi, DSI_CLKMGR_CFG, TO_CLK_DIVISION(10) |
+		  TX_ESC_CLK_DIVISION(esc_clk_division));
+}
+
+static void dw_mipi_dsi_dpi_config(struct dw_mipi_dsi *dsi,
+				   struct display_timing *timings)
+{
+	u32 val = 0, color = 0;
+
+	switch (dsi->format) {
+	case MIPI_DSI_FMT_RGB888:
+		color = DPI_COLOR_CODING_24BIT;
+		break;
+	case MIPI_DSI_FMT_RGB666:
+		color = DPI_COLOR_CODING_18BIT_2 | LOOSELY18_EN;
+		break;
+	case MIPI_DSI_FMT_RGB666_PACKED:
+		color = DPI_COLOR_CODING_18BIT_1;
+		break;
+	case MIPI_DSI_FMT_RGB565:
+		color = DPI_COLOR_CODING_16BIT_1;
+		break;
+	}
+
+	if (dsi->mode_flags & DISPLAY_FLAGS_VSYNC_HIGH)
+		val |= VSYNC_ACTIVE_LOW;
+	if (dsi->mode_flags & DISPLAY_FLAGS_HSYNC_HIGH)
+		val |= HSYNC_ACTIVE_LOW;
+
+	dsi_write(dsi, DSI_DPI_VCID, DPI_VCID(dsi->channel));
+	dsi_write(dsi, DSI_DPI_COLOR_CODING, color);
+	dsi_write(dsi, DSI_DPI_CFG_POL, val);
+	/*
+	 * TODO dw drv improvements
+	 * largest packet sizes during hfp or during vsa/vpb/vfp
+	 * should be computed according to byte lane, lane number and only
+	 * if sending lp cmds in high speed is enable (PHY_TXREQUESTCLKHS)
+	 */
+	dsi_write(dsi, DSI_DPI_LP_CMD_TIM, OUTVACT_LPCMD_TIME(4)
+		  | INVACT_LPCMD_TIME(4));
+}
+
+static void dw_mipi_dsi_packet_handler_config(struct dw_mipi_dsi *dsi)
+{
+	dsi_write(dsi, DSI_PCKHDL_CFG, CRC_RX_EN | ECC_RX_EN | BTA_EN);
+}
+
+static void dw_mipi_dsi_video_packet_config(struct dw_mipi_dsi *dsi,
+					    struct display_timing *timings)
+{
+	/*
+	 * TODO dw drv improvements
+	 * only burst mode is supported here. For non-burst video modes,
+	 * we should compute DSI_VID_PKT_SIZE, DSI_VCCR.NUMC &
+	 * DSI_VNPCR.NPSIZE... especially because this driver supports
+	 * non-burst video modes, see dw_mipi_dsi_video_mode_config()...
+	 */
+	dsi_write(dsi, DSI_VID_PKT_SIZE, VID_PKT_SIZE(timings->hactive.typ));
+}
+
+static void dw_mipi_dsi_command_mode_config(struct dw_mipi_dsi *dsi)
+{
+	/*
+	 * TODO dw drv improvements
+	 * compute high speed transmission counter timeout according
+	 * to the timeout clock division (TO_CLK_DIVISION) and byte lane...
+	 */
+	dsi_write(dsi, DSI_TO_CNT_CFG, HSTX_TO_CNT(1000) | LPRX_TO_CNT(1000));
+	/*
+	 * TODO dw drv improvements
+	 * the Bus-Turn-Around Timeout Counter should be computed
+	 * according to byte lane...
+	 */
+	dsi_write(dsi, DSI_BTA_TO_CNT, 0xd00);
+	dsi_write(dsi, DSI_MODE_CFG, ENABLE_CMD_MODE);
+}
+
+/* Get lane byte clock cycles. */
+static u32 dw_mipi_dsi_get_hcomponent_lbcc(struct dw_mipi_dsi *dsi,
+					   struct display_timing *timings,
+					   u32 hcomponent)
+{
+	u32 frac, lbcc;
+
+	lbcc = hcomponent * dsi->lane_mbps * MSEC_PER_SEC / 8;
+
+	frac = lbcc % (timings->pixelclock.typ / 1000);
+	lbcc = lbcc / (timings->pixelclock.typ / 1000);
+	if (frac)
+		lbcc++;
+
+	return lbcc;
+}
+
+static void dw_mipi_dsi_line_timer_config(struct dw_mipi_dsi *dsi,
+					  struct display_timing *timings)
+{
+	u32 htotal, hsa, hbp, lbcc;
+
+	htotal = timings->hactive.typ + timings->hfront_porch.typ +
+		 timings->hback_porch.typ + timings->hsync_len.typ;
+
+	hsa = timings->hback_porch.typ;
+	hbp = timings->hsync_len.typ;
+
+	/*
+	 * TODO dw drv improvements
+	 * computations below may be improved...
+	 */
+	lbcc = dw_mipi_dsi_get_hcomponent_lbcc(dsi, timings, htotal);
+	dsi_write(dsi, DSI_VID_HLINE_TIME, lbcc);
+
+	lbcc = dw_mipi_dsi_get_hcomponent_lbcc(dsi, timings, hsa);
+	dsi_write(dsi, DSI_VID_HSA_TIME, lbcc);
+
+	lbcc = dw_mipi_dsi_get_hcomponent_lbcc(dsi, timings, hbp);
+	dsi_write(dsi, DSI_VID_HBP_TIME, lbcc);
+}
+
+static void dw_mipi_dsi_vertical_timing_config(struct dw_mipi_dsi *dsi,
+					       struct display_timing *timings)
+{
+	u32 vactive, vsa, vfp, vbp;
+
+	vactive = timings->vactive.typ;
+	vsa =  timings->vback_porch.typ;
+	vfp =  timings->vfront_porch.typ;
+	vbp = timings->vsync_len.typ;
+
+	dsi_write(dsi, DSI_VID_VACTIVE_LINES, vactive);
+	dsi_write(dsi, DSI_VID_VSA_LINES, vsa);
+	dsi_write(dsi, DSI_VID_VFP_LINES, vfp);
+	dsi_write(dsi, DSI_VID_VBP_LINES, vbp);
+}
+
+static void dw_mipi_dsi_dphy_timing_config(struct dw_mipi_dsi *dsi)
+{
+	u32 hw_version;
+
+	/*
+	 * TODO dw drv improvements
+	 * data & clock lane timers should be computed according to panel
+	 * blankings and to the automatic clock lane control mode...
+	 * note: DSI_PHY_TMR_CFG.MAX_RD_TIME should be in line with
+	 * DSI_CMD_MODE_CFG.MAX_RD_PKT_SIZE_LP (see CMD_MODE_ALL_LP)
+	 */
+
+	hw_version = dsi_read(dsi, DSI_VERSION) & VERSION;
+
+	if (hw_version >= HWVER_131) {
+		dsi_write(dsi, DSI_PHY_TMR_CFG, PHY_HS2LP_TIME_V131(0x40) |
+			  PHY_LP2HS_TIME_V131(0x40));
+		dsi_write(dsi, DSI_PHY_TMR_RD_CFG, MAX_RD_TIME_V131(10000));
+	} else {
+		dsi_write(dsi, DSI_PHY_TMR_CFG, PHY_HS2LP_TIME(0x40) |
+			  PHY_LP2HS_TIME(0x40) | MAX_RD_TIME(10000));
+	}
+
+	dsi_write(dsi, DSI_PHY_TMR_LPCLK_CFG, PHY_CLKHS2LP_TIME(0x40)
+		  | PHY_CLKLP2HS_TIME(0x40));
+}
+
+static void dw_mipi_dsi_dphy_interface_config(struct dw_mipi_dsi *dsi)
+{
+	/*
+	 * TODO dw drv improvements
+	 * stop wait time should be the maximum between host dsi
+	 * and panel stop wait times
+	 */
+	dsi_write(dsi, DSI_PHY_IF_CFG, PHY_STOP_WAIT_TIME(0x20) |
+		  N_LANES(dsi->lanes));
+}
+
+static void dw_mipi_dsi_dphy_init(struct dw_mipi_dsi *dsi)
+{
+	/* Clear PHY state */
+	dsi_write(dsi, DSI_PHY_RSTZ, PHY_DISFORCEPLL | PHY_DISABLECLK
+		  | PHY_RSTZ | PHY_SHUTDOWNZ);
+	dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_UNTESTCLR);
+	dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_TESTCLR);
+	dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_UNTESTCLR);
+}
+
+static void dw_mipi_dsi_dphy_enable(struct dw_mipi_dsi *dsi)
+{
+	u32 val;
+	int ret;
+
+	dsi_write(dsi, DSI_PHY_RSTZ, PHY_ENFORCEPLL | PHY_ENABLECLK |
+		  PHY_UNRSTZ | PHY_UNSHUTDOWNZ);
+
+	ret = readl_poll_timeout(dsi->base + DSI_PHY_STATUS, val,
+				 val & PHY_LOCK, PHY_STATUS_TIMEOUT_US);
+	if (ret < 0)
+		pr_err("failed to wait phy lock state\n");
+
+	ret = readl_poll_timeout(dsi->base + DSI_PHY_STATUS,
+				 val, val & PHY_STOP_STATE_CLK_LANE,
+				 PHY_STATUS_TIMEOUT_US);
+	if (ret < 0)
+		pr_err("failed to wait phy clk lane stop state\n");
+}
+
+static void dw_mipi_dsi_clear_err(struct dw_mipi_dsi *dsi)
+{
+	dsi_read(dsi, DSI_INT_ST0);
+	dsi_read(dsi, DSI_INT_ST1);
+	dsi_write(dsi, DSI_INT_MSK0, 0);
+	dsi_write(dsi, DSI_INT_MSK1, 0);
+}
+
+static void dw_mipi_dsi_bridge_set(struct dw_mipi_dsi *dsi,
+				   struct display_timing *timings)
+{
+	const struct dw_mipi_dsi_phy_ops *phy_ops = dsi->phy_ops;
+	int ret;
+
+	ret = phy_ops->get_lane_mbps(dsi->device, timings, dsi->lanes,
+				     dsi->format, &dsi->lane_mbps);
+	if (ret)
+		pr_err("Phy get_lane_mbps() failed\n");
+
+	dw_mipi_dsi_init(dsi);
+	dw_mipi_dsi_dpi_config(dsi, timings);
+	dw_mipi_dsi_packet_handler_config(dsi);
+	dw_mipi_dsi_video_mode_config(dsi);
+	dw_mipi_dsi_video_packet_config(dsi, timings);
+	dw_mipi_dsi_command_mode_config(dsi);
+	dw_mipi_dsi_line_timer_config(dsi, timings);
+	dw_mipi_dsi_vertical_timing_config(dsi, timings);
+
+	dw_mipi_dsi_dphy_init(dsi);
+	dw_mipi_dsi_dphy_timing_config(dsi);
+	dw_mipi_dsi_dphy_interface_config(dsi);
+
+	dw_mipi_dsi_clear_err(dsi);
+
+	ret = phy_ops->init(dsi->device);
+	if (ret)
+		pr_err("Phy init() failed\n");
+
+	dw_mipi_dsi_dphy_enable(dsi);
+
+	dw_mipi_dsi_wait_for_two_frames(timings);
+
+	/* Switch to cmd mode for panel-bridge pre_enable & panel prepare */
+	dw_mipi_dsi_set_mode(dsi, 0);
+}
+
+void dw_mipi_dsi_bridge_enable(struct mipi_dsi_device *device)
+{
+	struct mipi_dsi_host *host = device->host;
+	struct dw_mipi_dsi *dsi = host_to_dsi(host);
+
+	/* Switch to video mode for panel-bridge enable & panel enable */
+	dw_mipi_dsi_set_mode(dsi, MIPI_DSI_MODE_VIDEO);
+}
+EXPORT_SYMBOL_GPL(dw_mipi_dsi_bridge_enable);
+
+int dw_mipi_dsi_init_bridge(struct mipi_dsi_device *device)
+{
+	struct dw_mipi_dsi_plat_data *platdata = dev_get_platdata(device->dev);
+	struct display_timing timings;
+	struct dw_mipi_dsi *dsi;
+	struct clk clk;
+	int ret;
+
+	dsi = kzalloc(sizeof(*dsi), GFP_KERNEL);
+
+	dsi->phy_ops = platdata->phy_ops;
+	dsi->max_data_lanes = platdata->max_data_lanes;
+	dsi->device = device;
+	dsi->dsi_host.ops = &dw_mipi_dsi_host_ops;
+	device->host = &dsi->dsi_host;
+
+	 /* TODO Get these settings from panel */
+	dsi->lanes = 2;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
+			  MIPI_DSI_MODE_VIDEO_BURST |
+			  MIPI_DSI_MODE_LPM;
+
+	dsi->base = (void *)dev_read_addr(device->dev);
+	if ((fdt_addr_t)dsi->base == FDT_ADDR_T_NONE) {
+		pr_err("%s: dsi dt register address error\n", __func__);
+		return -EINVAL;
+	}
+
+	ret = fdtdec_decode_display_timing(gd->fdt_blob,
+					   dev_of_offset(platdata->panel),
+					   0, &timings);
+	if (ret) {
+		pr_err("%s: decode display timing error %d\n", __func__, ret);
+		return ret;
+	}
+
+	if (!dsi->phy_ops->init || !dsi->phy_ops->get_lane_mbps) {
+		pr_err("Phy not properly configured\n");
+		return -ENODEV;
+	}
+
+	ret = clk_get_by_name(device->dev, "px_clk", &clk);
+	if (ret) {
+		pr_err("%s: peripheral clock get error %d\n", __func__, ret);
+		return ret;
+	}
+
+	/*  get the pixel clock set by the clock framework */
+	timings.pixelclock.typ = clk_get_rate(&clk);
+
+	dw_mipi_dsi_bridge_set(dsi, &timings);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_mipi_dsi_init_bridge);
+
+MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
+MODULE_AUTHOR("Philippe Cornu <philippe.cornu@st.com>");
+MODULE_AUTHOR("Yannick Fertré <yannick.fertre@st.com>");
+MODULE_DESCRIPTION("DW MIPI DSI host controller driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:dw-mipi-dsi");
diff --git a/include/dw_mipi_dsi.h b/include/dw_mipi_dsi.h
new file mode 100644
index 0000000..8c33ec2
--- /dev/null
+++ b/include/dw_mipi_dsi.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright (C) 2017-2018, STMicroelectronics - All Rights Reserved
+ *
+ * Authors: Yannick Fertre <yannick.fertre@st.com>
+ *          Philippe Cornu <philippe.cornu@st.com>
+ *
+ * Modified by Yannick Fertre <yannick.fertre@st.com>
+ * This generic Synopsys DesignWare MIPI DSI host driver is based on the
+ * bridge synopsys from include/drm/bridge/dw_mipi_dsi.h (kernel linux).
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#ifndef __DW_MIPI_DSI__
+#define __DW_MIPI_DSI__
+
+struct dw_mipi_dsi_phy_ops {
+	int (*init)(void *priv_data);
+	int (*get_lane_mbps)(void *priv_data, struct display_timing *timings,
+			     u32 lanes, u32 format, unsigned int *lane_mbps);
+};
+
+struct dw_mipi_dsi_plat_data {
+	unsigned int max_data_lanes;
+	const struct dw_mipi_dsi_phy_ops *phy_ops;
+	struct udevice *panel;
+};
+
+int dw_mipi_dsi_init_bridge(struct mipi_dsi_device *device);
+void dw_mipi_dsi_bridge_enable(struct mipi_dsi_device *device);
+
+#endif /* __DW_MIPI_DSI__ */
-- 
1.9.1
