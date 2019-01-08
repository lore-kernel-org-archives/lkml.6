Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4071BC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A1420827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xu9xvZtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbfAHSyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:54:52 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38419 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbfAHSys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:54:48 -0500
Received: by mail-lj1-f195.google.com with SMTP id c19-v6so4328234lja.5;
        Tue, 08 Jan 2019 10:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/oNBVI7r+RUN31V3RzJh6kA1WRwfvNRrEP4X/9vskjo=;
        b=Xu9xvZtnWi2GmWXYXiY8i7kfrkgQ752+TKMKaUNDbcdmoPT+zkclhn/McWlbowKYJd
         JUbkgMNixu+ckWmw8Y6Ynq0ITjBXdQPZe6rX+atrSFFJk10BdJyGnrcoCYCsYG4o4zeq
         tiNcvCpZqGWn8rtuddhnOdKvL7t0nY9+nEcDKQ9JkszfVVCHgpTgVEnkjGJzWT4+vJKT
         TPYP5hJATnsQf2Na2XwpR8VWyMozvaYAMuRTIY8MkmFsOUkdfZR6jdtz7Pk8rKfij3eM
         sh0uIapHn48dWtMYstFsBzpYxMN15h332yRDdIvR6xccVKQIfMp0IhC9LaQEQQRX9QQU
         DtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=/oNBVI7r+RUN31V3RzJh6kA1WRwfvNRrEP4X/9vskjo=;
        b=n0dv4mhTwNmTqX551hQscp0lHM08aWeEeCxdXKLJ040vB8ycU+9nZJ6Nu+qBvXYoja
         6GbkP5VvOrW7uQrsQUCEWICekB+qo1H//21SSSu/VRLi9sIBUKmpCZlOuNiCz2NAB96H
         ixnzT/SFhui8hipiND6nQlXHSo59WFueJ04r8hDSYyH+l2JbGfi2ocrtGoI6bKDD4mbT
         lH9utdZ3rU2QW4/T78tQC57x0yat2n25kiMVg8Orw2Z5BhHIEc8s1+3DragC7/vlGRjx
         rYebYdQdWfpPOHgwvxvs9kkcVWbOjA13z1lAqY94MTg3klULGgkRu120LQMWsQrPqX9U
         atVQ==
X-Gm-Message-State: AJcUukfQ6At84FbFfDxMlaaXWyMiIMcnZ+k1csIUTXhBRnUILpV5Hq9D
        necKrBJxYv42WIz/7HPLVis=
X-Google-Smtp-Source: ALg8bN7bFZ5RlDq+e+5chw0zDjzFMkAdz0w+MPlei4RrzrRl3gciLtlk9+cO0g6Qz5jGjLwd+7+HVg==
X-Received: by 2002:a2e:9059:: with SMTP id n25-v6mr1732682ljg.155.1546973685762;
        Tue, 08 Jan 2019 10:54:45 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a11sm13321648lff.68.2019.01.08.10.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 10:54:45 -0800 (PST)
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
        =?UTF-8?q?Urs=20F=C3=A4ssler?= <urs.fassler@bbv.ch>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v2 4/5] rtc: pcf8523: set xtal load capacitance from DT
Date:   Tue,  8 Jan 2019 19:54:13 +0100
Message-Id: <20190108185414.26922-5-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190108185414.26922-1-sam@ravnborg.org>
References: <20190108185414.26922-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for specifying the xtal load capacitance in the DT node.
The pcf8523 supports xtal load capacitance of 7pF or 12.5pF.
If the rtc has the wrong configuration the time will
drift several hours/week.

The driver use the default value 12.5pF.

The DT may specify either 7000fF or 12500fF.
(The DT uses femto Farad to avoid decimal numbers).
Other values are warned and the driver uses the default value.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf8523.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-pcf8523.c b/drivers/rtc/rtc-pcf8523.c
index 3fcd2cbafc84..dbbc00b53b50 100644
--- a/drivers/rtc/rtc-pcf8523.c
+++ b/drivers/rtc/rtc-pcf8523.c
@@ -97,8 +97,9 @@ static int pcf8523_voltage_low(struct i2c_client *client)
 	return !!(value & REG_CONTROL3_BLF);
 }
 
-static int pcf8523_select_capacitance(struct i2c_client *client, bool high)
+static int pcf8523_load_capacitance(struct i2c_client *client)
 {
+	u32 load;
 	u8 value;
 	int err;
 
@@ -106,14 +107,24 @@ static int pcf8523_select_capacitance(struct i2c_client *client, bool high)
 	if (err < 0)
 		return err;
 
-	if (!high)
-		value &= ~REG_CONTROL1_CAP_SEL;
-	else
+	load = 12500;
+	of_property_read_u32(client->dev.of_node, "quartz-load-femtofarads",
+			     &load);
+
+	switch (load) {
+	default:
+		dev_warn(&client->dev, "Unknown quartz-load-femtofarads value: %d. Assuming 12500",
+			load);
+		/* fall through */
+	case 12500:
 		value |= REG_CONTROL1_CAP_SEL;
+		break;
+	case 7000:
+		value &= ~REG_CONTROL1_CAP_SEL;
+		break;
+	}
 
 	err = pcf8523_write(client, REG_CONTROL1, value);
-	if (err < 0)
-		return err;
 
 	return err;
 }
@@ -347,9 +358,10 @@ static int pcf8523_probe(struct i2c_client *client,
 	if (!pcf)
 		return -ENOMEM;
 
-	err = pcf8523_select_capacitance(client, true);
+	err = pcf8523_load_capacitance(client);
 	if (err < 0)
-		return err;
+		dev_warn(&client->dev, "failed to set xtal load capacitance: %d",
+			err);
 
 	err = pcf8523_set_pm(client, 0);
 	if (err < 0)
-- 
2.12.0

