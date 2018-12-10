Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBCFC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C4D2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZRPxyo2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C4D2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbeLJRhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:37:05 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36539 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbeLJRhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:37:04 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so5734731pfc.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 09:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KIbCrv6kxd+jKuB+Z655EDqVYRNgXku8ohIbZgJ20mM=;
        b=ZRPxyo2zGSkOcBSGXrLTPsyinQ6P17sQYCJvUWjiXwmwT74RFHgz7X57daD7YmwgzX
         ZtexgVCNfkVxz82UizIMCUz/1zzmbIC9wGECCFVSwIvAPLwUKhjsFKbWqKkArHL6FgoI
         sYTSI6gLwi8oMawAa4OIfsFh/Jb24VFHbaxAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KIbCrv6kxd+jKuB+Z655EDqVYRNgXku8ohIbZgJ20mM=;
        b=MapUsN8EebWi05oRha/2Fe5iRi8cS0j0yH56MMxrT+nBBy/mbC6OhdkYTGby82y8kg
         8jYdP8C5aPbSrmOsJIek6MRtsbLD3u7R2pALC40gV3YuNHDEvtpwObV6jcr0ThFRVwO7
         zQlHCKPJYEfq1Qrne9Wl4p6d57JcSdlB8Ly0cKpzNmgSATH3nAsTWsB3NlWJ97432wNN
         Ls8Zq9Rww95LAOZTUf6YEFGuDMfoc2WIZuRBFSqUUeuCqn0eW0HuEVx0009Z10/QNSWR
         XML2mKAQLrRRxgYjBxDGyX5eptb1f2AeUjHXILHzf7Ew7xenX3vNG5C38ZeolhkG/gfv
         4tfQ==
X-Gm-Message-State: AA+aEWadZcNTmSxjxvA2ffYIAw9YA5Faw5mMDNo3LYutV15Gi9i/WPT/
        RG1G6RJ1fvzCRxCdQA5snAm7
X-Google-Smtp-Source: AFSGD/UDpibuiqyGmYDVZAmSvbl9AYGGt2C+azqUEAanptdoxG9VicS7YbIrgv9QlL1kEXtyuKZ9Og==
X-Received: by 2002:a63:4b60:: with SMTP id k32mr11526285pgl.186.1544463423895;
        Mon, 10 Dec 2018 09:37:03 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
        by smtp.gmail.com with ESMTPSA id q1sm15998396pfb.96.2018.12.10.09.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 09:37:03 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 07/15] ARM: dts: Add devicetree for OrangePi i96 board
Date:   Mon, 10 Dec 2018 23:05:42 +0530
Message-Id: <20181210173550.29643-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial devicetree for Orange Pi i96 board from Xunlong. It
is one of the 96Boards IoT Edition board.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/Makefile                   |  3 +-
 arch/arm/boot/dts/rda8810pl-orangepi-i96.dts | 50 ++++++++++++++++++++
 2 files changed, 52 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/rda8810pl-orangepi-i96.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a0fdad8f10dd..cfb08ea33872 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -807,7 +807,8 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-msm8974-sony-xperia-honami.dtb \
 	qcom-mdm9615-wp8548-mangoh-green.dtb
 dtb-$(CONFIG_ARCH_RDA) += \
-	rda8810pl-orangepi-2g-iot.dtb
+	rda8810pl-orangepi-2g-iot.dtb \
+	rda8810pl-orangepi-i96.dtb
 dtb-$(CONFIG_ARCH_REALVIEW) += \
 	arm-realview-pb1176.dtb \
 	arm-realview-pb11mp.dtb \
diff --git a/arch/arm/boot/dts/rda8810pl-orangepi-i96.dts b/arch/arm/boot/dts/rda8810pl-orangepi-i96.dts
new file mode 100644
index 000000000000..728f76931b99
--- /dev/null
+++ b/arch/arm/boot/dts/rda8810pl-orangepi-i96.dts
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
+	compatible = "xunlong,orangepi-i96", "rda,8810pl";
+	model = "Orange Pi i96";
+
+	aliases {
+		serial0 = &uart2;
+		serial1 = &uart1;
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

