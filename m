Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AB2C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3F420844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZjDSuC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E3F420844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeIHASc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:18:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33302 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbeIHASb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:18:31 -0400
Received: by mail-ed1-f67.google.com with SMTP id d8-v6so12335148edv.0;
        Fri, 07 Sep 2018 12:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kOIsmyFppsawiQL0wuv2FvPTQktlrZJDKtjIXxHFoEk=;
        b=XZjDSuC+oZImQYekR3Z582J4Scs7FzPf4nhmJCRPYjZ+7gNqxD+OSdj00r1ExnKZOb
         +pcbSgvnZ67GW+RO5ZPgYbKuHvDYLuYqgsuOHuF977VuvYFU21QAGWch/8YY0GPxJWbt
         GR/smusQiidLhj6AuDt8VVLNrLyqkfDpYGiKQEWfehzoyDDNr+c06WIiBBgtCj4vohHS
         smCifQphTOprSLfwJN4PoS4ugjraWREazccwc7g1hC1tM2uG9YLsd62AYsSxaRwg2Uag
         qMeankig7fLVTh48A0CBoYUv4p9xBmW5ZLOZvzZc7woSrR5pW5rgu4PhnwXTOMpO4UDe
         e3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kOIsmyFppsawiQL0wuv2FvPTQktlrZJDKtjIXxHFoEk=;
        b=iFCvDndLt1/NHhyh4uV/DVsjNFSQ6/tmDaR7lzypJIQww5R8iGR3hchxUay1fppkzF
         b48niCxM0Xa8IYFsGQaML5inFtcsfX9qj8r1ebFX8s3hf43yUTfiZYiAhEcj0m+zaQfv
         aikr4vRYPK4l12h1skMJN7/iJeSDwoXvEzTbF4mQKiqfP8E2ktXBgmOnaJTwrOMHRUiR
         TTwe7UzdIfRn5g/N91li6Cp9e3ivl+YBd/0FVQJBydZ7ZmowUdj71uciBDFWtBav3MBt
         apLerJ14a3Ri5U3JlDh9+sLavumX6anF/Pkgn77p3lrgzaeWxsnh2yUe+93GyYwxxAGd
         xLHg==
X-Gm-Message-State: APzg51CHm8P6XKH5t5prt1zmzIt7Nk0v/VhnWixIKuRVsztkTStYExKo
        W1GoORtqfxcaUBpPS2thOCw=
X-Google-Smtp-Source: ANB0VdZFNeszT5gT9ZyGCgr3ozb0zeRK0fC1x9TC684ZEvLqAyki8IQQ8iK0+vFlwJhCfh+nyHAE0A==
X-Received: by 2002:a50:984b:: with SMTP id h11-v6mr10769892edb.26.1536348965999;
        Fri, 07 Sep 2018 12:36:05 -0700 (PDT)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id h34-v6sm4868808eda.58.2018.09.07.12.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 12:36:05 -0700 (PDT)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH v1 5/5] rtc: pcf85063: external capacitor configuration
Date:   Fri,  7 Sep 2018 21:35:08 +0200
Message-Id: <20180907193508.24974-6-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180822183555.GA24084@ravnborg.org>
References: <20180822183555.GA24084@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Søren Andersen <san@skov.dk>

Add support for specifying the quartz load in the DT node.
The pcf85063 may use either a 7 pF or an 12.5 pF xtal.
If the rtc has the wrong configuration the time will
drift several hours/week.

If nothing is specified in DT then the factory default of 7 pF is used.

Signed-off-by: Søren Andersen <san@skov.dk>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf85063.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 283c2335b01b..38163446664f 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -27,6 +27,7 @@
 */
 
 #define PCF85063_REG_CTRL1		0x00 /* status */
+#define PCF85063_REG_CTRL1_CAP_SEL	BIT(0)
 #define PCF85063_REG_CTRL1_STOP		BIT(5)
 #define PCF85063_REG_CTRL2		0x01
 
@@ -180,6 +181,31 @@ static const struct rtc_class_ops pcf85063_rtc_ops = {
 	.set_time	= pcf85063_rtc_set_time
 };
 
+static int pcf85063_select_capacitance(struct i2c_client *client)
+{
+	int rc;
+	u8 reg;
+
+	rc = i2c_smbus_read_byte_data(client, PCF85063_REG_CTRL1);
+	if (rc < 0) {
+		dev_err(&client->dev, "Failing to read Control1 reg\n");
+		return -EIO;
+	}
+
+	if (device_property_present(&client->dev, "nxp,quartz_load_12.5pf"))
+		reg = rc |= PCF85063_REG_CTRL1_CAP_SEL;
+	else
+		reg = rc &= ~PCF85063_REG_CTRL1_CAP_SEL;
+
+	rc = i2c_smbus_write_byte_data(client, PCF85063_REG_CTRL1, reg);
+	if (rc < 0) {
+		dev_err(&client->dev, "Failing to configure device\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static int pcf85063_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
@@ -197,6 +223,11 @@ static int pcf85063_probe(struct i2c_client *client,
 		return err;
 	}
 
+	err = pcf85063_select_capacitance(client);
+	if (err < 0)
+		dev_warn(&client->dev,
+			 "Capacitance  setup failed. Trying to continue\n");
+
 	rtc = devm_rtc_device_register(&client->dev,
 				       pcf85063_driver.driver.name,
 				       &pcf85063_rtc_ops, THIS_MODULE);
-- 
2.12.0

