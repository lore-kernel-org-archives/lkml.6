Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE8CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC236206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bYjQCOLA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC236206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436454AbeKTDfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:35:40 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37772 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406330AbeKTDfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:35:39 -0500
Received: by mail-pf1-f194.google.com with SMTP id u3-v6so12473257pfm.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 09:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=STUzB5fKji2OZDTM554uiQTGQqsNeS58eSkJzLF2e6o=;
        b=bYjQCOLApNB1fYP8RIJ8dZWlHsJ+xdZf5IX64jBJ2xWgLcwdWYVvEr8YMO0MVTjV9f
         BSOPTw3EOdJ6fROVdP8rhJTq72FP9M3SkDV036apofPlMmMESqY+sfB/NhFaGAkqBxiR
         Kp229RBwRyIQxJ11B5gRHeDaiXdUgfh13IO9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=STUzB5fKji2OZDTM554uiQTGQqsNeS58eSkJzLF2e6o=;
        b=sS3Y/fNmMLl6ktzvJ6mFx5Pm5XHkJLbRG9LPRLhQul+pxhXwkP211japcZNHOuCZje
         Bh70ijGMI1gY1Xa1VZB7S5ImFy+7WsqC/6y18yp/Afg/wmuuQ65pCuDmdWgClm/3EH9q
         ufEqCmnSGKI7qyp5YdB85Mmu36CjEtCfyuWwy1R+EmOPbn6HppV33SvgaorQH20btDCY
         7mzxGtFKCgoN/Zv/fAyj+VlvEH8YpXYSakLnXwhZB3zEm72bj/dj2sz3a5fXFUO6CZU0
         la1lMtIuUu0kWShsdUBxP4AeNuGyzR0+ETTXyXjh/KC8JHAWT9O0SdQPAnTDYvaYSv31
         C6LA==
X-Gm-Message-State: AGRZ1gJck2rLIR4PITojZQjxMjurq4/OFFLJKBM5YKWdc6Ru8xx5L2rP
        afLDwAL7PTgVfVhgTgroYogM
X-Google-Smtp-Source: AJdET5cmgO+BVh464DC+zUzN81c+WqRanbXOk3Sza+w/32eHUFZ2Z/xyPWTR7CvBVLaKKyEbKOaMJQ==
X-Received: by 2002:a63:1d59:: with SMTP id d25mr18767398pgm.180.1542647479640;
        Mon, 19 Nov 2018 09:11:19 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:631b:44eb:3905:6402:e2fb:2d7])
        by smtp.gmail.com with ESMTPSA id 186-v6sm46175458pfe.39.2018.11.19.09.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 09:11:19 -0800 (PST)
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
Subject: [PATCH 04/16] arm: dts: Add devicetree for RDA8810PL SoC
Date:   Mon, 19 Nov 2018 22:39:27 +0530
Message-Id: <20181119170939.19153-5-manivannan.sadhasivam@linaro.org>
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

Add initial device tree for RDA8810PL SoC from RDA Microelectronics.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/rda8810pl.dtsi | 95 ++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 arch/arm/boot/dts/rda8810pl.dtsi

diff --git a/arch/arm/boot/dts/rda8810pl.dtsi b/arch/arm/boot/dts/rda8810pl.dtsi
new file mode 100644
index 000000000000..7f1ff2021eff
--- /dev/null
+++ b/arch/arm/boot/dts/rda8810pl.dtsi
@@ -0,0 +1,95 @@
+/*
+ * RDA8810PL SoC
+ *
+ * Copyright (c) 2017 Andreas Färber
+ * Copyright (c) 2018 Manivannan Sadhasivam
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+/ {
+	compatible = "rda,8810pl";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a5";
+			reg = <0x0>;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x80000000>;
+
+		sram@100000 {
+			compatible = "mmio-sram";
+			reg = <0x100000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+		};
+
+		apb@20800000 {
+			compatible = "simple-bus";
+			reg = <0x20800000 0x100000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x20800000 0x100000>;
+		};
+
+		apb@20900000 {
+			compatible = "simple-bus";
+			reg = <0x20900000 0x100000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x20900000 0x100000>;
+		};
+
+		apb@20a00000 {
+			compatible = "simple-bus";
+			reg = <0x20a00000 0x100000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x20a00000 0x100000>;
+
+			uart0: serial@0 {
+				compatible = "rda,8810pl-uart";
+				reg = <0x0 0x1000>;
+				status = "disabled";
+			};
+
+			uart1: serial@10000 {
+				compatible = "rda,8810pl-uart";
+				reg = <0x10000 0x1000>;
+				status = "disabled";
+			};
+
+			uart2: serial@90000 {
+				compatible = "rda,8810pl-uart";
+				reg = <0x90000 0x1000>;
+				status = "disabled";
+			};
+		};
+
+		l2: cache-controller@21100000 {
+			compatible = "arm,pl310-cache";
+			reg = <0x21100000 0x1000>;
+			cache-unified;
+			cache-level = <2>;
+		};
+	};
+};
-- 
2.17.1

