Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465B1C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1187821848
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/dO1oJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbfBTB7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 20:59:25 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37216 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730018AbfBTB7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 20:59:14 -0500
Received: by mail-pg1-f194.google.com with SMTP id q206so11036390pgq.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 17:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1DK3P0WkhGvTvHQ5jdvVLLL+MfoZ3wDJCVPLaiQLhdw=;
        b=U/dO1oJQMe2XiZabm2bbVcCRwCueveksGT5jzWnK2mKBwnt9UJZJMLHCSocCPSOi4f
         nuPa3Go3bDDheAiaEjn9Ccwp4xcRz+5MmjpN81dl9e36yKvBBfvokcf5RqTkS2R8H65a
         6Wo4PqDVb0wTjVe68Vgg6z9zzv3QK75yXwBFG6fNxtGsGoNDlhyjzyANef0G39WJzb2B
         GixJMQt7DoWPYFoFs37+1JZIXx+mI/eXv/ajaCAQ4dRHBoRdpy9EyYR9Gl38RoDIj8Us
         PdV2McrRbSjoWCPOXLUmGgr5bEAUhtvDJ/NnXFh91UCyDifWVIeYl5Ykda0r94UON6eQ
         ZiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1DK3P0WkhGvTvHQ5jdvVLLL+MfoZ3wDJCVPLaiQLhdw=;
        b=N8msKpQdM+KwAYD0OqNWoQ5QJJ1HO/qw2QHrYihNHl4AFQY7lc/XQklmsBmdmvKg7w
         i+Ll0G0NIGIkAgxsUqDIxZMkGl3dStXUpL9sCt4MVUpEiFhh/a/vMxwrJYomfszajTJJ
         uj0VSFycZxDxQAR1i/UTjTy8Xb+PDgbLEBLme5XxOePQyy26GHlbW9cHmk67HlRjgq4I
         Rveh1L0Qyp/VGZTSkJHxlEvguAJz0sCfEnGI77GWLY86YXIdKl1n01UrOgo78HpI7QTb
         GdF/rlVn6ogC9Lr7kECx8RySqbEreBn8BAsbgA7I7C87g7sDU/0rmLspqFVGXTBJNup+
         q6JQ==
X-Gm-Message-State: AHQUAuY9EyukjcEQ4bPUeDkU5E8IcbE91YdCDuqoJlKHkYRMR1zLR5i9
        zvn5Y6/Wzjg8PK59xnh+HZw=
X-Google-Smtp-Source: AHgI3IZ9j1a+9OZFzcrzrCwnurWZ4i9YvcpKIdIy0APxc6nQzM0A2e0G2kDOVl/hGp3ofo4WHL7bRQ==
X-Received: by 2002:a63:b14d:: with SMTP id g13mr11892684pgp.270.1550627953698;
        Tue, 19 Feb 2019 17:59:13 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id h3sm2562525pgv.38.2019.02.19.17.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 17:59:12 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] arm64: dts: imx8mq: Add nodes for PCIe IP blocks
Date:   Tue, 19 Feb 2019 17:58:56 -0800
Message-Id: <20190220015857.7136-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220015857.7136-1-andrew.smirnov@gmail.com>
References: <20190220015857.7136-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for two PCIe controllers found on i.MX8MQ.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 58 +++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index fca9b71de94f..cae44bcde6f4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/clock/imx8mq-clock.h>
 #include <dt-bindings/power/imx8mq-power.h>
+#include <dt-bindings/reset/imx8mq-reset.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include "imx8mq-pinfunc.h"
@@ -536,6 +537,63 @@
 			};
 		};
 
+		pcie0: pcie@33800000 {
+			compatible = "fsl,imx8mq-pcie";
+			reg = <0x33800000 0x400000>,
+			      <0x1ff00000 0x80000>;
+			reg-names = "dbi", "config";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			bus-range = <0x00 0xff>;
+			ranges = <0x81000000 0 0x00000000 0x1ff80000 0 0x00010000 /* downstream I/O 64KB */
+			          0x82000000 0 0x18000000 0x18000000 0 0x07f00000>; /* non-prefetchable memory */
+			num-lanes = <1>;
+			interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+			                <0 0 0 2 &gic GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+			                <0 0 0 3 &gic GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+			                <0 0 0 4 &gic GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+			fsl,max-link-speed = <2>;
+			power-domains = <&pgc_pcie>;
+			resets = <&src IMX8MQ_RESET_PCIEPHY>,
+			         <&src IMX8MQ_RESET_PCIE_CTRL_APPS_EN>,
+			         <&src IMX8MQ_RESET_PCIE_CTRL_APPS_TURNOFF>;
+			reset-names = "pciephy", "apps", "turnoff";
+			status = "disabled";
+		};
+
+		pcie1: pcie@33c00000 {
+			compatible = "fsl,imx8mq-pcie";
+			reg = <0x33c00000 0x400000>,
+			      <0x27f00000 0x80000>;
+			reg-names = "dbi", "config";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges =  <0x81000000 0 0x00000000 0x27f80000 0 0x00010000 /* downstream I/O 64KB */
+				   0x82000000 0 0x20000000 0x20000000 0 0x07f00000>; /* non-prefetchable memory */
+			num-lanes = <1>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &gic GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &gic GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &gic GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			fsl,max-link-speed = <2>;
+			power-domains = <&pgc_pcie>;
+			resets = <&src IMX8MQ_RESET_PCIEPHY2>,
+			         <&src IMX8MQ_RESET_PCIE2_CTRL_APPS_EN>,
+			         <&src IMX8MQ_RESET_PCIE2_CTRL_APPS_TURNOFF>;
+			reset-names = "pciephy", "apps", "turnoff";
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@38800000 {
 			compatible = "arm,gic-v3";
 			reg = <0x38800000 0x10000>,	/* GIC Dist */
-- 
2.20.1

