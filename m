Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7BEC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 18:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43DE1208B6
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 18:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pados.hu header.i=@pados.hu header.b="D517BRNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43DE1208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=pados.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934154AbeFQSZO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 14:25:14 -0400
Received: from erza.pados.hu ([176.9.136.194]:40756 "EHLO erza.pados.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933374AbeFQSZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 14:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pados.hu;
         s=february2016; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3ccTSkA5dtw9wZx91hs+/Mo7onP5vDIKIAxeeTWrYQ0=; b=D517BRNMpBpYQeE4ST+dPqdV0u
        qS9AY9kMHMPzUzbuIXZ7eE+xugjG/YHSIZE2KbZiqRdaVDTmViju7suIbf4ikk3M/uX4kSrGAe85a
        iSVjBszu+wQN99yB76dWsD2Mb2jaMuGu+Kt+bE3ejv4eZVtnVGjwwe1XAYyStSJvMPR4BfWXDDvPR
        2UMq8jphO5hOS6csp5KFUvvT8LXJTS4L1CxoKvEzQP1k2HdDgp7yCr3phtCJa0Z+R6UoISi6ZBeaB
        M8VbVcX9qwQCdG5qThKivxuJtEf9csyl+UsfkeQg6VaH+74coo+ncPMIUK1n2P85GM2H0Ud2PZ2LM
        Np6w+bmg==;
Received: from 4f7a7acb.dsl.pool.telekom.hu ([79.122.122.203] helo=localhost)
        by erza with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <pados@pados.hu>)
        id 1fUcMO-0005Dv-Bh; Sun, 17 Jun 2018 20:25:09 +0200
