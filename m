Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34D8C6369F
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 09:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71BD12086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 09:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiVKZPv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfASJBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 04:01:19 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35632 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbfASJBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 04:01:10 -0500
Received: by mail-lf1-f66.google.com with SMTP id e26so12199492lfc.2;
        Sat, 19 Jan 2019 01:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F+4crJRPxHtpzXBHJc8HDEgRsj27zduN5WVH8mp44vs=;
        b=eiVKZPv6zpF2tmPSUb4dlp/umUAwEJA0QO+ee7FoHY/R3vOI9WVYP2PE+ADKy0u8ZS
         yGVmLt+bPssXsMpASfvMM5s7L5YmcfRSozgJayflQXGOmcBfzWbpPRBnnswhczW6iKc/
         BmVTuHlW8kB97dubxQZSs1gHFveyaKCWYpEXU7EC1Xbok2kFLwlvckFmiRHPpQXRJqMs
         hgfpovPtxnB5AyG9awD5zHvbf3yWQiqvegql4eCbto3b8F1BYMB5k0UWU7YHi50DWcM3
         jHuthg1AFwJE6Ho2IdaB5rXpGTZlK1ETpd+qyAmasX41eZcUscX/3eJik8LQnT+W0NE5
         hB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=F+4crJRPxHtpzXBHJc8HDEgRsj27zduN5WVH8mp44vs=;
        b=JKSqwqkbA6gpQlr/dHDz2mdU2Jks/IGQ3lT9C7sutclZZWAZO08ScOjLgO/xEQOoaB
         hA4CAJhaz2VUsLdKUmNlVtiGWWqB7RtKflQWGGQsS3nZ5fO5E3yLDrDDaSvV217ndYIO
         laUyP0K2fReiwH1QBTHCrGMOhhPgqg4IzDNUZ7dIfgw3QTRBZSeWfm72GI9GTwJMBgP2
         h1JfCasMWP/GusjIrjJrmlNwxJ4h6CCruDUDEWw+8ZHUkiEVWGtc65URjFIL5opUYMr7
         FXcPdgnOhh8srcIAQ04iQ9WpRtL93OpAbmbmu7GY2GfjH2/PplKiUsO766wGn3bzCD6u
         7T5w==
X-Gm-Message-State: AJcUukem9mW0hk35tGX2iJPuxel2cEJICKIj7biSpefYytJVJBNzs5XO
        uUlgVfHJFg0QcPqGXy4/j9I=
X-Google-Smtp-Source: ALg8bN6eG/BWG4SeJAjJv2PlwZYDnCRuW9fd/L60d077GzSmw0AECYULj7qI9UQ70Hb76saX2wqmZQ==
X-Received: by 2002:a19:5059:: with SMTP id z25mr9983093lfj.120.1547888468482;
        Sat, 19 Jan 2019 01:01:08 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id h22-v6sm1254995lji.45.2019.01.19.01.01.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 01:01:08 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Andrew Jeffery <andrew@aj.id.au>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?q?Urs=20F=C3=A4ssler?= <urs.fassler@bbv.ch>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v3 6/6] rtc: pcf85063: set xtal load capacitance from DT
Date:   Sat, 19 Jan 2019 10:00:31 +0100
Message-Id: <20190119090031.29147-7-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190119090031.29147-1-sam@ravnborg.org>
References: <20190119090031.29147-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for specifying the xtal load capacitance in the DT node.
The pcf85063 supports xtal load capacitance of 7pF or 12.5pF.
If the rtc has the wrong configuration the time will
drift several hours/week.

The driver use the default value 7pF.

The DT may specify either 7000fF or 12500fF.
(The DT uses femto Farad to avoid decimal numbers).
Other values are warned and the driver uses the default value.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Urs Fässler <urs.fassler@bbv.ch>
---
 drivers/rtc/rtc-pcf85063.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 283c2335b01b..b79af6e96292 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -27,6 +27,7 @@
 */
 
 #define PCF85063_REG_CTRL1		0x00 /* status */
+#define PCF85063_REG_CTRL1_CAP_SEL	BIT(0)
 #define PCF85063_REG_CTRL1_STOP		BIT(5)
 #define PCF85063_REG_CTRL2		0x01
 
@@ -180,6 +181,39 @@ static const struct rtc_class_ops pcf85063_rtc_ops = {
 	.set_time	= pcf85063_rtc_set_time
 };
 
+static int pcf85063_load_capacitance(struct i2c_client *client)
+{
+	u32 load;
+	int rc;
+	u8 reg;
+
+	rc = i2c_smbus_read_byte_data(client, PCF85063_REG_CTRL1);
+	if (rc < 0)
+		return rc;
+
+	reg = rc;
+	load = 7000;
+	of_property_read_u32(client->dev.of_node, "quartz-load-femtofarads",
+			     &load);
+
+	switch (load) {
+	default:
+		dev_warn(&client->dev, "Unknown quartz-load-femtofarads value: %d. Assuming 7000",
+			 load);
+		/* fall through */
+	case 7000:
+		reg &= ~PCF85063_REG_CTRL1_CAP_SEL;
+		break;
+	case 12500:
+		reg |= PCF85063_REG_CTRL1_CAP_SEL;
+		break;
+	}
+
+	rc = i2c_smbus_write_byte_data(client, PCF85063_REG_CTRL1, reg);
+
+	return rc;
+}
+
 static int pcf85063_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
@@ -197,6 +231,11 @@ static int pcf85063_probe(struct i2c_client *client,
 		return err;
 	}
 
+	err = pcf85063_load_capacitance(client);
+	if (err < 0)
+		dev_warn(&client->dev, "failed to set xtal load capacitance: %d",
+			 err);
+
 	rtc = devm_rtc_device_register(&client->dev,
 				       pcf85063_driver.driver.name,
 				       &pcf85063_rtc_ops, THIS_MODULE);
-- 
2.12.0

