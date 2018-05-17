Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbeEQHpa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 03:45:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752348AbeEQHpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 03:45:24 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan@agner.ch>, Lucas Stach <dev@lynxeye.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v5 3/3] ARM: dts: tegra: Work safely with 256 MB Colibri-T20 modules
Date: Thu, 17 May 2018 09:45:03 +0200
Message-Id: <1526543103-21668-3-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526543103-21668-1-git-send-email-krzk@kernel.org>
References: <1526543103-21668-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colibri-T20 can come in 256 MB RAM (with 512 MB NAND) or 512 MB RAM
(with 1024 MB NAND) flavors.  Both of them will use the same DTSI
expecting the bootloader to do the fixup of /memory node.  However in
case it does not happen, let's stay on safe side by limiting the memory
to 256 MB for both versions of Colibri-T20.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

RFT:
Not tested on 512 MB module as I have only the 256 MB one.

Changes since v4:
1. Drop the 512 suffix from file names (suggested by Stefan).

Changes since v3:
1. Reduce the memory in existing DTSI instead of creating a new one
   (suggested by Marcel).

Changes since v2:
1. Do not add new compatible but use everywhere existing
   "toradex,colibri_t20-512" (suggested by Rob).

Changes since v1:
1. Fix memory size in tegra20-colibri-256.dtsi (was working fine because
   my bootloader uses mem= argument).
---
 arch/arm/boot/dts/Makefile                                       | 2 +-
 .../boot/dts/{tegra20-colibri-512.dtsi => tegra20-colibri.dtsi}  | 9 +++++++--
 arch/arm/boot/dts/{tegra20-iris-512.dts => tegra20-iris.dts}     | 4 ++--
 3 files changed, 10 insertions(+), 5 deletions(-)
 rename arch/arm/boot/dts/{tegra20-colibri-512.dtsi => tegra20-colibri.dtsi} (98%)
 rename arch/arm/boot/dts/{tegra20-iris-512.dts => tegra20-iris.dts} (95%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ec2024ea8b1e..837f8274b3ee 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1030,7 +1030,7 @@ dtb-$(CONFIG_ARCH_TANGO) += \
 	tango4-vantage-1172.dtb
 dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += \
 	tegra20-harmony.dtb \
-	tegra20-iris-512.dtb \
+	tegra20-iris.dtb \
 	tegra20-medcom-wide.dtb \
 	tegra20-paz00.dtb \
 	tegra20-plutux.dtb \
diff --git a/arch/arm/boot/dts/tegra20-colibri-512.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
similarity index 98%
rename from arch/arm/boot/dts/tegra20-colibri-512.dtsi
rename to arch/arm/boot/dts/tegra20-colibri.dtsi
index 305efb275b48..b9387c540450 100644
--- a/arch/arm/boot/dts/tegra20-colibri-512.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -2,7 +2,7 @@
 #include "tegra20.dtsi"
 
 / {
-	model = "Toradex Colibri T20 512MB";
+	model = "Toradex Colibri T20 256/512 MB";
 	compatible = "toradex,colibri_t20-512", "nvidia,tegra20";
 
 	aliases {
@@ -12,7 +12,12 @@
 
 	memory@0 {
 		device_type = "memory";
-		reg = <0x00000000 0x20000000>;
+		/*
+		 * Set memory to 256 MB to be safe as this could be used on
+		 * 256 or 512 MB module. It is expected from bootloader
+		 * to fix this up for 512 MB version.
+		 */
+		reg = <0x00000000 0x10000000>;
 	};
 
 	host1x@50000000 {
diff --git a/arch/arm/boot/dts/tegra20-iris-512.dts b/arch/arm/boot/dts/tegra20-iris.dts
similarity index 95%
rename from arch/arm/boot/dts/tegra20-iris-512.dts
rename to arch/arm/boot/dts/tegra20-iris.dts
index 40126388946d..57f16c0e9917 100644
--- a/arch/arm/boot/dts/tegra20-iris-512.dts
+++ b/arch/arm/boot/dts/tegra20-iris.dts
@@ -1,10 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 /dts-v1/;
 
-#include "tegra20-colibri-512.dtsi"
+#include "tegra20-colibri.dtsi"
 
 / {
-	model = "Toradex Colibri T20 512MB on Iris";
+	model = "Toradex Colibri T20 256/512 MB on Iris";
 	compatible = "toradex,iris", "toradex,colibri_t20-512", "nvidia,tegra20";
 
 	aliases {
-- 
2.7.4
