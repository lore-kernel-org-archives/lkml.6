Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D876BC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A509620827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O207XpcR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbfAHSys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:54:48 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44454 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbfAHSyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:54:46 -0500
Received: by mail-lj1-f194.google.com with SMTP id k19-v6so4292884lji.11;
        Tue, 08 Jan 2019 10:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Jxc09nR2EzuAI4Quh7s7X+Br0y1JbQDF3E2+ykcUnI=;
        b=O207XpcReODflK0r4occHODJUvXmZlg4+FTU71Fj37O3nFCbiCHcj1uuIESE0I9e9c
         MUv8dGIadhqsMurTBErqqNAlfuZ93ZjEpRE40GlUrYBp6/9OHWCeSUmxJYcE4Ymo3O16
         4ccEmTXhBamd/kcEm3XKUHOxMgXvJ0o4J8Zmddw0TuGPvI6mJ/VGjiTauTlqnLtMDxgz
         cjOqGRdsgUSP7vqSMpjd7dWRdszUCEI2JLmU0AAhkjBiGBxm6adsPyuwHZ5zWozWFIU/
         EWYUgsbUPdmlqtsyI/Nrp35WJ2zgC1hl8N7S3yiAaxXBcp4nqrlfBeC8Uu5o/jg9kzjB
         Yzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=4Jxc09nR2EzuAI4Quh7s7X+Br0y1JbQDF3E2+ykcUnI=;
        b=mN72LILgRYygvpp80nlMF526fqZ4O7q6CFc1W+9V2M4ixrgbzyoL/SAb4zSl0z+8wd
         kGKl6EM8JTFyfMhRHbLEAkgkYJ81cjzNcWu6FyBiHeQikuVmTK7E4lpwZI2z3H4a7DoZ
         mvQt7C8k8LAT6v2sszoI4dy0Ifyi3uemnLIw1lCPmeYoCOGJbNZ2c1YAvcxta61EHMm5
         ipplylU19h3ImnZf23tTI+SrxV/ejdJvLe2K+iAvkeowOSVcFdy/LjAGDTZlU/EwXWLL
         z4S4b7rgnJ8AHdFTOOJ5EG0RWkw06LsTy34G37CP/t/jiKWzGCgqqP0DiCBDy6bHq46o
         7+2g==
X-Gm-Message-State: AJcUukd/jPGL3HO3WNtga9JjTeMbmyHc5V0qFR6G5yeJfXdAqdOBu+tX
        +UMW0bm4XeQLbY3bz1YjbHc=
X-Google-Smtp-Source: ALg8bN7X8nkPtp446DV1G+m+O+Jw38/ARvRpiPBJD+CyaYM2T1pu2X+P51I245aLys1KpjBI6Ses4Q==
X-Received: by 2002:a2e:868c:: with SMTP id l12-v6mr1902323lji.90.1546973683926;
        Tue, 08 Jan 2019 10:54:43 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a11sm13321648lff.68.2019.01.08.10.54.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 10:54:43 -0800 (PST)
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
Subject: [PATCH v2 3/5] dt-binding: pcf85063: add xtal load capacitance
Date:   Tue,  8 Jan 2019 19:54:12 +0100
Message-Id: <20190108185414.26922-4-sam@ravnborg.org>
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
index 000000000000..ad5e8eaa370e
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
+pcf85063: pcf85063@51 {
+	compatible = "nxp,pcf85063";
+	reg = <0x51>;
+	quartz-load-femtofarads = <12500>;
+};
diff --git a/Documentation/devicetree/bindings/rtc/rtc.txt b/Documentation/devicetree/bindings/rtc/rtc.txt
index e07b15d151ac..efac6dc5b914 100644
--- a/Documentation/devicetree/bindings/rtc/rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/rtc.txt
@@ -52,7 +52,6 @@ microcrystal,rv3029	Real Time Clock Module with I2C-Bus
 nxp,pcf2127		Real-time clock
 nxp,pcf2129		Real-time clock
 nxp,pcf8563		Real-time clock/calendar
-nxp,pcf85063		Tiny Real-Time Clock
 pericom,pt7c4338	Real-time Clock Module
 ricoh,r2025sd		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
 ricoh,r2221tl		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
-- 
2.12.0

