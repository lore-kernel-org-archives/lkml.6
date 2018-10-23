Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D18C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B66A20665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HZJ1xqPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B66A20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbeJXAQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:16:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39043 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbeJXAQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:16:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id r9-v6so856185pgv.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 08:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HlqvyVxrx75NOn82GVMXgOU3Afz6lacgakwTsKXnt2w=;
        b=HZJ1xqPB9nZ8Qbe4tx6apMvmSRog4qRr3R4fe4cl0MyXhBvjytpa8LyA6Ca7FbXszV
         N5QsZ7XCp5w8jMBJpcI6Mu3+NHONjoN4XeVTa59Fs8JJ3xISx94syh2VVULEEixd6Xwn
         rHhXI7nkKrreXotjIyrFsy8+SJCZmL8EaJiS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HlqvyVxrx75NOn82GVMXgOU3Afz6lacgakwTsKXnt2w=;
        b=UPwihReUD6RX17jODvoRa2DS4FO3UpukfCodI1gEFcYN8hKY+mMvtI8hggsmmiJhc7
         Cp7D2y1nhM1lbqpQguKdhdj5P3PUlV1+QRhdOX3+KFktiwfofsCNTebaYlT9y8GVjpx0
         VFF2Fl96py9vqy+sjSjNXBMktbSxVtsPeO3r6PMvvZTvRNsb2GoYSZsixSN9BARZv3KH
         BKWHYvkw4Vc5uLZHS8SIVJ5EG3NJKHyFhtl8XrcKdcG9glDY6RsY8r3HiAETFQ1B6zAJ
         mgIBsjuqqzQZy2Yi4L26eEthc7Vi5MyR0BC2+GrJ3xsJHy3Mw7AOXLnI2djALgbhhHCT
         /WxQ==
X-Gm-Message-State: AGRZ1gJN9oHndsBO4xzTekpMMXbONX814FOoq7K2cfCvtHAFNroD0ICE
        J5CM+V7odkiIlVNg5BV98/2aRg==
X-Google-Smtp-Source: AJdET5c8geUzHYhcbqgCFVoE13rlTg+25LzQx0dpHwZyYviAPpqPto11GZ/hPY5qyyegy+6hh4k9Ww==
X-Received: by 2002:a63:3204:: with SMTP id y4mr1808778pgy.41.1540309943547;
        Tue, 23 Oct 2018 08:52:23 -0700 (PDT)
Received: from localhost.localdomain ([27.7.51.1])
        by smtp.gmail.com with ESMTPSA id o75-v6sm7442829pfg.0.2018.10.23.08.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 08:52:23 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 15/15] arm64: dts: allwinner: bananapi-m64: Bananapi S070WV20-CT16 DSI panel
Date:   Tue, 23 Oct 2018 21:20:35 +0530
Message-Id: <20181023155035.9101-16-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181023155035.9101-1-jagan@amarulasolutions.com>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for Bananapi S070WV20-CT16 DSI panel to
BPI-M64 board.

DSI panel connected via board DSI port with,
- DC1SW as AVDD supply
- DCDC1 as DVDD supply
- PD6 gpio for reset pin
- PD5 gpio for backlight enable pin
- PD7 gpio for backlight vdd supply

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- Use quadratic rule on pwm brightness

 .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index ef1c90401bb2..e0c6d1870a94 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -45,6 +45,7 @@
 #include "sun50i-a64.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "BananaPi-M64";
@@ -56,6 +57,24 @@
 		serial1 = &uart1;
 	};
 
+	vdd_bl: regulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "bl-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pio 3 7 GPIO_ACTIVE_HIGH>; /* PD7 */
+		enable-active-high;
+	};
+
+	backlight_dsi: backlight-dsi {
+		compatible = "pwm-backlight";
+		pwms = <&r_pwm 0 50000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <1 2 4 8 16 32 64 128 512>;
+		default-brightness-level = <2>;
+		enable-gpios = <&pio 3 5 GPIO_ACTIVE_HIGH>; /* PD5 */
+		power-supply = <&vdd_bl>;
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -101,6 +120,23 @@
 	status = "okay";
 };
 
+&dphy {
+	status = "okay";
+};
+
+&dsi {
+	status = "okay";
+
+	panel@0 {
+		compatible = "bananapi,s070wv20-ct16-icn6211";
+		reg = <0>;
+		avdd-supply = <&reg_dc1sw>;
+		dvdd-supply = <&reg_dldo1>;
+		reset-gpios = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
+		backlight = <&backlight_dsi>;
+	};
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -193,6 +229,12 @@
 	status = "okay";
 };
 
+&r_pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&r_pwm_pin>;
+	status = "okay";
+};
+
 &r_rsb {
 	status = "okay";
 
-- 
2.18.0.321.gffc6fa0e3

