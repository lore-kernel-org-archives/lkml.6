Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22EFC4321E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750B22086C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VJwUFCOZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 750B22086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbeIDJXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 05:23:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38989 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbeIDJXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 05:23:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id i190-v6so1034368pgc.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 21:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rzoXv4JI/XBl9sTdYh43zCggusy7S3nif7FKYzx4Gas=;
        b=VJwUFCOZR0uSvbUlfbEUNdrE7fg8iinaSHZuaWJXpy8iK3VwGVLwTUNuz8UBqQvrOt
         ws2su6FPf2nn+k/BzLllTzkirKXpF6L9rmklwNrZNvxpvT2TMphX325cykU9uFxJv1da
         0E+hOlPFRooBZp8UcK7I04MT8E3q+uAfkTK+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rzoXv4JI/XBl9sTdYh43zCggusy7S3nif7FKYzx4Gas=;
        b=h4L4Y51ZF4+bYnXG4dUrPqTFeCnSpd8VCvLJalNdNj8+aGfXOjhkglodHrQ5wQWP7Q
         BmFsWIO0PGlcCHI4K0b2N0HbqsetUrjp9HcjClNrZiEYMXMbFZ7mBZfDzsW5KpbDPuD5
         I5GZEB+grxVNJtectBzdnCR9c8adqVoFEY6gaFIjIxfETH+m+4imD+EOvMBLbpeV29Ig
         R7sF8JYtS6kLv5Hj/YDD7cK2OieFNJ84n+iTeCNTNmSDs6YAkqR5ta8+EKUSNR1Y4IOz
         5BRZgNRjn3vEIgyoVYwnRipYup3i9YZXBx8R9rOJUHhaSi4H9n9OOAx1yK5SIKjs75j0
         xiRw==
X-Gm-Message-State: APzg51AJzJZ8mLjkyDrjjWt/fTEJbs+RUk2wFJVu2aOcYXpMO0cymkfP
        LuA/io/yUHswALaBhwyVXW9cFQ==
X-Google-Smtp-Source: ANB0VdavrGH6avVCWhrWhapP+SyzTo0RYS51Mmxn+3pMzAWGr5sYE87OiFkr/RIT8veYHt39YuFsqw==
X-Received: by 2002:a65:66d4:: with SMTP id c20-v6mr9117167pgw.55.1536037178777;
        Mon, 03 Sep 2018 21:59:38 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v72-v6sm41180378pfj.22.2018.09.03.21.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 21:59:38 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/8] arm64: dts: qcom: msm8998: Add pmi8998 file
Date:   Mon,  3 Sep 2018 22:01:19 -0700
Message-Id: <20180904050123.26601-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904050123.26601-1-bjorn.andersson@linaro.org>
References: <20180904050123.26601-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new dtsi file for the PMI8998, with its gpios and include all three
PMICs in the MSM8998 MTP dts.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- New patch

 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi |  3 ++
 arch/arm64/boot/dts/qcom/pmi8998.dtsi     | 40 +++++++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pmi8998.dtsi

diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
index 202aa1a5cf27..b4276da1fb0d 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
@@ -2,6 +2,9 @@
 /* Copyright (c) 2016, The Linux Foundation. All rights reserved. */
 
 #include "msm8998.dtsi"
+#include "pm8998.dtsi"
+#include "pmi8998.dtsi"
+#include "pm8005.dtsi"
 
 / {
 	aliases {
diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
new file mode 100644
index 000000000000..da3285e216e2
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus {
+	pmi8998_lsid0: pmic@2 {
+		compatible = "qcom,pmi8998", "qcom,spmi-pmic";
+		reg = <0x2 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmi8998_gpio: gpios@c000 {
+			compatible = "qcom,pmi8998-gpio", "qcom,spmi-gpio";
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
+				     <0 0xcd 0 IRQ_TYPE_NONE>;
+		};
+	};
+
+	pmi8998_lsid1: pmic@3 {
+		compatible = "qcom,pmi8998", "qcom,spmi-pmic";
+		reg = <0x3 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+};
-- 
2.18.0

