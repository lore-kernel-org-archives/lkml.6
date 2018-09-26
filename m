Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89501C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D2F2154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRCCdr9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D2F2154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbeI0BRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:17:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbeI0BRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:17:17 -0400
Received: from localhost.localdomain (unknown [178.38.103.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32A2E2150C;
        Wed, 26 Sep 2018 19:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537988575;
        bh=g8o1YT3RxeHkdBx4JaUy+bmb1nF2286k1/uBWAqVwk4=;
        h=From:To:Cc:Subject:Date:From;
        b=qRCCdr9GPVi7/8Gjtc/9q4DzAE8PWkY6G0HjHxNiQ/FZP0+bsWPXLvIH3kA1nwKbL
         CnCBoUhnS/2XRixwlKPf5VKjU2wsH6Nt6u69gt12nundHBla+jZFZN44wGMIESA1TC
         T+6hCPMZTQidArZUYXcwf0dA9IgN6emvEaMmt5e4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v2] ARM: dts: exynos: Add pin configuration for SD write protect on Odroid XU
Date:   Wed, 26 Sep 2018 21:02:48 +0200
Message-Id: <20180926190248.6369-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SD card write-protect pin configuration to be sure that it will be
properly pulled down to indicate write access.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Remove cd-gpios and wp-gpios leaving only WP pin configuration (after
   Marek Szyprowski feedback).
2. Pull pin down.
---
 arch/arm/boot/dts/exynos5410-odroidxu.dts | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
index a2046f5f998c..434a7591ff63 100644
--- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
+++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
@@ -530,7 +530,7 @@
 	samsung,dw-mshc-sdr-timing = <0 4>;
 	samsung,dw-mshc-ddr-timing = <0 2>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
+	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4 &sd2_wp>;
 	bus-width = <4>;
 	cap-sd-highspeed;
 	vmmc-supply = <&ldo21_reg>;
@@ -545,6 +545,14 @@
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
+	sd2_wp: sd2-wp {
+		samsung,pins = "gpm5-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		/* Pin is floating so be sure to disable write-protect */
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
+	};
+
 	pmic_dvs_3: pmic-dvs-3 {
 		samsung,pins = "gpx0-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
-- 
2.17.1

