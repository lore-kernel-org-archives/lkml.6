Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753743AbeA3VTK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 16:19:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:35846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753662AbeA3VTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 16:19:07 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C3C32178E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v2 4/4] arm64: dts: exynos: Fix missing missing reg warning for syscon restart nodes
Date: Tue, 30 Jan 2018 22:18:19 +0100
Message-Id: <20180130211819.17139-5-krzk@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180130211819.17139-1-krzk@kernel.org>
References: <20180130211819.17139-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix DTC warnings like:

    arch/arm64/boot/dts/exynos/exynos7-espresso.dtb: Warning (simple_bus_reg):
        Node /soc/syscon-reboot missing or empty reg/ranges property

by moving the syscon restart node into the PMU (Power Management Unit)
node.  The PMU node is the actual block responsible for power
management, including typical Exynos on/off/restart procedures.
Therefore the syscon restart node logically belongs to it.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested.  All tests are welcomed.
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 14 +++++++-------
 arch/arm64/boot/dts/exynos/exynos7.dtsi    | 12 ++++++------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 62f276970174..0f3ec7e4b0f7 100644
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
2.11.0
