Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9270BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A2C2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vKUx+VR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A2C2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeIHASa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:18:30 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35714 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeIHAS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:18:29 -0400
Received: by mail-ed1-f65.google.com with SMTP id y20-v6so12321995edq.2;
        Fri, 07 Sep 2018 12:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2H3W5PSrw7X0V5elG5tkVVfeMUcFmlMqWuca4tChZUQ=;
        b=vKUx+VR5ekzKi2aRyQnHf5mq/Fe5THH7xwu33o5bwQhechX1+5GSahpZhluje7a3F2
         ARLwLsfX1SZiA9B6EYjLqm+J1ELU1hvAevDGdQb/ONhxLXLW58s7Bai0vnivCWqEGUVL
         5ZkxuOo3qjtY6vcH7UmXdHNpwiuNxgMeyHQ7E/MVdViVVAQqq8gW9r61WtfTTn9ziAGd
         jmM2VoHQ6g4JPI6lC1Fnq6o/tgKm8/QpnJpDQagSJvgjzn41DQ6k/0G1kxJMLyLELf0/
         EWHiRRRg+y0/WCE+ayupzbta/HmXya4/pphYKMQ9KD0TJOn+g1sgTYaQJKkph0MuMnW3
         tbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2H3W5PSrw7X0V5elG5tkVVfeMUcFmlMqWuca4tChZUQ=;
        b=ojjViwaUwMfV3W2AJBLF6s94c2UrKrWlaIR59DOYP2sYrFvkk62Uz8GP6WyqN4Acoz
         r93jwM2IySOHuP/7ZZsArwywelNIuLm3onIBzGLylrFlo7FC2lUH6F5C/42nygek7em4
         TXXRB1ACJZy+GQwa99NHSStrRncLWUrey+8wazxXFxW/fgmeR5QErDck0TKZds1J/oYj
         bAOJsAPw6586WuUVCwiE3TOe4y9R9Vusc1/sE+9zCgORSFbFHAX+olyl5tsqW+FjwKMF
         yELPwJb2SQ60P6Q2eY8VkdcaPCBQffE3oQHSGkDR8eVLHoTRCq0eUktc8i5cmS0Vncsd
         zZ/g==
X-Gm-Message-State: APzg51AmEYGOONO99SoquZ7uzoGKKeZ9SWvMsMRRMT0mah1n5e3PuOdQ
        gM+CHiN7kLaN03A1SpyOatw=
X-Google-Smtp-Source: ANB0VdYOwnTpHJ+vVm9IJ/E6tID43Mm9IQNWfg06R9JjOk5rKRy4ddWCrJjBgaFySgINVo8b1Z9KiQ==
X-Received: by 2002:a50:b0c1:: with SMTP id j59-v6mr10206573edd.267.1536348963804;
        Fri, 07 Sep 2018 12:36:03 -0700 (PDT)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id h34-v6sm4868808eda.58.2018.09.07.12.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 12:36:03 -0700 (PDT)
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
Subject: [PATCH v1 4/5] rtc: pcf8523: external capacitor configuration
Date:   Fri,  7 Sep 2018 21:35:07 +0200
Message-Id: <20180907193508.24974-5-sam@ravnborg.org>
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
The pcf8523 may use either a 7 pF or an 12.5 pF xtal.
If the rtc has the wrong configuration the time will
drift several hours/week.

If nothing is specified in DT then the factory default of 7 pF is used.
This is a change compared to before where the driver assumed 12.5 pF.

Note: all kernel dts trees are updated with the new property.

Signed-off-by: Søren Andersen <san@skov.dk>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf8523.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-pcf8523.c b/drivers/rtc/rtc-pcf8523.c
index 453615f8ac9a..3c19b4d21a2d 100644
--- a/drivers/rtc/rtc-pcf8523.c
+++ b/drivers/rtc/rtc-pcf8523.c
@@ -85,7 +85,7 @@ static int pcf8523_write(struct i2c_client *client, u8 reg, u8 value)
 	return 0;
 }
 
-static int pcf8523_select_capacitance(struct i2c_client *client, bool high)
+static int pcf8523_select_capacitance(struct i2c_client *client)
 {
 	u8 value;
 	int err;
@@ -94,7 +94,7 @@ static int pcf8523_select_capacitance(struct i2c_client *client, bool high)
 	if (err < 0)
 		return err;
 
-	if (!high)
+	if (!device_property_present(&client->dev, "nxp,quartz_load_12.5pf"))
 		value &= ~REG_CONTROL1_CAP_SEL;
 	else
 		value |= REG_CONTROL1_CAP_SEL;
@@ -331,7 +331,7 @@ static int pcf8523_probe(struct i2c_client *client,
 	if (!pcf)
 		return -ENOMEM;
 
-	err = pcf8523_select_capacitance(client, true);
+	err = pcf8523_select_capacitance(client);
 	if (err < 0)
 		return err;
 
-- 
2.12.0

