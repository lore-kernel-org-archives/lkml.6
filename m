Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbeDENZ6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 09:25:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751437AbeDENZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 09:25:55 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kt.liao@emc.com.tw, Oliver Haessler <oliver@redhat.com>,
        Benjamin Berg <bberg@redhat.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 6/8] Input: elantech - add support for SMBus devices
Date: Thu,  5 Apr 2018 15:25:35 +0200
Message-Id: <20180405132537.3218-7-benjamin.tissoires@redhat.com>
In-Reply-To: <20180405132537.3218-1-benjamin.tissoires@redhat.com>
References: <20180405132537.3218-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many of the Elantech devices are connected through PS/2 and a different
bus (SMBus or plain I2C).

To not break any existing device, we only enable SMBus based
on a module parameter. If some laptops require the quirk to
be set, we will have to rely on a list of PNPIds or MDI matching
to individually expose those hardware over SMBus.
the parameter mentioned above is elantech_smbus from the psmouse
module.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/Kconfig        |  12 +++
 drivers/input/mouse/elantech.c     | 184 ++++++++++++++++++++++++++++++++++++-
 drivers/input/mouse/elantech.h     |  24 +++++
 drivers/input/mouse/psmouse-base.c |  21 ++++-
 drivers/input/mouse/psmouse.h      |   1 +
 5 files changed, 235 insertions(+), 7 deletions(-)

diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
index 89ebb8f39fee..f27f23f2d99a 100644
--- a/drivers/input/mouse/Kconfig
+++ b/drivers/input/mouse/Kconfig
@@ -133,6 +133,18 @@ config MOUSE_PS2_ELANTECH
 
 	  If unsure, say N.
 
+config MOUSE_PS2_ELANTECH_SMBUS
+	bool "Elantech PS/2 SMbus companion" if EXPERT
+	default y
+	depends on MOUSE_PS2 && MOUSE_PS2_ELANTECH
+	depends on I2C=y || I2C=MOUSE_PS2
+	select MOUSE_PS2_SMBUS
+	help
+	  Say Y here if you have a Elantech touchpad connected to
+	  to an SMBus, but enumerated through PS/2.
+
+	  If unsure, say Y.
+
 config MOUSE_PS2_SENTELIC
 	bool "Sentelic Finger Sensing Pad PS/2 protocol extension"
 	depends on MOUSE_PS2
diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 41af0c9098af..a61fbddd6b92 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -14,13 +14,16 @@
 #include <linux/dmi.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/input/mt.h>
+#include <linux/platform_device.h>
 #include <linux/serio.h>
 #include <linux/libps2.h>
 #include <asm/unaligned.h>
 #include "psmouse.h"
 #include "elantech.h"
