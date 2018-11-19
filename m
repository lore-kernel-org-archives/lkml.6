Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7CEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85CF206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DcQi4j/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85CF206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436456AbeKTDf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:35:57 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38168 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406258AbeKTDf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:35:56 -0500
Received: by mail-pf1-f193.google.com with SMTP id q1so7153562pfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 09:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f8EdN9IfUC+HQpAsL0jSDLomOfXBY5TdAIOND6Bm3Pg=;
        b=DcQi4j/uit2V/jjRVTqlhidAKQmOlNp6R3xG9FsvTzENvySz0QN8wwDgEa+NxDZR1y
         pMxnrzcMAGlWp4qptU3Xhc7jKLq3Ws2l82u2et/KBPI9aViVUalcOjSzCLecsi3YW9k2
         e0OHpNninSSTutQfVyh9xDRiQ7lYKxjHV1k2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f8EdN9IfUC+HQpAsL0jSDLomOfXBY5TdAIOND6Bm3Pg=;
        b=XfJJ7WjuUYhUJQXtmXNh7WxY0YbkqSHbALlHJdJtYF3UeUUyOjn01k0C9kHBJgmU+k
         22pIWBFlcRzxfiu9flAo92Ymv+sxic/9qhs9+g5G8Ib3uceSpeSqsxz2CMditwqvbDpR
         up2KRZgjSypLs9RYckdI7O59b4aIA25OPIWl8tsx+XPvhIZbqBVTU68aGgZfO6huGCVb
         gR9oggCufS4RsGBGV358SomBvZ/XdzGbhe/zuQT9WPHJbYlEvf7wLpLgGw5MsZ4HWUBV
         phM4QiG74uJkG3iupQRIrcu3/bRYTohvNZZTlBeXS145qBApzXNHEXriu0Ad75zsp9cS
         QvmQ==
X-Gm-Message-State: AGRZ1gKQLmosconvICi0Ld6vZmxwS49USCRJDVq7sYNo+rpsmFrl5bh5
        s2qqIwwGq5CZFFE2IIyBkfMX
X-Google-Smtp-Source: AJdET5eMv18kMDsLE0eoCXWqRIA+aAQKo2rn4pNCCLLN3Ng1XI0/LM7GaCBw5+K5e4t/ysbiywv6dw==
X-Received: by 2002:a63:6f0d:: with SMTP id k13mr20651272pgc.42.1542647496980;
        Mon, 19 Nov 2018 09:11:36 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:631b:44eb:3905:6402:e2fb:2d7])
        by smtp.gmail.com with ESMTPSA id 186-v6sm46175458pfe.39.2018.11.19.09.11.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 09:11:36 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        service@rdamicro.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH 06/16] arm: dts: Add devicetree for OrangePi i96 board
Date:   Mon, 19 Nov 2018 22:39:29 +0530
Message-Id: <20181119170939.19153-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
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
 arch/arm/boot/dts/rda8810pl-orangepi-i96.dts | 35 ++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)
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
index 000000000000..3e3b8c4575cd
--- /dev/null
+++ b/arch/arm/boot/dts/rda8810pl-orangepi-i96.dts
@@ -0,0 +1,35 @@
+/*
+ * Copyright (c) 2017 Andreas Färber
+ * Copyright (c) 2018 Manivannan Sadhasivam
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
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

