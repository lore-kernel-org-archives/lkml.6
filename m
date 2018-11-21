Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90547C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA06213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="isXAzGUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA06213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeKUOKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 09:10:47 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44657 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbeKUOKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 09:10:47 -0500
Received: by mail-pl1-f196.google.com with SMTP id s5-v6so3371142plq.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 19:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rkb6Vur4U4SNVlmfWr82lctyg9peW1saJEvXYDmJZJg=;
        b=isXAzGUMPrGvEmLT/EVW63npjfGPeZ3GX9Vh/DkvxH6TV5vkydusq1kUe1ddyIg/3D
         X2r8ZVgYUJww6By5Dt9uP25FpuGOKKELX5W8Isg/nK/9lItVzelhyPEs1JdJ+2mIlgsZ
         BHgUf3Wx0xQZlpFUajTu0WwwSPC2TUASAvkfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rkb6Vur4U4SNVlmfWr82lctyg9peW1saJEvXYDmJZJg=;
        b=rp+7Z3I6Q/No72Mrht1sHz0OLbBgLDf4hc4Tsfkdrb9NxhOA30sayDRhfIetHOy1kY
         HwzlRlWN4LQoNGDomSOAF58b9TZ7gEzKGyvtYTKCknF4XBySsF81Iuft9kuYlOCalzSH
         3F2RihHFpuiuGG/SSs3UniievTwe6qGYUUmu2WaVhEH1fNqyw6kLcrijkOd8G1zS6r/q
         l1gu1vJKenVbKy/3o5nAXUYGXqGP6957HUZ5Fm2giXkIRA40d8/Xiru6SYi8cDQGJUYx
         Vub7hMnAtmjzUTQ8y/r/yX+RdLOjOwGh52z9BZEBOaZq6WC4fjhVXUqw2IBfSjG6Kfru
         cICA==
X-Gm-Message-State: AA+aEWYUm71GRb932vrj/PTN1D7UvLgxhOomUU1CHqoo3kCWfUEb8sDz
        O2GPu4YWm6p04ry7SlB9W7re
X-Google-Smtp-Source: AFSGD/U7gI9R3e8oyxpC8BBfl2/qGTwNjpY73xqPArY0J5VpUFT+Bz0TNhmrtSm3lj3aXFSY3PnM9Q==
X-Received: by 2002:a63:ed15:: with SMTP id d21mr4388449pgi.305.1542771493024;
        Tue, 20 Nov 2018 19:38:13 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:98b:9501:106a:f751:df0d:9e68])
        by smtp.gmail.com with ESMTPSA id z8sm72025095pgz.53.2018.11.20.19.38.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 19:38:12 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     afaerber@suse.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        overseas.sales@unisoc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 06/15] arm: dts: Add devicetree for OrangePi 2G IoT board
Date:   Wed, 21 Nov 2018 09:06:43 +0530
Message-Id: <20181121033652.12247-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
References: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial devicetree support for OrangePi 2G IoT board from Xunlong.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/Makefile                    |  2 +
 .../boot/dts/rda8810pl-orangepi-2g-iot.dts    | 40 +++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b0e966d625b9..a0fdad8f10dd 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -806,6 +806,8 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-msm8974-sony-xperia-castor.dtb \
 	qcom-msm8974-sony-xperia-honami.dtb \
 	qcom-mdm9615-wp8548-mangoh-green.dtb
+dtb-$(CONFIG_ARCH_RDA) += \
+	rda8810pl-orangepi-2g-iot.dtb
 dtb-$(CONFIG_ARCH_REALVIEW) += \
 	arm-realview-pb1176.dtb \
 	arm-realview-pb11mp.dtb \
diff --git a/arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts b/arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts
new file mode 100644
index 000000000000..5e5bd0542e0c
--- /dev/null
+++ b/arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2017 Andreas Färber
+ * Copyright (c) 2018 Manivannan Sadhasivam
+ */
+
+/dts-v1/;
+
+#include "rda8810pl.dtsi"
+
+/ {
+	compatible = "xunlong,orangepi-2g-iot", "rda,8810pl";
+	model = "Orange Pi 2G-IoT";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+	};
+
+	chosen {
+		stdout-path = "serial2:921600n8";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x10000000>;
+	};
+
+	uart2_clk: uart2-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <921600>;
+		#clock-cells = <0>;
+	};
+};
+
+&uart2 {
+	status = "okay";
+	clocks = <&uart2_clk>;
+};
-- 
2.17.1

