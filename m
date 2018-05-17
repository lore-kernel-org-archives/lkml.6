Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeEQUGh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:06:37 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:58332 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbeEQUGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:06:35 -0400
X-AuditID: 0a3aad16-be7ff70000000413-6b-5afde0c77e53
From: Mark Jonas <mark.jonas@de.bosch.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
CC: <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hs@denx.de>,
        <andy.shevchenko@gmail.com>, Zhu Yi <yi.zhu5@cn.bosch.com>,
        Mark Jonas <mark.jonas@de.bosch.com>
Subject: [PATCH v5] Input: add bu21029 touch driver
Date: Thu, 17 May 2018 22:06:28 +0200
Message-ID: <1526587588-885-1-git-send-email-mark.jonas@de.bosch.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521651874-15379-1-git-send-email-mark.jonas@de.bosch.com>
References: <1521651874-15379-1-git-send-email-mark.jonas@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA21SX0xbVRzm9N7b3hauXi4r/OxkiU324KbQMU1umMFFo/RBN93T1ge1yB29
        sX9Ib0FYomlcVMDO1QFza1iBDmtDMChDV5jC2jWsLGYGcQJhBglYYVtGBTe7AdV7V1j74MvJ
        d37f+b7vnC+HxJhphYbkrQ7ObjWatXIVrir9qvDpy7+vG3TezgJ20X0Jse2RqwR7ybeA2OD1
        GYydWr5LsOODbXL2i4kxGfvhDxHFXlLf4+1Beq8niusHPL8p9H3djXL9St+21wiD6rlKzszX
        cvbisrdUppNLmuoLPlS32DGEOdHN95uQkgT6GYjFV/AmpCIZ+pQMusbuylKbYQQj61F5anMe
        wbTvF7kkkdM7YCoaxCS8ha6DdX+EkA5h9DiC2eYQkog8ejf4/0jgEsbp7TDhuyeTMEW/BK23
        erBU9jaYutr4ACtpPfwcuEJImKHLIXSthUidz4XR0/MPfDAaILSwgLnRo54MypNBdSBZN1IL
        vK7WUqJjS4rsFZxwRLer6G2bpQ+lKs4PoqOhyjCiSaTNoTzT6waGMNYK9ZYwepaUadXUp8lV
        A/NIha2y3mQUTG/aa8ycoNVQKCsri8l7OBZqKiy8IPA2axgBiWm3UPvqRSuq0lh/hLPbUrIw
        2kri2gJqfm/cwNBVRgf3DsdVc/ZNdg9JaoGiZ0Rhrp2r4uoO82bHJq0tTGXmZzKZsTJSGUa7
        yRwx2ylZUEK10SLwVRvyx1JyZnOall5B+8nA3CcujDzpd4lrcqnFhTG41WblNAXUccmLllSm
        GuvD22gep4oLREKdQaQdb6BJJPaZR2VJ4hzxV6fvAVQwr+0Qk7sxTItKukQN7SsC7wd2GDjn
        QhA9cQ5B4pb48/oaxVpXv51F4A3eQeCP30dwrbUBg94zFzGYTM5hEBm4icFoWzMOs38O4eCM
        x3Bomf2MgL/PtBIwGfMTsPJ5hIAf1ybkcLojLofRrjU5JGIfKWAgnFDAZMdxUsxeJiHwzVkl
        JPtvK+HU9JoSPL0N2RDt/j4b3Mdi2TfEjmVix+jiqtSxw+j4n443punHaZyo5T4+OLOzVP3l
        C0WDmsv5/zz/den1ZfaNY/NkOV+oCbzyZNPHsZE7e/gy5VGrO/ffg6+a+PYDoeYls/re7eJk
        5wF7cedi7NBQNtN/9kT7e56dc2W/bh07354TmHA/8dS+teFeJPvuwosvk47+0uER0+HXe8Z1
        rr8SDe/+JHcGyhOaTi0umIy7dmB2wfgfR3GXHG4EAAA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhu Yi <yi.zhu5@cn.bosch.com>

