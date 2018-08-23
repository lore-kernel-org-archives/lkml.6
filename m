Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADABEC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E60820839
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cx8M9jwr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E60820839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388154AbeHWMW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:22:26 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37110 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387539AbeHWMWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:22:25 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11-v6so4917492wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 01:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JcIlW3cpxGsURQTBg2vdL3XElbzAB6H7Y+Oqb/egFe0=;
        b=cx8M9jwrYIp2ToxsGS3lU/tdO1on91kl09mkTBG3SiVjEZKKC1HTy8NgkKhv8ctj8W
         yNVkcW2QTDxYVmhJy6iI5tWvgHRXNpuizQoqeaprDGT84u2cvvDh/6Xrx734sPM03VR8
         Ms7YGevqe62nJszrW/d4AKyq7wg1vbbwFiycE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JcIlW3cpxGsURQTBg2vdL3XElbzAB6H7Y+Oqb/egFe0=;
        b=VZZlP4NThEHg4oHBfN3OeBsRfxHh6FxFHQIVcFDYTqAf/Zvt1WM2dTonQQ4LUA7cHe
         qgRBSAQl+A8M2EijmiTTD4RfVozHkxROdAZeYNxZBP3UvRzRPBk/wyecPy5GyNkj79/A
         SvcoRFfXt63/LyuftBWhdK194/FffsTlRAfvQNFnmLi5CZ9b09NLjxOwelH6GcPERvZk
         pLEoDUuhlKrEzc5VN00eiTi0xu41qJvJV4XazCVaA9STI1uOmLj9afkQPlV/O3b5DHUb
         P7NtG7tTDyroCuIJAgPNamJhmIPIQj7E5klJ5ag4YGa1v7StWs29PuRh/f7XCwtdyOyF
         FzTQ==
X-Gm-Message-State: APzg51BpfRqXZrfgPVCt93f62nqOUOFieC7bP1Zx1vNaVIYovW5d5eQb
        n+x87Jp/wsxHOykrmHX4x9YRmsfcSck=
X-Google-Smtp-Source: ANB0VdaBQ5lj6eBcegr62q/21oHDVCiHoBL+NvQ2O3HPs4yfyxSuLR/cQpEAkN+qKS+YJR7DCQMvYQ==
X-Received: by 2002:a1c:8893:: with SMTP id k141-v6mr4665366wmd.36.1535014423597;
        Thu, 23 Aug 2018 01:53:43 -0700 (PDT)
Received: from localhost ([49.248.176.232])
        by smtp.gmail.com with ESMTPSA id l130-v6sm3411161wmd.16.2018.08.23.01.53.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 01:53:42 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Yuantian Tang <andy.tang@nxp.com>,
        Ran Wang <ran.wang_1@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Yuan Yao <yao.yuan@nxp.com>, Sumit Garg <sumit.garg@nxp.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] arm64: dts: Fix various entry-method properties to reflect documentation
Date:   Thu, 23 Aug 2018 14:23:29 +0530
Message-Id: <113f28acbc55f64762c9f0bcefe076a811f2ed82.1535014078.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idle-states binding documentation[1] mentions that the
'entry-method' property is required on 64-bit platforms and must be
set to "psci".

