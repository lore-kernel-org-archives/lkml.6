Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51497C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BE520838
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lNiHCA9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfBVAeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 19:34:18 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34932 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfBVAeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 19:34:15 -0500
Received: by mail-pf1-f195.google.com with SMTP id j5so251786pfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 16:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RR7eeTc5evmNysGncoSTvgraRGvki7PHizg2IrrqAno=;
        b=lNiHCA9jEGDfOnBWLjteJsSGpKbT9OoEUAQ/tUgxTgvzm2xQsZDCGyGv19fdPOGCQQ
         KH/ce28Lu26d6ScU7Sgy+r0Z+3wz4qWjYKMDH9Shu+06vPfccRuITkW5PT50IgZM4xd2
         73FUTUUX14iiOaazpXJmd8Osg1ZdhuaFAZltI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RR7eeTc5evmNysGncoSTvgraRGvki7PHizg2IrrqAno=;
        b=cEQLDHB1eru/+lowE67CohxCjSjlgaa7K6utdd6RBOZqtqWTHqmma5wWVNpoOT1eL0
         q4AqWZLOH4HToOZKKeO5WA0MswZdEpx+kCsOd2+5k2qwIpAoxe+GditgKHNja32gYaE+
         eA6D0CPtE5XAdN2lwFXMtyGPKwMmcDNFtTQCpWgI5IYBN7AAjc87LVplB0e6M8E6EA67
         qj35uf5VoP2tDh+McBgdgaAa+JDEoSbVe7E/3is9LHcpsIEPT6+VybL/5FgtGXyrbssY
         v0tfo+sE7WHAxxIid+fHwJB8vPU23QTcz+OkyJJOkbolB61D8S8m/1BDKHXC06arnE0+
         c7Hw==
X-Gm-Message-State: AHQUAuauHqm2KHQ2flcFZ73O7OtTycsePaA6sEs5MoD/Tk6YSDmP5ceW
        iHCY+24T0ZX6yOFOJx5kYFUAPQ==
X-Google-Smtp-Source: AHgI3IbCtnM2qcA6AOxb+Ppo9HLPiQkuBDM0wJ6iE8J31zCdd5IcDff5ZHPf/002z3h3kfbvW7tEVQ==
X-Received: by 2002:a62:ee13:: with SMTP id e19mr1315978pfi.224.1550795653788;
        Thu, 21 Feb 2019 16:34:13 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id c3sm269830pfg.53.2019.02.21.16.34.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 16:34:12 -0800 (PST)
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
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 3/3] arm64: dts: rockchip: move QCA6174A wakeup pin into its USB node
Date:   Thu, 21 Feb 2019 16:34:03 -0800
Message-Id: <20190222003403.128243-3-briannorris@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190222003403.128243-1-briannorris@chromium.org>
References: <20190222003403.128243-1-briannorris@chromium.org>
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
---
This patch is also required to make this stable, but since it's not
really tied to the device tree, and it's an existing bug, I sent it
separately:

  https://lore.kernel.org/patchwork/patch/1044896/
  Subject: Bluetooth: btusb: request wake pin with NOAUTOEN

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
index fc50b3ef758c..3e2196c08473 100644
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
+	qca_bt: bt@1 {
+		compatible = "usb0cf3,e300", "usb04ca,301a";
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

