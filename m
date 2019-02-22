Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FDDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F8D20651
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fBNrSvoT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfBVWyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:54:06 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43931 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfBVWyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:54:03 -0500
Received: by mail-pg1-f196.google.com with SMTP id l11so1741481pgq.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 14:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8BXw3ZHIYVqI7gUabwMIYanS3N5oJSBfJnmbDn81unQ=;
        b=fBNrSvoTwca7CmmLOXS7hVF9dXkptUNho4FX1YtIQbBYx4j3ThWKRtAMvcWBG9viSx
         8YGW6iPJDKHqdIj9FUdlVP2pS/kR6C10jG26iddZfZqSoBWzPsprKh3srU39Bp+9IKtd
         RbRvWV5U3/MY3RSmE8kvSPzMYpVuto6i3ReB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8BXw3ZHIYVqI7gUabwMIYanS3N5oJSBfJnmbDn81unQ=;
        b=FrHjlb2q7Q+QMZ+zCTeEyrAT1rCRD5XpE9ZPdMqiLAgQCtBU6DJrQFPtmjuaV7n/Ec
         w8t6+97nuTmpGv+0Z5pzV2bPqqGgqeW1axBdUAu16b+TtFwfzU9XUC+USOgmK/Eackkp
         tkDzE1530mFJkcsw+c/I31VcP3T78Tz45jve2MXB1QiCNC4FOOjojxXAgyBFoMYR/dCE
         WdQYDbesKKTvMxgW7ciH7xwBMgTTdk5izvwguh4ONu5zsL+MPU6PsvBpVZ+Yrv6n10KZ
         L9tNEKNyqO5Pw152CCMMqzCdKcodXLH+RwoQDHnqrjc7reoSIY1lKjbzUF6lmvBaNw49
         Ajow==
X-Gm-Message-State: AHQUAuZtfSfGvVmtPy6egh/ADPOVxUKzICe8WEvLmhTQ22tkamiyU3lV
        gbs7TNZSlTMu/DN4xQa0bS4qrA==
X-Google-Smtp-Source: AHgI3IbfKc/mdIHLhW/nIrPvqnp6/k2674ZMTQLwTY9Oj+x7/526fXdLzLzAAFq3iPEcP8QkZZkwlg==
X-Received: by 2002:aa7:9255:: with SMTP id 21mr6663437pfp.8.1550876042694;
        Fri, 22 Feb 2019 14:54:02 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id g185sm3994995pfc.174.2019.02.22.14.54.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 14:54:01 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 3/3] arm64: dts: rockchip: move QCA6174A wakeup pin into its USB node
Date:   Fri, 22 Feb 2019 14:53:45 -0800
Message-Id: <20190222225345.69084-3-briannorris@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190222225345.69084-1-briannorris@chromium.org>
References: <20190222225345.69084-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we don't coordinate BT USB activity with our handling of the
BT out-of-band wake pin, and instead just use gpio-keys. That causes
problems because we have no way of distinguishing wake activity due to a
BT device (e.g., mouse) vs. the BT controller (e.g., re-configuring wake
mask before suspend). This can cause spurious wake events just because
we, for instance, try to reconfigure the host controller's event mask
before suspending.

We can avoid these synchronization problems by handling the BT wake pin
directly in the btusb driver -- for all activity up until BT controller
suspend(), we simply listen to normal USB activity (e.g., to know the
difference between device and host activity); once we're really ready to
suspend the host controller, there should be no more host activity, and
only *then* do we unmask the GPIO interrupt.

This is already supported by btusb; we just need to describe the wake
pin in the right node.

We list 2 compatible properties, since both PID/VID pairs show up on
Scarlet devices, and they're both essentially identical QCA6174A-based
modules.

Also note that the polarity was wrong before: Qualcomm implemented WAKE
as active high, not active low. We only got away with this because
gpio-keys always reconfigured us as bi-directional edge-triggered.

Finally, we have an external pull-up and a level-shifter on this line
(we didn't notice Qualcomm's polarity in the initial design), so we
can't do pull-down. Switch to pull-none.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
v2:
 * drop leading zeroes from VID
 * rename 'bt' node to 'bluetooth'
---
 .../dts/rockchip/rk3399-gru-chromebook.dtsi   | 13 ++++++
 .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi | 46 ++++++++++++-------
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  | 13 ------
 3 files changed, 42 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
index c400be64170e..931640e9aed4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
@@ -200,6 +200,19 @@
 		pinctrl-0 = <&bl_en>;
 		pwm-delay-us = <10000>;
 	};
+
+	gpio_keys: gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_host_wake_l>;
+
+		wake_on_bt: wake-on-bt {
+			label = "Wake-on-Bluetooth";
+			gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_WAKEUP>;
+			wakeup-source;
+		};
+	};
 };
 
 &ppvar_bigcpu {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
index fc50b3ef758c..62ea7d6a7d4a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
@@ -175,6 +175,21 @@
 		pinctrl-0 = <&dmic_en>;
 		wakeup-delay-ms = <250>;
 	};
+
+	gpio_keys: gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pen_eject_odl>;
+
+		pen-insert {
+			label = "Pen Insert";
+			/* Insert = low, eject = high */
+			gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
+			linux,code = <SW_PEN_INSERTED>;
+			linux,input-type = <EV_SW>;
+			wakeup-source;
+		};
+	};
 };
 
 /* pp900_s0 aliases */
@@ -328,20 +343,6 @@ camera: &i2c7 {
 		<400000000>;
 };
 
-&gpio_keys {
-	pinctrl-names = "default";
-	pinctrl-0 = <&bt_host_wake_l>, <&pen_eject_odl>;
-
-	pen-insert {
-		label = "Pen Insert";
-		/* Insert = low, eject = high */
-		gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
-		linux,code = <SW_PEN_INSERTED>;
-		linux,input-type = <EV_SW>;
-		wakeup-source;
-	};
-};
-
 &i2c_tunnel {
 	google,remote-bus = <0>;
 };
@@ -437,8 +438,19 @@ camera: &i2c7 {
 	status = "okay";
 };
 
-&wake_on_bt {
-	gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
+&usb_host0_ohci {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	qca_bt: bluetooth@1 {
+		compatible = "usbcf3,e300", "usb4ca,301a";
+		reg = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_host_wake_l>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "wakeup";
+	};
 };
 
 /* PINCTRL OVERRIDES */
@@ -455,7 +467,7 @@ camera: &i2c7 {
 };
 
 &bt_host_wake_l {
-	rockchip,pins = <1 2 RK_FUNC_GPIO &pcfg_pull_up>;
+	rockchip,pins = <1 2 RK_FUNC_GPIO &pcfg_pull_none>;
 };
 
 &ec_ap_int_l {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index ea607a601a86..da03fa9c5662 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -269,19 +269,6 @@
 		#clock-cells = <0>;
 	};
 
-	gpio_keys: gpio-keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&bt_host_wake_l>;
-
-		wake_on_bt: wake-on-bt {
-			label = "Wake-on-Bluetooth";
-			gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_WAKEUP>;
-			wakeup-source;
-		};
-	};
-
 	max98357a: max98357a {
 		compatible = "maxim,max98357a";
 		pinctrl-names = "default";
-- 
2.21.0.rc0.258.g878e2cd30e-goog