commit a13f18f59d26 ("Documentation: arm: Fix typo in the idle-states
bindings examples") attempted to fix this earlier but clearly more is
needed.

Fix the cpu-capacity.txt documentation that uses the incorrect value so
we don't get copy-paste errors like these. Clarify the language in
idle-states.txt by removing the reference to the psci bindings that
might be causing this confusion.

Finally, fix devicetrees of various boards to reflect current
documentation.

[1] Documentation/devicetree/bindings/arm/idle-states.txt (see
idle-states node)

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 Documentation/devicetree/bindings/arm/cpu-capacity.txt | 2 +-
 Documentation/devicetree/bindings/arm/idle-states.txt  | 4 ++--
 arch/arm64/boot/dts/arm/juno-r1.dts                    | 2 +-
 arch/arm64/boot/dts/arm/juno-r2.dts                    | 2 +-
 arch/arm64/boot/dts/arm/juno.dts                       | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi         | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi         | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi         | 2 +-
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi              | 2 +-
 arch/arm64/boot/dts/sprd/sc9860.dtsi                   | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi                 | 2 +-
 11 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cpu-capacity.txt b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
index 7809fbe0cdb7..9b5685a1d15d 100644
--- a/Documentation/devicetree/bindings/arm/cpu-capacity.txt
+++ b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
@@ -94,7 +94,7 @@ cpus {
 	};
 
 	idle-states {
-		entry-method = "arm,psci";
+		entry-method = "psci";
 
 		CPU_SLEEP_0: cpu-sleep-0 {
 			compatible = "arm,idle-state";
diff --git a/Documentation/devicetree/bindings/arm/idle-states.txt b/Documentation/devicetree/bindings/arm/idle-states.txt
index 7a591333f2b1..2c73847499ab 100644
--- a/Documentation/devicetree/bindings/arm/idle-states.txt
+++ b/Documentation/devicetree/bindings/arm/idle-states.txt
@@ -237,8 +237,8 @@ processor idle states, defined as device tree nodes, are listed.
 		Value type: <stringlist>
 		Usage and definition depend on ARM architecture version.
 			# On ARM v8 64-bit this property is required and must
-			  be one of:
-			   - "psci" (see bindings in [2])
+			  be:
+			   - "psci"
 			# On ARM 32-bit systems this property is optional
 
 The nodes describing the idle states (state) can only be defined within the
diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
index 2c5db03f226c..b2b7ced633cf 100644
--- a/arch/arm64/boot/dts/arm/juno-r1.dts
+++ b/arch/arm64/boot/dts/arm/juno-r1.dts
@@ -63,7 +63,7 @@
 		};
 
 		idle-states {
-			entry-method = "arm,psci";
+			entry-method = "psci";
 
 			CPU_SLEEP_0: cpu-sleep-0 {
 				compatible = "arm,idle-state";
diff --git a/arch/arm64/boot/dts/arm/juno-r2.dts b/arch/arm64/boot/dts/arm/juno-r2.dts
index c51950f4a1b6..ab77adb4f3c2 100644
--- a/arch/arm64/boot/dts/arm/juno-r2.dts
+++ b/arch/arm64/boot/dts/arm/juno-r2.dts
@@ -63,7 +63,7 @@
 		};
 
 		idle-states {
-			entry-method = "arm,psci";
+			entry-method = "psci";
 
 			CPU_SLEEP_0: cpu-sleep-0 {
 				compatible = "arm,idle-state";
diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index 2b2bf39c30ef..1fb5c5a0f32e 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -62,7 +62,7 @@
 		};
 
 		idle-states {
-			entry-method = "arm,psci";
+			entry-method = "psci";
 
 			CPU_SLEEP_0: cpu-sleep-0 {
 				compatible = "arm,idle-state";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 205f0f4c5df0..3a2784117139 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -79,7 +79,7 @@
 		 * PSCI node is not added default, U-boot will add missing
 		 * parts if it determines to use PSCI.
 		 */
-		entry-method = "arm,psci";
+		entry-method = "psci";
 
 		CPU_PH20: cpu-ph20 {
 			compatible = "arm,idle-state";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 1109f22bda5e..e238b86e95fb 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -121,7 +121,7 @@
 		 * PSCI node is not added default, U-boot will add missing
 		 * parts if it determines to use PSCI.
 		 */
-		entry-method = "arm,psci";
+		entry-method = "psci";
 
 		CPU_PH20: cpu-ph20 {
 			compatible = "arm,idle-state";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 136ebfa9b333..1b200f7be0ba 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -117,7 +117,7 @@
 		 * PSCI node is not added default, U-boot will add missing
 		 * parts if it determines to use PSCI.
 		 */
-		entry-method = "arm,psci";
+		entry-method = "psci";
 
 		CPU_PH20: cpu-ph20 {
 			compatible = "arm,idle-state";
diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index 6d8532af8346..75cc0f7cc088 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -119,7 +119,7 @@
 		};
 
 		idle-states {
-			entry-method = "arm,psci";
+			entry-method = "psci";
 
 			CPU_SLEEP_0: cpu-sleep-0 {
 				compatible = "arm,idle-state";
diff --git a/arch/arm64/boot/dts/sprd/sc9860.dtsi b/arch/arm64/boot/dts/sprd/sc9860.dtsi
index 3f5160d2f130..48f5928ed45c 100644
--- a/arch/arm64/boot/dts/sprd/sc9860.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9860.dtsi
@@ -114,7 +114,7 @@
 	};
 
 	idle-states{
-		entry-method = "arm,psci";
+		entry-method = "psci";
 
 		CORE_PD: core_pd {
 			compatible = "arm,idle-state";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index a091e6f03014..29ce23422acf 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -58,7 +58,7 @@
 		};
 
 		idle-states {
-			entry-method = "arm,psci";
+			entry-method = "psci";
 
 			CPU_SLEEP_0: cpu-sleep-0 {
 				compatible = "arm,idle-state";
-- 
2.17.1

