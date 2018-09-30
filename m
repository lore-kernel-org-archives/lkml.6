Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F89C64EB0
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 12:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4A82089D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 12:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfnEeRH3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4A82089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbeI3TCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 15:02:37 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42632 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728299AbeI3TCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 15:02:36 -0400
Received: by mail-lf1-f66.google.com with SMTP id s10-v6so444864lfc.9;
        Sun, 30 Sep 2018 05:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rVyblo+VQ+yESTzADioS2/MobtKe4/7BSVHQtoGYLrc=;
        b=OfnEeRH3hMPGYrN8oxRDB0yNZd2SYWUyaME0cj0i2+MEEcaGXljeYbA5YATrcZC12A
         pLRLZ7Cn2lk48xICp1pADV9vUwO08iA5Vu+jEl/HUmQvxwB2t1kQhkA2k0FIt3Z0y7pB
         7YIoArp9+nWabXceRtGfbDDuuKFOZViUoTM7jFWN0LgIUw7nr2rGfTfMS11mFSib4wGF
         6ZJ6rckvZGLJhcPeybKZ1o6KHKT7T4Ws6mZS8Kyb6JXyQI1TeKOsozw0tT1gWzBXrq0j
         NQNgl3JRetzWM6E//H2LJEXAaXHgWHx23L7AgXzwAQ4P3lS8WQjCrM+IzlFurchQr5yf
         sc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rVyblo+VQ+yESTzADioS2/MobtKe4/7BSVHQtoGYLrc=;
        b=Xgw0UuhW4kZ0RvrhIhwD2q5h7urK8Dwd/gSknJnK2/DtKjtKApcAmNrpkgg81A+mIE
         U1z85ES1CFDgpzeskrvYCdX+yN+Rjs1g43ZWR49YQGRm2RsuHjtkikv1nAEf3vFG/cT5
         //Gf9mjGk5FJ27SIv/U9PlJNcaRt7ksrZ0fOMVYdgVZp736+Qdn8ubu/t0DdKMZHuBH0
         PtKsrhwk9orw8Q+5WVy2mIZ7tNlBkObwxio38oJHOooo/YHG6AQ7EQqSau/F/gLx5wlm
         rEfqdRHU9M1DxrDgDB329e2G1zLEZOOEH5XNXMaTaqQiPRP5BRGG9gnfkbIgeNxHDg63
         Y73A==
X-Gm-Message-State: ABuFfogOsusHl6F27fhWFZIW42O++dW9LinUlNaxhfz4jX1McoqZ8qI/
        jDIPWtsAqlPV0WtWOqquNBP7NiEB
X-Google-Smtp-Source: ACcGV60xWq5m3vsbqoj0xi1n05s7EjM4U6NHDJS6FxCWyzKH1yIJp9tOY1sGfRTvhYVPJQg0j1Jyqw==
X-Received: by 2002:a19:2a12:: with SMTP id f18-v6mr3356455lfl.28.1538310584482;
        Sun, 30 Sep 2018 05:29:44 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id g68-v6sm890337lje.44.2018.09.30.05.29.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 05:29:42 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1g6aqz-0001sT-Bj; Sun, 30 Sep 2018 14:29:41 +0200
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Karoly Pados <pados@pados.hu>,
        Loic Poulain <loic.poulain@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] USB: serial: ftdi_sio: add support for FT232R CBUS gpios
Date:   Sun, 30 Sep 2018 14:27:03 +0200
Message-Id: <20180930122703.7115-3-johan@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930122703.7115-1-johan@kernel.org>
References: <20180930122703.7115-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support for cbus gpios on FT232R. The cbus configuration is
stored in one word in the EEPROM at offset 0x0a (byte-offset 0x14) with
the mux config for CBUS0, CBUS1, CBUS2 and CBUS3 in bits 0..3, 4..7,
8..11 and 12..15, respectively.

Tested using FT232RL by configuring one cbus pin at a time.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 40 +++++++++++++++++++++++++++++++++--
 drivers/usb/serial/ftdi_sio.h |  3 ++-
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index be50b2a200aa..f1eb20acb3bb 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -2007,7 +2007,40 @@ static int ftdi_read_eeprom(struct usb_serial *serial, void *dst, u16 addr,
 	return 0;
 }
 
-static int ftx_gpioconf_init(struct usb_serial_port *port)
+static int ftdi_gpio_init_ft232r(struct usb_serial_port *port)
+{
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	u16 cbus_config;
+	u8 *buf;
+	int ret;
+	int i;
+
+	buf = kmalloc(2, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = ftdi_read_eeprom(port->serial, buf, 0x14, 2);
+	if (ret < 0)
+		goto out_free;
+
+	cbus_config = le16_to_cpup((__le16 *)buf);
+	dev_dbg(&port->dev, "cbus_config = 0x%04x\n", cbus_config);
+
+	priv->gc.ngpio = 4;
+
+	priv->gpio_altfunc = 0xff;
+	for (i = 0; i < priv->gc.ngpio; ++i) {
+		if ((cbus_config & 0xf) == FTDI_FT232R_CBUS_MUX_GPIO)
+			priv->gpio_altfunc &= ~BIT(i);
+		cbus_config >>= 4;
+	}
+out_free:
+	kfree(buf);
+
+	return ret;
+}
+
+static int ftdi_gpio_init_ftx(struct usb_serial_port *port)
 {
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
 	struct usb_serial *serial = port->serial;
@@ -2049,8 +2082,11 @@ static int ftdi_gpio_init(struct usb_serial_port *port)
 	int result;
 
 	switch (priv->chip_type) {
+	case FT232RL:
+		result = ftdi_gpio_init_ft232r(port);
+		break;
 	case FTX:
-		result = ftx_gpioconf_init(port);
+		result = ftdi_gpio_init_ftx(port);
 		break;
 	default:
 		return 0;
diff --git a/drivers/usb/serial/ftdi_sio.h b/drivers/usb/serial/ftdi_sio.h
index 6cfe682f8348..a79a1325b4d9 100644
--- a/drivers/usb/serial/ftdi_sio.h
+++ b/drivers/usb/serial/ftdi_sio.h
@@ -457,7 +457,8 @@ enum ftdi_sio_baudrate {
 #define FTDI_SIO_READ_EEPROM_REQUEST_TYPE 0xc0
 #define FTDI_SIO_READ_EEPROM_REQUEST FTDI_SIO_READ_EEPROM
 
-#define FTDI_FTX_CBUS_MUX_GPIO		8
+#define FTDI_FTX_CBUS_MUX_GPIO		0x8
+#define FTDI_FT232R_CBUS_MUX_GPIO	0xa
 
 
 /* Descriptors returned by the device
-- 
2.19.0

