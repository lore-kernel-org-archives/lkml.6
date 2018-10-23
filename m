Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA18EC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21F5204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C6lxIww7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21F5204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbeJXDcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:32:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41166 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbeJXDb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:31:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id 23-v6so1092756pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 12:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dM5n3AfaOF7ndZCp2d7aOJs0/BKCgH5twTcGD2xF2B8=;
        b=C6lxIww7QnkYoipUdnNucUUmZRiyLif9qnOaWtSC5GWsuDAscHjY0vZNKm6ikmYYRW
         Abr73puaNmDE2rXe3v9asCD2zkFkFBLxSSku0Ks+vJWQifxsDNaC8vnime5ZPUzGfpdJ
         bMeMyi0uwTQCCUvyD1itU+rlowYekJ+Dkf8Ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dM5n3AfaOF7ndZCp2d7aOJs0/BKCgH5twTcGD2xF2B8=;
        b=rGDIQZsl/wDeN+Mcmu2F7c3pDlV8f7VBS9NfQeeEJF6U4fQXic0AtZgR6KxkOVlyvo
         AVVM7Xkuo8HkOziBwsKz/31Y0MHVYnKmzl7vuK8BlArdZMDr9gl7EEc8twqt27W6pfgS
         6RRh7dnJYdyCy+2Z+TpCarbtKJCcRXxMiL2lZQWAjw9qvkDk9s6u9ffRCdI+PE9Nc5mT
         ZukvSrqOJc5GEHaT2TjzlPVp9wlhkvzcB03+SGVCob9u+Otg5A3NIosaBLBnaDOnr+mz
         iel3CYQDQdWpMiXK/GciFee1L2CihSVEkH2mwcgfr4VNPQRk8ezMJqOa+fhU2eCMxbX+
         N3aQ==
X-Gm-Message-State: AGRZ1gKkPlri88xZxt875frdmCvgDBqitczwxa8Umgus4jwD0xSVVzom
        LrE+7/A6BgneA5mQFZLwJIJD
X-Google-Smtp-Source: AJdET5fxabyM8V3HxPi1lnH1n0I3PVG4PQlz0pj4iK2hVfDYdx7Kf1PHXvvwIjmmPU9ZdaG/UcyxJw==
X-Received: by 2002:a63:f844:: with SMTP id v4mr1860975pgj.82.1540321639000;
        Tue, 23 Oct 2018 12:07:19 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:744c:7bc5:17c:5f65:76c4:d542])
        by smtp.gmail.com with ESMTPSA id v189-v6sm4897075pfb.54.2018.10.23.12.07.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 12:07:18 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     xuwei5@hisilicon.com, linus.walleij@linaro.org, robh+dt@kernel.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/5] arm64: dts: hisilicon: Add Pinctrl support for HiKey970 board
Date:   Wed, 24 Oct 2018 00:36:51 +0530
Message-Id: <20181023190655.12004-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181023190655.12004-1-manivannan.sadhasivam@linaro.org>
References: <20181023190655.12004-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl support based on "pinctrl-single" driver for HiKey970
development board from HiSilicon.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../boot/dts/hisilicon/hikey970-pinctrl.dtsi  | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hikey970-pinctrl.dtsi

diff --git a/arch/arm64/boot/dts/hisilicon/hikey970-pinctrl.dtsi b/arch/arm64/boot/dts/hisilicon/hikey970-pinctrl.dtsi
new file mode 100644
index 000000000000..64fb9a3bd707
--- /dev/null
+++ b/arch/arm64/boot/dts/hisilicon/hikey970-pinctrl.dtsi
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Pinctrl dts file for HiSilicon HiKey970 development board
+ */
+
+#include <dt-bindings/pinctrl/hisi.h>
+
+/ {
+	soc {
+		range: gpio-range {
+			#pinctrl-single,gpio-range-cells = <3>;
+		};
+
+		pmx0: pinmux@e896c000 {
+			compatible = "pinctrl-single";
+			reg = <0x0 0xe896c000 0x0 0x72c>;
+			#pinctrl-cells = <1>;
+			#gpio-range-cells = <0x3>;
+			pinctrl-single,register-width = <0x20>;
+			pinctrl-single,function-mask = <0x7>;
+			/* pin base, nr pins & gpio function */
+			pinctrl-single,gpio-range = <&range 0 82 0>;
+		};
+
+		pmx2: pinmux@e896c800 {
+			compatible = "pinconf-single";
+			reg = <0x0 0xe896c800 0x0 0x72c>;
+			#pinctrl-cells = <1>;
+			pinctrl-single,register-width = <0x20>;
+		};
+
+		pmx5: pinmux@fc182000 {
+			compatible = "pinctrl-single";
+			reg = <0x0 0xfc182000 0x0 0x028>;
+			#gpio-range-cells = <3>;
+			#pinctrl-cells = <1>;
+			pinctrl-single,register-width = <0x20>;
+			pinctrl-single,function-mask = <0x7>;
+			/* pin base, nr pins & gpio function */
+			pinctrl-single,gpio-range = <&range 0 10 0>;
+
+		};
+
+		pmx6: pinmux@fc182800 {
+			compatible = "pinconf-single";
+			reg = <0x0 0xfc182800 0x0 0x028>;
+			#pinctrl-cells = <1>;
+			pinctrl-single,register-width = <0x20>;
+		};
+
+		pmx7: pinmux@ff37e000 {
+			compatible = "pinctrl-single";
+			reg = <0x0 0xff37e000 0x0 0x030>;
+			#gpio-range-cells = <3>;
+			#pinctrl-cells = <1>;
+			pinctrl-single,register-width = <0x20>;
+			pinctrl-single,function-mask = <7>;
+			/* pin base, nr pins & gpio function */
+			pinctrl-single,gpio-range = <&range 0 12 0>;
+		};
+
+		pmx8: pinmux@ff37e800 {
+			compatible = "pinconf-single";
+			reg = <0x0 0xff37e800 0x0 0x030>;
+			#pinctrl-cells = <1>;
+			pinctrl-single,register-width = <0x20>;
+		};
+
+		pmx1: pinmux@fff11000 {
+			compatible = "pinctrl-single";
+			reg = <0x0 0xfff11000 0x0 0x73c>;
+			#gpio-range-cells = <0x3>;
+			#pinctrl-cells = <1>;
+			pinctrl-single,register-width = <0x20>;
+			pinctrl-single,function-mask = <0x7>;
+			/* pin base, nr pins & gpio function */
+			pinctrl-single,gpio-range = <&range 0 46 0>;
+		};
+
+		pmx16: pinmux@fff11800 {
+			compatible = "pinconf-single";
+			reg = <0x0 0xfff11800 0x0 0x73c>;
+			#pinctrl-cells = <1>;
+			pinctrl-single,register-width = <0x20>;
+		};
+	};
+};
-- 
2.17.1

