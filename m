Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5F6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B281C2146D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W6Fdv0y4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B281C2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbeKUOKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 09:10:37 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36443 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbeKUOKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 09:10:37 -0500
Received: by mail-pl1-f193.google.com with SMTP id y6-v6so3381626plt.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 19:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wRzyWtQem/ZudNzb9RZbtf1aGt6UbjSssLp+q/Rsb70=;
        b=W6Fdv0y4dpDrEI7W3bcMcFFwDrafrf8k0lK+uOJ+jLA1327RGVnlS1bFbp89uBFLW8
         Fn+UjhyF0RfO6E5H8x8xXxa/Mv+eKKgWOL9IpMRNNGdv44C2P3n/I8mlTXdHKqK50CRw
         Ap+pgLHhm4+jM9lSDXGqdj0R+QjC5xtwGVvAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wRzyWtQem/ZudNzb9RZbtf1aGt6UbjSssLp+q/Rsb70=;
        b=sgTzCxRsNzFy8ca6D/fkNLNwbrKAkQLDnbuYTtI9r90EQmCqHjPdtdMetKxUPNyIzD
         uDzmRrwCsV8i22CaFqJpbU6RJADiRMo6Yuw2USkfbXdOdevCAF1v2R/7/9+QTON8U17H
         bZ9kVz+Z76cbXGQ8tshMW92UFR7ugpOgqeiXOJjl9j580Ez2w9tlZqf2JubPur6Npt5C
         ubCNMi6HEtbF88OgUITpNqUls1soFJl92qXGo2tHg+p9qzzJWezAuXSw5tEOvtDYPFVT
         LAz6zI/4aeTuV0Ooc26uLtwpKc/6aj7p5gNnA+jukniuUlOrnnXPzsHgGK7uLQpwcllL
         s59w==
X-Gm-Message-State: AA+aEWZ5HlMyhVUysXlHtmhqdavtvpus0n5b+JIW48Z8nFPXP656+M3C
        dHOGVt5KR0Wmqr+HT34JVK53
X-Google-Smtp-Source: AFSGD/U7NTQQAAD9bKTJgl/bPtsqCBRkhTibBPJcE1gFIce94J6ImTI9IABXrpIUJ6f/In3YO37tog==
X-Received: by 2002:a63:1444:: with SMTP id 4mr4447921pgu.430.1542771483254;
        Tue, 20 Nov 2018 19:38:03 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:98b:9501:106a:f751:df0d:9e68])
        by smtp.gmail.com with ESMTPSA id z8sm72025095pgz.53.2018.11.20.19.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 19:38:02 -0800 (PST)
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
Subject: [PATCH v2 05/15] arm: dts: Add devicetree for RDA8810PL SoC
Date:   Wed, 21 Nov 2018 09:06:42 +0530
Message-Id: <20181121033652.12247-6-manivannan.sadhasivam@linaro.org>
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

Add initial device tree for RDA8810PL SoC from RDA Microelectronics.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/rda8810pl.dtsi | 86 ++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 arch/arm/boot/dts/rda8810pl.dtsi

diff --git a/arch/arm/boot/dts/rda8810pl.dtsi b/arch/arm/boot/dts/rda8810pl.dtsi
new file mode 100644
index 000000000000..ab85ee06d84f
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
+		uart0: serial@0 {
+			compatible = "rda,8810pl-uart";
+			reg = <0x0 0x1000>;
+			status = "disabled";
+		};
+
+		uart1: serial@10000 {
+			compatible = "rda,8810pl-uart";
+			reg = <0x10000 0x1000>;
+			status = "disabled";
+		};
+
+		uart2: serial@90000 {
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

