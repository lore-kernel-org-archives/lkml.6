Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9D3ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 21:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E9A2156E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 21:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HX6GLAfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E9A2156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391521AbeIVCyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 22:54:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391328AbeIVCyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 22:54:06 -0400
Received: from localhost.localdomain (unknown [178.38.103.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B2C321532;
        Fri, 21 Sep 2018 21:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537563809;
        bh=h4/iplhYCAV79ucu4oz9dTxNL7eJrY13ixOD0eE3JN4=;
        h=From:To:Cc:Subject:Date:From;
        b=HX6GLAfL1eT5WklSKw2SN8qdImCnstaVvQtn9pTUx2/Q/T129qH+g2M8ZKssyydcS
         2CPz+bbpu3bBbZZY9qxPaGibqjVh9HHLw8pSE21KX4foV9G6zk7ZaQWUct7blF3Wz/
         LyojjIjvPU8G4oi4Y4gHZac4SN3X1D/2xn+15dnk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH] ARM: dts: exynos: Add CD and WP pins to Odroid XU SD card
Date:   Fri, 21 Sep 2018 23:03:21 +0200
Message-Id: <20180921210321.12404-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defining card-detect and write-protect GPIO pins in Odroid XU SD Card
does not change anything from functional point of view - dw-mmc driver
was reading the state from registers.  Adding cd-gpios and wp-gpios
properties changes only internal driver behavior to access the pins
directly.

Add them to DTS only to comprehensively describe the hardware.  Minor
benefit is that write-protect pin configuration makes sure that it will
be properly pulled up to indicate write access.

This also removes debug messages:
    dwmmc_exynos 12220000.mmc: No GPIO consumer cd found
    dwmmc_exynos 12220000.mmc: No GPIO consumer wp found

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5410-odroidxu.dts | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
index a2046f5f998c..dae360f29a47 100644
--- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
+++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
@@ -525,12 +525,14 @@
 
 &mmc_2 {
 	status = "okay";
+	wp-gpios = <&gpm5 0 GPIO_ACTIVE_LOW>;
+	cd-gpios = <&gpc2 2 GPIO_ACTIVE_LOW>;
 	card-detect-delay = <200>;
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <0 4>;
 	samsung,dw-mshc-ddr-timing = <0 2>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
+	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4 &sd2_wp>;
 	bus-width = <4>;
 	cap-sd-highspeed;
 	vmmc-supply = <&ldo21_reg>;
@@ -573,6 +575,14 @@
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
+
+	sd2_wp: sd2-wp {
+		samsung,pins = "gpm5-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		/* Pin is floating so pull it up to disable write-protect */
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
+	};
 };
 
 &pwm {
-- 
2.17.1

