Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CC0C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4132D205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nfz6DIa6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4132D205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeH3FrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 01:47:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34638 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbeH3FrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 01:47:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id d19-v6so3146603pgv.1;
        Wed, 29 Aug 2018 18:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pefCd/wiDF8YvelbaDuXnT91JPjUdEsdWs9c6vvOQEE=;
        b=Nfz6DIa6PDWxDq0MInbr9C1PzRs/kFtC/AvK9s56BgVfpiI5dNMxLdMrERBuDLvj9c
         CoUz/Go2FWbX4ed4X1Q+FBL2qpaVtqt+b6AwxGAyhQuTh2x6x4ZD7Sw+uNzlPubfot0v
         PONZgdHHmumzk+xn9bbrgv8lW/IJNWXGIEhXwxtFlpxEpv8as6iV2fTHAmlSpPPfIM+s
         4Utx2HBsP+fwwpoxjTczutPreonkASuj4CnQw/9BOKtT8TpuXusTIWYJY0V99hcEMBOb
         FihMVRkI92980BTmb1yj6uFlKeFousDupb/zd7SglN3HbTJP0XdoEH0NQ+rREK/yElv2
         +/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pefCd/wiDF8YvelbaDuXnT91JPjUdEsdWs9c6vvOQEE=;
        b=c3rIWDj06Anjo9lwtSXBthbUd0xSJrXLWDMymePEgKhEKCIsmmoEmJHiLXyZAMzqtG
         OvpCU3p/V3iI1OyffUeHysz8I4rD3n/tX5oXTfN8WeEEXk1acOz4u8bdmWrK+5/PAc7h
         OR3Z47b3y3KcJNNOd1UexdVNwfVZeoFSsLoPY0X0EjpF5rkFqp0f2x+4x9fF4DfKsjzr
         mZBbLCly0USFQgDhWoPVz0Lr7R12tpR6K2m7m1E0dvkD071dADA5kabkqRIrEgvoSyrX
         mUqmY/a0aNN2SXRjgxij11iGDeEl10tud9YOCugImF0oipVjJGN3Zq/aNBFNuiEJqUXi
         HaEg==
X-Gm-Message-State: APzg51BHsDDFVpFp7sc2/pga3XcGOgYFY++sNY3igx/VS839ZTvGBGLt
        KrvEzahV4UOJMcqkN0DkJPc=
X-Google-Smtp-Source: ANB0VdY6Jjcq1xH1q44h01VKzDZzsHLafcZkczOu6/m6x4C6OG4H+hk7GVG5CU4VP3t0rm0YzJdzJQ==
X-Received: by 2002:a63:10c:: with SMTP id 12-v6mr7714243pgb.62.1535593645398;
        Wed, 29 Aug 2018 18:47:25 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id d24-v6sm5947734pgv.23.2018.08.29.18.47.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 18:47:24 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        hpeter+linux_kernel@gmail.com
Subject: [PATCH V2 2/4] USB: serial: f81232: add high baud rate support
Date:   Thu, 30 Aug 2018 09:47:11 +0800
Message-Id: <1535593634-22004-3-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535593634-22004-1-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1535593634-22004-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The F81232 had 4 clocksource 1.846/18.46/14.77/24MHz and baud rates
can be up to 1.5Mbits with 24MHz.

F81232 Clock registers (106h)

Bit1-0:     Clock source selector
                    00: 1.846MHz.
                    01: 18.46MHz.
                    10: 24MHz.
                    11: 14.77MHz.

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/usb/serial/f81232.c | 105 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 94 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 2f595307dd14..56adae8a9ee0 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -28,7 +28,8 @@ static const struct usb_device_id id_table[] = {
 MODULE_DEVICE_TABLE(usb, id_table);
 
 /* Maximum baudrate for F81232 */
-#define F81232_MAX_BAUDRATE		115200
+#define F81232_MAX_BAUDRATE		1500000
+#define F81232_DEF_BAUDRATE		9600
 
 /* USB Control EP parameter */
 #define F81232_REGISTER_REQUEST		0xa0
@@ -44,18 +45,42 @@ MODULE_DEVICE_TABLE(usb, id_table);
 #define LINE_STATUS_REGISTER		(0x05 + SERIAL_BASE_ADDRESS)
 #define MODEM_STATUS_REGISTER		(0x06 + SERIAL_BASE_ADDRESS)
 
+/*
+ * F81232 Clock registers (106h)
+ *
+ * Bit1-0:	Clock source selector
+ *			00: 1.846MHz.
+ *			01: 18.46MHz.
+ *			10: 24MHz.
+ *			11: 14.77MHz.
+ */
+#define F81232_CLK_REGISTER		0x106
+#define F81232_CLK_1_846_MHZ		0
+#define F81232_CLK_18_46_MHZ		BIT(0)
+#define F81232_CLK_24_MHZ		BIT(1)
+#define F81232_CLK_14_77_MHZ		(BIT(1) | BIT(0))
+#define F81232_CLK_MASK			GENMASK(1, 0)
+
 struct f81232_private {
 	struct mutex lock;
 	u8 modem_control;
 	u8 modem_status;
+	speed_t baud_base;
 	struct work_struct lsr_work;
 	struct work_struct interrupt_work;
 	struct usb_serial_port *port;
 };
 
-static int calc_baud_divisor(speed_t baudrate)
+static u32 const baudrate_table[] = { 115200, 921600, 1152000, 1500000 };
+static u8 const clock_table[] = { F81232_CLK_1_846_MHZ, F81232_CLK_14_77_MHZ,
+				F81232_CLK_18_46_MHZ, F81232_CLK_24_MHZ };
+
+static int calc_baud_divisor(speed_t baudrate, speed_t clockrate)
 {
-	return DIV_ROUND_CLOSEST(F81232_MAX_BAUDRATE, baudrate);
+	if (!baudrate)
+		return 0;
+
+	return DIV_ROUND_CLOSEST(clockrate, baudrate);
 }
 
 static int f81232_get_register(struct usb_serial_port *port, u16 reg, u8 *val)
@@ -129,6 +154,21 @@ static int f81232_set_register(struct usb_serial_port *port, u16 reg, u8 val)
 	return status;
 }
 
