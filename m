Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427926AbeCBPto (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 10:49:44 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:7366 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S936273AbeCBPol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 10:44:41 -0500
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
Subject: [PATCH v2 03/10] video: add support of MIPI DSI interface
Date: Fri, 2 Mar 2018 16:44:04 +0100
Message-ID: <1520005451-23217-4-git-send-email-yannick.fertre@st.com>
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

Mipi_display.c contains a set of dsi helpers.
This file is a copy of file drm_mipi_dsi.c (linux kernel).

Signed-off-by: yannick fertre <yannick.fertre@st.com>
---
 drivers/video/Kconfig        |   7 +
 drivers/video/Makefile       |   1 +
 drivers/video/mipi_display.c | 807 +++++++++++++++++++++++++++++++++++++++++++
 include/mipi_display.h       | 257 +++++++++++++-
 4 files changed, 1071 insertions(+), 1 deletion(-)
 create mode 100644 drivers/video/mipi_display.c

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 2fc0def..1981298 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -75,6 +75,13 @@ config VIDEO_ANSI
 	  Enable ANSI escape sequence decoding for a more fully functional
 	  console.
 
+config VIDEO_MIPI_DSI
+	bool "Support MIPI DSI interface"
+	depends on DM_VIDEO
+	default y if DM_VIDEO
+	help
+	  Support MIPI DSI interface for driving a MIPI compatible LCD panel.
+
 config CONSOLE_NORMAL
 	bool "Support a simple text console"
 	depends on DM_VIDEO
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index dfafe08..6f42cca 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_FORMIKE) += formike.o
 obj-$(CONFIG_LG4573) += lg4573.o
 obj-$(CONFIG_AM335X_LCD) += am335x-fb.o
 obj-$(CONFIG_VIDEO_DW_HDMI) += dw_hdmi.o
+obj-${CONFIG_VIDEO_MIPI_DSI} += mipi_display.o
 obj-$(CONFIG_VIDEO_SIMPLE) += simplefb.o
 obj-${CONFIG_VIDEO_TEGRA124} += tegra124/
 obj-${CONFIG_EXYNOS_FB} += exynos/