+#include "elan_i2c.h"
 
 #define elantech_debug(fmt, ...)					\
 	do {								\
@@ -1084,7 +1087,8 @@ static unsigned int elantech_convert_res(unsigned int val)
 
 static int elantech_get_resolution_v4(struct psmouse *psmouse,
 				      unsigned int *x_res,
-				      unsigned int *y_res)
+				      unsigned int *y_res,
+				      unsigned int *bus)
 {
 	unsigned char param[3];
 
@@ -1093,6 +1097,7 @@ static int elantech_get_resolution_v4(struct psmouse *psmouse,
 
 	*x_res = elantech_convert_res(param[1] & 0x0f);
 	*y_res = elantech_convert_res((param[1] & 0xf0) >> 4);
+	*bus = param[2];
 
 	return 0;
 }
@@ -1474,6 +1479,12 @@ static void elantech_disconnect(struct psmouse *psmouse)
 {
 	struct elantech_data *etd = psmouse->private;
 
+	/*
+	 * We might have left a breadcrumb when trying to
+	 * set up SMbus companion.
+	 */
+	psmouse_smbus_cleanup(psmouse);
+
 	if (etd->tp_dev)
 		input_unregister_device(etd->tp_dev);
 	sysfs_remove_group(&psmouse->ps2dev.serio->dev.kobj,
@@ -1659,6 +1670,8 @@ int elantech_query_info(struct psmouse *psmouse,
 {
 	unsigned char param[3];
 
+	memset(info, 0, sizeof(*info));
+
 	/*
 	 * Do the version query again so we can store the result
 	 */
@@ -1717,7 +1730,8 @@ int elantech_query_info(struct psmouse *psmouse,
 	if (info->hw_version == 4) {
 		if (elantech_get_resolution_v4(psmouse,
 					       &info->x_res,
-					       &info->y_res)) {
+					       &info->y_res,
+					       &info->bus)) {
 			psmouse_warn(psmouse,
 				     "failed to query resolution data.\n");
 		}
@@ -1726,6 +1740,125 @@ int elantech_query_info(struct psmouse *psmouse,
 	return 0;
 }
 
+#if defined(CONFIG_MOUSE_PS2_ELANTECH_SMBUS)
+
+/*
+ * The newest Elantech device can use a secondary bus (over SMBus) which
+ * provides a better bandwidth and allow a better control of the touchpads.
+ * This is used to decide if we need to use this bus or not.
+ */
+enum {
+	ELANTECH_SMBUS_NOT_SET = -1,
+	ELANTECH_SMBUS_OFF,
+	ELANTECH_SMBUS_ON,
+};
+
+static int elantech_smbus = IS_ENABLED(CONFIG_MOUSE_ELAN_I2C_SMBUS) ?
+		ELANTECH_SMBUS_NOT_SET : ELANTECH_SMBUS_OFF;
+module_param_named(elantech_smbus, elantech_smbus, int, 0644);
+MODULE_PARM_DESC(elantech_smbus, "Use a secondary bus for the Elantech device.");
+
+static int elantech_create_smbus(struct psmouse *psmouse,
+				 struct elantech_device_info *info,
+				 bool leave_breadcrumbs)
+{
+	struct elan_platform_data pdata = {
+		.trackpoint = info->has_trackpoint,
+	};
+	struct i2c_board_info smbus_board = {
+		I2C_BOARD_INFO("elan_i2c", 0x15),
+		.flags = I2C_CLIENT_HOST_NOTIFY,
+	};
+
+	return psmouse_smbus_init(psmouse, &smbus_board, &pdata,
+				  sizeof(pdata), leave_breadcrumbs);
+}
+
+/**
+ * elantech_setup_smbus - called once the PS/2 devices are enumerated
+ * and decides to instantiate a SMBus InterTouch device.
+ */
+static int elantech_setup_smbus(struct psmouse *psmouse,
+				struct elantech_device_info *info,
+				bool leave_breadcrumbs)
+{
+	int error;
+
+	if (elantech_smbus == ELANTECH_SMBUS_OFF)
+		return -ENXIO;
+
+	if (elantech_smbus == ELANTECH_SMBUS_NOT_SET) {
+		/*
+		 * FIXME:
+		 * constraint the I2C capable devices by using FW version,
+		 * board version, or by using DMI matching
+		 */
+		return -ENXIO;
+	}
+
+	psmouse_info(psmouse, "Trying to set up SMBus access\n");
+
+	error = elantech_create_smbus(psmouse, info, leave_breadcrumbs);
+	if (error) {
+		if (error == -EAGAIN)
+			psmouse_info(psmouse, "SMbus companion is not ready yet\n");
+		else
+			psmouse_err(psmouse, "unable to create intertouch device\n");
+
+		return error;
+	}
+
+	return 0;
+}
+
+static bool elantech_use_host_notify(struct psmouse *psmouse,
+				     struct elantech_device_info *info)
+{
+	switch (info->bus) {
+	case ETP_BUS_PS2_ONLY:
+		/* expected case */
+		break;
+	case ETP_BUS_SMB_ALERT_ONLY:
+		/* fall-through  */
+	case ETP_BUS_PS2_SMB_ALERT:
+		psmouse_dbg(psmouse, "Ignoring SMBus provider through alert protocol.\n");
+		break;
+	case ETP_BUS_SMB_HST_NTFY_ONLY:
+		/* fall-through  */
+	case ETP_BUS_PS2_SMB_HST_NTFY:
+		return true;
+	default:
+		psmouse_dbg(psmouse,
+			    "Ignoring SMBus bus provider %d.\n",
+			    info->bus);
+	}
+
+	return false;
+}
+
+int elantech_init_smbus(struct psmouse *psmouse)
+{
+	struct elantech_device_info info;
+	int error = -EINVAL;
+
+	psmouse_reset(psmouse);
+
+	error = elantech_query_info(psmouse, &info);
+	if (error)
+		goto init_fail;
+
+	if (info.hw_version < 4) {
+		error = -ENXIO;
+		goto init_fail;
+	}
+
+	return elantech_create_smbus(psmouse, &info, false);
+ init_fail:
+	psmouse_reset(psmouse);
+	return error;
+}
+#endif /* CONFIG_MOUSE_PS2_ELANTECH_SMBUS */
+
 /*
  * Initialize the touchpad and create sysfs entries
  */
@@ -1734,7 +1867,7 @@ static int elantech_setup_ps2(struct psmouse *psmouse,
 {
 	struct elantech_data *etd;
 	int i;
-	int error;
+	int error = -EINVAL;
 	struct input_dev *tp_dev;
 
 	psmouse->private = etd = kzalloc(sizeof(*etd), GFP_KERNEL);
@@ -1821,7 +1954,7 @@ static int elantech_setup_ps2(struct psmouse *psmouse,
 	return error;
 }
 
-int elantech_init(struct psmouse *psmouse)
+int elantech_init_ps2(struct psmouse *psmouse)
 {
 	struct elantech_device_info info;
 	int error = -EINVAL;
@@ -1841,3 +1974,46 @@ int elantech_init(struct psmouse *psmouse)
 	psmouse_reset(psmouse);
 	return error;
 }
+
+int elantech_init(struct psmouse *psmouse)
+{
+	struct elantech_device_info info;
+	int error = -EINVAL;
+
+	psmouse_reset(psmouse);
+
+	error = elantech_query_info(psmouse, &info);
+	if (error)
+		goto init_fail;
+
+#if defined(CONFIG_MOUSE_PS2_ELANTECH_SMBUS)
+
+	if (elantech_use_host_notify(psmouse, &info)) {
+		if (!IS_ENABLED(CONFIG_MOUSE_ELAN_I2C_SMBUS) ||
+		    !IS_ENABLED(CONFIG_MOUSE_PS2_ELANTECH_SMBUS)) {
+			psmouse_warn(psmouse,
+				     "The touchpad can support a better bus than the too old PS/2 protocol. "
+				     "Make sure MOUSE_PS2_ELANTECH_SMBUS and MOUSE_ELAN_I2C_SMBUS are enabled to get a better touchpad experience.\n");
+		}
+		error = elantech_setup_smbus(psmouse, &info, true);
+		if (!error)
+			return PSMOUSE_ELANTECH_SMBUS;
+	}
+
+#endif /* CONFIG_MOUSE_PS2_ELANTECH_SMBUS */
+
+	error = elantech_setup_ps2(psmouse, &info);
+	if (error < 0) {
+		/*
+		 * Not using any flavor of Elantech support, so clean up
+		 * SMbus breadcrumbs, if any.
+		 */
+		psmouse_smbus_cleanup(psmouse);
+		goto init_fail;
+	}
+
+	return PSMOUSE_ELANTECH;
+ init_fail:
+	psmouse_reset(psmouse);
+	return error;
+}
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h
index 851df4ce6232..f9b1c485e8d9 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -106,6 +106,15 @@
  */
 #define ETP_WEIGHT_VALUE		5
 
+/*
+ * Bus information on 3rd byte of query ETP_RESOLUTION_QUERY(0x04)
+ */
+#define ETP_BUS_PS2_ONLY		0
+#define ETP_BUS_SMB_ALERT_ONLY		1
+#define ETP_BUS_SMB_HST_NTFY_ONLY	2
+#define ETP_BUS_PS2_SMB_ALERT		3
+#define ETP_BUS_PS2_SMB_HST_NTFY	4
+
 /*
  * The base position for one finger, v4 hardware
  */
@@ -122,6 +131,7 @@ struct elantech_device_info {
 	unsigned int fw_version;
 	unsigned int x_res;
 	unsigned int y_res;
+	unsigned int bus;
 	bool paritycheck;
 	bool jumpy_cursor;
 	bool reports_pressure;
@@ -156,6 +166,7 @@ struct elantech_data {
 
 #ifdef CONFIG_MOUSE_PS2_ELANTECH
 int elantech_detect(struct psmouse *psmouse, bool set_properties);
+int elantech_init_ps2(struct psmouse *psmouse);
 int elantech_init(struct psmouse *psmouse);
 #else
 static inline int elantech_detect(struct psmouse *psmouse, bool set_properties)
@@ -166,6 +177,19 @@ static inline int elantech_init(struct psmouse *psmouse)
 {
 	return -ENOSYS;
 }
+static inline int elantech_init_ps2(struct psmouse *psmouse)
+{
+	return -ENOSYS;
+}
 #endif /* CONFIG_MOUSE_PS2_ELANTECH */
 
+#if defined(CONFIG_MOUSE_PS2_ELANTECH_SMBUS)
+int elantech_init_smbus(struct psmouse *psmouse);
+#else
+static inline int elantech_init_smbus(struct psmouse *psmouse)
+{
+	return -ENOSYS;
+}
+#endif /* CONFIG_MOUSE_PS2_ELANTECH_SMBUS */
+
 #endif
diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 8900c3166ebf..5ff5b1952be0 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -856,7 +856,17 @@ static const struct psmouse_protocol psmouse_protocols[] = {
 		.name		= "ETPS/2",
 		.alias		= "elantech",
 		.detect		= elantech_detect,
-		.init		= elantech_init,
+		.init		= elantech_init_ps2,
+	},
+#endif
+#ifdef CONFIG_MOUSE_PS2_ELANTECH_SMBUS
+	{
+		.type		= PSMOUSE_ELANTECH_SMBUS,
+		.name		= "ETSMBus",
+		.alias		= "elantech-smbus",
+		.detect		= elantech_detect,
+		.init		= elantech_init_smbus,
+		.smbus_companion = true,
 	},
 #endif
 #ifdef CONFIG_MOUSE_PS2_SENTELIC
@@ -1158,8 +1168,13 @@ static int psmouse_extensions(struct psmouse *psmouse,
 	/* Try Elantech touchpad */
 	if (max_proto > PSMOUSE_IMEX &&
 	    psmouse_try_protocol(psmouse, PSMOUSE_ELANTECH,
-				 &max_proto, set_properties, true)) {
-		return PSMOUSE_ELANTECH;
+				 &max_proto, set_properties, false)) {
+		if (!set_properties)
+			return PSMOUSE_ELANTECH;
+
+		ret = elantech_init(psmouse);
+		if (ret >= 0)
+			return ret;
 	}
 
 	if (max_proto > PSMOUSE_IMEX) {
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
index 71ac50082c8b..dd4ec1f602d7 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -68,6 +68,7 @@ enum psmouse_type {
 	PSMOUSE_VMMOUSE,
 	PSMOUSE_BYD,
 	PSMOUSE_SYNAPTICS_SMBUS,
+	PSMOUSE_ELANTECH_SMBUS,
 	PSMOUSE_AUTO		/* This one should always be last */
 };
 
-- 
2.14.3
