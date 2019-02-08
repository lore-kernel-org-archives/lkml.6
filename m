Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA43C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943F220663
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfBHM0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:26:21 -0500
Received: from mx.socionext.com ([202.248.49.38]:27777 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbfBHM0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:26:20 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 08 Feb 2019 21:26:18 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id D2CCD60062;
        Fri,  8 Feb 2019 21:26:18 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Fri, 8 Feb 2019 21:26:18 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id AA4EA4036D;
        Fri,  8 Feb 2019 21:26:18 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 874BD1202F1;
        Fri,  8 Feb 2019 21:26:18 +0900 (JST)
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH v2 07/15] ndings: clock: milbeaut: add Milbeaut clock description
Date:   Fri,  8 Feb 2019 21:27:03 +0900
Message-Id: <1549628823-31388-1-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings document for Milbeaut clock.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 .../devicetree/bindings/clock/milbeaut-clock.txt   | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/milbeaut-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/milbeaut-clock.txt b/Documentation/devicetree/bindings/clock/milbeaut-clock.txt
new file mode 100644
index 0000000..bcfc5df
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/milbeaut-clock.txt
@@ -0,0 +1,49 @@
+Milbeaut SoCs Clock Controller Binding
+----------------------------------------
+Milbeaut SoCs Clock controller is an integrated clock controller, which
+generates and supplies to all modules.
+
+This binding uses common clock bindings
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible: should be one of the following:
+    "socionext,milbeaut-m10v-ccu" - for M10V SoC
+- reg: shall contain base address and length of clock registers
+- #clock-cells: shall be 1
+- clocks: shall be an external clock
+
+Example: Clock controller node:
+
+	clk: m10v-clk-ctrl@1d021000 {
+		compatible = "socionext,milbeaut-m10v-clk-ccu";
+		reg = <0x1d021000 0x4000>;
+		#clock-cells = <1>
+		clocks = <&clki40mhz>
+	};
+
+Example: Required an external clock for Clock controller node:
+
+	clocks {
+		clki40mhz: clki40mhz {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <40000000>;
+		};
+
+		/* other clocks */
+	};
+
+The clock consumer shall specify the desired clock-output of the clock
+controller as below by specifying output-id in its "clk" phandle cell.
+2: uart
+4: 32-bit timer
+
+Example: uart1 node:
+	uart1: serial@1e700010 {
+		compatible = "socionext,milbeaut-usio-uart";
+		reg = <0x1e700010 0x10>;
+		interrupts = <0 141 0x4>, <0 149 0x4>;
+		interrupt-names = "rx", "tx";
+		clocks = <&clk 2>;
+	};
-- 
1.9.1

