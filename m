Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D14C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC72420651
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kzHDavJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC72420651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbeJZXXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:23:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39744 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbeJZXXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:23:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id c25-v6so669153pfe.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=04KdMrY9mtNc8S8nXjCwQwnQ1yX1anhNtmkrnoFdsyE=;
        b=kzHDavJkBKEuNxBJGJXmVcZvHVE8c3PhDjf0C0QetI58w3llHUDa9sEX1LnBU+r9vR
         jB8wNhA9Avo5S1BxJmAoOenbADcDdaDbP8Fdw+SQlYvnDjIEoca+FohyzIPtKgjxQ2bO
         SP+F9mWdgv5/y6KhLISY3cmqQOOpF7bne1HkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=04KdMrY9mtNc8S8nXjCwQwnQ1yX1anhNtmkrnoFdsyE=;
        b=QT8ljw/keMm3UDmKFmQ2w0lo/4Tswe2lwZVSXQEf23fJcLbJMcEClM9a+XYq1p3Q8V
         huwxFJFVMMBB6Rpua0jVlm2PGXXhYShyB8H0hb8gnrMt9qSxjQ7kGXZUWd98hthR60FN
         vfhwO41/WWouH+Bpi56vx4qXq2ICTifB7bMSqJzgTMaykK53dpPGdBiVxF68DNXNZV+V
         Oa8Q/K5R/TIsgJdg3RYQfuzP3a1lGlyYcsYM7rALVrwcrEmEP2ChSW3YzGSbnI/QgDpN
         Bxxq+CIYGYsjdoSuhBMpuNSsx7Yf9uzWCglYYaBFTpsH7QA6yg8wb81UebMz+srIkDjb
         jYTw==
X-Gm-Message-State: AGRZ1gIlrRhtdpffJ0rWbjFuIuLAv4srksivox3jT2bwwRXzrQeJaapH
        M7fmV9zAtOY1/Pv2oTlh3Rc+c97x6HA=
X-Google-Smtp-Source: AJdET5f6MTIVMmNIvwzCOSzm7jx1xZ8DzZqc3aLbwSQ0SdAKgElQtiGUWyB6uScd3SKceYBey2wSjw==
X-Received: by 2002:a63:ce56:: with SMTP id r22-v6mr3703870pgi.217.1540565193758;
        Fri, 26 Oct 2018 07:46:33 -0700 (PDT)
Received: from localhost.localdomain ([27.7.51.1])
        by smtp.gmail.com with ESMTPSA id z22-v6sm12044467pgv.24.2018.10.26.07.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 07:46:33 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
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
Subject: [PATCH v3 25/25] arm64: dts: allwinner: a64-amarula-relic: Enable Techstar TS8550B MIPI-DSI panel
Date:   Fri, 26 Oct 2018 20:13:44 +0530
Message-Id: <20181026144344.27778-26-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181026144344.27778-1-jagan@amarulasolutions.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amarula A64-Relic board by default bound with Techstar TS8550B
MIPI-DSI panel, add support for it.

DSI panel connected via board DSI port with,
- DC1SW as AVDD supply
- DCDC2 as DVDD supply
- DCDC1 as VCC-DSI supply
- PD24 gpio for reset pin
- PD23 gpio for backlight enable pin

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- new patch

 .../allwinner/sun50i-a64-amarula-relic.dts    | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
index 6cb2b7f0c817..ecc0d8094815 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
@@ -9,6 +9,7 @@
 #include "sun50i-a64.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "Amarula A64-Relic";
@@ -18,6 +19,14 @@
 		serial0 = &uart0;
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <1 2 4 8 16 32 64 128 512>;
+		default-brightness-level = <2>;
+		enable-gpios = <&pio 3 23 GPIO_ACTIVE_HIGH>; /* LCD-BL-EN: PD23 */
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -30,6 +39,28 @@
 	};
 };
 
+&de {
+	status = "okay";
+};
+
+&dphy {
+	status = "okay";
+};
+
+&dsi {
+	vcc-dsi-supply = <&reg_dldo1>;
+	status = "okay";
+
+	panel@0 {
+		compatible = "techstar,ts8550b";
+		reg = <0>;
+		avdd-supply = <&reg_dc1sw>;
+		dvdd-supply = <&reg_dldo2>;
+		reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
+		backlight = <&backlight>;
+	};
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -72,6 +103,12 @@
 	status = "okay";
 };
 
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm_pin>;
+	status = "okay";
+};
+
 &r_rsb {
 	status = "okay";
 
@@ -107,6 +144,15 @@
 	regulator-name = "vcc-pll-avcc";
 };
 
+&reg_dc1sw {
+	/*
+	 * This regulator also indirectly drives the PD pingroup GPIOs,
+	 * which also controls the power LED.
+	 */
+	regulator-always-on;
+	regulator-name = "vcc-phy";
+};
+
 &reg_dcdc1 {
 	regulator-always-on;
 	regulator-min-microvolt = <3300000>;
-- 
2.18.0.321.gffc6fa0e3

