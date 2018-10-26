Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB2EECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169CA20651
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="p/Xw8STA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 169CA20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbeJZXXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:23:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37506 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbeJZXXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:23:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id c10-v6so652272pgq.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q6u30J53lPheTTjrrL7nM+PLAo3DbPBTmQWn02a2iHU=;
        b=p/Xw8STAMTpBBLncROH5aKHWB2b0L06z/UhiqQp2F9+VrSZOIDsV0mmfx9hVuftiHz
         pK5lph159Au6unI7SZNuaBJx+68/tHXUO1pND1fb0FXjmgJvdR0H2V5WMMdXQFSiNYoQ
         Gb08ac3/q7cJqmSElroxmGb2h1MNwOkptPQ1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q6u30J53lPheTTjrrL7nM+PLAo3DbPBTmQWn02a2iHU=;
        b=QGl9J+MQYHoONXmLkXYQT2f91K+BMEIBj6SKpc/CzrpzxYdxrVhYy4VFf+dNexFGc3
         qT9q0ppnBfIrCbdGtt9emHm33ZyH8RROHGb1aHr6L+kSJMfeQO6a/znFx8xK0MTntC7H
         afIjFzNf7RYqna6gkYnZ2W59r0WizApRuPSUaUpBBrC+yVFXNnAVhhzjQJ5Bo2Zdsxzh
         /BWKvFGSAzF/5MNRcg4yJR2bDU5olpH1buYtDQceyl1ZFVzGGmQQHNwBpCRI+rdxuEmu
         RNUq5GgIdd/wRQjxhttvXfwEwnm7DsKsFdTaD/A+u9D+EzhKAiAQMhYXUDF2FSvipWMY
         9VUQ==
X-Gm-Message-State: AGRZ1gIGb6+EnBooDmCHdXS5NOvTM6pEF32DKbVDvfqJ4ADbUGaG0Ksk
        OWidJLyy1cB6+V2bj7YGrKO7Aw==
X-Google-Smtp-Source: AJdET5cgG0qlCI/VdYgL30LMx8lLSWukX6LeQQzQtqXJQ27TFAV39x3nA8JEMtCOtgWz3vmexzHz1Q==
X-Received: by 2002:a63:dc54:: with SMTP id f20mr3787544pgj.410.1540565188096;
        Fri, 26 Oct 2018 07:46:28 -0700 (PDT)
Received: from localhost.localdomain ([27.7.51.1])
        by smtp.gmail.com with ESMTPSA id z22-v6sm12044467pgv.24.2018.10.26.07.46.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 07:46:27 -0700 (PDT)
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
Subject: [PATCH v3 24/25] [DO NOT MERGE] arm64: dts: allwinner: bananapi-m64: Bananapi S070WV20-CT16 DSI panel
Date:   Fri, 26 Oct 2018 20:13:43 +0530
Message-Id: <20181026144344.27778-25-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181026144344.27778-1-jagan@amarulasolutions.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
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
Tested-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- remove unit address 0
- add nodes in alphabetical order
- Use backlight instead of backlight_dsi
- add tested credit
Changes for v2:
- Use quadratic rule on pwm brightness

 .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index ef1c90401bb2..6cb010e3bbd9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -45,6 +45,7 @@
 #include "sun50i-a64.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "BananaPi-M64";
@@ -56,6 +57,15 @@
 		serial1 = &uart1;
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&r_pwm 0 50000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <1 2 4 8 16 32 64 128 512>;
+		default-brightness-level = <2>;
+		enable-gpios = <&pio 3 5 GPIO_ACTIVE_HIGH>; /* LCD-BL-EN: PD5 */
+		power-supply = <&reg_vdd_backlight>;
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -91,6 +101,15 @@
 		};
 	};
 
+	reg_vdd_backlight: vdd-backlight {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd-backlight";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pio 3 7 GPIO_ACTIVE_HIGH>; /* LCD-PWR-EN: PD7 */
+		enable-active-high;
+	};
+
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
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
+		reset-gpios = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD6 */
+		backlight = <&backlight>;
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

