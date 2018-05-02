Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751605AbeEBJy3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 05:54:29 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34766 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbeEBJxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 05:53:54 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>
Cc: Gwendal Grignou <gwendal@chromium.org>,
        Sameer Nanda <snanda@chromium.org>, linux-pm@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>, miguel.ojeda.sandonis@gmail.com,
        kernel@collabora.com
Subject: [PATCH v3 1/3] mfd: cros_ec: Add USBPD charger commands and struct definitions.
Date: Wed,  2 May 2018 11:53:41 +0200
Message-Id: <20180502095343.17092-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180502095343.17092-1-enric.balletbo@collabora.com>
References: <20180502095343.17092-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sameer Nanda <snanda@chromium.org>

The USBPD charger driver gets information from the ChromeOS EC, this
patch adds the USBPD charger definitions needed by this driver.

Signed-off-by: Sameer Nanda <snanda@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v3:
- [1/3] Use the BIT macro.

Changes in v2: None

 include/linux/mfd/cros_ec_commands.h | 132 ++++++++++++++++++++++++++-
 1 file changed, 128 insertions(+), 4 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index f2edd9969b40..0d926492ac3a 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -2593,14 +2593,18 @@ struct ec_params_current_limit {
 } __packed;
 
 /*
- * Set maximum external power current.
+ * Set maximum external voltage / current.
  */
-#define EC_CMD_EXT_POWER_CURRENT_LIMIT 0xa2
+#define EC_CMD_EXTERNAL_POWER_LIMIT 0x00A2
 
