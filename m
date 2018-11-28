Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F0DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFAAA2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KqLomgPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFAAA2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbeK2Axy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:53:54 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35644 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbeK2Axy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 19:53:54 -0500
Received: by mail-pl1-f196.google.com with SMTP id p8so7129454plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 05:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wp3BZDgoaFaJmF6UrFqd9p3SyvZQREQyZwNsYyp7Sws=;
        b=KqLomgPNvKwvQ3ceqKWiy1BOunRA7JDH9BvSb+C2jlB2uWEGyyvwIUFHOFQvKDfwZe
         H/gC2vVjIJwPpccvEUbIQR/Zowotjp1elCJ01gIdG/+RKMDJ6ftRFGUnltRLNfXogAUR
         DK1kSxto0T44hs1ADFsF1iaei/3eihunZZfOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wp3BZDgoaFaJmF6UrFqd9p3SyvZQREQyZwNsYyp7Sws=;
        b=MNLqCEgQ+cyRi6/HfwWLihEuTerAwgNQVfbFY8Vxu8kjXRN0ZFcjxxrvSyYBb+lx2p
         3rQglYziIY7zr+Vks0DfdHFf+lBlPu6s3xqtR6+gFqQrba/0kkyFf/KiDE2grhvN2Yjt
         Y1bthZbybZNftoEE+XxRtpctziERd6d4UL3KKuW1OFfOr4KAT6P5WiOSXNIVJ603kyYM
         7RS28nUNf0bDIc1/JIa1OvATwwtTfChGjMYZqVZtAw9rasrCLc56yz4J5zpXWtmfZoYH
         uRuvkmjyfavuBAXRptULdTq4Ql8e6shX9bWc97PXycyEbzkwZMtxeDHJ3DUHjrB+1Dz4
         I0vQ==
X-Gm-Message-State: AA+aEWbUSxud7R4HffaD0uDNMyY2i3HLX1KgCe/fPbNM5bOlyPzuvV4f
        JFcbHC29+GZKFxYcgSVFWopk
X-Google-Smtp-Source: AFSGD/WU1ObRtIzTudUgBcgJHR8zn4pTI7RTFLD2r9HJvw+72mQgDtcZeKHo61AL9EICgMciEluBfA==
X-Received: by 2002:a17:902:9887:: with SMTP id s7mr1416136plp.199.1543413130823;
        Wed, 28 Nov 2018 05:52:10 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:90a:a93f:b481:6fae:6692:c3ee])
        by smtp.gmail.com with ESMTPSA id c4sm22049854pfm.151.2018.11.28.05.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 05:52:10 -0800 (PST)
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
Subject: [PATCH v3 05/15] arm: dts: Add devicetree for RDA8810PL SoC
Date:   Wed, 28 Nov 2018 19:20:56 +0530
Message-Id: <20181128135106.9255-6-manivannan.sadhasivam@linaro.org>
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