+static int f81232_set_mask_register(struct usb_serial_port *port, u16 reg,
+					u8 mask, u8 val)
+{
+	int status;
+	u8 tmp;
+
+	status = f81232_get_register(port, reg, &tmp);
+	if (status)
+		return status;
+
+	tmp = (tmp & ~mask) | (val & mask);
+
+	return f81232_set_register(port, reg, tmp);
+}
+
 static void f81232_read_msr(struct usb_serial_port *port)
 {
 	int status;
@@ -346,13 +386,53 @@ static void f81232_break_ctl(struct tty_struct *tty, int break_state)
 	 */
 }
 
-static void f81232_set_baudrate(struct usb_serial_port *port, speed_t baudrate)
+static int f81232_find_clk(speed_t baudrate)
+{
+	int idx;
+
+	for (idx = 0; idx < ARRAY_SIZE(baudrate_table); ++idx) {
+		if (baudrate <= baudrate_table[idx] &&
+				baudrate_table[idx] % baudrate == 0)
+			return idx;
+	}
+
+	return -EINVAL;
+}
+
+static void f81232_set_baudrate(struct tty_struct *tty,
+				struct usb_serial_port *port, speed_t baudrate,
+				speed_t old_baudrate)
 {
+	struct f81232_private *priv = usb_get_serial_port_data(port);
 	u8 lcr;
 	int divisor;
 	int status = 0;
+	int i;
+	int idx;
+	speed_t baud_list[] = {baudrate, old_baudrate, F81232_DEF_BAUDRATE};
+
+	for (i = 0; i < ARRAY_SIZE(baud_list); ++i) {
+		idx = f81232_find_clk(baud_list[i]);
+		if (idx >= 0) {
+			baudrate = baud_list[i];
+			tty_encode_baud_rate(tty, baudrate, baudrate);
+			break;
+		}
+	}
 
-	divisor = calc_baud_divisor(baudrate);
+	if (idx < 0)
+		return;
+
+	priv->baud_base = baudrate_table[idx];
+	divisor = calc_baud_divisor(baudrate, priv->baud_base);
+
+	status = f81232_set_mask_register(port, F81232_CLK_REGISTER,
+			F81232_CLK_MASK, clock_table[idx]);
+	if (status) {
+		dev_err(&port->dev, "%s failed to set CLK_REG: %d\n",
+			__func__, status);
+		return;
+	}
 
 	status = f81232_get_register(port, LINE_CONTROL_REGISTER,
 			 &lcr); /* get LCR */
@@ -442,6 +522,7 @@ static void f81232_set_termios(struct tty_struct *tty,
 	u8 new_lcr = 0;
 	int status = 0;
 	speed_t baudrate;
+	speed_t old_baud;
 
 	/* Don't change anything if nothing has changed */
 	if (old_termios && !tty_termios_hw_change(&tty->termios, old_termios))
@@ -454,11 +535,12 @@ static void f81232_set_termios(struct tty_struct *tty,
 
 	baudrate = tty_get_baud_rate(tty);
 	if (baudrate > 0) {
-		if (baudrate > F81232_MAX_BAUDRATE) {
-			baudrate = F81232_MAX_BAUDRATE;
-			tty_encode_baud_rate(tty, baudrate, baudrate);
-		}
-		f81232_set_baudrate(port, baudrate);
+		if (old_termios)
+			old_baud = tty_termios_baud_rate(old_termios);
+		else
+			old_baud = F81232_DEF_BAUDRATE;
+
+		f81232_set_baudrate(tty, port, baudrate, old_baud);
 	}
 
 	if (C_PARENB(tty)) {
@@ -593,6 +675,7 @@ static int f81232_carrier_raised(struct usb_serial_port *port)
 static int f81232_get_serial_info(struct usb_serial_port *port,
 		unsigned long arg)
 {
+	struct f81232_private *priv = usb_get_serial_port_data(port);
 	struct serial_struct ser;
 
 	memset(&ser, 0, sizeof(ser));
@@ -600,7 +683,7 @@ static int f81232_get_serial_info(struct usb_serial_port *port,
 	ser.type = PORT_16550A;
 	ser.line = port->minor;
 	ser.port = port->port_number;
-	ser.baud_base = F81232_MAX_BAUDRATE;
+	ser.baud_base = priv->baud_base;
 
 	if (copy_to_user((void __user *)arg, &ser, sizeof(ser)))
 		return -EFAULT;
-- 
2.7.4