diff --git a/drivers/video/mipi_display.c b/drivers/video/mipi_display.c
new file mode 100644
index 0000000..d90ff5d
--- /dev/null
+++ b/drivers/video/mipi_display.c
@@ -0,0 +1,807 @@
+/*
+ * MIPI DSI Bus
+ *
+ * Copyright (C) 2012-2013, Samsung Electronics, Co., Ltd.
+ * Copyright (C) 2018 STMicroelectronics - All Rights Reserved
+ * Andrzej Hajda <a.hajda@samsung.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sub license, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
+ * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
+ * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
+ * USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include <common.h>
+#include <clk.h>
+#include <display.h>
+#include <dm.h>
+#include <mipi_display.h>
+
+/**
+ * DOC: dsi helpers
+ *
+ * These functions contain some common logic and helpers to deal with MIPI DSI
+ * peripherals.
+ *
+ * Helpers are provided for a number of standard MIPI DSI command as well as a
+ * subset of the MIPI DCS command set.
+ */
+
+/**
+ * mipi_dsi_attach - attach a DSI device to its DSI host
+ * @dsi: DSI peripheral
+ */
+int mipi_dsi_attach(struct mipi_dsi_device *dsi)
+{
+	const struct mipi_dsi_host_ops *ops = dsi->host->ops;
+
+	if (!ops || !ops->attach)
+		return -ENOSYS;
+
+	return ops->attach(dsi->host, dsi);
+}
+EXPORT_SYMBOL(mipi_dsi_attach);
+
+/**
+ * mipi_dsi_detach - detach a DSI device from its DSI host
+ * @dsi: DSI peripheral
+ */
+int mipi_dsi_detach(struct mipi_dsi_device *dsi)
+{
+	const struct mipi_dsi_host_ops *ops = dsi->host->ops;
+
+	if (!ops || !ops->detach)
+		return -ENOSYS;
+
+	return ops->detach(dsi->host, dsi);
+}
+EXPORT_SYMBOL(mipi_dsi_detach);
+
+static ssize_t mipi_dsi_device_transfer(struct mipi_dsi_device *dsi,
+					struct mipi_dsi_msg *msg)
+{
+	const struct mipi_dsi_host_ops *ops = dsi->host->ops;
+
+	if (!ops || !ops->transfer)
+		return -ENOSYS;
+
+	if (dsi->mode_flags & MIPI_DSI_MODE_LPM)
+		msg->flags |= MIPI_DSI_MSG_USE_LPM;
+
+	return ops->transfer(dsi->host, msg);
+}
+
+/**
+ * mipi_dsi_packet_format_is_short - check if a packet is of the short format
+ * @type: MIPI DSI data type of the packet
+ *
+ * Return: true if the packet for the given data type is a short packet, false
+ * otherwise.
+ */
+bool mipi_dsi_packet_format_is_short(u8 type)
+{
+	switch (type) {
+	case MIPI_DSI_V_SYNC_START:
+	case MIPI_DSI_V_SYNC_END:
+	case MIPI_DSI_H_SYNC_START:
+	case MIPI_DSI_H_SYNC_END:
+	case MIPI_DSI_END_OF_TRANSMISSION:
+	case MIPI_DSI_COLOR_MODE_OFF:
+	case MIPI_DSI_COLOR_MODE_ON:
+	case MIPI_DSI_SHUTDOWN_PERIPHERAL:
+	case MIPI_DSI_TURN_ON_PERIPHERAL:
+	case MIPI_DSI_GENERIC_SHORT_WRITE_0_PARAM:
+	case MIPI_DSI_GENERIC_SHORT_WRITE_1_PARAM:
+	case MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM:
+	case MIPI_DSI_GENERIC_READ_REQUEST_0_PARAM:
+	case MIPI_DSI_GENERIC_READ_REQUEST_1_PARAM:
+	case MIPI_DSI_GENERIC_READ_REQUEST_2_PARAM:
+	case MIPI_DSI_DCS_SHORT_WRITE:
+	case MIPI_DSI_DCS_SHORT_WRITE_PARAM:
+	case MIPI_DSI_DCS_READ:
+	case MIPI_DSI_SET_MAXIMUM_RETURN_PACKET_SIZE:
+		return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(mipi_dsi_packet_format_is_short);
+
+/**
+ * mipi_dsi_packet_format_is_long - check if a packet is of the long format
+ * @type: MIPI DSI data type of the packet
+ *
+ * Return: true if the packet for the given data type is a long packet, false
+ * otherwise.
+ */
+bool mipi_dsi_packet_format_is_long(u8 type)
+{
+	switch (type) {
+	case MIPI_DSI_NULL_PACKET:
+	case MIPI_DSI_BLANKING_PACKET:
+	case MIPI_DSI_GENERIC_LONG_WRITE:
+	case MIPI_DSI_DCS_LONG_WRITE:
+	case MIPI_DSI_LOOSELY_PACKED_PIXEL_STREAM_YCBCR20:
+	case MIPI_DSI_PACKED_PIXEL_STREAM_YCBCR24:
+	case MIPI_DSI_PACKED_PIXEL_STREAM_YCBCR16:
+	case MIPI_DSI_PACKED_PIXEL_STREAM_30:
+	case MIPI_DSI_PACKED_PIXEL_STREAM_36:
+	case MIPI_DSI_PACKED_PIXEL_STREAM_YCBCR12:
+	case MIPI_DSI_PACKED_PIXEL_STREAM_16:
+	case MIPI_DSI_PACKED_PIXEL_STREAM_18:
+	case MIPI_DSI_PIXEL_STREAM_3BYTE_18:
+	case MIPI_DSI_PACKED_PIXEL_STREAM_24:
+		return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(mipi_dsi_packet_format_is_long);
+
+/**
+ * mipi_dsi_create_packet - create a packet from a message according to the
+ *     DSI protocol
+ * @packet: pointer to a DSI packet structure
+ * @msg: message to translate into a packet
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int mipi_dsi_create_packet(struct mipi_dsi_packet *packet,
+			   const struct mipi_dsi_msg *msg)
+{
+	if (!packet || !msg)
+		return -EINVAL;
+
+	/* do some minimum sanity checking */
+	if (!mipi_dsi_packet_format_is_short(msg->type) &&
+	    !mipi_dsi_packet_format_is_long(msg->type))
+		return -EINVAL;
+
+	if (msg->channel > 3)
+		return -EINVAL;
+
+	memset(packet, 0, sizeof(*packet));
+	packet->header[0] = ((msg->channel & 0x3) << 6) | (msg->type & 0x3f);
+
+	/* TODO: compute ECC if hardware support is not available */
+
+	/*
+	 * Long write packets contain the word count in header bytes 1 and 2.
+	 * The payload follows the header and is word count bytes long.
+	 *
+	 * Short write packets encode up to two parameters in header bytes 1
+	 * and 2.
+	 */
+	if (mipi_dsi_packet_format_is_long(msg->type)) {
+		packet->header[1] = (msg->tx_len >> 0) & 0xff;
+		packet->header[2] = (msg->tx_len >> 8) & 0xff;
+
+		packet->payload_length = msg->tx_len;
+		packet->payload = msg->tx_buf;
+	} else {
+		const u8 *tx = msg->tx_buf;
+
+		packet->header[1] = (msg->tx_len > 0) ? tx[0] : 0;
+		packet->header[2] = (msg->tx_len > 1) ? tx[1] : 0;
+	}
+
+	packet->size = sizeof(packet->header) + packet->payload_length;
+
+	return 0;
+}
+EXPORT_SYMBOL(mipi_dsi_create_packet);
+
+/*
+ * mipi_dsi_set_maximum_return_packet_size() - specify the maximum size of the
+ *    the payload in a long packet transmitted from the peripheral back to the
+ *    host processor
+ * @dsi: DSI peripheral device
+ * @value: the maximum size of the payload
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int mipi_dsi_set_maximum_return_packet_size(struct mipi_dsi_device *dsi,
+					    u16 value)
+{
+	u8 tx[2] = { value & 0xff, value >> 8 };
+	struct mipi_dsi_msg msg = {
+		.channel = dsi->channel,
+		.type = MIPI_DSI_SET_MAXIMUM_RETURN_PACKET_SIZE,
+		.tx_len = sizeof(tx),
+		.tx_buf = tx,
+	};
+	int ret = mipi_dsi_device_transfer(dsi, &msg);
+
+	return (ret < 0) ? ret : 0;
+}
+EXPORT_SYMBOL(mipi_dsi_set_maximum_return_packet_size);
+
+/**
+ * mipi_dsi_generic_write() - transmit data using a generic write packet
+ * @dsi: DSI peripheral device
+ * @payload: buffer containing the payload
+ * @size: size of payload buffer
+ *
+ * This function will automatically choose the right data type depending on
+ * the payload length.
+ *
+ * Return: The number of bytes transmitted on success or a negative error code
+ * on failure.
+ */
+ssize_t mipi_dsi_generic_write(struct mipi_dsi_device *dsi, const void *payload,
+			       size_t size)
+{
+	struct mipi_dsi_msg msg = {
+		.channel = dsi->channel,
+		.tx_buf = payload,
+		.tx_len = size
+	};
+
+	switch (size) {
+	case 0:
+		msg.type = MIPI_DSI_GENERIC_SHORT_WRITE_0_PARAM;
+		break;
+
+	case 1:
+		msg.type = MIPI_DSI_GENERIC_SHORT_WRITE_1_PARAM;
+		break;
+
+	case 2:
+		msg.type = MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM;
+		break;
+
+	default:
+		msg.type = MIPI_DSI_GENERIC_LONG_WRITE;
+		break;
+	}
+
+	return mipi_dsi_device_transfer(dsi, &msg);
+}
+EXPORT_SYMBOL(mipi_dsi_generic_write);
+
+/**
+ * mipi_dsi_generic_read() - receive data using a generic read packet
+ * @dsi: DSI peripheral device
+ * @params: buffer containing the request parameters
+ * @num_params: number of request parameters
+ * @data: buffer in which to return the received data
+ * @size: size of receive buffer
+ *
+ * This function will automatically choose the right data type depending on
+ * the number of parameters passed in.
+ *
+ * Return: The number of bytes successfully read or a negative error code on
+ * failure.
+ */
+ssize_t mipi_dsi_generic_read(struct mipi_dsi_device *dsi, const void *params,
+			      size_t num_params, void *data, size_t size)
+{
+	struct mipi_dsi_msg msg = {
+		.channel = dsi->channel,
+		.tx_len = num_params,
+		.tx_buf = params,
+		.rx_len = size,
+		.rx_buf = data
+	};
+
+	switch (num_params) {
+	case 0:
+		msg.type = MIPI_DSI_GENERIC_READ_REQUEST_0_PARAM;
+		break;
+
+	case 1:
+		msg.type = MIPI_DSI_GENERIC_READ_REQUEST_1_PARAM;
+		break;
+
+	case 2:
+		msg.type = MIPI_DSI_GENERIC_READ_REQUEST_2_PARAM;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return mipi_dsi_device_transfer(dsi, &msg);
+}
+EXPORT_SYMBOL(mipi_dsi_generic_read);
+
+/**
+ * mipi_dsi_dcs_write_buffer() - transmit a DCS command with payload
+ * @dsi: DSI peripheral device
+ * @data: buffer containing data to be transmitted
+ * @len: size of transmission buffer
+ *
+ * This function will automatically choose the right data type depending on
+ * the command payload length.
+ *
+ * Return: The number of bytes successfully transmitted or a negative error
+ * code on failure.
+ */
+ssize_t mipi_dsi_dcs_write_buffer(struct mipi_dsi_device *dsi,
+				  const void *data, size_t len)
+{
+	struct mipi_dsi_msg msg = {
+		.channel = dsi->channel,
+		.tx_buf = data,
+		.tx_len = len
+	};
+
+	switch (len) {
+	case 0:
+		return -EINVAL;
+
+	case 1:
+		msg.type = MIPI_DSI_DCS_SHORT_WRITE;
+		break;
+
+	case 2:
+		msg.type = MIPI_DSI_DCS_SHORT_WRITE_PARAM;
+		break;
+
+	default:
+		msg.type = MIPI_DSI_DCS_LONG_WRITE;
+		break;
+	}
+
+	return mipi_dsi_device_transfer(dsi, &msg);
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_write_buffer);
+
+/**
+ * mipi_dsi_dcs_write() - send DCS write command
+ * @dsi: DSI peripheral device
+ * @cmd: DCS command
+ * @data: buffer containing the command payload
+ * @len: command payload length
+ *
+ * This function will automatically choose the right data type depending on
+ * the command payload length.
+ *
+ * Return: The number of bytes successfully transmitted or a negative error
+ * code on failure.
+ */
+ssize_t mipi_dsi_dcs_write(struct mipi_dsi_device *dsi, u8 cmd,
+			   const void *data, size_t len)
+{
+	ssize_t err;
+	size_t size;
+	u8 *tx;
+
+	if (len > 0) {
+		size = 1 + len;
+
+		tx = kmalloc(size, GFP_KERNEL);
+		if (!tx)
+			return -ENOMEM;
+
+		/* concatenate the DCS command byte and the payload */
+		tx[0] = cmd;
+		memcpy(&tx[1], data, len);
+	} else {
+		tx = &cmd;
+		size = 1;
+	}
+
+	err = mipi_dsi_dcs_write_buffer(dsi, tx, size);
+
+	if (len > 0)
+		kfree(tx);
+
+	return err;
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_write);
+
+/**
+ * mipi_dsi_dcs_read() - send DCS read request command
+ * @dsi: DSI peripheral device
+ * @cmd: DCS command
+ * @data: buffer in which to receive data
+ * @len: size of receive buffer
+ *
+ * Return: The number of bytes read or a negative error code on failure.
+ */
+ssize_t mipi_dsi_dcs_read(struct mipi_dsi_device *dsi, u8 cmd, void *data,
+			  size_t len)
+{
+	struct mipi_dsi_msg msg = {
+		.channel = dsi->channel,
+		.type = MIPI_DSI_DCS_READ,
+		.tx_buf = &cmd,
+		.tx_len = 1,
+		.rx_buf = data,
+		.rx_len = len
+	};
+
+	return mipi_dsi_device_transfer(dsi, &msg);
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_read);
+
+/**
+ * mipi_dsi_pixel_format_to_bpp - obtain the number of bits per pixel for any
+ *                                given pixel format defined by the MIPI DSI
+ *                                specification
+ * @fmt: MIPI DSI pixel format
+ *
+ * Returns: The number of bits per pixel of the given pixel format.
+ */
+int mipi_dsi_pixel_format_to_bpp(enum mipi_dsi_pixel_format fmt)
+{
+	switch (fmt) {
+	case MIPI_DSI_FMT_RGB888:
+	case MIPI_DSI_FMT_RGB666:
+		return 24;
+
+	case MIPI_DSI_FMT_RGB666_PACKED:
+		return 18;
+
+	case MIPI_DSI_FMT_RGB565:
+		return 16;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(mipi_dsi_pixel_format_to_bpp);
+
+/**
+ * mipi_dsi_dcs_nop() - send DCS nop packet
+ * @dsi: DSI peripheral device
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int mipi_dsi_dcs_nop(struct mipi_dsi_device *dsi)
+{
+	ssize_t err;
+
+	err = mipi_dsi_dcs_write(dsi, MIPI_DCS_NOP, NULL, 0);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_nop);
+
+/**
+ * mipi_dsi_dcs_soft_reset() - perform a software reset of the display module
+ * @dsi: DSI peripheral device
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int mipi_dsi_dcs_soft_reset(struct mipi_dsi_device *dsi)
+{
+	ssize_t err;
+
+	err = mipi_dsi_dcs_write(dsi, MIPI_DCS_SOFT_RESET, NULL, 0);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_soft_reset);
+
+/**
+ * mipi_dsi_dcs_get_power_mode() - query the display module's current power
+ *    mode
+ * @dsi: DSI peripheral device
+ * @mode: return location for the current power mode
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int mipi_dsi_dcs_get_power_mode(struct mipi_dsi_device *dsi, u8 *mode)
+{
+	ssize_t err;
+
+	err = mipi_dsi_dcs_read(dsi, MIPI_DCS_GET_POWER_MODE, mode,
+				sizeof(*mode));
+	if (err <= 0) {
+		if (err == 0)
+			err = -ENODATA;
+
+		return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_get_power_mode);
+
+/**
+ * mipi_dsi_dcs_get_pixel_format() - gets the pixel format for the RGB image
+ *    data used by the interface
+ * @dsi: DSI peripheral device
+ * @format: return location for the pixel format
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int mipi_dsi_dcs_get_pixel_format(struct mipi_dsi_device *dsi, u8 *format)
+{
+	ssize_t err;
+
+	err = mipi_dsi_dcs_read(dsi, MIPI_DCS_GET_PIXEL_FORMAT, format,
+				sizeof(*format));
+	if (err <= 0) {
+		if (err == 0)
+			err = -ENODATA;
+
+		return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_get_pixel_format);
+
+/**
+ * mipi_dsi_dcs_enter_sleep_mode() - disable all unnecessary blocks inside the
+ *    display module except interface communication
+ * @dsi: DSI peripheral device
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int mipi_dsi_dcs_enter_sleep_mode(struct mipi_dsi_device *dsi)
+{
+	ssize_t err;
+
+	err = mipi_dsi_dcs_write(dsi, MIPI_DCS_ENTER_SLEEP_MODE, NULL, 0);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_enter_sleep_mode);
+
+/**
+ * mipi_dsi_dcs_exit_sleep_mode() - enable all blocks inside the display
+ *    module
+ * @dsi: DSI peripheral device
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int mipi_dsi_dcs_exit_sleep_mode(struct mipi_dsi_device *dsi)
+{
+	ssize_t err;
+
+	err = mipi_dsi_dcs_write(dsi, MIPI_DCS_EXIT_SLEEP_MODE, NULL, 0);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_exit_sleep_mode);
+
+/**
+ * mipi_dsi_dcs_set_display_off() - stop displaying the image data on the
+ *    display device
+ * @dsi: DSI peripheral device
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int mipi_dsi_dcs_set_display_off(struct mipi_dsi_device *dsi)
+{
+	ssize_t err;
+
+	err = mipi_dsi_dcs_write(dsi, MIPI_DCS_SET_DISPLAY_OFF, NULL, 0);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_set_display_off);
+
+/**
+ * mipi_dsi_dcs_set_display_on() - start displaying the image data on the
+ *    display device
+ * @dsi: DSI peripheral device
+ *
+ * Return: 0 on success or a negative error code on failure
+ */
+int mipi_dsi_dcs_set_display_on(struct mipi_dsi_device *dsi)
+{
+	ssize_t err;
+
+	err = mipi_dsi_dcs_write(dsi, MIPI_DCS_SET_DISPLAY_ON, NULL, 0);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_set_display_on);
+
+/**
+ * mipi_dsi_dcs_set_column_address() - define the column extent of the frame
+ *    memory accessed by the host processor
+ * @dsi: DSI peripheral device
+ * @start: first column of frame memory
+ * @end: last column of frame memory
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int mipi_dsi_dcs_set_column_address(struct mipi_dsi_device *dsi, u16 start,
+				    u16 end)
+{
+	u8 payload[4] = { start >> 8, start & 0xff, end >> 8, end & 0xff };
+	ssize_t err;
+
+	err = mipi_dsi_dcs_write(dsi, MIPI_DCS_SET_COLUMN_ADDRESS, payload,
+				 sizeof(payload));
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_set_column_address);
+
+/**
+ * mipi_dsi_dcs_set_page_address() - define the page extent of the frame
+ *    memory accessed by the host processor
+ * @dsi: DSI peripheral device
+ * @start: first page of frame memory
+ * @end: last page of frame memory
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int mipi_dsi_dcs_set_page_address(struct mipi_dsi_device *dsi, u16 start,
+				  u16 end)
+{
+	u8 payload[4] = { start >> 8, start & 0xff, end >> 8, end & 0xff };
+	ssize_t err;
+
+	err = mipi_dsi_dcs_write(dsi, MIPI_DCS_SET_PAGE_ADDRESS, payload,
+				 sizeof(payload));
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_set_page_address);
+
+/**
+ * mipi_dsi_dcs_set_tear_off() - turn off the display module's Tearing Effect
+ *    output signal on the TE signal line
+ * @dsi: DSI peripheral device
+ *
+ * Return: 0 on success or a negative error code on failure
+ */
+int mipi_dsi_dcs_set_tear_off(struct mipi_dsi_device *dsi)
+{
+	ssize_t err;
+
+	err = mipi_dsi_dcs_write(dsi, MIPI_DCS_SET_TEAR_OFF, NULL, 0);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_set_tear_off);
+
+/**
+ * mipi_dsi_dcs_set_tear_on() - turn on the display module's Tearing Effect
+ *    output signal on the TE signal line.
+ * @dsi: DSI peripheral device
+ * @mode: the Tearing Effect Output Line mode
+ *
+ * Return: 0 on success or a negative error code on failure
+ */
+int mipi_dsi_dcs_set_tear_on(struct mipi_dsi_device *dsi,
+			     enum mipi_dsi_dcs_tear_mode mode)
+{
+	u8 value = mode;
+	ssize_t err;
+
+	err = mipi_dsi_dcs_write(dsi, MIPI_DCS_SET_TEAR_ON, &value,
+				 sizeof(value));
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_set_tear_on);
+
+/**
+ * mipi_dsi_dcs_set_pixel_format() - sets the pixel format for the RGB image
+ *    data used by the interface
+ * @dsi: DSI peripheral device
+ * @format: pixel format
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int mipi_dsi_dcs_set_pixel_format(struct mipi_dsi_device *dsi, u8 format)
+{
+	ssize_t err;
+
+	err = mipi_dsi_dcs_write(dsi, MIPI_DCS_SET_PIXEL_FORMAT, &format,
+				 sizeof(format));
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_set_pixel_format);
+
+/**
+ * mipi_dsi_dcs_set_tear_scanline() - set the scanline to use as trigger for
+ *    the Tearing Effect output signal of the display module
+ * @dsi: DSI peripheral device
+ * @scanline: scanline to use as trigger
+ *
+ * Return: 0 on success or a negative error code on failure
+ */
+int mipi_dsi_dcs_set_tear_scanline(struct mipi_dsi_device *dsi, u16 scanline)
+{
+	u8 payload[3] = { MIPI_DCS_SET_TEAR_SCANLINE, scanline >> 8,
+			  scanline & 0xff };
+	ssize_t err;
+
+	err = mipi_dsi_generic_write(dsi, payload, sizeof(payload));
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_set_tear_scanline);
+
+/**
+ * mipi_dsi_dcs_set_display_brightness() - sets the brightness value of the
+ *    display
+ * @dsi: DSI peripheral device
+ * @brightness: brightness value
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int mipi_dsi_dcs_set_display_brightness(struct mipi_dsi_device *dsi,
+					u16 brightness)
+{
+	u8 payload[2] = { brightness & 0xff, brightness >> 8 };
+	ssize_t err;
+
+	err = mipi_dsi_dcs_write(dsi, MIPI_DCS_SET_DISPLAY_BRIGHTNESS,
+				 payload, sizeof(payload));
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_set_display_brightness);
+
+/**
+ * mipi_dsi_dcs_get_display_brightness() - gets the current brightness value
+ *    of the display
+ * @dsi: DSI peripheral device
+ * @brightness: brightness value
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int mipi_dsi_dcs_get_display_brightness(struct mipi_dsi_device *dsi,
+					u16 *brightness)
+{
+	ssize_t err;
+
+	err = mipi_dsi_dcs_read(dsi, MIPI_DCS_GET_DISPLAY_BRIGHTNESS,
+				brightness, sizeof(*brightness));
+	if (err <= 0) {
+		if (err == 0)
+			err = -ENODATA;
+
+		return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_get_display_brightness);
+
+MODULE_AUTHOR("Andrzej Hajda <a.hajda@samsung.com>");
+MODULE_AUTHOR("Yannick Fertre <yannick.fertre@st.com>");
+MODULE_DESCRIPTION("MIPI DSI Bus");
+MODULE_LICENSE("GPL and additional rights");
diff --git a/include/mipi_display.h b/include/mipi_display.h
index ddcc8ca..8f9d4a4 100644
--- a/include/mipi_display.h
+++ b/include/mipi_display.h
@@ -4,12 +4,16 @@
  *
  * Copyright (C) 2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
  * Copyright (C) 2006 Nokia Corporation
- * Author: Imre Deak <imre.deak@nokia.com>
+ * Copyright (C) 2018 STMicroelectronics - All Rights Reserved
+ * Author(s): Imre Deak <imre.deak@nokia.com>
+ *	   Yannick Fertre <yannick.fertre@st.com>
+ *         Philippe Cornu <philippe.cornu@st.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+
 #ifndef MIPI_DISPLAY_H
 #define MIPI_DISPLAY_H
 
@@ -115,6 +119,14 @@ enum {
 	MIPI_DCS_READ_MEMORY_CONTINUE	= 0x3E,
 	MIPI_DCS_SET_TEAR_SCANLINE	= 0x44,
 	MIPI_DCS_GET_SCANLINE		= 0x45,
+	MIPI_DCS_SET_DISPLAY_BRIGHTNESS = 0x51,		/* MIPI DCS 1.3 */
+	MIPI_DCS_GET_DISPLAY_BRIGHTNESS = 0x52,		/* MIPI DCS 1.3 */
+	MIPI_DCS_WRITE_CONTROL_DISPLAY  = 0x53,		/* MIPI DCS 1.3 */
+	MIPI_DCS_GET_CONTROL_DISPLAY	= 0x54,		/* MIPI DCS 1.3 */
+	MIPI_DCS_WRITE_POWER_SAVE	= 0x55,		/* MIPI DCS 1.3 */
+	MIPI_DCS_GET_POWER_SAVE		= 0x56,		/* MIPI DCS 1.3 */
+	MIPI_DCS_SET_CABC_MIN_BRIGHTNESS = 0x5E,	/* MIPI DCS 1.3 */
+	MIPI_DCS_GET_CABC_MIN_BRIGHTNESS = 0x5F,	/* MIPI DCS 1.3 */
 	MIPI_DCS_READ_DDB_START		= 0xA1,
 	MIPI_DCS_READ_DDB_CONTINUE	= 0xA8,
 };
@@ -127,4 +139,247 @@ enum {
 #define MIPI_DCS_PIXEL_FMT_8BIT		2
 #define MIPI_DCS_PIXEL_FMT_3BIT		1
 
+struct mipi_dsi_host;
+struct mipi_dsi_device;
+
+/* request ACK from peripheral */
+#define MIPI_DSI_MSG_REQ_ACK	BIT(0)
+/* use Low Power Mode to transmit message */
+#define MIPI_DSI_MSG_USE_LPM	BIT(1)
+
+/**
+ * struct mipi_dsi_msg - read/write DSI buffer
+ * @channel: virtual channel id
+ * @type: payload data type
+ * @flags: flags controlling this message transmission
+ * @tx_len: length of @tx_buf
+ * @tx_buf: data to be written
+ * @rx_len: length of @rx_buf
+ * @rx_buf: data to be read, or NULL
+ */
+struct mipi_dsi_msg {
+	u8 channel;
+	u8 type;
+	u16 flags;
+
+	size_t tx_len;
+	const void *tx_buf;
+
+	size_t rx_len;
+	void *rx_buf;
+};
+
+bool mipi_dsi_packet_format_is_short(u8 type);
+bool mipi_dsi_packet_format_is_long(u8 type);
+
+/**
+ * struct mipi_dsi_packet - represents a MIPI DSI packet in protocol format
+ * @size: size (in bytes) of the packet
+ * @header: the four bytes that make up the header (Data ID, Word Count or
+ *     Packet Data, and ECC)
+ * @payload_length: number of bytes in the payload
+ * @payload: a pointer to a buffer containing the payload, if any
+ */
+struct mipi_dsi_packet {
+	size_t size;
+	u8 header[4];
+	size_t payload_length;
+	const u8 *payload;
+};
+
+int mipi_dsi_create_packet(struct mipi_dsi_packet *packet,
+			   const struct mipi_dsi_msg *msg);
+
+/**
+ * struct mipi_dsi_host_ops - DSI bus operations
+ * @attach: attach DSI device to DSI host
+ * @detach: detach DSI device from DSI host
+ * @transfer: transmit a DSI packet
+ *
+ * DSI packets transmitted by .transfer() are passed in as mipi_dsi_msg
+ * structures. This structure contains information about the type of packet
+ * being transmitted as well as the transmit and receive buffers. When an
+ * error is encountered during transmission, this function will return a
+ * negative error code. On success it shall return the number of bytes
+ * transmitted for write packets or the number of bytes received for read
+ * packets.
+ *
+ * Note that typically DSI packet transmission is atomic, so the .transfer()
+ * function will seldomly return anything other than the number of bytes
+ * contained in the transmit buffer on success.
+ */
+struct mipi_dsi_host_ops {
+	int (*attach)(struct mipi_dsi_host *host,
+		      struct mipi_dsi_device *dsi);
+	int (*detach)(struct mipi_dsi_host *host,
+		      struct mipi_dsi_device *dsi);
+	ssize_t (*transfer)(struct mipi_dsi_host *host,
+			    const struct mipi_dsi_msg *msg);
+};
+
+/**
+ * struct mipi_dsi_host - DSI host device
+ * @dev: driver model device node for this DSI host
+ * @ops: DSI host operations
+ * @list: list management
+ */
+struct mipi_dsi_host {
+	struct device *dev;
+	const struct mipi_dsi_host_ops *ops;
+	struct list_head list;
+};
+
+/* DSI mode flags */
+
+/* video mode */
+#define MIPI_DSI_MODE_VIDEO		BIT(0)
+/* video burst mode */
+#define MIPI_DSI_MODE_VIDEO_BURST	BIT(1)
+/* video pulse mode */
+#define MIPI_DSI_MODE_VIDEO_SYNC_PULSE	BIT(2)
+/* enable auto vertical count mode */
+#define MIPI_DSI_MODE_VIDEO_AUTO_VERT	BIT(3)
+/* enable hsync-end packets in vsync-pulse and v-porch area */
+#define MIPI_DSI_MODE_VIDEO_HSE		BIT(4)
+/* disable hfront-porch area */
+#define MIPI_DSI_MODE_VIDEO_HFP		BIT(5)
+/* disable hback-porch area */
+#define MIPI_DSI_MODE_VIDEO_HBP		BIT(6)
+/* disable hsync-active area */
+#define MIPI_DSI_MODE_VIDEO_HSA		BIT(7)
+/* flush display FIFO on vsync pulse */
+#define MIPI_DSI_MODE_VSYNC_FLUSH	BIT(8)
+/* disable EoT packets in HS mode */
+#define MIPI_DSI_MODE_EOT_PACKET	BIT(9)
+/* device supports non-continuous clock behavior (DSI spec 5.6.1) */
+#define MIPI_DSI_CLOCK_NON_CONTINUOUS	BIT(10)
+/* transmit data in low power */
+#define MIPI_DSI_MODE_LPM		BIT(11)
+
+enum mipi_dsi_pixel_format {
+	MIPI_DSI_FMT_RGB888,
+	MIPI_DSI_FMT_RGB666,
+	MIPI_DSI_FMT_RGB666_PACKED,
+	MIPI_DSI_FMT_RGB565,
+};
+
+#define DSI_DEV_NAME_SIZE		20
+
+/**
+ * struct mipi_dsi_device_info - template for creating a mipi_dsi_device
+ * @type: DSI peripheral chip type
+ * @channel: DSI virtual channel assigned to peripheral
+ * @node: pointer to OF device node or NULL
+ *
+ * This is populated and passed to mipi_dsi_device_new to create a new
+ * DSI device
+ */
+struct mipi_dsi_device_info {
+	char type[DSI_DEV_NAME_SIZE];
+	u32 channel;
+	struct device_node *node;
+};
+
+/**
+ * struct mipi_dsi_device - DSI peripheral device
+ * @host: DSI host for this peripheral
+ * @dev: driver model device node for this peripheral
+ * @name: DSI peripheral chip type
+ * @channel: virtual channel assigned to the peripheral
+ * @format: pixel format for video mode
+ * @lanes: number of active data lanes
+ * @mode_flags: DSI operation mode related flags
+ */
+struct mipi_dsi_device {
+	struct mipi_dsi_host *host;
+	struct udevice *dev;
+
+	char name[DSI_DEV_NAME_SIZE];
+	unsigned int channel;
+	unsigned int lanes;
+	enum mipi_dsi_pixel_format format;
+	unsigned long mode_flags;
+};
+
+/**
+ * enum mipi_dsi_dcs_tear_mode - Tearing Effect Output Line mode
+ * @MIPI_DSI_DCS_TEAR_MODE_VBLANK: the TE output line consists of V-Blanking
+ *    information only
+ * @MIPI_DSI_DCS_TEAR_MODE_VHBLANK : the TE output line consists of both
+ *    V-Blanking and H-Blanking information
+ */
+enum mipi_dsi_dcs_tear_mode {
+	MIPI_DSI_DCS_TEAR_MODE_VBLANK,
+	MIPI_DSI_DCS_TEAR_MODE_VHBLANK,
+};
+
+/**
+ * struct mipi_dsi_panel_plat - DSI panel platform data
+ * @device: DSI peripheral device
+ */
+struct mipi_dsi_panel_plat {
+	struct mipi_dsi_device *device;
+};
+
+int mipi_dsi_attach(struct mipi_dsi_device *dsi);
+int mipi_dsi_detach(struct mipi_dsi_device *dsi);
+int mipi_dsi_pixel_format_to_bpp(enum mipi_dsi_pixel_format fmt);
+
+/* bit compatible with the xrandr RR_ definitions (bits 0-13)
+ *
+ * ABI warning: Existing userspace really expects
+ * the mode flags to match the xrandr definitions. Any
+ * changes that don't match the xrandr definitions will
+ * likely need a new client cap or some other mechanism
+ * to avoid breaking existing userspace. This includes
+ * allocating new flags in the previously unused bits!
+ */
+#define MIPI_DSI_FLAG_PHSYNC			BIT(0)
+#define MIPI_DSI_FLAG_NHSYNC			BIT(1)
+#define MIPI_DSI_FLAG_PVSYNC			BIT(2)
+#define MIPI_DSI_FLAG_NVSYNC			BIT(3)
+#define MIPI_DSI_FLAG_INTERLACE			BIT(4)
+#define MIPI_DSI_FLAG_DBLSCAN			BIT(5)
+#define MIPI_DSI_FLAG_CSYNC			BIT(6)
+#define MIPI_DSI_FLAG_PCSYNC			BIT(7)
+#define MIPI_DSI_FLAG_NCSYNC			BIT(8)
+#define MIPI_DSI_FLAG_HSKEW			BIT(9) /* hskew provided */
+#define MIPI_DSI_FLAG_BCAST			BIT(10)
+#define MIPI_DSI_FLAG_PIXMUX			BIT(11)
+#define MIPI_DSI_FLAG_DBLCLK			BIT(12)
+#define MIPI_DSI_FLAG_CLKDIV2			BIT(13)
+
+/* request ACK from peripheral */
+#define MIPI_DSI_MSG_REQ_ACK	BIT(0)
+/* use Low Power Mode to transmit message */
+#define MIPI_DSI_MSG_USE_LPM	BIT(1)
+
+ssize_t mipi_dsi_dcs_write_buffer(struct mipi_dsi_device *dsi,
+				  const void *data, size_t len);
+ssize_t mipi_dsi_dcs_write(struct mipi_dsi_device *dsi, u8 cmd,
+			   const void *data, size_t len);
+ssize_t mipi_dsi_dcs_read(struct mipi_dsi_device *dsi, u8 cmd, void *data,
+			  size_t len);
+int mipi_dsi_dcs_nop(struct mipi_dsi_device *dsi);
+int mipi_dsi_dcs_soft_reset(struct mipi_dsi_device *dsi);
+int mipi_dsi_dcs_get_power_mode(struct mipi_dsi_device *dsi, u8 *mode);
+int mipi_dsi_dcs_get_pixel_format(struct mipi_dsi_device *dsi, u8 *format);
+int mipi_dsi_dcs_enter_sleep_mode(struct mipi_dsi_device *dsi);
+int mipi_dsi_dcs_exit_sleep_mode(struct mipi_dsi_device *dsi);
+int mipi_dsi_dcs_set_display_off(struct mipi_dsi_device *dsi);
+int mipi_dsi_dcs_set_display_on(struct mipi_dsi_device *dsi);
+int mipi_dsi_dcs_set_column_address(struct mipi_dsi_device *dsi, u16 start,
+				    u16 end);
+int mipi_dsi_dcs_set_page_address(struct mipi_dsi_device *dsi, u16 start,
+				  u16 end);
+int mipi_dsi_dcs_set_tear_off(struct mipi_dsi_device *dsi);
+int mipi_dsi_dcs_set_tear_on(struct mipi_dsi_device *dsi,
+			     enum mipi_dsi_dcs_tear_mode mode);
+int mipi_dsi_dcs_set_pixel_format(struct mipi_dsi_device *dsi, u8 format);
+int mipi_dsi_dcs_set_tear_scanline(struct mipi_dsi_device *dsi, u16 scanline);
+int mipi_dsi_dcs_set_display_brightness(struct mipi_dsi_device *dsi,
+					u16 brightness);
+int mipi_dsi_dcs_get_display_brightness(struct mipi_dsi_device *dsi,
+					u16 *brightness);
+
 #endif
-- 
1.9.1
