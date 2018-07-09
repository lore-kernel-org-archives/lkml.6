Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D780C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED96820877
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zijseTDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED96820877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933333AbeGIQGy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:06:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754459AbeGIQGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:06:47 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 108B420881;
        Mon,  9 Jul 2018 16:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531152407;
        bh=afS/JwtTsESU6Co6uejgWrWyD3XI9/Yna8IcFoBQBMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zijseTDNUW2OikZaeWlsq/nmrhmirdDrvEzD7TR2pdJJPaJt+zfctU+K50yeXVdyi
         W9RGs4l6ySswnRqqeV1DG3fTrRvoXj5cX0Zc6C3GSU2OWI3s9u0Wc8+OoswFAjRVwm
         s3Vnd0BGb3LMFDXPxg2GJqX0hJl1ycopmo35JIfE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan@agner.ch>, Lucas Stach <dev@lynxeye.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v8 4/4] ARM: dts: tegra: Work safely with 256 MB Colibri-T20 modules
Date:   Mon,  9 Jul 2018 18:05:19 +0200
Message-Id: <20180709160519.23497-4-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180709160519.23497-1-krzk@kernel.org>
References: <20180709160519.23497-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colibri-T20 can come in 256 MB RAM (with 512 MB NAND) or 512 MB RAM
(with 1024 MB NAND) flavors.  Both of them will use the same DTSI
expecting the bootloader to do the fixup of /memory node.  However in
case it does not happen, let's stay on safe side by limiting the memory
to 256 MB for both versions of Colibri-T20.

Rename to remove the unnecessary memory size from the device tree file
name.  While at it, also follow the typical Toradex SoC, module, carrier
board hierarchy.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Stefan Agner <stefan@agner.ch>
Tested-by: Stefan Agner <stefan@agner.ch>

---

Changes since v7:
1. Add tags.

Changes since v6:
1. Only adjust commit msg.

Changes since v5:
1. Add "colibri" suffix to iris DTS (suggested by Stefan).

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
 .../boot/dts/{tegra20-iris-512.dts => tegra20-colibri-iris.dts}  | 4 ++--
 .../boot/dts/{tegra20-colibri-512.dtsi => tegra20-colibri.dtsi}  | 9 +++++++--
 3 files changed, 10 insertions(+), 5 deletions(-)
 rename arch/arm/boot/dts/{tegra20-iris-512.dts => tegra20-colibri-iris.dts} (95%)
 rename arch/arm/boot/dts/{tegra20-colibri-512.dtsi => tegra20-colibri.dtsi} (98%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 89a84e5ca637..749caca383ed 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1048,7 +1048,7 @@ dtb-$(CONFIG_ARCH_TANGO) += \
 	tango4-vantage-1172.dtb
 dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += \
 	tegra20-harmony.dtb \
-	tegra20-iris-512.dtb \
+	tegra20-colibri-iris.dtb \
 	tegra20-medcom-wide.dtb \
 	tegra20-paz00.dtb \
 	tegra20-plutux.dtb \
diff --git a/arch/arm/boot/dts/tegra20-iris-512.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
similarity index 95%
rename from arch/arm/boot/dts/tegra20-iris-512.dts
rename to arch/arm/boot/dts/tegra20-colibri-iris.dts
index 40126388946d..57f16c0e9917 100644
--- a/arch/arm/boot/dts/tegra20-iris-512.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
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
diff --git a/arch/arm/boot/dts/tegra20-colibri-512.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
similarity index 98%
rename from arch/arm/boot/dts/tegra20-colibri-512.dtsi
rename to arch/arm/boot/dts/tegra20-colibri.dtsi
index 5623ff8d128c..dc06b23183e1 100644
--- a/arch/arm/boot/dts/tegra20-colibri-512.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -2,7 +2,7 @@
 #include "tegra20.dtsi"
 
 / {
-	model = "Toradex Colibri T20 512MB";
+	model = "Toradex Colibri T20 256/512 MB";
 	compatible = "toradex,colibri_t20-512", "nvidia,tegra20";
 
 	aliases {
@@ -11,7 +11,12 @@
 	};
 
 	memory@0 {
-		reg = <0x00000000 0x20000000>;
+		/*
+		 * Set memory to 256 MB to be safe as this could be used on
+		 * 256 or 512 MB module. It is expected from bootloader
+		 * to fix this up for 512 MB version.
+		 */
+		reg = <0x00000000 0x10000000>;
 	};
 
 	host1x@50000000 {
-- 
2.14.1

