Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbeCOL4B (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 07:56:01 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38454 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751806AbeCOLzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 07:55:55 -0400
X-Google-Smtp-Source: AG47ELuWH/h6pGw4NrPFC6nLoEwZvOdZy+qv1T5zGoK0TO0xX9Ym4NkPrLq4rOY+UvSgQYfEAvhNoA==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/4] ARM64: dts: meson-axg: use hhi syscon for the clock controller
Date: Thu, 15 Mar 2018 12:55:44 +0100
Message-Id: <20180315115545.1884-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180315115545.1884-1-jbrunet@baylibre.com>
References: <20180315115545.1884-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the meson-gx, the axg clock controller should go through a syscon
to access the hhi register region, and not directly map the region.
This way, the hhi register region can be used safely by multiple drivers.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index b58808eb3cc8..d4c5507fff30 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -262,10 +262,14 @@
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xff63c000 0x0 0x1c00>;
 
-			clkc: clock-controller@0 {
-				compatible = "amlogic,axg-clkc";
-				#clock-cells = <1>;
-				reg = <0x0 0x0 0x0 0x320>;
+			sysctrl: system-controller@0 {
+				compatible = "amlogic,meson-axg-hhi-sysctrl", "syscon", "simple-mfd";
+				reg = <0 0 0 0x400>;
+
+				clkc: clock-controller {
+					compatible = "amlogic,axg-clkc";
+					#clock-cells = <1>;
+				};
 			};
 		};
 
-- 
2.14.3
