Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140FCC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA64022507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Dv16mTKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA64022507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733009AbeKMVRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:17:12 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46611 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732418AbeKMVRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:17:12 -0500
Received: by mail-pf1-f194.google.com with SMTP id s9-v6so5868171pfm.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 03:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SYvsDZFatZNo8KTo2brjgveRTySLcBTtFJwHL/yY9k0=;
        b=Dv16mTKbMxtpErNDUmEh+zfhaf3fKwqMnSIW9RBbJh6fKgooYqRs/noey6KlP+ujEu
         Zjr0YO40cstJc0BEZlVbBMgp4ARAr38G0s8mCeYN+LL8odW40qCxKLRpX/fRzin26oOM
         QbxIw32B7AfZdDcNC1+L5IUiTrUtSreh99huQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SYvsDZFatZNo8KTo2brjgveRTySLcBTtFJwHL/yY9k0=;
        b=Si0qzgtfly8ojyZMjEz1VMk8qBvU16K947ON7uPTTLEwtsuCJXafSI37R1oW5PeIFw
         tMlS+9P3Oh4stY3scGk53z0O9iyRzjieQRy2acfj0EdUFXBIGiS6pLgvH9EiqkahHJBG
         MEd858MWGyACbkfz/ol0nVM1J2DtWdVysfX4oMliF6RQ1BBxhhlrv5od4BGAOBVVSBRx
         bAzpbYPs9HJztyTkrCo/FqgvUD1GmgIeFHObJtzCvyEt1ydQwPctWNgW+WgiAVJCWOD+
         ++dNKxjM54DH/oPxICpRL4PwVVBpQgKk1FgzV56XAkaxg66lJ046eb3YH8tYeMMA/bDh
         OHyQ==
X-Gm-Message-State: AGRZ1gKEdjtjbPca2HlOIJfnWG8LHAdfiGaRUzepi1xT/zaerQjOAENO
        CeztXqKiNlSNsJCC4gSz84Yj6A==
X-Google-Smtp-Source: AJdET5dhef3zHWl6a/7x7lhsAttAAaHHpP3FIb9XZmOXPQBl1Ydz+eFHawtisZ7Dno7t6QaYZeKkng==
X-Received: by 2002:a63:af18:: with SMTP id w24mr4397635pge.385.1542107973054;
        Tue, 13 Nov 2018 03:19:33 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:3670:3f11:bc71:2ef7:4a39:e260])
        by smtp.gmail.com with ESMTPSA id 27-v6sm28531377pfm.36.2018.11.13.03.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 03:19:32 -0800 (PST)
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
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4 26/26] arm64: dts: allwinner: a64-amarula-relic: Enable Techstar TS8550B MIPI-DSI panel
Date:   Tue, 13 Nov 2018 16:46:33 +0530
Message-Id: <20181113111633.20189-27-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181113111633.20189-1-jagan@amarulasolutions.com>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
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
---
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

