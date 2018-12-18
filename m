Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B039FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E88120874
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Al3IShOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbeLRDmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 22:42:32 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43789 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbeLRDmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 22:42:31 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so7418055pfk.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 19:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wp3BZDgoaFaJmF6UrFqd9p3SyvZQREQyZwNsYyp7Sws=;
        b=Al3IShOYSEOBbrFcPKx6XF/WIM0mMVlKZMwpMPSGfSDTo7h2gNuirVbFiXN9Nzj+JX
         ix6o0Qy9na7XehwtlMFMgBUUle/2M5xVH2SRjBKcCHbsDkp0tbo7itULMt+7syrWxuj7
         jYkbNSupld1RHEJE99VNd8a8PR8ec9zl7bjUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wp3BZDgoaFaJmF6UrFqd9p3SyvZQREQyZwNsYyp7Sws=;
        b=ipcZx0KMvVtBHeTwXw2LuHQMBCwdMe25K/PEfd+9DvB/BJSzG5UJZmCXokE6q1CN7M
         6igKNJQ4eMYYEqZswCalIXBGuNpy1GcQ1Mu/sPRNlPHEFg8eOcfp5MhRM/CE2KSQEoaN
         6UavW4Tr50uEQIoYj7ha+mWsAUXxftjKrgH/e/9T2KyKg/HCqNLbxpC3qDzOyq3UA687
         B+WyHy3V7GTaYS9WjKWYdnmf5SwhuOTubKjdNU8VXbj+ZpURT3iBio4XZpSCKVdyB61j
         DOWPPYDqe0BnHDnV53t2BGtEbuxPkgm8/q0ECtC5MVeZJPAwDGysHLEx5c6MxCA9hMbP
         5cjA==
X-Gm-Message-State: AA+aEWaUstC8Zgc6oCLR1ZbUJ+oxdDfQeNnsJbeaNgNYcXRNTglD822D
        XHu2ncDqPRKaKj/NLl7XiBxR
X-Google-Smtp-Source: AFSGD/WhwXAt84it0ytvn2rwfCvKtZk1skWtKfy8y/DRyqBYSS2tK9G2YlSulgBfX6NRhvW5XJ0AbQ==
X-Received: by 2002:a63:9712:: with SMTP id n18mr14220503pge.295.1545104550679;
        Mon, 17 Dec 2018 19:42:30 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
        by smtp.gmail.com with ESMTPSA id b202sm25255422pfb.88.2018.12.17.19.42.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 19:42:30 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 04/11] ARM: dts: Add devicetree for RDA8810PL SoC
Date:   Tue, 18 Dec 2018 09:11:25 +0530
Message-Id: <20181218034132.5070-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
References: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
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
 arch/arm/boot/dts/rda8810pl.dtsi | 86 ++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 arch/arm/boot/dts/rda8810pl.dtsi

diff --git a/arch/arm/boot/dts/rda8810pl.dtsi b/arch/arm/boot/dts/rda8810pl.dtsi
new file mode 100644
index 000000000000..15547b138977
--- /dev/null
+++ b/arch/arm/boot/dts/rda8810pl.dtsi
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * RDA8810PL SoC
+ *
+ * Copyright (c) 2017 Andreas Färber
+ * Copyright (c) 2018 Manivannan Sadhasivam
+ */
+
+/ {
+	compatible = "rda,8810pl";
+	interrupt-parent = <&intc>;
+	#address-cells = <1>;
+	#size-cells = <1>;
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
+	sram@100000 {
+		compatible = "mmio-sram";
+		reg = <0x100000 0x10000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+	};
+
+	apb@20800000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x20800000 0x100000>;
+
+		intc: interrupt-controller@0 {
+			compatible = "rda,8810pl-intc";
+			reg = <0x0 0x1000>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	apb@20900000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x20900000 0x100000>;
+	};
+
+	apb@20a00000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x20a00000 0x100000>;
+
+		uart1: serial@0 {
+			compatible = "rda,8810pl-uart";
+			reg = <0x0 0x1000>;
+			status = "disabled";
+		};
+
+		uart2: serial@10000 {
+			compatible = "rda,8810pl-uart";
+			reg = <0x10000 0x1000>;
+			status = "disabled";
+		};
+
+		uart3: serial@90000 {
+			compatible = "rda,8810pl-uart";
+			reg = <0x90000 0x1000>;
+			status = "disabled";
+		};
+	};
+
+	l2: cache-controller@21100000 {
+		compatible = "arm,pl310-cache";
+		reg = <0x21100000 0x1000>;
+		cache-unified;
+		cache-level = <2>;
+	};
+};
-- 
2.17.1