Add Rohm BU21029 resistive touch panel controller support with I2C
interface.

Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
Reviewed-by: Heiko Schocher <hs@denx.de>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v5:
 - use usleep_range() and msleep() instead of atomic delays
 - drop #ifdef CONFIG_PM_SLEEP
 - annotate HW ID as big endian (sparse check finding)
---
Changes in v4:
 - remove potential kernel log spamming from irq handler
 - fix bug in endianess conversion of the chip's HW ID
 - simplify device tree reading
 - flag resume and suspend functions as potentially unused
---
Changes in v3:
 - reviewed by Rob Herring
---
Changes in v2:
 - make ABS_PRESSURE proportionally rising with finger pressure
 - fix race between interrupt and timer during shutdown
 - use infrastructure from include/linux/input/touchscreen.h
 - add SPDX tag for the driver
 - improve binding documentation
 - fix multi-line comments
---
 .../bindings/input/touchscreen/bu21029.txt         |  34 ++
 drivers/input/touchscreen/Kconfig                  |  12 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/bu21029_ts.c             | 474 +++++++++++++++++++++
 4 files changed, 521 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/bu21029.txt
 create mode 100644 drivers/input/touchscreen/bu21029_ts.c

diff --git a/Documentation/devicetree/bindings/input/touchscreen/bu21029.txt b/Documentation/devicetree/bindings/input/touchscreen/bu21029.txt
new file mode 100644
index 0000000..030a888
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/bu21029.txt
@@ -0,0 +1,34 @@
+* Rohm BU21029 Touch Screen Controller
+
+Required properties:
+ - compatible              : must be "rohm,bu21029"
+ - reg                     : i2c device address of the chip (0x40 or 0x41)
+ - interrupt-parent        : the phandle for the gpio controller
+ - interrupts              : (gpio) interrupt to which the chip is connected
+ - reset-gpios             : gpio pin to reset the chip (active low)
+ - rohm,x-plate-ohms       : x-plate resistance in Ohm
+
+Optional properties:
+ - touchscreen-size-x      : horizontal resolution of touchscreen (in pixels)
+ - touchscreen-size-y      : vertical resolution of touchscreen (in pixels)
+ - touchscreen-max-pressure: maximum pressure value
+
+Example:
+
+	&i2c1 {
+		/* ... */
+
+		bu21029: bu21029@40 {
+			compatible = "rohm,bu21029";
+			reg = <0x40>;
+			interrupt-parent = <&gpio1>;
+			interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
+			reset-gpios = <&gpio6 16 GPIO_ACTIVE_LOW>;
+			rohm,x-plate-ohms = <600>;
+			touchscreen-size-x = <800>;
+			touchscreen-size-y = <480>;
+			touchscreen-max-pressure = <4095>;
+		};
+
+		/* ... */
+	};
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 4f15496..e09fe8f 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -151,6 +151,18 @@ config TOUCHSCREEN_BU21013
 	  To compile this driver as a module, choose M here: the
 	  module will be called bu21013_ts.
 
+config TOUCHSCREEN_BU21029
+	tristate "Rohm BU21029 based touch panel controllers"
+	depends on I2C
+	help
+	  Say Y here if you have a Rohm BU21029 touchscreen controller
+	  connected to your system.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called bu21029_ts.
+
 config TOUCHSCREEN_CHIPONE_ICN8318
 	tristate "chipone icn8318 touchscreen controller"
 	depends on GPIOLIB || COMPILE_TEST
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index dddae79..f50624c 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_TOUCHSCREEN_AR1021_I2C)	+= ar1021_i2c.o
 obj-$(CONFIG_TOUCHSCREEN_ATMEL_MXT)	+= atmel_mxt_ts.o
 obj-$(CONFIG_TOUCHSCREEN_AUO_PIXCIR)	+= auo-pixcir-ts.o
 obj-$(CONFIG_TOUCHSCREEN_BU21013)	+= bu21013_ts.o
