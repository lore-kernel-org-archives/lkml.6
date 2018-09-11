Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25566C46469
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 02:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44E720865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 02:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UvEWSGR0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44E720865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbeIKH2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 03:28:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36295 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbeIKH2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 03:28:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id d1-v6so11438369pgo.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 19:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hSYOd7dNccYUVmVYlbggsH+0qcQaz/KvUWzO+ef+8ns=;
        b=UvEWSGR0cBBe/2osmiKYR0MYNAZt9lSp1xXPZFMih2FFCUdjBVcKmT6v/y8yimoeVR
         /2BVbINMW8zIl4pvfQyjNraZv0TDepPXxK/X/dj84wQNsrJkP5OfIMD/nq4ngDSDNwbu
         Jea7ZWjw8yZE/9ARlOJOfliU+YbqT5kGhR+zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hSYOd7dNccYUVmVYlbggsH+0qcQaz/KvUWzO+ef+8ns=;
        b=mk4j4wB/8ABUurQbgzjJtu0Fu/FnCmjiMtrNUVLBkS8LVuaXcbBCJC/6f6+rus+ilG
         X8ekvsxkwpoZBPbLZmEGUNUEFRanmmmCo7Ubkn4L1wp0VYDSytzpYRn/L4lAF0OZKP0x
         tj46NfUzIAP4jKQixm9MFxe9WokPQSJZjulAN6GJwmpdoBIg/v1rBpSBztg0vsI+vC0O
         PRpWIZdnVo50OKqLpSwIoZz3em4gCYCzCczTTsbxHQlsTvkJUMrXQXoIDfSW1QSV5x13
         psH+8M4NdmDe7exEuWCnAhPKn4nbTR3mmCY6c5ikI0qIzxVjujFr6B/lyRN7KDGycjng
         +C6w==
X-Gm-Message-State: APzg51BXjoewYRVBhwQ4lQNPsa6fN+zvZO4ob1pOWZ59scLQMPCO6818
        j5B8nz4Kp4NWCD3jiV0idPd8
X-Google-Smtp-Source: ANB0VdaZ4Ei0QAiL32EvJNMiXMlcPnsRUbiU164ahoNnU+gSwDNYW39R++WHI3uACXIgG6g50ATDJw==
X-Received: by 2002:a63:fd06:: with SMTP id d6-v6mr25201396pgh.348.1536633075269;
        Mon, 10 Sep 2018 19:31:15 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7200:d313:f895:c3fd:ee92:ac72])
        by smtp.gmail.com with ESMTPSA id y85-v6sm27025893pfa.170.2018.09.10.19.31.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 19:31:14 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     heiko@sntech.de, robh+dt@kernel.org
Cc:     vicencb@gmail.com, shawn.lin@rock-chips.com,
        ezequiel@collabora.com, enric.balletbo@collabora.com,
        pbrobinson@gmail.com, tom@vamrs.com, dev@vamrs.com,
        stephen@vamrs.com, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 3/4] arm64: boot: dts: rockchip: Add support for Rock960 board
Date:   Tue, 11 Sep 2018 08:00:30 +0530
Message-Id: <20180911023031.4892-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180911023031.4892-1-manivannan.sadhasivam@linaro.org>
References: <20180911023031.4892-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree support for Rock960 board, one of the Consumer Edition
boards of the 96Boards family. This board support utilizes the common
Rock960 family board support that includes Ficus 96Board.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3399-rock960.dts      | 139 ++++++++++++++++++
 2 files changed, 140 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock960.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index b0092d95b574..57c0d76458e6 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -14,5 +14,6 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-firefly.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-bob.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-kevin.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock960.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
new file mode 100644
index 000000000000..37242b64a7a3
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2018 Linaro Ltd.
+ */
+
+/dts-v1/;
+#include "rk3399-rock960.dtsi"
+
+/ {
+	model = "96boards Rock960";
+	compatible = "vamrs,rock960", "rockchip,rk3399";
+
+	chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+
+	vcc3v3_pcie: vcc3v3-pcie-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio2 5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie_drv>;
+		regulator-boot-on;
+		regulator-name = "vcc3v3_pcie";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc3v3_sys>;
+	};
+
+	vcc5v0_host: vcc5v0-host-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio4 25 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&host_vbus_drv>;
+		regulator-name = "vcc5v0_host";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		vin-supply = <&vcc_sys>;
+	};
+};
+
+&pinctrl {
+	pcie {
+		pcie_drv: pcie-drv {
+			rockchip,pins =
+				<2 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+			};
+	};
+
+	usb2 {
+		host_vbus_drv: host-vbus-drv {
+			rockchip,pins =
+				<4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&pcie_phy {
+	status = "okay";
+};
+
+&pcie0 {
+	ep-gpios = <&gpio2 RK_PA2 GPIO_ACTIVE_HIGH>;
+	num-lanes = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_clkreqn_cpm>;
+	vpcie3v3-supply = <&vcc3v3_pcie>;
+	status = "okay";
+};
+
+&tcphy0 {
+	status = "okay";
+};
+
+&tcphy1 {
+	status = "okay";
+};
+
+&u2phy0 {
+	status = "okay";
+};
+
+&u2phy1 {
+	status = "okay";
+};
+
+&u2phy0_host {
+	phy-supply = <&vcc5v0_host>;
+	status = "okay";
+};
+
+&u2phy1_host {
+	phy-supply = <&vcc5v0_host>;
+	status = "okay";
+};
+
+&u2phy0_otg {
+	status = "okay";
+};
+
+&u2phy1_otg {
+	status = "okay";
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+&usb_host1_ehci {
+	status = "okay";
+};
+
+&usb_host1_ohci {
+	status = "okay";
+};
+
+&usbdrd3_0 {
+	status = "okay";
+};
+
+&usbdrd_dwc3_0 {
+	status = "okay";
+	dr_mode = "otg";
+};
+
+&usbdrd3_1 {
+	status = "okay";
+};
+
+&usbdrd_dwc3_1 {
+	status = "okay";
+	dr_mode = "host";
+};
-- 
2.17.1

