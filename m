Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25851C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7712083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rj3m6gfe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7712083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeIHAS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:18:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40405 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeIHASZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:18:25 -0400
Received: by mail-ed1-f65.google.com with SMTP id j62-v6so12316692edd.7;
        Fri, 07 Sep 2018 12:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9XnubIp5xE5amgY6FZ4Zm0LXCR7rLDghBJ94netcLig=;
        b=rj3m6gfeUshuiybQO6hy0VwIc+Tlib5VMMDRasxJ7y8nPSxC7sC7eUCQrfnoxWfB1Q
         5cwCt8P/TN+cg9WrlmMps7H6ONsRKVC512GXfxHeuIMlwaSHoDCWe0rfAjDAsCCMrYIB
         iMUP0vlcoa4nqI9Cb8WGMLLWkNaifGEQdyrNUeMtJZeecQQ6jEm2kj04yMov1vn1nzKn
         laexgdNGpduHh80/o26hRpDqLu+/zS2meMzcZ5fCWDh+BgQ7e8CbBm+iGp60wRw4uy2X
         uTpgjAtMnRgAhBMwcWGPd7Rk+VhK1xCkIEaKSdYay0s7stm5qLa+R9i9NuvPMd9rwJqs
         cVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9XnubIp5xE5amgY6FZ4Zm0LXCR7rLDghBJ94netcLig=;
        b=jf9wNxxOr6Z5Q414vAO04ISMTGqpdS+lyYzUWBfv/oF3NS35ppsvXWg8OQFBGyrCN5
         H83X/NrXn+PFmvTBX1H5co7XYOvFy4sY3UHj5r8kCiIlNwuA/P3vdof0lwhiX1oSrEGI
         1R3t0rmFoYCQt13v/Es3HtHTUYIjhLrvM7HhIjTqdEa9ardyq+suQJlAFct0ENjvnQA2
         2/SbW1SmF4DXcr5SR+biwElovlasEcYkq4VjWCEww5MWH8K76EKnsosHcMOW5SlUvrWI
         1ijZquB5GT+wqAYxDCu1gWDHVDufj208bPI8XZaRUCH4iQtt8Iump7+HWs8dGIb2NmlC
         Jb8w==
X-Gm-Message-State: APzg51DhzH1CU8zknGlN6Cvz2Vh+XFsm61oiFWt8PkK9qY2y67RSKRMa
        cTdQ4n+SA4dlboUJ8u5ORbs=
X-Google-Smtp-Source: ANB0VdZSrxoy/hcZpjXw8sU5eLOd3qCM93rmsc4+SeW3fIQz5lxPGQssxWtvIIz4CAxAoLCs3AsCLA==
X-Received: by 2002:a50:95dd:: with SMTP id x29-v6mr10610191eda.3.1536348959677;
        Fri, 07 Sep 2018 12:35:59 -0700 (PDT)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id h34-v6sm4868808eda.58.2018.09.07.12.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 12:35:59 -0700 (PDT)
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
Subject: [PATCH v1 2/5] dt-binding: rtc-pcf85063: add quartz load property
Date:   Fri,  7 Sep 2018 21:35:05 +0200
Message-Id: <20180907193508.24974-3-sam@ravnborg.org>
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

The NXP pcf85063 support two different quartz loads.
- 7 pF (default)
- 12.5 pF (minimum power consumption)

The pcf85063 needs to know the size of the external capacitor,
otherwise the RTC will have a bad precision (hours/week).

The power-on default is 7 pF
Add a property that tells if the external capacitor is 12.5 pF

Signed-off-by: Søren Andersen <san@skov.dk>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 .../devicetree/bindings/rtc/nxp,pcf85063.txt          | 19 +++++++++++++++++++
 Documentation/devicetree/bindings/trivial-devices.txt |  1 -
 2 files changed, 19 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt b/Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt
new file mode 100644
index 000000000000..22ebb2ce52c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt
@@ -0,0 +1,19 @@
+* NXP PCF85063 Real Time Clock
+
+NXP PCF85063 Real Time Clock
+
+Required properties:
+- compatible: Should contain "nxp,pcf85063".
+- reg: I2C address for chip.
+
+Optional property:
+- nxp,quartz_load_12.5pF: The capacitive load on the quartz is 12.5 pF,
+  which differ from the default value of 7 pF
+
+Example:
+
+pcf85063: pcf85063@51 {
+	compatible = "nxp,pcf85063";
+	reg = <0x51>;
+	nxp,quartz_load_12.5pF;
+};
diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
index 297dc82b67ad..440632682e31 100644
--- a/Documentation/devicetree/bindings/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/trivial-devices.txt
@@ -170,7 +170,6 @@ nxp,pca9557		8-bit I2C-bus and SMBus I/O port with reset
 nxp,pcf2127		Real-time clock
 nxp,pcf2129		Real-time clock
 nxp,pcf8563		Real-time clock/calendar
-nxp,pcf85063		Tiny Real-Time Clock
 oki,ml86v7667		OKI ML86V7667 video decoder
 ovti,ov5642		OV5642: Color CMOS QSXGA (5-megapixel) Image Sensor with OmniBSI and Embedded TrueFocus
 pericom,pt7c4338	Real-time Clock Module
-- 
2.12.0

