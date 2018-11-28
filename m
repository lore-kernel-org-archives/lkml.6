Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A52C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E56A2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cddgPvll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E56A2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbeK2AyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:54:16 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46490 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728436AbeK2AyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 19:54:16 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so9519331pgp.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 05:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KIbCrv6kxd+jKuB+Z655EDqVYRNgXku8ohIbZgJ20mM=;
        b=cddgPvllApWIuVm4aNSLi6L2wrPXnlKhA3mnRLP96rpqQQu6i5k+lgm3nyXgO9/6DJ
         S5wl6GHcGKuu3+5Orn7JV1lCcNbtvp5XHWme7qykP1/clAEbfBPCqpdC6wgUcTclDdHl
         j73ST9dIaacg47QmZUoQiErzxlERmv+FB78LM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KIbCrv6kxd+jKuB+Z655EDqVYRNgXku8ohIbZgJ20mM=;
        b=XkTwXhUnTh5zAaEXZwRQiSbEFJW21a8OODT2nXbAXUmRLXb9JRv/H6++BT58N0htWa
         An1eYJB1D6r+Mb9UT4bnXS5umYz1TaeCKf/8QR3vMev1B9inZ1xGQcY5MtCoXPuHiBPX
         4IeoBcRVG8HbhnjkC9wFbRWtJBuiL+cnis+nI5JcWD4fLWxpvMiHufPIq2kcuASlONrI
         k9NO8FjSCbDNJnCrZDMWupGM+iEu54vs2iQqE/gJAlHpr+NJEBCzfxP5B5wnlX4BLChP
         wdMCDRx6SHJ62m2+TpQRdrkSMSec/Jnz5JU1r91plwLpY1GcDTpGtS4RB9mmLPOWH9aB
         XNrQ==
X-Gm-Message-State: AA+aEWZ18ZFQe4svNrFv8cZCzqK2mHr5q6BmeuXovEqmwKngf3Etkzni
        rwHMfqQGna5bIyMv7jOJ1oDL
X-Google-Smtp-Source: AFSGD/X7xEns8x7ZErDI5kbdlJzpK49d+hofENqSuExZPwF9pgI5cf54alwVfUDJDM1ZoW1h7JpLhQ==
X-Received: by 2002:a63:1848:: with SMTP id 8mr32779975pgy.81.1543413152522;
        Wed, 28 Nov 2018 05:52:32 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:90a:a93f:b481:6fae:6692:c3ee])
        by smtp.gmail.com with ESMTPSA id c4sm22049854pfm.151.2018.11.28.05.52.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 05:52:32 -0800 (PST)
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
Subject: [PATCH v3 07/15] arm: dts: Add devicetree for OrangePi i96 board
Date:   Wed, 28 Nov 2018 19:20:58 +0530
Message-Id: <20181128135106.9255-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
References: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
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

