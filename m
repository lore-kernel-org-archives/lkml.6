Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DADC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47C72086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="n0lVMIhf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47C72086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbeLJLxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:53:45 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:52153 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727694AbeLJLxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 06:53:42 -0500
Received: by mail-wm1-f46.google.com with SMTP id s14so10654986wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 03:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xKc4rpirIDSNGgBaxIhfJAOtD80I9o5vCC89+wiWkHs=;
        b=n0lVMIhf/pt2IhkdEtL/kB0UPnc12c5yZJO8z1mlEQchur8xRLpaFk1VbVOvFlJQ1g
         Mj92rLsdzeV6FTj2vMCaJnKQjTuqWrx1tUfhMFiacFRjso4P91fpKg6jExzPm7lVjBc3
         APnAy8mCqdqqm1rIvJ+0Dfbuilzxi1Cq3itL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xKc4rpirIDSNGgBaxIhfJAOtD80I9o5vCC89+wiWkHs=;
        b=R5P2fUg8XOePlkn0ZNIfR6mQ1Dls688w9++g7XqZIKKLuhZ0tp7QaIBN2E1Wp2xFrl
         FZTmIQbnb75eseCZqh9PHdubSiQvusb0pS8L2W990UdqYtXwYTq81qmk/yqCDeRxwKgD
         Oaiyz62y1an7aBfLOGH0ih7Dr7C2bv4LzILZrfzvQv4jX+5AgMgcjs6mmHiPVM2sPTdC
         z4HJPoAC996GPhF5JnQ1T5CsIdwIqXmqgGXybs3HjfJwDZ+8hsY+QtHgwufwx84FMi0S
         tsRMi7CP9vMSv0JJTFty2YH5BTrrHUl0PnJJj3bP6lzCzMnDtNI8+3J/XRH646V45PWH
         Xj2A==
X-Gm-Message-State: AA+aEWavlClhaxMpaMzuB3qUXBz4LdhpCWHZMAEzUEOf5jbS7EJCY/9v
        39Or92KfpUBZp4n/CbSHber1Lw==
X-Google-Smtp-Source: AFSGD/WnBP1Yq/JRouF0m4at1X0DT0N5cwK9FxnDzEubdisXhm7dXDnKqLaqkQ+t2zSaxIkyjtCAbA==
X-Received: by 2002:a1c:d912:: with SMTP id q18mr10093519wmg.122.1544442819830;
        Mon, 10 Dec 2018 03:53:39 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com. [213.198.162.59])
        by smtp.gmail.com with ESMTPSA id b16sm7869243wrm.41.2018.12.10.03.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 03:53:38 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 6/6] arm64: dts: allwinner: a64-amarula-relic: Add OV5640 camera node
Date:   Mon, 10 Dec 2018 17:22:46 +0530
Message-Id: <20181210115246.8188-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210115246.8188-1-jagan@amarulasolutions.com>
References: <20181210115246.8188-1-jagan@amarulasolutions.com>
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
- ALDO1 as AVDD supply
- DLDO3 as DOVDD supply
- ELDO3 as DVDD supply
- PE14 gpio for reset pin
- PE15 gpio for powerdown pin

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../allwinner/sun50i-a64-amarula-relic.dts    | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
index 6cb2b7f0c817..ea6286ce5de3 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
@@ -22,6 +22,41 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	i2c-csi {
+		compatible = "i2c-gpio";
+		sda-gpios = <&pio 4 13 GPIO_ACTIVE_HIGH>; /* CSI-SDA: PE13 */
+		scl-gpios = <&pio 4 12 GPIO_ACTIVE_HIGH>; /* CSI-SCK: PE12 */
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
+			AVDD-supply = <&reg_aldo1>;
+			DOVDD-supply = <&reg_dldo3>;
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
@@ -30,6 +65,24 @@
 	};
 };
 
+&csi {
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
-- 
2.18.0.321.gffc6fa0e3

