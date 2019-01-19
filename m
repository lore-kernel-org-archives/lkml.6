Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987B0C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 09:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6748A20883
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 09:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkk4BRzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfASJBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 04:01:31 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42556 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbfASJBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 04:01:07 -0500
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so13586186lja.9;
        Sat, 19 Jan 2019 01:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1pudjFZm7a1TG8b705J5+DLKWhWvGwPk11vg4nopYJk=;
        b=fkk4BRzw835xS+GyYaXXi+h/P94dO8Ss8mevsxlSA/BuAAe+GIf1U893vJhhNI2i02
         tcfYFbcduwycjK/q5S7KZmBHuuNxwzAfF+ylj+OSTN9uLKhKQ0FP3AaqNHYs6i6aWH7w
         +oeG2g6DwoD0/R0Vpxs78yscBmPo/BXEFcGIwF5mMz5CTBAaosCOFZmhLdgnAlnhzSXr
         ghU/Ge9i4niAZrNSbDn2hT1iKItKHAeCT/ylusv29lbU6/pQL51noWX81ME0cZrsGiIF
         AJ6NrHgef9B95/O7FmFkR6th6Warm4g8kRd4VM/xoTQ6sQquFAa3HuIrWEBsmPL65z+g
         auUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=1pudjFZm7a1TG8b705J5+DLKWhWvGwPk11vg4nopYJk=;
        b=SOzRrlbxA5VjQxVw/F60VT5jlPqATXKVo6QDFQM5QyiFYauL//tOYOTccExvdRM1xX
         FERg4w3YoYuyJoA67qxWMQZWDSrmMfPbLocPns/8OEA7zHtYAt1h55aV7Kwnigczs07n
         6WEk/8cRmjJ3TwQh1OS7A6aFn5BpaIeSf4m6A+47UWqW9QcXj7oYxT/KVO4RwGR0lZE9
         on849aLBq+guHFjtxsYqNWmrXZtfeZfzIcMju1IoTPayFdxqzRZnHsVgLhFPZuc7FKov
         W4WFSYp0umSGdlAuFIpT4PIdY94Cq705qScJgpopJgLE6gV0v5T8HJUEdw/YGHTXfnh6
         oXPg==
X-Gm-Message-State: AJcUukcarmFwU8HhNWD/FRCVuIUUm8L1GtlhQxmNEr85xY4bKnj13PSs
        RZoLInpDvjUf2Bzc/DxIua4=
X-Google-Smtp-Source: ALg8bN72OQaBPsFJgD/k6pNJAUvUZIOHB+1axILf3JhkGhzV7kUTLBkDdjcybobihzmmmf2UGGMZ/Q==
X-Received: by 2002:a2e:5703:: with SMTP id l3-v6mr15189174ljb.106.1547888465056;
        Sat, 19 Jan 2019 01:01:05 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id h22-v6sm1254995lji.45.2019.01.19.01.01.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 01:01:04 -0800 (PST)
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
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH v3 3/6] dt-binding: pcf8523: add xtal load capacitance
Date:   Sat, 19 Jan 2019 10:00:28 +0100
Message-Id: <20190119090031.29147-4-sam@ravnborg.org>
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

The NXP pcf8523 supports two different xtal load capacitance
- 7000fF  (7pF)    HW default
- 12500fF (12.5pF) Minimum power consumption, driver default

To obtain a precise RTC the pcf8523 must be configured
with the correct capacitance load of the xtal.

Add a property to specify the xtal capacitance load.
The default value matches that of the current Linux driver.

With a dedicated binding remove the entry in rtc.txt

Signed-off-by: Søren Andersen <san@skov.dk>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt | 18 ++++++++++++++++++
 Documentation/devicetree/bindings/rtc/rtc.txt         |  1 -
 2 files changed, 18 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
new file mode 100644
index 000000000000..0b1080c60f63
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
@@ -0,0 +1,18 @@
+* NXP PCF8523 Real Time Clock
+
+Required properties:
+- compatible: Should contain "nxp,pcf8523".
+- reg: I2C address for chip.
+
+Optional property:
+- quartz-load-femtofarads: The capacitive load of the quartz(x-tal),
+  expressed in femto Farad (fF). Valid values are 7000 and 12500.
+  Default value (if no value is specified) is 12500fF.
+
+Example:
+
+pcf8523: rtc@68 {
+	compatible = "nxp,pcf8523";
+	reg = <0x68>;
+	quartz-load-femtofarads = <7000>;
+};
diff --git a/Documentation/devicetree/bindings/rtc/rtc.txt b/Documentation/devicetree/bindings/rtc/rtc.txt
index 41eb335ea816..6d726a801d21 100644
--- a/Documentation/devicetree/bindings/rtc/rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/rtc.txt
@@ -55,7 +55,6 @@ isil,isl12022		Intersil ISL12022 Real-time Clock
 microcrystal,rv3029	Real Time Clock Module with I2C-Bus
 nxp,pcf2127		Real-time clock
 nxp,pcf2129		Real-time clock
-nxp,pcf8523		Real-time Clock
 nxp,pcf8563		Real-time clock/calendar
 nxp,pcf85063		Tiny Real-Time Clock
 pericom,pt7c4338	Real-time Clock Module
-- 
2.12.0

