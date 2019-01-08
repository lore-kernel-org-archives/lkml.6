Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D56FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D164E2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEx7NWDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbfAHSyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:54:47 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44452 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbfAHSyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:54:45 -0500
Received: by mail-lj1-f195.google.com with SMTP id k19-v6so4292807lji.11;
        Tue, 08 Jan 2019 10:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9KlJyAU1h4/N8SK8wouQfQ15knLJxHRRdyRexKmVSFc=;
        b=kEx7NWDKR4q7vG5y2Cw+JxUFO05iHPNDnHxWIPfAr6QD0sH88twoXSn1B07tejzGMG
         YBnv3v3wcLvyX93ahJzRUb0R7gBxsuZYq+ZGJ72AHWEbtBbz4zAcdbp+OPDwq0OYVxBk
         XY3wpJiPx7i5fTKbmHEcv8zmE4lfvpnCGaMH1NB020qT2E3Rv+5ty0xQ4EljIDnZM0en
         3Q52su4RrD38xEpbffF/h9gyKZkNn8Zl4YPFNiqDZtCA5+1RIg9bFPUTDZimQa878JdC
         oNrhANw9iYNIjwCxVVQQ+XkJpZXTS1YbmzY91W9uDnl7Av6uVCPMb9PztsQ23cDUCmwI
         x0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9KlJyAU1h4/N8SK8wouQfQ15knLJxHRRdyRexKmVSFc=;
        b=SHXCYCbzDJC/2DcO8z0TC+IxZxAMgrFmXZo/QeYro+iYgs/nQloQUUsczyKPk79E21
         jR5urmhyDSF1ggg1mqja6xo6prOtlWSBbEeDjGeSXtOtCzfSHlsDokgFKyybQWnjejp1
         toWX9QT09bQdkKPCW+1ULHhfadLy9JYikc69Eibgy52jx5fJk8imgZzvdZwhe5c67BZe
         SU6jE0Z6rIWiMKLHQ/UbYh1c2LZbU6lncHK+cTk8lcFEc5lkwC1ADfhVvoKuEuBUZihK
         Myqmy4J71K3J707P9Hn+HLow5jatCi3pu6xfxZ283FLeNeqtvMDxL4LrLx1pm12lxUBE
         XF8g==
X-Gm-Message-State: AJcUuke2xNgJfDJalVh7ZwCrkMrt8Cb2xzQUU6YVJkIuS7bZoikawEMi
        6txUi+VELw0v81+oYEYXg04=
X-Google-Smtp-Source: ALg8bN5YinGcYnbvrjj6tdgo5vIjAqUWqJrfQtdIlwVpYI/ef6WoUvFF45CbyFPzNCm6Juyn54yujg==
X-Received: by 2002:a2e:86ca:: with SMTP id n10-v6mr1665068ljj.49.1546973682153;
        Tue, 08 Jan 2019 10:54:42 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a11sm13321648lff.68.2019.01.08.10.54.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 10:54:41 -0800 (PST)
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
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH v2 2/5] dt-binding: pcf8523: add xtal load capacitance
Date:   Tue,  8 Jan 2019 19:54:11 +0100
Message-Id: <20190108185414.26922-3-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190108185414.26922-1-sam@ravnborg.org>
References: <20190108185414.26922-1-sam@ravnborg.org>
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
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt | 18 ++++++++++++++++++
 Documentation/devicetree/bindings/rtc/rtc.txt         |  1 -
 2 files changed, 18 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
new file mode 100644
index 000000000000..214ac5d26df7
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
+pcf8523: pcf8523@68 {
+	compatible = "nxp,pcf8523";
+	reg = <0x68>;
+	quartz-load-femtofarads = <7000>;
+};
diff --git a/Documentation/devicetree/bindings/rtc/rtc.txt b/Documentation/devicetree/bindings/rtc/rtc.txt
index 7c8da6926095..e07b15d151ac 100644
--- a/Documentation/devicetree/bindings/rtc/rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/rtc.txt
@@ -51,7 +51,6 @@ isil,isl12022		Intersil ISL12022 Real-time Clock
 microcrystal,rv3029	Real Time Clock Module with I2C-Bus
 nxp,pcf2127		Real-time clock
 nxp,pcf2129		Real-time clock
-nxp,pcf8523		Real-time Clock
 nxp,pcf8563		Real-time clock/calendar
 nxp,pcf85063		Tiny Real-Time Clock
 pericom,pt7c4338	Real-time Clock Module
-- 
2.12.0

