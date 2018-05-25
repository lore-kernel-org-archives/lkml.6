Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966383AbeEYKek (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:34:40 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34825 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966262AbeEYKcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:32:45 -0400
X-Google-Smtp-Source: AB8JxZr20TQqBVa8vUfOUB6aT5xFwRkvQV4qHPi9PgrmDktCAOP+XS/sx8V3u35LWTq6HZdA+vgCtA==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: arm@kernel.org,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>, chris.redpath@arm.com,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/15] arm: dts: omap: Add missing cooling device properties for CPUs
Date: Fri, 25 May 2018 16:01:55 +0530
Message-Id: <7aa1c7c6d1e76b551ed74512af797db28be8925f.1527244201.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
In-Reply-To: <cover.1527244200.git.viresh.kumar@linaro.org>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1527244200.git.viresh.kumar@linaro.org>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cooling device properties, like "#cooling-cells" and
"dynamic-power-coefficient", should either be present for all the CPUs
of a cluster or none. If these are present only for a subset of CPUs of
a cluster then things will start falling apart as soon as the CPUs are
brought online in a different order. For example, this will happen
because the operating system looks for such properties in the CPU node
it is trying to bring up, so that it can register a cooling device.

Add such missing properties.

Fix other missing properties (clocks, supply, clock latency) as well to
make it all work.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/boot/dts/omap5.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 732b61a0e990..574ac11c0489 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -61,6 +61,20 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x1>;
+
+			operating-points = <
+				/* kHz    uV */
+				1000000 1060000
+				1500000 1250000
+			>;
+
+			clocks = <&dpll_mpu_ck>;
+			clock-names = "cpu";
+
+			clock-latency = <300000>; /* From omap-cpufreq driver */
+
+			/* cooling options */
+			#cooling-cells = <2>; /* min followed by max */
 		};
 	};
 
-- 
2.15.0.194.g9af6a3dea062
