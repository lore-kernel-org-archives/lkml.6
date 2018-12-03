Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D46EC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A23214D9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="AYMfQAZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A23214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeLCKI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:08:27 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:32854 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbeLCKIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:08:25 -0500
Received: by mail-wr1-f41.google.com with SMTP id c14so11471934wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8g+uoe2D0wbUmeVGWobhlMg09E9u+QyXMer1oiBcYAk=;
        b=AYMfQAZYz5o2/kkSAsIQmbtkGPKTB4spjIXNR78pptmK9KqHI1S0qOiAXe3PIPUt2V
         6cdy3GA7OWSQ8rNjvPHvrBMflwbnR3cKp1YFBn2C/D2DDtwxo7vm6oF7QYLOMAWNHCjy
         jXdBOT9NDpQf2ZAocmFItxwTfI/uDxMHEApmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8g+uoe2D0wbUmeVGWobhlMg09E9u+QyXMer1oiBcYAk=;
        b=UzwKUZpAIiDn4+OTLiuKZtE7E9EbDBcWhb9ryMdLcjM2wTOWEy8mB9olRhcyJVx5q/
         0qdMD3TL9wF/sX9aFG5tbdDQ1O+R9ymRkJ4k/BJlE9movD2Kb7114j0/araCxmmEjzFG
         Exr8QQDW+t3uxJ3CuoTTr/6o+T7CJtXjW1IEmPwDhrxkDuQyZWcnhLrF9STqlPPqSq/3
         ITtFvzcHb2HhG+BX8xdeYDyByzW5leTeLNhazAH8986m8R7DzqWFubedT3Y3G/Sj2Up4
         EnCwdjwrkoEL41F05NFd1qmZv99J4PS/Nwtyd4gjEaxWd06yjLWa5v5WPaXZAzBGpqma
         sg5A==
X-Gm-Message-State: AA+aEWbtsdPbwAIZjjcJHE/WSPZpaHhOz8bysND47lSqDJtFXb1UBhQR
        MRbuGIk8xAj66edpuDpAYWCiTg==
X-Google-Smtp-Source: AFSGD/XXnRvxPu+v/q0zi96QmqEJxLzAnSJQrpfhNl1nyainR2UMa5onjVEXfYEj5+c4mOqkVdyVbA==
X-Received: by 2002:adf:e846:: with SMTP id d6mr14057493wrn.72.1543831681810;
        Mon, 03 Dec 2018 02:08:01 -0800 (PST)
Received: from localhost.localdomain (conf.hotelmediterraneo.com. [2.228.78.71])
        by smtp.gmail.com with ESMTPSA id n15sm18589236wrt.21.2018.12.03.02.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 02:08:01 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 5/5] arm64: dts: allwinner: a64-amarula-relic: Add OV5640 camera node
Date:   Mon,  3 Dec 2018 15:37:47 +0530
Message-Id: <20181203100747.16442-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181203100747.16442-1-jagan@amarulasolutions.com>
References: <20181203100747.16442-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amarula A64-Relic board by default bound with OV5640 camera,
so add support for it with below pin information.

- PE13, PE12 via i2c-gpio bitbanging
- CLK_CSI_MCLK as external clock
- PE1 as external clock pin muxing
- DLDO3 as vcc-csi supply
- DLDO3 as AVDD supply
- ALDO1 as DOVDD supply
- ELDO3 as DVDD supply
- PE14 gpio for reset pin
- PE15 gpio for powerdown pin

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../allwinner/sun50i-a64-amarula-relic.dts    | 54 +++++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  5 ++
 2 files changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
index 6cb2b7f0c817..9ac6d773188b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
@@ -22,6 +22,41 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	i2c-csi {
+		compatible = "i2c-gpio";
+		sda-gpios = <&pio 4 13 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&pio 4 12 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <5>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ov5640: camera@3c {
+			compatible = "ovti,ov5640";
+			reg = <0x3c>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&csi_mclk_pin>;
+			clocks = <&ccu CLK_CSI_MCLK>;
+			clock-names = "xclk";
+
+			AVDD-supply = <&reg_dldo3>;
+			DOVDD-supply = <&reg_aldo1>;
+			DVDD-supply = <&reg_eldo3>;
+			reset-gpios = <&pio 4 14 GPIO_ACTIVE_LOW>; /* CSI-RST-R: PE14 */
+			powerdown-gpios = <&pio 4 15 GPIO_ACTIVE_HIGH>; /* CSI-STBY-R: PE15 */
+
+			port {
+				ov5640_ep: endpoint {
+					remote-endpoint = <&csi_ep>;
+					bus-width = <8>;
+					hsync-active = <1>; /* Active high */
+					vsync-active = <0>; /* Active low */
+					data-active = <1>;  /* Active high */
+					pclk-sample = <1>;  /* Rising */
+				};
+			};
+		};
+	};
+
 	wifi_pwrseq: wifi-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&rtc 1>;
@@ -30,6 +65,25 @@
 	};
 };
 
+&csi {
+	vcc-csi-supply = <&reg_dldo3>;
+	status = "okay";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		csi_ep: endpoint {
+			remote-endpoint = <&ov5640_ep>;
+			bus-width = <8>;
+			hsync-active = <1>; /* Active high */
+			vsync-active = <0>; /* Active low */
+			data-active = <1>;  /* Active high */
+			pclk-sample = <1>;  /* Rising */
+		};
+	};
+};
+
 &ehci0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index d32ff694ac5c..844bb44a78af 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -538,6 +538,11 @@
 				function = "csi0";
 			};
 
+			csi_mclk_pin: csi-mclk {
+				pins = "PE1";
+				function = "csi0";
+			};
+
 			i2c0_pins: i2c0_pins {
 				pins = "PH0", "PH1";
 				function = "i2c0";
-- 
2.18.0.321.gffc6fa0e3

