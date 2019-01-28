Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D215C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 05:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CF820989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 05:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfA1F6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 00:58:00 -0500
Received: from hermes.aosc.io ([199.195.250.187]:41100 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfA1F6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 00:58:00 -0500
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 6345919D11F;
        Mon, 28 Jan 2019 05:57:56 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH] USB: serial: cp210x: add GPIO support for CP2104
Date:   Mon, 28 Jan 2019 13:57:17 +0800
Message-Id: <20190128055717.31162-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CP2104 chips feature 4 controllable GPIO pins, which are similar to
the ones on CP2102N chip (output-only when push-pull, output or
simulated input mode when open-drain).

Add support for the GPIO pins for cp210x driver. The pin get/set routine
is shared with CP2102N, but the pinconf initialization code is not
shared because the acquisition of GPIO configuration in OTP ROM is
similar to CP2105, not CP2102N.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/usb/serial/cp210x.c | 82 +++++++++++++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index c0777a374a88..b27cf9d00aec 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -443,10 +443,10 @@ struct cp210x_pin_mode {
 #define CP210X_PIN_MODE_GPIO		BIT(0)
 
 /*
- * CP210X_VENDOR_SPECIFIC, CP210X_GET_PORTCONFIG call reads these 0xf bytes.
- * Structure needs padding due to unused/unspecified bytes.
+ * CP210X_VENDOR_SPECIFIC, CP210X_GET_PORTCONFIG call reads these 0xf bytes
+ * on a CP2105 chip. Structure needs padding due to unused/unspecified bytes.
  */
-struct cp210x_config {
+struct cp210x_dual_port_config {
 	__le16	gpio_mode;
 	u8	__pad0[2];
 	__le16	reset_state;
@@ -457,6 +457,19 @@ struct cp210x_config {
 	u8	device_cfg;
 } __packed;
 
+/*
+ * CP210X_VENDOR_SPECIFIC, CP210X_GET_PORTCONFIG call reads these 0xd bytes
+ * on a CP2104 chip. Structure needs padding due to unused/unspecified bytes.
+ */
+struct cp210x_single_port_config {
+	__le16	gpio_mode;
+	u8	__pad0[2];
+	__le16	reset_state;
+	u8	__pad1[4];
+	__le16	suspend_state;
+	u8	device_cfg;
+} __packed;
+
 /* GPIO modes */
 #define CP210X_SCI_GPIO_MODE_OFFSET	9
 #define CP210X_SCI_GPIO_MODE_MASK	GENMASK(11, 9)
@@ -464,11 +477,19 @@ struct cp210x_config {
 #define CP210X_ECI_GPIO_MODE_OFFSET	2
 #define CP210X_ECI_GPIO_MODE_MASK	GENMASK(3, 2)
 
+#define CP210X_GPIO_MODE_OFFSET		8
+#define CP210X_GPIO_MODE_MASK		GENMASK(11, 8)
+
 /* CP2105 port configuration values */
 #define CP2105_GPIO0_TXLED_MODE		BIT(0)
 #define CP2105_GPIO1_RXLED_MODE		BIT(1)
 #define CP2105_GPIO1_RS485_MODE		BIT(2)
 
+/* CP2104 port configuration values */
+#define CP2104_GPIO0_TXLED_MODE		BIT(0)
+#define CP2104_GPIO1_RXLED_MODE		BIT(1)
+#define CP2104_GPIO2_RS485_MODE		BIT(2)
+
 /* CP2102N configuration array indices */
 #define CP210X_2NCONFIG_CONFIG_VERSION_IDX	2
 #define CP210X_2NCONFIG_GPIO_MODE_IDX		581
@@ -1470,7 +1491,7 @@ static int cp2105_gpioconf_init(struct usb_serial *serial)
 {
 	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
 	struct cp210x_pin_mode mode;
-	struct cp210x_config config;
+	struct cp210x_dual_port_config config;
 	u8 intf_num = cp210x_interface_num(serial);
 	u8 iface_config;
 	int result;
@@ -1529,6 +1550,56 @@ static int cp2105_gpioconf_init(struct usb_serial *serial)
 	return 0;
 }
 
+static int cp2104_gpioconf_init(struct usb_serial *serial)
+{
+	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
+	struct cp210x_single_port_config config;
+	u8 iface_config;
+	u8 gpio_latch;
+	int result;
+	u8 i;
+
+	result = cp210x_read_vendor_block(serial, REQTYPE_DEVICE_TO_HOST,
+					  CP210X_GET_PORTCONFIG, &config,
+					  sizeof(config));
+	if (result < 0)
+		return result;
+
+	priv->gc.ngpio = 4;
+
+	iface_config = config.device_cfg;
+	priv->gpio_pushpull = (u8)((le16_to_cpu(config.gpio_mode) &
+					CP210X_GPIO_MODE_MASK) >>
+					CP210X_GPIO_MODE_OFFSET);
+	gpio_latch = (u8)((le16_to_cpu(config.reset_state) &
+					CP210X_GPIO_MODE_MASK) >>
+					CP210X_GPIO_MODE_OFFSET);
+
+	/* mark all pins which are not in GPIO mode */
+	if (iface_config & CP2104_GPIO0_TXLED_MODE)	/* GPIO 0 */
+		priv->gpio_altfunc |= BIT(0);
+	if (iface_config & CP2104_GPIO1_RXLED_MODE)	/* GPIO 1 */
+		priv->gpio_altfunc |= BIT(1);
+	if (iface_config & CP2104_GPIO2_RS485_MODE)	/* GPIO 2 */
+		priv->gpio_altfunc |= BIT(2);
+
+	/*
+	 * Like CP2102N, CP2104 has also no strict input and output pin
+	 * modes.
+	 * Do the same input mode emulation as CP2102N.
+	 */
+	for (i = 0; i < priv->gc.ngpio; ++i) {
+		/*
+		 * Set direction to "input" iff pin is open-drain and reset
+		 * value is 1.
+		 */
+		if (!(priv->gpio_pushpull & BIT(i)) && (gpio_latch & BIT(i)))
+			priv->gpio_input |= BIT(i);
+	}
+
+	return 0;
+}
+
 static int cp2102n_gpioconf_init(struct usb_serial *serial)
 {
 	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
@@ -1620,6 +1691,9 @@ static int cp210x_gpio_init(struct usb_serial *serial)
 	int result;
 
 	switch (priv->partnum) {
+	case CP210X_PARTNUM_CP2104:
+		result = cp2104_gpioconf_init(serial);
+		break;
 	case CP210X_PARTNUM_CP2105:
 		result = cp2105_gpioconf_init(serial);
 		break;
-- 
2.18.1

