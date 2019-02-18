Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94194C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5289320675
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550519336;
	bh=+OmSMSGwo3GxzHENcDMY1mw3dpV1vusvdXOAz2UjDMg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=MstcWJgJXfPFwYGO9m0jU6Sik/6YukY4yWgmWlh/9WfWX774VQzyN4cDd3Pm2wHOi
	 o4bUhlfTv5VYtgm99KsGgpzSVlPNkQjTs/5eN/ojmZszzbY1Jn7wMhl7J0bGMSgZnK
	 Sr6woNuaq+A9e0eEG5clgtLUWEZYWojNQ0MttSVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfBRTsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:48:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:48044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfBRTsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:48:54 -0500
Received: from localhost.localdomain (unknown [194.230.155.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4091217D9;
        Mon, 18 Feb 2019 19:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550519332;
        bh=+OmSMSGwo3GxzHENcDMY1mw3dpV1vusvdXOAz2UjDMg=;
        h=From:To:Cc:Subject:Date:From;
        b=onY3EccKQ3K+JONHcVvPzMMCldpxR6jrFgabQluLx2Vl+p6AfP6N47okbHi83e/AA
         GFuXK1Qj0FwASH/+KE9NrgBXiM5bWZDg8FHunqIyknE5OQtkU1Os1cDocXh+RvbrKE
         QO8J6ajm5pn0f4NjwnmGx/dvfYrpx76ZGWlJUnUg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Markus Reichl <reichl@t-online.de>
Subject: [PATCH 1/2] ARM: dts: exynos: Add CPU cooling on Arndale Octa
Date:   Mon, 18 Feb 2019 20:48:40 +0100
Message-Id: <20190218194841.21374-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arndale Octa board comes without fan so proper CPU cooling is necessary
to avoid critical shutdowns when CPUs are busy.  Although thermal zones
were present but CPU cooling was missing in DTS.

Adjust the trip points and add respective cooling nodes for each CPU
thermal zone.  The CPU throttling will start at 60 degrees of C,
intensify at 80 degrees of C and slow down CPUs as much as possible at
110 degrees of C.

With this configuration, when running four CPU intensive tasks, the
temperatures did not exceed 90 degrees of Celsius mostly oscillating
around 88 degrees in hottest thermal zone.  Test was however done with
only four CPUs online (big cluster, Cortex A15) because of errors when
booting secondary CPUs.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 264 ++++++++++++++++++
 1 file changed, 264 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index c7d9604a119e..2b227246c685 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -59,6 +59,270 @@
 	cpu-supply = <&buck6_reg>;
 };
 
+&cpu0_thermal {
+	trips {
+		cpu0_alert0: cpu-alert-0 {
+			temperature = <60000>; /* millicelsius */
+			hysteresis = <5000>; /* millicelsius */
+			type = "passive";
+		};
+		cpu0_alert1: cpu-alert-1 {
+			temperature = <80000>; /* millicelsius */
+			hysteresis = <10000>; /* millicelsius */
+			type = "passive";
+		};
+		cpu0_alert2: cpu-alert-2 {
+			temperature = <110000>; /* millicelsius */
+			hysteresis = <10000>; /* millicelsius */
+			type = "passive";
+		};
+		cpu0_crit0: cpu-crit-0 {
+			temperature = <120000>; /* millicelsius */
+			hysteresis = <0>; /* millicelsius */
+			type = "critical";
+		};
+	};
+
+	cooling-maps {
+		/*
+		 * Reduce the CPU speed by 2 steps, down to: 1600 MHz
+		 * and 1100 MHz.
+		 */
+		map0 {
+			trip = <&cpu0_alert0>;
+			cooling-device = <&cpu0 0 2>,
+					 <&cpu1 0 2>,
+					 <&cpu2 0 2>,
+					 <&cpu3 0 2>,
+					 <&cpu4 0 2>,
+					 <&cpu5 0 2>,
+					 <&cpu6 0 2>,
+					 <&cpu7 0 2>;
+		};
+
+		/*
+		 * Reduce the CPU speed down to 1200 MHz big (6 steps)
+		 * and 800 MHz LITTLE (5 steps).
+		 */
+		map1 {
+			trip = <&cpu0_alert1>;
+			cooling-device = <&cpu0 3 6>,
+					 <&cpu1 3 6>,
+					 <&cpu2 3 6>,
+					 <&cpu3 3 6>,
+					 <&cpu4 3 5>,
+					 <&cpu5 3 5>,
+					 <&cpu6 3 5>,
+					 <&cpu7 3 5>;
+		};
+
+		/*
+		 * Reduce the CPU speed as much as possible, down to 700 MHz
+		 * big (11 steps) and 600 MHz LITTLE (7 steps).
+		 */
+		map2 {
+			trip = <&cpu0_alert2>;
+			cooling-device = <&cpu0 6 11>,
+					 <&cpu1 6 11>,
+					 <&cpu2 6 11>,
+					 <&cpu3 6 11>,
+					 <&cpu4 5 7>,
+					 <&cpu5 5 7>,
+					 <&cpu6 5 7>,
+					 <&cpu7 5 7>;
+		};
+	};
+};
+
+&cpu1_thermal {
+	trips {
+		cpu1_alert0: cpu-alert-0 {
+			temperature = <60000>; /* millicelsius */
+			hysteresis = <5000>; /* millicelsius */
+			type = "passive";
+		};
+		cpu1_alert1: cpu-alert-1 {
+			temperature = <80000>; /* millicelsius */
+			hysteresis = <10000>; /* millicelsius */
+			type = "passive";
+		};
+		cpu1_alert2: cpu-alert-2 {
+			temperature = <110000>; /* millicelsius */
+			hysteresis = <10000>; /* millicelsius */
+			type = "passive";
+		};
+		cpu1_crit0: cpu-crit-0 {
+			temperature = <120000>; /* millicelsius */
+			hysteresis = <0>; /* millicelsius */
+			type = "critical";
+		};
+	};
+
+	cooling-maps {
+		map0 {
+			trip = <&cpu1_alert0>;
+			cooling-device = <&cpu0 0 2>,
+					 <&cpu1 0 2>,
+					 <&cpu2 0 2>,
+					 <&cpu3 0 2>,
+					 <&cpu4 0 2>,
+					 <&cpu5 0 2>,
+					 <&cpu6 0 2>,
+					 <&cpu7 0 2>;
+		};
+
+		map1 {
+			trip = <&cpu1_alert1>;
+			cooling-device = <&cpu0 3 6>,
+					 <&cpu1 3 6>,
+					 <&cpu2 3 6>,
+					 <&cpu3 3 6>,
+					 <&cpu4 3 5>,
+					 <&cpu5 3 5>,
+					 <&cpu6 3 5>,
+					 <&cpu7 3 5>;
+		};
+
+		map2 {
+			trip = <&cpu1_alert2>;
+			cooling-device = <&cpu0 6 11>,
+					 <&cpu1 6 11>,
+					 <&cpu2 6 11>,
+					 <&cpu3 6 11>,
+					 <&cpu4 5 7>,
+					 <&cpu5 5 7>,
+					 <&cpu6 5 7>,
+					 <&cpu7 5 7>;
+		};
+	};
+};
+
+&cpu2_thermal {
+	trips {
+		cpu2_alert0: cpu-alert-0 {
+			temperature = <60000>; /* millicelsius */
+			hysteresis = <5000>; /* millicelsius */
+			type = "passive";
+		};
+		cpu2_alert1: cpu-alert-1 {
+			temperature = <80000>; /* millicelsius */
+			hysteresis = <10000>; /* millicelsius */
+			type = "passive";
+		};
+		cpu2_alert2: cpu-alert-2 {
+			temperature = <110000>; /* millicelsius */
+			hysteresis = <10000>; /* millicelsius */
+			type = "passive";
+		};
+		cpu2_crit0: cpu-crit-0 {
+			temperature = <120000>; /* millicelsius */
+			hysteresis = <0>; /* millicelsius */
+			type = "critical";
+		};
+	};
+
+	cooling-maps {
+		map0 {
+			trip = <&cpu2_alert0>;
+			cooling-device = <&cpu0 0 2>,
+					 <&cpu1 0 2>,
+					 <&cpu2 0 2>,
+					 <&cpu3 0 2>,
+					 <&cpu4 0 2>,
+					 <&cpu5 0 2>,
+					 <&cpu6 0 2>,
+					 <&cpu7 0 2>;
+		};
+
+		map1 {
+			trip = <&cpu2_alert1>;
+			cooling-device = <&cpu0 3 6>,
+					 <&cpu1 3 6>,
+					 <&cpu2 3 6>,
+					 <&cpu3 3 6>,
+					 <&cpu4 3 5>,
+					 <&cpu5 3 5>,
+					 <&cpu6 3 5>,
+					 <&cpu7 3 5>;
+		};
+
+		map2 {
+			trip = <&cpu2_alert2>;
+			cooling-device = <&cpu0 6 11>,
+					 <&cpu1 6 11>,
+					 <&cpu2 6 11>,
+					 <&cpu3 6 11>,
+					 <&cpu4 6 7>,
+					 <&cpu5 6 7>,
+					 <&cpu6 6 7>,
+					 <&cpu7 6 7>;
+		};
+	};
+};
+
+&cpu3_thermal {
+	trips {
+		cpu3_alert0: cpu-alert-0 {
+			temperature = <60000>; /* millicelsius */
+			hysteresis = <5000>; /* millicelsius */
+			type = "passive";
+		};
+		cpu3_alert1: cpu-alert-1 {
+			temperature = <80000>; /* millicelsius */
+			hysteresis = <10000>; /* millicelsius */
+			type = "passive";
+		};
+		cpu3_alert2: cpu-alert-2 {
+			temperature = <110000>; /* millicelsius */
+			hysteresis = <10000>; /* millicelsius */
+			type = "passive";
+		};
+		cpu3_crit0: cpu-crit-0 {
+			temperature = <120000>; /* millicelsius */
+			hysteresis = <0>; /* millicelsius */
+			type = "critical";
+		};
+	};
+
+	cooling-maps {
+		map0 {
+			trip = <&cpu3_alert0>;
+			cooling-device = <&cpu0 0 2>,
+					 <&cpu1 0 2>,
+					 <&cpu2 0 2>,
+					 <&cpu3 0 2>,
+					 <&cpu4 0 2>,
+					 <&cpu5 0 2>,
+					 <&cpu6 0 2>,
+					 <&cpu7 0 2>;
+		};
+
+		map1 {
+			trip = <&cpu3_alert1>;
+			cooling-device = <&cpu0 3 6>,
+					 <&cpu1 3 6>,
+					 <&cpu2 3 6>,
+					 <&cpu3 3 6>,
+					 <&cpu4 3 5>,
+					 <&cpu5 3 5>,
+					 <&cpu6 3 5>,
+					 <&cpu7 3 5>;
+		};
+
+		map2 {
+			trip = <&cpu3_alert2>;
+			cooling-device = <&cpu0 6 11>,
+					 <&cpu1 6 11>,
+					 <&cpu2 6 11>,
+					 <&cpu3 6 11>,
+					 <&cpu4 5 7>,
+					 <&cpu5 5 7>,
+					 <&cpu6 5 7>,
+					 <&cpu7 5 7>;
+		};
+	};
+};
+
 &usbdrd_dwc3_1 {
 	dr_mode = "host";
 };
-- 
2.17.1

