Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4325C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 09:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44AA2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 09:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgDtiBdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfASJBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 04:01:25 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33885 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfASJBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 04:01:10 -0500
Received: by mail-lj1-f193.google.com with SMTP id u89-v6so13624113lje.1;
        Sat, 19 Jan 2019 01:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gsad/wBToe+cmtNDHEYdNCur8rX+EzM0uvagphRxBvM=;
        b=GgDtiBdUwfAVCMRUZFT/cYdaRDT15Q90Aw7kFvRLf7pT3ggSVQOVNmqy3qMqQLLIhd
         bP89XL+haGdT8RZYSDUyLUPgDlECebFuL7hCPdLyDND0iAP7tqeC6dx1fjFlmqaEnTPj
         AGzt1qCYhdxsYNhNh8LAxk9JcaY/6pahAT1E+l4+oh9DZWg/b64OwjvZs7uN3euPwx1s
         fHlpklv1UOlIbZp1yGpfAff8+ikDchyvwXhcYjURgPtanLSRfpjhueqFSL0N6xoVU8l9
         6hEO5V1QHNaBqNZEWrWmzF3y8vhtCuFl2ztB71T1k5WR9KNJkZMZU4ERTHgdDmBR0oAi
         LWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Gsad/wBToe+cmtNDHEYdNCur8rX+EzM0uvagphRxBvM=;
        b=gW7MD1gnr7JGy8qWJm1rYiP6xpbInZx3Uq5egLKS2cjCxoROSP40QM1zraZZn7dws3
         NEAHFETvrqRR1Px4VsQth2KAlxEEQBY31VDxSd6g9FMacNyA6ctNyAhulp46/vD6ICN3
         G2ugN247KJc/Eo6wuUADREms9qjgjn9mZqTA0sybkDhF1QTojHm71WrCy9+Mh7uWiwM4
         jtpnz20zBrXWy+CQ85Bs0qR+k2pNkYWnExLHvhIFCuF8lch1SKy85kCoiMy0WSiFPfH1
         OvJq9m4LciqpTm35o7zTye0GoOudWRHSFVEDUCAbDXQe1YtUowvvf4SaC8uIkgSVauNF
         xw9Q==
X-Gm-Message-State: AJcUukfJly8rpUD41+9rm9OTe0ydbjntzVmondP7720IPvaOLna7WuJQ
        Nnem5a08DDOEOPk7BqtixQQ=
X-Google-Smtp-Source: ALg8bN4w0xDZHt23MbaUSx8PRMigw70iS8f7jKTxfstac8yVlL6xceH9gF2m14GhKUn+ZoU1dYa0BQ==
X-Received: by 2002:a2e:710a:: with SMTP id m10-v6mr13726595ljc.66.1547888467396;
        Sat, 19 Jan 2019 01:01:07 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id h22-v6sm1254995lji.45.2019.01.19.01.01.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 01:01:06 -0800 (PST)
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
Subject: [PATCH v3 5/6] rtc: pcf8523: set xtal load capacitance from DT
Date:   Sat, 19 Jan 2019 10:00:30 +0100
Message-Id: <20190119090031.29147-6-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190119090031.29147-1-sam@ravnborg.org>
References: <20190119090031.29147-1-sam@ravnborg.org>
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
index 3fcd2cbafc84..2e03021f15d1 100644
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
+			 load);
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
+			 err);
 
 	err = pcf8523_set_pm(client, 0);
 	if (err < 0)
-- 
2.12.0

