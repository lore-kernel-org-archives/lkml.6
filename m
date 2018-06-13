Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 64FF5C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183B020891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PboYvwdZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183B020891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935952AbeFMPU7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:20:59 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41456 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935680AbeFMPU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:20:57 -0400
Received: by mail-pg0-f65.google.com with SMTP id l65-v6so1433891pgl.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uFrdXHLaQ1q9Qzt3Ros6b/d9NTIr1h/WxaGuAmEAIb4=;
        b=PboYvwdZHIyv2votKn4+dNIFSRsJ+87pVEsNaj2yYVCV6AvtMt5RQnF35ULwOYfmNi
         Strql15K1lgza/G8JwhBn7PYrlEUqfnSeyArrisYx/UL8SAXjBa53xvVAmFLSxrSpFj6
         o8yfunOtvBtzenFTeJycCdJmPVgYLmrsAxpP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uFrdXHLaQ1q9Qzt3Ros6b/d9NTIr1h/WxaGuAmEAIb4=;
        b=rMYqdp9rViHmAsF+0u1sHdKh9EI7Fi7NoSnGPJx+N+V7ZlGPcfaUl2Vom0RFeqprHR
         /F6chOGMfRXuMkUQ9QShGsrI8LIwJeWZg3l6XvfLGGJ2Xe/7MPGpptTBieTJGeMa8kz7
         pzzcrQx2Q1hsM/pX3w3putqTYHWR6FfXvR1S59K4T12EEeKYgU56QSvIqKnc5PuWZAc+
         nomOMtdWbJe1/Xbq9bmcDPNY4GU5jau5MNdLB5YF28tvm7Q7yh6wcdB1qXQ1ORW+pOtr
         JpsG63k5x5el1ossmANE2GcjGuHTjDi4s0N0+Gx3K2qO+kcfg8zEwYgFRB2/PMdImb+p
         It5g==
X-Gm-Message-State: APt69E1XyHwVzp3PPgsb7z1jHakk6UkJLgBgxkxjDxEDX5TpWzP+UiKB
        wzCAZ++F3t5/3nHFeccNmYNZyg==
X-Google-Smtp-Source: ADUXVKLSOuEgMD0f2nBJXfXR3GdJXxc+ixHFdoaAmY9rK7i+DcyHj/8I/g2W1HgrhIEIrxWYnH5ncw==
X-Received: by 2002:a63:730d:: with SMTP id o13-v6mr4426416pgc.1.1528903257322;
        Wed, 13 Jun 2018 08:20:57 -0700 (PDT)
Received: from swboyd.mtv.corp.google.com ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id h8-v6sm3362365pgq.35.2018.06.13.08.20.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 08:20:56 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: Add pm8005 and pm8998 support
Date:   Wed, 13 Jun 2018 08:20:54 -0700
Message-Id: <20180613152054.54812-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic support for the pm8005 and pm8998 PMICs. For now just support
the GPIO controllers.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/pm8005.dtsi | 33 +++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 55 ++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8005.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm8998.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm8005.dtsi b/arch/arm64/boot/dts/qcom/pm8005.dtsi
new file mode 100644
index 000000000000..4d5aca3eeb69
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8005.dtsi
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/* Copyright 2018 Google LLC. */
+
+#include <dt-bindings/spmi/spmi.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+&spmi_bus {
+	pm8005_lsid0: pmic@4 {
+		compatible = "qcom,pm8005", "qcom,spmi-pmic";
+		reg = <0x4 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8005_gpio: gpios@c000 {
+			compatible = "qcom,pm8005-gpio", "qcom,spmi-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <0 0xc0 0 IRQ_TYPE_NONE>,
+				     <0 0xc1 0 IRQ_TYPE_NONE>,
+				     <0 0xc2 0 IRQ_TYPE_NONE>,
+				     <0 0xc3 0 IRQ_TYPE_NONE>;
+		};
+
+	};
+
+	pm8005_lsid1: pmic@5 {
+		compatible = "qcom,pm8005", "qcom,spmi-pmic";
+		reg = <0x5 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
new file mode 100644
index 000000000000..92bed1e7d4bb
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/* Copyright 2018 Google LLC. */
+
+#include <dt-bindings/spmi/spmi.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+&spmi_bus {
+	pm8998_lsid0: pmic@0 {
+		compatible = "qcom,pm8998", "qcom,spmi-pmic";
+		reg = <0x0 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8998_gpio: gpios@c000 {
+			compatible = "qcom,pm8998-gpio", "qcom,spmi-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <0 0xc0 0 IRQ_TYPE_NONE>,
+				     <0 0xc1 0 IRQ_TYPE_NONE>,
+				     <0 0xc2 0 IRQ_TYPE_NONE>,
+				     <0 0xc3 0 IRQ_TYPE_NONE>,
+				     <0 0xc4 0 IRQ_TYPE_NONE>,
+				     <0 0xc5 0 IRQ_TYPE_NONE>,
+				     <0 0xc6 0 IRQ_TYPE_NONE>,
+				     <0 0xc7 0 IRQ_TYPE_NONE>,
+				     <0 0xc8 0 IRQ_TYPE_NONE>,
+				     <0 0xc9 0 IRQ_TYPE_NONE>,
+				     <0 0xca 0 IRQ_TYPE_NONE>,
+				     <0 0xcb 0 IRQ_TYPE_NONE>,
+				     <0 0xcc 0 IRQ_TYPE_NONE>,
+				     <0 0xcd 0 IRQ_TYPE_NONE>,
+				     <0 0xce 0 IRQ_TYPE_NONE>,
+				     <0 0xcf 0 IRQ_TYPE_NONE>,
+				     <0 0xd0 0 IRQ_TYPE_NONE>,
+				     <0 0xd1 0 IRQ_TYPE_NONE>,
+				     <0 0xd2 0 IRQ_TYPE_NONE>,
+				     <0 0xd3 0 IRQ_TYPE_NONE>,
+				     <0 0xd4 0 IRQ_TYPE_NONE>,
+				     <0 0xd5 0 IRQ_TYPE_NONE>,
+				     <0 0xd6 0 IRQ_TYPE_NONE>,
+				     <0 0xd7 0 IRQ_TYPE_NONE>,
+				     <0 0xd8 0 IRQ_TYPE_NONE>,
+				     <0 0xd9 0 IRQ_TYPE_NONE>;
+		};
+
+	};
+
+	pm8998_lsid1: pmic@1 {
+		compatible = "qcom,pm8998", "qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+};
-- 
Sent by a computer through tubes

