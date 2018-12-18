Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37D3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9318A21852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eD+V7KxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeLRPDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:03:39 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43616 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeLRPDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:03:38 -0500
Received: by mail-pf1-f195.google.com with SMTP id w73so8249525pfk.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 07:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Auk2XhMMEToip2KKbDHncAZfukq8/UgpgNfIt0Pzr7k=;
        b=eD+V7KxZyfplaiikOGHEny17DLB002K4PPJd22DBzjlyRGHLiWc4KzF61xHvSji3zM
         lkEbs2K4r464GiJx9nkp8lydkKTl8UzKwdcXjHPu/+xKzPxYo1ORcdt7QgDbWvQqnCin
         2h7ZgxhFlv336oNVWV+FKF5sEuXTmlykTV/EQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Auk2XhMMEToip2KKbDHncAZfukq8/UgpgNfIt0Pzr7k=;
        b=BFmbkrW1lUkQ9ZonBHCxFHHgjuXemvPics7swZPlexqWWsdsnfkShUy0xH6YN7iqhI
         +etNyJEsTxMlf4aWHqeXRb/j5deLZsJ0OLsOwUYDKHEqpIve9KZiRaQX7jutJoFRmfvf
         yuvReXNZloK0Y3CcgEmQzLAv5jqXrrjHHOukFQbXuuRp+yo7YwWi8QyRNBLfT0QvcZgV
         +tg/sgb078N7vBA8xjL/ESPA+MnhsN59nl6mnt3rndckJcXjEXO1laRtsW4T+Nu0uGg6
         Qj2//v9LiHD68HCQdWQy6430cmptC8aeZ5YXBjDUzluHFWahYQ76joL3yZ3nZRVFqqBu
         pb+g==
X-Gm-Message-State: AA+aEWYcWWc7+GMz3AtJZ4om6DQdiKjFTc6L9mho8IEtN2nI2e35pFNP
        FCFTUiYad9cLmiF84K7EQUm6
X-Google-Smtp-Source: AFSGD/V6ZNPnQdNlACM329WNhwzrBru0FdVcxU85XT+R7LEKj0do9AljsFCWmgbIyvPT96vBVl2h0g==
X-Received: by 2002:a62:cd1:: with SMTP id 78mr1804653pfm.219.1545145416963;
        Tue, 18 Dec 2018 07:03:36 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
        by smtp.gmail.com with ESMTPSA id m198sm28798688pga.10.2018.12.18.07.03.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 07:03:36 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 05/11] ARM: dts: Add devicetree for OrangePi 2G IoT board
Date:   Tue, 18 Dec 2018 20:32:32 +0530
Message-Id: <20181218150238.23010-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
References: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
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
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/Makefile                    |  2 +
 .../boot/dts/rda8810pl-orangepi-2g-iot.dts    | 50 +++++++++++++++++++
 2 files changed, 52 insertions(+)
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
index 000000000000..98e34248ae80
--- /dev/null
+++ b/arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts
@@ -0,0 +1,50 @@
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
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
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
+	uart_clk: uart-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <921600>;
+		#clock-cells = <0>;
+	};
+};
+
+&uart1 {
+	status = "okay";
+	clocks = <&uart_clk>;
+};
+
+&uart2 {
+	status = "okay";
+	clocks = <&uart_clk>;
+};
+
+&uart3 {
+	status = "okay";
+	clocks = <&uart_clk>;
+};
-- 
2.17.1

