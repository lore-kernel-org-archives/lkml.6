Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753138AbeDPSLz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 14:11:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752854AbeDPSLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 14:11:53 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6EE4205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] ARM: dts: exynos: Move syscon poweroff and restart nodes under the PMU
Date: Mon, 16 Apr 2018 20:11:25 +0200
Message-Id: <20180416181126.15629-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMU node is the actual block responsible for power management,
including typical Exynos on/off/restart procedures.  Therefore the
syscon poweroff and restart nodes logically belong to it.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Previously was "Fix missing missing reg warning for syscon restart
nodes" to fix DTC warnings like:

    arch/arm/boot/dts/exynos4412-trats2.dtb: Warning (simple_bus_reg):
        Node /soc/syscon-poweroff missing or empty reg/ranges property
    arch/arm/boot/dts/exynos4412-trats2.dtb: Warning (simple_bus_reg):
        Node /soc/syscon-reboot missing or empty reg/ranges property

but this warnings are gone in v4.17-rc1 since 9130ba884640
("scripts/dtc: Update to upstream version v1.4.6-9-gaadd0b65c987")
---
 arch/arm/boot/dts/exynos-syscon-restart.dtsi | 28 ++++++++++++----------------
 arch/arm/boot/dts/exynos3250.dtsi            |  2 +-
 arch/arm/boot/dts/exynos4.dtsi               |  3 ++-
 arch/arm/boot/dts/exynos5.dtsi               |  1 -
 arch/arm/boot/dts/exynos5250.dtsi            |  1 +
 arch/arm/boot/dts/exynos5410.dtsi            |  1 +
 arch/arm/boot/dts/exynos5420.dtsi            |  1 +
 7 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/exynos-syscon-restart.dtsi b/arch/arm/boot/dts/exynos-syscon-restart.dtsi
index 4b3dd0549a54..ecf416690a15 100644
--- a/arch/arm/boot/dts/exynos-syscon-restart.dtsi
+++ b/arch/arm/boot/dts/exynos-syscon-restart.dtsi
@@ -3,22 +3,18 @@
  * Samsung's Exynos SoC syscon reboot/poweroff nodes common definition.
  */
 
-/ {
-	soc {
-		compatible = "simple-bus";
-
-		poweroff: syscon-poweroff {
-			compatible = "syscon-poweroff";
-			regmap = <&pmu_system_controller>;
-			offset = <0x330C>; /* PS_HOLD_CONTROL */
-			mask = <0x5200>; /* reset value */
-		};
+&pmu_system_controller {
+	poweroff: syscon-poweroff {
+		compatible = "syscon-poweroff";
+		regmap = <&pmu_system_controller>;
+		offset = <0x330C>; /* PS_HOLD_CONTROL */
+		mask = <0x5200>; /* reset value */
+	};
 
-		reboot: syscon-reboot {
-			compatible = "syscon-reboot";
-			regmap = <&pmu_system_controller>;
-			offset = <0x0400>; /* SWRESET */
-			mask = <0x1>;
-		};
+	reboot: syscon-reboot {
+		compatible = "syscon-reboot";
+		regmap = <&pmu_system_controller>;
+		offset = <0x0400>; /* SWRESET */
+		mask = <0x1>;
 	};
 };
diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 0a5f989d963b..962af97c1883 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -15,7 +15,6 @@
  */
 
 #include "exynos4-cpu-thermal.dtsi"
-#include "exynos-syscon-restart.dtsi"
 #include <dt-bindings/clock/exynos3250.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
@@ -919,3 +918,4 @@
 };
 
 #include "exynos3250-pinctrl.dtsi"
+#include "exynos-syscon-restart.dtsi"
diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 909a9f2bf5be..dfe41b698745 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -20,7 +20,6 @@
 #include <dt-bindings/clock/exynos-audss-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include "exynos-syscon-restart.dtsi"
 
 / {
 	interrupt-parent = <&gic>;
@@ -1025,3 +1024,5 @@
 		};
 	};
 };
+
+#include "exynos-syscon-restart.dtsi"
diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index f8d7de1144f1..359f49bdd4e2 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -12,7 +12,6 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include "exynos-syscon-restart.dtsi"
 
 / {
 	interrupt-parent = <&gic>;
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 45283a6c5eee..85bfa8909af3 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -1117,3 +1117,4 @@
 };
 
 #include "exynos5250-pinctrl.dtsi"
+#include "exynos-syscon-restart.dtsi"
diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 55509c690328..20e789ea136f 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -439,3 +439,4 @@
 };
 
 #include "exynos5410-pinctrl.dtsi"
+#include "exynos-syscon-restart.dtsi"
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 2f3cb2a97f71..71e2b154a244 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -1531,3 +1531,4 @@
 };
 
 #include "exynos5420-pinctrl.dtsi"
+#include "exynos-syscon-restart.dtsi"
-- 
2.14.1