+obj-$(CONFIG_TOUCHSCREEN_BU21029)	+= bu21029_ts.o
 obj-$(CONFIG_TOUCHSCREEN_CHIPONE_ICN8318)	+= chipone_icn8318.o
 obj-$(CONFIG_TOUCHSCREEN_CY8CTMG110)	+= cy8ctmg110_ts.o
 obj-$(CONFIG_TOUCHSCREEN_CYTTSP_CORE)	+= cyttsp_core.o
diff --git a/drivers/input/touchscreen/bu21029_ts.c b/drivers/input/touchscreen/bu21029_ts.c
new file mode 100644
index 0000000..5a72671
--- /dev/null
+++ b/drivers/input/touchscreen/bu21029_ts.c
@@ -0,0 +1,474 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Rohm BU21029 touchscreen controller driver
+ *
+ * Copyright (C) 2015-2018 Bosch Sicherheitssysteme GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/input/touchscreen.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/timer.h>
+
+/*
+ * HW_ID1 Register (PAGE=0, ADDR=0x0E, Reset value=0x02, Read only)
+ * +--------+--------+--------+--------+--------+--------+--------+--------+
+ * |   D7   |   D6   |   D5   |   D4   |   D3   |   D2   |   D1   |   D0   |
+ * +--------+--------+--------+--------+--------+--------+--------+--------+
+ * |                                 HW_IDH                                |
+ * +--------+--------+--------+--------+--------+--------+--------+--------+
+ * HW_ID2 Register (PAGE=0, ADDR=0x0F, Reset value=0x29, Read only)
+ * +--------+--------+--------+--------+--------+--------+--------+--------+
+ * |   D7   |   D6   |   D5   |   D4   |   D3   |   D2   |   D1   |   D0   |
+ * +--------+--------+--------+--------+--------+--------+--------+--------+
+ * |                                 HW_IDL                                |
+ * +--------+--------+--------+--------+--------+--------+--------+--------+
+ * HW_IDH: high 8bits of IC's ID
+ * HW_IDL: low  8bits of IC's ID
+ */
+#define BU21029_HWID_REG (0x0E << 3)
+#define SUPPORTED_HWID    0x0229
+
+/*
+ * CFR0 Register (PAGE=0, ADDR=0x00, Reset value=0x20)
+ * +--------+--------+--------+--------+--------+--------+--------+--------+
+ * |   D7   |   D6   |   D5   |   D4   |   D3   |   D2   |   D1   |   D0   |
+ * +--------+--------+--------+--------+--------+--------+--------+--------+
+ * |   0    |   0    |  CALIB |  INTRM |   0    |   0    |   0    |   0    |
+ * +--------+--------+--------+--------+--------+--------+--------+--------+
+ * CALIB: 0 = not to use calibration result (*)
+ *        1 = use calibration result
+ * INTRM: 0 = INT output depend on "pen down" (*)
+ *        1 = INT output always "0"
+ */
+#define BU21029_CFR0_REG (0x00 << 3)
+#define CFR0_VALUE        0x00
+
+/*
+ * CFR1 Register (PAGE=0, ADDR=0x01, Reset value=0xA6)
+ * +--------+--------+--------+--------+--------+--------+--------+--------+
+ * |   D7   |   D6   |   D5   |   D4   |   D3   |   D2   |   D1   |   D0   |
+ * +--------+--------+--------+--------+--------+--------+--------+--------+
+ * |  MAV   |         AVE[2:0]         |   0    |         SMPL[2:0]        |
+ * +--------+--------+--------+--------+--------+--------+--------+--------+
+ * MAV:  0 = median average filter off
+ *       1 = median average filter on (*)
+ * AVE:  AVE+1 = number of average samples for MAV,
+ *               if AVE>SMPL, then AVE=SMPL (=3)
+ * SMPL: SMPL+1 = number of conversion samples for MAV (=7)
+ */
+#define BU21029_CFR1_REG (0x01 << 3)
+#define CFR1_VALUE        0xA6
+
+/*
+ * CFR2 Register (PAGE=0, ADDR=0x02, Reset value=0x04)
+ * +--------+--------+--------+--------+--------+--------+--------+--------+
+ * |   D7   |   D6   |   D5   |   D4   |   D3   |   D2   |   D1   |   D0   |
+ * +--------+--------+--------+--------+--------+--------+--------+--------+
+ * |          INTVL_TIME[3:0]          |          TIME_ST_ADC[3:0]         |
+ * +--------+--------+--------+--------+--------+--------+--------+--------+
+ * INTVL_TIME: waiting time between completion of conversion
+ *             and start of next conversion, only usable in
+ *             autoscan mode (=20.480ms)
+ * TIME_ST_ADC: waiting time between application of voltage
+ *              to panel and start of A/D conversion (=100us)
+ */
+#define BU21029_CFR2_REG (0x02 << 3)
+#define CFR2_VALUE        0xC9
+
+/*
+ * CFR3 Register (PAGE=0, ADDR=0x0B, Reset value=0x72)
+ * +--------+--------+--------+--------+--------+--------+--------+--------+
+ * |   D7   |   D6   |   D5   |   D4   |   D3   |   D2   |   D1   |   D0   |
+ * +--------+--------+--------+--------+--------+--------+--------+--------+
+ * |  RM8   | STRETCH|  PU90K |  DUAL  |           PIDAC_OFS[3:0]          |
+ * +--------+--------+--------+--------+--------+--------+--------+--------+
+ * RM8: 0 = coordinate resolution is 12bit (*)
+ *      1 = coordinate resolution is 8bit
+ * STRETCH: 0 = SCL_STRETCH function off
+ *          1 = SCL_STRETCH function on (*)
+ * PU90K: 0 = internal pull-up resistance for touch detection is ~50kohms (*)
+ *        1 = internal pull-up resistance for touch detection is ~90kohms
+ * DUAL: 0 = dual touch detection off (*)
+ *       1 = dual touch detection on
+ * PIDAC_OFS: dual touch detection circuit adjustment, it is not necessary
+ *            to change this from initial value
+ */
+#define BU21029_CFR3_REG (0x0B << 3)
+#define CFR3_VALUE        0x42
+
+/*
+ * LDO Register (PAGE=0, ADDR=0x0C, Reset value=0x00)
+ * +--------+--------+--------+--------+--------+--------+--------+--------+
+ * |   D7   |   D6   |   D5   |   D4   |   D3   |   D2   |   D1   |   D0   |
+ * +--------+--------+--------+--------+--------+--------+--------+--------+
+ * |   0    |         PVDD[2:0]        |   0    |         AVDD[2:0]        |
+ * +--------+--------+--------+--------+--------+--------+--------+--------+
+ * PVDD: output voltage of panel output regulator (=2.000V)
+ * AVDD: output voltage of analog circuit regulator (=2.000V)
+ */
+#define BU21029_LDO_REG  (0x0C << 3)
+#define LDO_VALUE         0x77
+
+/*
+ * Serial Interface Command Byte 1 (CID=1)
+ * +--------+--------+--------+--------+--------+--------+--------+--------+
+ * |   D7   |   D6   |   D5   |   D4   |   D3   |   D2   |   D1   |   D0   |
+ * +--------+--------+--------+--------+--------+--------+--------+--------+
+ * |   1    |                 CF                |  CMSK  |  PDM   |  STP   |
+ * +--------+--------+--------+--------+--------+--------+--------+--------+
+ * CF: conversion function, see table 3 in datasheet p6 (=0000, automatic scan)
+ * CMSK: 0 = executes convert function (*)
+ *       1 = reads the convert result
+ * PDM: 0 = power down after convert function stops (*)
+ *      1 = keep power on after convert function stops
+ * STP: 1 = abort current conversion and power down, set to "0" automatically
+ */
+#define BU21029_AUTOSCAN  0x80
+
+/*
+ * The timeout value needs to be larger than INTVL_TIME + tConv4 (sample and
+ * conversion time), where tConv4 is calculated by formula:
+ * tPON + tDLY1 + (tTIME_ST_ADC + (tADC * tSMPL) * 2 + tDLY2) * 3
+ * see figure 8 in datasheet p15 for details of each field.
+ */
+#define PEN_UP_TIMEOUT msecs_to_jiffies(50)
+
+#define STOP_DELAY_MIN_US 50
+#define STOP_DELAY_MAX_US 1000
+#define START_DELAY_MS    2
+#define BUF_LEN           8
+#define SCALE_12BIT       (1 << 12)
+#define MAX_12BIT         ((1 << 12) - 1)
+#define DRIVER_NAME       "bu21029"
+
+struct bu21029_ts_data {
+	struct i2c_client            *client;
+	struct input_dev             *in_dev;
+	struct timer_list             timer;
+	struct gpio_desc             *reset_gpios;
+	u32                           x_plate_ohms;
+	struct touchscreen_properties prop;
+};
+
+static int bu21029_touch_report(struct bu21029_ts_data *bu21029)
+{
+	struct i2c_client *i2c = bu21029->client;
+	u8 buf[BUF_LEN];
+	u16 x, y, z1, z2;
+	u32 rz;
+	s32 max_pressure = bu21029->in_dev->absinfo[ABS_PRESSURE].maximum;
+
+	/* read touch data and deassert INT (by restarting the autoscan mode) */
+	int error = i2c_smbus_read_i2c_block_data(i2c,
+						  BU21029_AUTOSCAN,
+						  BUF_LEN,
+						  buf);
+	if (error < 0)
+		return error;
+
+	/*
+	 * compose upper 8 and lower 4 bits into a 12bit value:
+	 * +---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
+	 * |            ByteH              |            ByteL              |
+	 * +---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
+	 * |b07|b06|b05|b04|b03|b02|b01|b00|b07|b06|b05|b04|b03|b02|b01|b00|
+	 * +---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
+	 * |v11|v10|v09|v08|v07|v06|v05|v04|v03|v02|v01|v00| 0 | 0 | 0 | 0 |
+	 * +---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
+	 */
+	x  = (buf[0] << 4) | (buf[1] >> 4);
+	y  = (buf[2] << 4) | (buf[3] >> 4);
+	z1 = (buf[4] << 4) | (buf[5] >> 4);
+	z2 = (buf[6] << 4) | (buf[7] >> 4);
+
+	if (z1 == 0 || z2 == 0)
+		return 0;
+
+	/*
+	 * calculate Rz (pressure resistance value) by equation:
+	 * Rz = Rx * (x/Q) * ((z2/z1) - 1), where
+	 * Rx is x-plate resistance,
+	 * Q  is the touch screen resolution (8bit = 256, 12bit = 4096)
+	 * x, z1, z2 are the measured positions.
+	 */
+	rz  = z2 - z1;
+	rz *= x;
+	rz *= bu21029->x_plate_ohms;
+	rz /= z1;
+	rz  = DIV_ROUND_CLOSEST(rz, SCALE_12BIT);
+	if (rz <= max_pressure) {
+		touchscreen_report_pos(bu21029->in_dev, &bu21029->prop,
+				       x, y, false);
+		input_report_abs(bu21029->in_dev, ABS_PRESSURE,
+				 max_pressure - rz);
+		input_report_key(bu21029->in_dev, BTN_TOUCH, 1);
+		input_sync(bu21029->in_dev);
+	}
+
+	return 0;
+}
+
+static void bu21029_touch_release(struct timer_list *t)
+{
+	struct bu21029_ts_data *bu21029 = from_timer(bu21029, t, timer);
+
+	input_report_abs(bu21029->in_dev, ABS_PRESSURE, 0);
+	input_report_key(bu21029->in_dev, BTN_TOUCH, 0);
+	input_sync(bu21029->in_dev);
+}
+
+static irqreturn_t bu21029_touch_soft_irq(int irq, void *data)
+{
+	struct bu21029_ts_data *bu21029 = data;
+
+	/*
+	 * report touch and deassert interrupt (will assert again after
+	 * INTVL_TIME + tConv4 for continuous touch)
+	 */
+	int error = bu21029_touch_report(bu21029);
+
+	if (error)
+		return IRQ_NONE;
+
+	/* reset timer for pen up detection */
+	mod_timer(&bu21029->timer, jiffies + PEN_UP_TIMEOUT);
+
+	return IRQ_HANDLED;
+}
+
+static void bu21029_stop_chip(struct input_dev *dev)
+{
+	struct bu21029_ts_data *bu21029 = input_get_drvdata(dev);
+
+	disable_irq(bu21029->client->irq);
+	del_timer_sync(&bu21029->timer);
+
+	/* put chip into reset */
+	gpiod_set_value_cansleep(bu21029->reset_gpios, 1);
+	usleep_range(STOP_DELAY_MIN_US, STOP_DELAY_MAX_US);
+}
+
+static int bu21029_start_chip(struct input_dev *dev)
+{
+	struct bu21029_ts_data *bu21029 = input_get_drvdata(dev);
+	struct i2c_client *i2c = bu21029->client;
+	struct {
+		u8 reg;
+		u8 value;
+	} init_table[] = {
+		{BU21029_CFR0_REG, CFR0_VALUE},
+		{BU21029_CFR1_REG, CFR1_VALUE},
+		{BU21029_CFR2_REG, CFR2_VALUE},
+		{BU21029_CFR3_REG, CFR3_VALUE},
+		{BU21029_LDO_REG,  LDO_VALUE}
+	};
+	int error, i;
+	__be16 hwid;
+
+	/* take chip out of reset */
+	gpiod_set_value_cansleep(bu21029->reset_gpios, 0);
+	msleep(START_DELAY_MS);
+
+	error = i2c_smbus_read_i2c_block_data(i2c,
+					      BU21029_HWID_REG,
+					      2,
+					      (u8 *)&hwid);
+	if (error < 0) {
+		dev_err(&i2c->dev, "failed to read HW ID\n");
+		goto out;
+	}
+
+	if (be16_to_cpu(hwid) != SUPPORTED_HWID) {
+		dev_err(&i2c->dev, "unsupported HW ID 0x%x\n", hwid);
+		error = -ENODEV;
+		goto out;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(init_table); ++i) {
+		error = i2c_smbus_write_byte_data(i2c,
+						  init_table[i].reg,
+						  init_table[i].value);
+		if (error < 0) {
+			dev_err(&i2c->dev,
+				"failed to write 0x%x to register 0x%x\n",
+				init_table[i].value,
+				init_table[i].reg);
+			goto out;
+		}
+	}
+
+	error = i2c_smbus_write_byte(i2c, BU21029_AUTOSCAN);
+	if (error < 0) {
+		dev_err(&i2c->dev, "failed to start autoscan\n");
+		goto out;
+	}
+
+	enable_irq(bu21029->client->irq);
+	return 0;
+
+out:
+	bu21029_stop_chip(dev);
+	return error;
+}
+
+static int bu21029_parse_dt(struct bu21029_ts_data *bu21029)
+{
+	struct device *dev = &bu21029->client->dev;
+	int error;
+
+	bu21029->reset_gpios = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(bu21029->reset_gpios)) {
+		error = PTR_ERR(bu21029->reset_gpios);
+		if (error != -EPROBE_DEFER)
+			dev_err(dev, "invalid 'reset-gpios':%d\n", error);
+		return error;
+	}
+
+	error = device_property_read_u32(dev, "rohm,x-plate-ohms",
+					 &bu21029->x_plate_ohms);
+	if (error) {
+		dev_err(dev, "invalid 'x-plate-ohms' supplied:%d\n", error);
+		return error;
+	}
+
+	touchscreen_parse_properties(bu21029->in_dev, false, &bu21029->prop);
+
+	return 0;
+}
+
+static int bu21029_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct bu21029_ts_data *bu21029;
+	struct input_dev *in_dev;
+	int error;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_WRITE_BYTE |
+				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
+				     I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
+		dev_err(&client->dev,
+			"i2c functionality support is not sufficient\n");
+		return -EIO;
+	}
+
+	bu21029 = devm_kzalloc(&client->dev, sizeof(*bu21029), GFP_KERNEL);
+	if (!bu21029)
+		return -ENOMEM;
+
+	in_dev = devm_input_allocate_device(&client->dev);
+	if (!in_dev) {
+		dev_err(&client->dev, "unable to allocate input device\n");
+		return -ENOMEM;
+	}
+
+	bu21029->client = client;
+	bu21029->in_dev	= in_dev;
+	timer_setup(&bu21029->timer, bu21029_touch_release, 0);
+
+	in_dev->name       = DRIVER_NAME;
+	in_dev->id.bustype = BUS_I2C;
+	in_dev->open       = bu21029_start_chip;
+	in_dev->close      = bu21029_stop_chip;
+
+	input_set_capability(in_dev, EV_KEY, BTN_TOUCH);
+	input_set_abs_params(in_dev, ABS_X, 0, MAX_12BIT, 0, 0);
+	input_set_abs_params(in_dev, ABS_Y, 0, MAX_12BIT, 0, 0);
+	input_set_abs_params(in_dev, ABS_PRESSURE, 0, MAX_12BIT, 0, 0);
+
+	error = bu21029_parse_dt(bu21029);
+	if (error)
+		return error;
+
+	input_set_drvdata(in_dev, bu21029);
+
+	error = devm_request_threaded_irq(&client->dev,
+					  client->irq,
+					  NULL,
+					  bu21029_touch_soft_irq,
+					  IRQF_ONESHOT,
+					  DRIVER_NAME,
+					  bu21029);
+	if (error) {
+		dev_err(&client->dev, "unable to request touch irq\n");
+		return error;
+	}
+
+	bu21029_stop_chip(in_dev);
+
+	error = input_register_device(in_dev);
+	if (error) {
+		dev_err(&client->dev, "unable to register input device\n");
+		return error;
+	}
+
+	i2c_set_clientdata(client, bu21029);
+
+	return 0;
+}
+
+static int bu21029_remove(struct i2c_client *client)
+{
+	struct bu21029_ts_data *bu21029 = i2c_get_clientdata(client);
+
+	bu21029_stop_chip(bu21029->in_dev);
+
+	return 0;
+}
+
+static int __maybe_unused bu21029_suspend(struct device *dev)
+{
+	struct i2c_client *i2c = to_i2c_client(dev);
+	struct bu21029_ts_data *bu21029 = i2c_get_clientdata(i2c);
+
+	mutex_lock(&bu21029->in_dev->mutex);
+	if (bu21029->in_dev->users)
+		bu21029_stop_chip(bu21029->in_dev);
+	mutex_unlock(&bu21029->in_dev->mutex);
+
+	return 0;
+}
+
+static int __maybe_unused bu21029_resume(struct device *dev)
+{
+	struct i2c_client *i2c = to_i2c_client(dev);
+	struct bu21029_ts_data *bu21029 = i2c_get_clientdata(i2c);
+
+	mutex_lock(&bu21029->in_dev->mutex);
+	if (bu21029->in_dev->users)
+		bu21029_start_chip(bu21029->in_dev);
+	mutex_unlock(&bu21029->in_dev->mutex);
+
+	return 0;
+}
+static SIMPLE_DEV_PM_OPS(bu21029_pm_ops, bu21029_suspend, bu21029_resume);
+
+static const struct i2c_device_id bu21029_ids[] = {
+	{DRIVER_NAME, 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, bu21029_ids);
+
+static struct i2c_driver bu21029_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.pm   = &bu21029_pm_ops,
+	},
+	.id_table = bu21029_ids,
+	.probe    = bu21029_probe,
+	.remove   = bu21029_remove,
+};
+module_i2c_driver(bu21029_driver);
+
+MODULE_AUTHOR("Zhu Yi <yi.zhu5@cn.bosch.com>");
+MODULE_DESCRIPTION("Rohm BU21029 touchscreen controller driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
