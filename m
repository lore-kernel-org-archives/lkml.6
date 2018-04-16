Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753182AbeDPSL5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 14:11:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752854AbeDPSLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 14:11:55 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1847421838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] arm64: dts: exynos: Move syscon poweroff and restart nodes under the PMU
Date: Mon, 16 Apr 2018 20:11:26 +0200
Message-Id: <20180416181126.15629-2-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180416181126.15629-1-krzk@kernel.org>
References: <20180416181126.15629-1-krzk@kernel.org>
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

    arch/arm64/boot/dts/exynos/exynos7-espresso.dtb: Warning (simple_bus_reg):
        Node /soc/syscon-reboot missing or empty reg/ranges property

but this warnings are gone in v4.17-rc1 since 9130ba884640
("scripts/dtc: Update to upstream version v1.4.6-9-gaadd0b65c987")
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 14 +++++++-------
 arch/arm64/boot/dts/exynos/exynos7.dtsi    | 12 ++++++------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index c0231d077fa6..01e49159dd91 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -231,13 +231,6 @@
 		cpu_on = <0xC4000003>;
 	};
 
-	reboot: syscon-reboot {
-		compatible = "syscon-reboot";
-		regmap = <&pmu_system_controller>;
-		offset = <0x400>; /* SWRESET */
-		mask = <0x1>;
-	};
-
 	soc: soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -799,6 +792,13 @@
 			#clock-cells = <1>;
 			clock-names = "clkout16";
 			clocks = <&xxti>;
+
+			reboot: syscon-reboot {
+				compatible = "syscon-reboot";
+				regmap = <&pmu_system_controller>;
+				offset = <0x400>; /* SWRESET */
+				mask = <0x1>;
+			};
 		};
 
 		gic: interrupt-controller@11001000 {
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index ad9dce6894ce..0b98d2334cad 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -494,13 +494,13 @@
 		pmu_system_controller: system-controller@105c0000 {
 			compatible = "samsung,exynos7-pmu", "syscon";
 			reg = <0x105c0000 0x5000>;
-		};
 
-		reboot: syscon-reboot {
-			compatible = "syscon-reboot";
-			regmap = <&pmu_system_controller>;
-			offset = <0x0400>;
-			mask = <0x1>;
+			reboot: syscon-reboot {
+				compatible = "syscon-reboot";
+				regmap = <&pmu_system_controller>;
+				offset = <0x0400>;
+				mask = <0x1>;
+			};
 		};
 
 		rtc: rtc@10590000 {
-- 
2.14.1