From:   Karoly Pados <pados@pados.hu>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Karoly Pados <pados@pados.hu>
Subject: [PATCH] USB: serial: cp210x: Implement GPIO support for CP2102N
Date:   Sun, 17 Jun 2018 20:25:03 +0200
Message-Id: <20180617182503.23080-1-pados@pados.hu>
X-Mailer: git-send-email 2.17.1
X-Spam_score: -2.9
X-Spam_report: Spam detection software, running on the system "erza",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Pretty much what the title says. No other functions/devices
    touched. Tested on CP2102N-QFN28. Limitation: Even though the QFN28 package
    has 7 GPIOs, this patch allows to control only the first 4. What I've found
    using reverse engineering regarding the other 3 pins collides both with reality
    and with other documented functions, so I did not dare to just use my findings
    because I cannot test on other packages. Instead, I decided to play it safe
    and only support 4 GPIOs. [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
  0.0 URIBL_BLOCKED          ADMINISTRATOR NOTICE: The query to URIBL was blocked.
                             See
                             http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
                              for more information.
                             [URIs: silabs.com]
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pretty much what the title says. No other functions/devices
touched. Tested on CP2102N-QFN28.

Limitation: Even though the QFN28 package has 7 GPIOs,
this patch allows to control only the first 4.
What I've found using reverse engineering regarding the
other 3 pins collides both with reality and with other
documented functions, so I did not dare to just use my
findings because I cannot test on other packages.
Instead, I decided to play it safe and only support 4 GPIOs.

Signed-off-by: Karoly Pados <pados@pados.hu>
---
 drivers/usb/serial/cp210x.c | 259 +++++++++++++++++++++++++++++++++++-
 1 file changed, 257 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 793b86252c46..adb450185ce8 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -6,7 +6,8 @@
  *
  * Support to set flow control line levels using TIOCMGET and TIOCMSET
  * thanks to Karl Hiramoto karl@hiramoto.org. RTSCTS hardware flow
- * control thanks to Munir Nassar nassarmu@real-time.com
+ * control thanks to Munir Nassar nassarmu@real-time.com.
+ * GPIO support for CP2102N thanks to Karoly Pados.
  *
  */
 
@@ -229,11 +230,16 @@ struct cp210x_serial_private {
 	struct gpio_chip	gc;
 	u8			config;
 	u8			gpio_mode;
+	u8			gpio_control;
+	u8			gpio_dir;
 	bool			gpio_registered;
 #endif
 	u8			partnum;
 };
 
+#define CP2102N_PIN_OPENDRAIN(var, pin)	(!((var) & BIT(pin)))
+#define CP2102N_PIN_GPIO(var, pin)	(!((var) & BIT(pin)))
+
 struct cp210x_port_private {
 	__u8			bInterfaceNumber;
 	bool			has_swapped_line_ctl;
@@ -349,6 +355,7 @@ static struct usb_serial_driver * const serial_drivers[] = {
 #define CP210X_GET_PORTCONFIG	0x370C
 #define CP210X_GET_DEVICEMODE	0x3711
 #define CP210X_WRITE_LATCH	0x37E1
+#define CP210X_READ_2NCONFIG	0x000E
 
 /* Part number definitions */
 #define CP210X_PARTNUM_CP2101	0x01
@@ -362,6 +369,14 @@ static struct usb_serial_driver * const serial_drivers[] = {
 #define CP210X_PARTNUM_CP2102N_QFN20	0x22
 #define CP210X_PARTNUM_UNKNOWN	0xFF
 
+#define	IS_CP2102N(partnum)   (((partnum) == CP210X_PARTNUM_CP2102N_QFN28) || \
+			       ((partnum) == CP210X_PARTNUM_CP2102N_QFN24) || \
+			       ((partnum) == CP210X_PARTNUM_CP2102N_QFN20))
+
+#define CP210X_2NCONFIG_GPIO_CONTROL_IDX	600
+#define CP210X_2NCONFIG_GPIO_MODE_IDX		581
+#define CP210X_2NCONFIG_GPIO_RSTLATCH_IDX	587
+
 /* CP210X_GET_COMM_STATUS returns these 0x13 bytes */
 struct cp210x_comm_status {
 	__le32   ulErrors;
@@ -1455,6 +1470,235 @@ static void cp210x_gpio_remove(struct usb_serial *serial)
 	}
 }
 
+static int cp2102n_gpio_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct usb_serial *serial = gpiochip_get_data(gc);
+	int result;
+	u8 buf;
+
+	result = cp210x_read_vendor_block(serial, REQTYPE_DEVICE_TO_HOST,
+					  CP210X_READ_LATCH, &buf, sizeof(buf));
+	if (result < 0)
+		return result;
+
+	return !!(buf & BIT(gpio));
+}
+
+static void cp2102n_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
+{
+	int result;
+	struct cp210x_gpio_write buf;
+	struct usb_serial *serial = gpiochip_get_data(gc);
+	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
+
+	/* Ignore request if pin is not in our control */
+	if (!CP2102N_PIN_GPIO(priv->gpio_control, gpio)) {
+		dev_warn(&serial->interface->dev,
+			 "Cannot control GPIO with active alternate function.\n");
+		return;
+	}
+
+	buf.state = (value == 1) ? BIT(gpio) : 0;
+	buf.mask = BIT(gpio);
+
+	result = usb_control_msg(serial->dev,
+				 usb_sndctrlpipe(serial->dev, 0),
+				 CP210X_VENDOR_SPECIFIC,
+				 REQTYPE_HOST_TO_DEVICE,
+				 CP210X_WRITE_LATCH,
+				 *(u16 *)&buf,
+				 NULL, 0, USB_CTRL_SET_TIMEOUT);
+
+	if (result < 0) {
+		dev_err(&serial->interface->dev,
+			"Failed to set GPIO value.\n");
+	}
+}
+
+static int cp2102n_gpio_direction_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct usb_serial *serial = gpiochip_get_data(gc);
+	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
+
+	return priv->gpio_dir & BIT(gpio);
+}
+
+static int cp2102n_gpio_direction_input(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct usb_serial *serial = gpiochip_get_data(gc);
+	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
+
+	/* Return an error if pin is not in our control */
+	if (!CP2102N_PIN_GPIO(priv->gpio_control, gpio)) {
+		dev_warn(&serial->interface->dev,
+			 "Cannot control GPIO with active alternate function.\n");
+		return -EPERM;
+	}
+
+	/* Push-pull pins cannot be changed to be inputs */
+	if (!CP2102N_PIN_OPENDRAIN(priv->gpio_mode, gpio)) {
+		dev_warn(&serial->interface->dev,
+			 "Cannot change direction of a push-pull GPIO to input.\n");
+		return -EPERM;
+	}
+
+	/* Make sure to release pin if it is being driven low */
+	cp2102n_gpio_set(gc, gpio, 1);
+
+	/* Note pin direction to ourselves */
+	priv->gpio_dir |= BIT(gpio);
+
+	return 0;
+}
+
+static int cp2102n_gpio_direction_output(struct gpio_chip *gc,
+					 unsigned int gpio,
+					 int value)
+{
+	struct usb_serial *serial = gpiochip_get_data(gc);
+	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
+
+	/* Return an error if pin is not in our control */
+	if (!CP2102N_PIN_GPIO(priv->gpio_control, gpio)) {
+		dev_warn(&serial->interface->dev,
+			 "Cannot control GPIO with active alternate function.\n");
+		return -EPERM;
+	}
+
+	/* Note pin direction to ourselves */
+	priv->gpio_dir &= ~BIT(gpio);
+
+	/* Set requested initial output value */
+	cp2102n_gpio_set(gc, gpio, value);
+
+	return 0;
+}
+
+static u16 fletcher16(u8 *data, u16 bytes)
+{
+	u16 sum1 = 0xff, sum2 = 0xff;
+	u16 tlen;
+
+	while (bytes) {
+		tlen = bytes >= 20 ? 20 : bytes;
+		bytes -= tlen;
+		do {
+			sum2 += sum1 += *data++;
+		} while (--tlen);
+		sum1 = (sum1 & 0xff) + (sum1 >> 8);
+		sum2 = (sum2 & 0xff) + (sum2 >> 8);
+	}
+	/* Second reduction step to reduce sums to 8 bits */
+	sum1 = (sum1 & 0xff) + (sum1 >> 8);
+	sum2 = (sum2 & 0xff) + (sum2 >> 8);
+	return sum2 << 8 | sum1;
+}
+
+static int cp2102n_gpio_init(struct usb_serial *serial)
+{
+	const u16 CONFIG_SIZE = 0x02A6;
+	int result;
+	u16 config_csum;
+	u8 *config_buf;
+	u8 gpio_ctrl;
+	u8 gpio_mode;
+	u8 gpio_latch;
+	u8 gpio_rst_latch;
+	u8 i;
+	bool config_valid = true;
+	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
+
+	/* Retrieve device configuration from the device.
+	 * The array received contains all customization settings
+	 * done at the factory/manufacturer.
+	 * Format of the array is documented at the time of writing at
+	 * https://www.silabs.com/community/interface/knowledge-base.entry.html/2017/03/31/cp2102n_setconfig-xsfa
+	 */
+	config_buf = kmalloc(CONFIG_SIZE, GFP_KERNEL);
+	if (!config_buf)
+		return -ENOMEM;
+
+	result = cp210x_read_vendor_block(serial,
+					  REQTYPE_DEVICE_TO_HOST,
+					  CP210X_READ_2NCONFIG,
+					  config_buf,
+					  CONFIG_SIZE);
+	if (result < 0)
+		return result;
+
+	/* Check configuration for validity.
+	 * The last two bytes of the array contain a fletcher16
+	 * checksum of all the bytes before, which we can validate.
+	 */
+	config_csum = fletcher16(config_buf, CONFIG_SIZE - 2);
+	if (((config_csum & 0xFF) != config_buf[CONFIG_SIZE - 1]) ||
+	    ((config_csum >> 8)   != config_buf[CONFIG_SIZE - 2])) {
+		config_valid = false;
+		dev_err(&serial->interface->dev,
+			"Corrupted device configuration received\n");
+	}
+
+	gpio_mode = config_buf[CP210X_2NCONFIG_GPIO_MODE_IDX];
+	gpio_ctrl = config_buf[CP210X_2NCONFIG_GPIO_CONTROL_IDX];
+	gpio_rst_latch = config_buf[CP210X_2NCONFIG_GPIO_RSTLATCH_IDX];
+
+	kfree(config_buf);
+
+	if (!config_valid)
+		return -EIO;
+
+	/* We only support 4 GPIOs even on the QFN28 package because
+	 * documentation about the CP2102N GetConfig Array
+	 * does not seem to correspond to reality on this device.
+	 */
+	priv->gc.ngpio = 4;
+
+	/* Get default pin states after reset. Needed so we can determine
+	 * the direction of an open-drain pin.
+	 */
+	gpio_latch = (gpio_rst_latch >> 3) & 0x0F;
+
+	/* 0 indicates open-drain mode, 1 is push-pull */
+	priv->gpio_mode = (gpio_mode >> 3) & 0x0F;
+
+	/* 0 indicates GPIO mode, 1 is alternate function */
+	priv->gpio_control = (gpio_ctrl >> 2) & 0x0F;
+
+	/* The CP2102N does not strictly has input and output pin modes,
+	 * it only knows open-drain and push-pull modes which is set at
+	 * factory. An open-drain pin can function both as an
+	 * input or an output. We emulate input mode for open-drain pins
+	 * by making sure they are not driven low, and we do not allow
+	 * push-pull pins to be set as an input.
+	 */
+	for (i = 0; i < priv->gc.ngpio; ++i) {
+		/* Set direction to "input" iff
+		 * pin is open-drain and reset value is 1
+		 */
+		if (CP2102N_PIN_OPENDRAIN(priv->gpio_mode, i) &&
+		    (gpio_latch & BIT(i))) {
+			priv->gpio_dir |= BIT(i);
+		}
+	}
+
+	priv->gc.label = "cp2102n";
+	priv->gc.get_direction = cp2102n_gpio_direction_get;
+	priv->gc.direction_input = cp2102n_gpio_direction_input;
+	priv->gc.direction_output = cp2102n_gpio_direction_output;
+	priv->gc.get = cp2102n_gpio_get;
+	priv->gc.set = cp2102n_gpio_set;
+	priv->gc.owner = THIS_MODULE;
+	priv->gc.parent = &serial->interface->dev;
+	priv->gc.base = -1;
+	priv->gc.can_sleep = true;
+
+	result = gpiochip_add_data(&priv->gc, serial);
+	if (!result)
+		priv->gpio_registered = true;
+
+	return result;
+}
+
 #else
 
 static int cp2105_shared_gpio_init(struct usb_serial *serial)
@@ -1462,6 +1706,11 @@ static int cp2105_shared_gpio_init(struct usb_serial *serial)
 	return 0;
 }
 
+static int cp2102n_gpio_init(struct usb_serial *serial)
+{
+	return 0;
+}
+
 static void cp210x_gpio_remove(struct usb_serial *serial)
 {
 	/* Nothing to do */
@@ -1522,7 +1771,13 @@ static int cp210x_attach(struct usb_serial *serial)
 
 	usb_set_serial_data(serial, priv);
 
-	if (priv->partnum == CP210X_PARTNUM_CP2105) {
+	if (IS_CP2102N(priv->partnum)) {
+		result = cp2102n_gpio_init(serial);
+		if (result < 0) {
+			dev_err(&serial->interface->dev,
+				"GPIO initialisation failed, continuing without GPIO support\n");
+		}
+	} else if (priv->partnum == CP210X_PARTNUM_CP2105) {
 		result = cp2105_shared_gpio_init(serial);
 		if (result < 0) {
 			dev_err(&serial->interface->dev,
-- 
2.17.1

