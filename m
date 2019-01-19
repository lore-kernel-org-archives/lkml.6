Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A499C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 09:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286CA2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 09:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwf2AI10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfASJBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 04:01:11 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42556 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727766AbfASJBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 04:01:08 -0500
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so13586214lja.9;
        Sat, 19 Jan 2019 01:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=32aiRvmXizk/aT/C00Lbv4hCDOoBJNEluj0FNlfhB88=;
        b=fwf2AI10JNdBGLGUXNF/k/IqzIm+quhTewahx/73CowFsttaqciq5dTIDvGi8Esc9J
         CdbuN7E282OJHzYVwtk9/TzhPG9SiC93ZRfQD88VvkcrniDwLnDHJNxoVC6IkZ2LLZ7U
         5mqgbIzj+QVE644dCorkVZWq2kV2qPenge/1jx9GAVSjMm5vgsMGOGiK8rIHhWNd58d/
         qJN+znRyCubfUo0WokgRXoeZe/Sb87ryNflU2vXhSDVYPaZ51TNXFpUJywiGxz2BRloT
         kSyw1czIfRBpgaWSvEvkbrnVRoodD6O7Ed839queFMBjPtViBUtfU/aqN2T8SfI4mH/B
         Qw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=32aiRvmXizk/aT/C00Lbv4hCDOoBJNEluj0FNlfhB88=;
        b=OkJeI2npnbRwobN5bFXNkzvw4VuRNh6zVjYI3EBABywchPwHHcD01B2kbO2Wy93FjV
         MMhrUjbF/ojvJqP1vFQHyr9verOEudH+lfktGfTrLRFdP/EioD3secY028AsMMI7uqD6
         FebT/LUgmQYSMJ4vAKBXUgu2h0lugrDLCaDfJCKyTdVUnbX5TOdR4UrGgn8j9aORS7n9
         EIVkx59qMwrvPYQwhvS137aP9LWPkKNIIUPRwpKpYtOGS5AlUt9eJrdftAWo1LU595Cl
         5Dye1p+LQZIKqwVZ+BYWyw+SlWkENUxZYSKRqFfDNA1S4NrZOuvgzdicqKOdAMOWuN0x
         hYFA==
X-Gm-Message-State: AJcUukfpMRNY7YscSSbqDSUmMeDZN+swfsKz63u7Zm+g2c8B70rqZy92
        gvaQQCludC3twCSaL0FYGnM=
X-Google-Smtp-Source: ALg8bN60Kyr9vJPWdA5vu6ykr6tRgENi50TfWCNF0Bq0qntG1DMbk2K8YRiCgxg7zEeFD8Ha4Hw4Ew==
X-Received: by 2002:a2e:e02:: with SMTP id 2-v6mr12320366ljo.10.1547888466233;
        Sat, 19 Jan 2019 01:01:06 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id h22-v6sm1254995lji.45.2019.01.19.01.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 01:01:05 -0800 (PST)
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
Subject: [PATCH v3 4/6] dt-binding: pcf85063: add xtal load capacitance
Date:   Sat, 19 Jan 2019 10:00:29 +0100
Message-Id: <20190119090031.29147-5-sam@ravnborg.org>
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

The NXP pcf85063 supports two different xtal load capacitance
- 7000fF  (7pF)    HW default, Linux driver default
- 12500fF (12.5pF) Minimum power consumption

To obtain a precise RTC the pcf85063 must be configured
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
Cc: Urs Fässler <urs.fassler@bbv.ch>
---
 Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt | 18 ++++++++++++++++++
 Documentation/devicetree/bindings/rtc/rtc.txt          |  1 -
 2 files changed, 18 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt b/Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt
new file mode 100644
index 000000000000..d3e380ad712d
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt
@@ -0,0 +1,18 @@
+* NXP PCF85063 Real Time Clock
+
+Required properties:
+- compatible: Should contain "nxp,pcf85063".
+- reg: I2C address for chip.
+
+Optional property:
+- quartz-load-femtofarads: The capacitive load of the quartz(x-tal),
+  expressed in femto Farad (fF). Valid values are 7000 and 12500.
+  Default value (if no value is specified) is 7000fF.
+
+Example:
+
+pcf85063: rtc@51 {
+	compatible = "nxp,pcf85063";
+	reg = <0x51>;
+	quartz-load-femtofarads = <12500>;
+};
diff --git a/Documentation/devicetree/bindings/rtc/rtc.txt b/Documentation/devicetree/bindings/rtc/rtc.txt
index 6d726a801d21..460c503e86c6 100644
--- a/Documentation/devicetree/bindings/rtc/rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/rtc.txt
@@ -56,7 +56,6 @@ microcrystal,rv3029	Real Time Clock Module with I2C-Bus
 nxp,pcf2127		Real-time clock
 nxp,pcf2129		Real-time clock
 nxp,pcf8563		Real-time clock/calendar
-nxp,pcf85063		Tiny Real-Time Clock
 pericom,pt7c4338	Real-time Clock Module
 ricoh,r2025sd		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
 ricoh,r2221tl		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
-- 
2.12.0