-struct ec_params_ext_power_current_limit {
-	uint32_t limit; /* in mA */
+/* Command v0 is used only on Spring and is obsolete + unsupported */
+struct ec_params_external_power_limit_v1 {
+	uint16_t current_lim; /* in mA, or EC_POWER_LIMIT_NONE to clear limit */
+	uint16_t voltage_lim; /* in mV, or EC_POWER_LIMIT_NONE to clear limit */
 } __packed;
 
+#define EC_POWER_LIMIT_NONE 0xffff
+
 /* Inform the EC when entering a sleep state */
 #define EC_CMD_HOST_SLEEP_EVENT 0xa9
 
@@ -2974,6 +2978,12 @@ enum usb_chg_type {
 	USB_CHG_TYPE_VBUS,
 	USB_CHG_TYPE_UNKNOWN,
 };
+enum usb_power_roles {
+	USB_PD_PORT_POWER_DISCONNECTED,
+	USB_PD_PORT_POWER_SOURCE,
+	USB_PD_PORT_POWER_SINK,
+	USB_PD_PORT_POWER_SINK_NOT_CHARGING,
+};
 
 struct usb_chg_measures {
 	uint16_t voltage_max;
@@ -2991,6 +3001,120 @@ struct ec_response_usb_pd_power_info {
 	uint32_t max_power;
 } __packed;
 
+struct ec_params_usb_pd_info_request {
+	uint8_t port;
+} __packed;
+
+/* Read USB-PD Device discovery info */
+#define EC_CMD_USB_PD_DISCOVERY 0x0113
+struct ec_params_usb_pd_discovery_entry {
+	uint16_t vid;  /* USB-IF VID */
+	uint16_t pid;  /* USB-IF PID */
+	uint8_t ptype; /* product type (hub,periph,cable,ama) */
+} __packed;
+
+/* Override default charge behavior */
+#define EC_CMD_PD_CHARGE_PORT_OVERRIDE 0x0114
+
+/* Negative port parameters have special meaning */
+enum usb_pd_override_ports {
+	OVERRIDE_DONT_CHARGE = -2,
+	OVERRIDE_OFF = -1,
+	/* [0, CONFIG_USB_PD_PORT_COUNT): Port# */
+};
+
+struct ec_params_charge_port_override {
+	int16_t override_port; /* Override port# */
+} __packed;
+
+/* Read (and delete) one entry of PD event log */
+#define EC_CMD_PD_GET_LOG_ENTRY 0x0115
+
+struct ec_response_pd_log {
+	uint32_t timestamp; /* relative timestamp in milliseconds */
+	uint8_t type;       /* event type : see PD_EVENT_xx below */
+	uint8_t size_port;  /* [7:5] port number [4:0] payload size in bytes */
+	uint16_t data;      /* type-defined data payload */
+	uint8_t payload[0]; /* optional additional data payload: 0..16 bytes */
+} __packed;
+
+/* The timestamp is the microsecond counter shifted to get about a ms. */
+#define PD_LOG_TIMESTAMP_SHIFT 10 /* 1 LSB = 1024us */
+
+#define PD_LOG_SIZE_MASK  0x1f
+#define PD_LOG_PORT_MASK  0xe0
+#define PD_LOG_PORT_SHIFT    5
+#define PD_LOG_PORT_SIZE(port, size) (((port) << PD_LOG_PORT_SHIFT) | \
+				      ((size) & PD_LOG_SIZE_MASK))
+#define PD_LOG_PORT(size_port) ((size_port) >> PD_LOG_PORT_SHIFT)
+#define PD_LOG_SIZE(size_port) ((size_port) & PD_LOG_SIZE_MASK)
+
+/* PD event log : entry types */
+/* PD MCU events */
+#define PD_EVENT_MCU_BASE       0x00
+#define PD_EVENT_MCU_CHARGE             (PD_EVENT_MCU_BASE+0)
+#define PD_EVENT_MCU_CONNECT            (PD_EVENT_MCU_BASE+1)
+/* Reserved for custom board event */
+#define PD_EVENT_MCU_BOARD_CUSTOM       (PD_EVENT_MCU_BASE+2)
+/* PD generic accessory events */
+#define PD_EVENT_ACC_BASE       0x20
+#define PD_EVENT_ACC_RW_FAIL   (PD_EVENT_ACC_BASE+0)
+#define PD_EVENT_ACC_RW_ERASE  (PD_EVENT_ACC_BASE+1)
+/* PD power supply events */
+#define PD_EVENT_PS_BASE        0x40
+#define PD_EVENT_PS_FAULT      (PD_EVENT_PS_BASE+0)
+/* PD video dongles events */
+#define PD_EVENT_VIDEO_BASE     0x60
+#define PD_EVENT_VIDEO_DP_MODE (PD_EVENT_VIDEO_BASE+0)
+#define PD_EVENT_VIDEO_CODEC   (PD_EVENT_VIDEO_BASE+1)
+/* Returned in the "type" field, when there is no entry available */
+#define PD_EVENT_NO_ENTRY       0xff
+
+/*
+ * PD_EVENT_MCU_CHARGE event definition :
+ * the payload is "struct usb_chg_measures"
+ * the data field contains the port state flags as defined below :
+ */
+/* Port partner is a dual role device */
+#define CHARGE_FLAGS_DUAL_ROLE         BIT(15)
+/* Port is the pending override port */
+#define CHARGE_FLAGS_DELAYED_OVERRIDE  BIT(14)
+/* Port is the override port */
+#define CHARGE_FLAGS_OVERRIDE          BIT(13)
+/* Charger type */
+#define CHARGE_FLAGS_TYPE_SHIFT               3
+#define CHARGE_FLAGS_TYPE_MASK       (0xf << CHARGE_FLAGS_TYPE_SHIFT)
+/* Power delivery role */
+#define CHARGE_FLAGS_ROLE_MASK         (7 <<  0)
+
+/*
+ * PD_EVENT_PS_FAULT data field flags definition :
+ */
+#define PS_FAULT_OCP                          1
+#define PS_FAULT_FAST_OCP                     2
+#define PS_FAULT_OVP                          3
+#define PS_FAULT_DISCH                        4
+
+/*
+ * PD_EVENT_VIDEO_CODEC payload is "struct mcdp_info".
+ */
+struct mcdp_version {
+	uint8_t major;
+	uint8_t minor;
+	uint16_t build;
+} __packed;
+
+struct mcdp_info {
+	uint8_t family[2];
+	uint8_t chipid[2];
+	struct mcdp_version irom;
+	struct mcdp_version fw;
+} __packed;
+
+/* struct mcdp_info field decoding */
+#define MCDP_CHIPID(chipid) ((chipid[0] << 8) | chipid[1])
+#define MCDP_FAMILY(family) ((family[0] << 8) | family[1])
+
 /* Get info about USB-C SS muxes */
 #define EC_CMD_USB_PD_MUX_INFO 0x11a
 
-- 
2.17.0
