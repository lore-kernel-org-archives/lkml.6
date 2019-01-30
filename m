Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE8DC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA9C21852
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbfA3InH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:43:07 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:60788 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727430AbfA3ImW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:42:22 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id D613C5FD4D; Wed, 30 Jan 2019 16:42:17 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>,
        Andre Przywara <andre.przywara@arm.com>,
        Emmanuel Vadot <manu@freebsd.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Sergey Matyukevich <geomatsi@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] arm64: dts: allwinner: h5: orange-pi-zero-plus: Add CPU regulator supply
Date:   Wed, 30 Jan 2019 16:41:58 +0800
Message-Id: <20190130084203.25053-6-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130084203.25053-1-wens@csie.org>
References: <20190130084203.25053-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OrangePi Zero Plus uses a fixed regulator to supply the CPU cores.
The feedback resistor network can be changed by toggling a GPIO line.
This is effectively a GPIO controlled regulator that can change between
roughly 1.1V and 1.3V. The actual voltage is slightly higher. The values
used in the device tree description are based on calculations using the
resistor values from the schematics.

Cc: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>

---

This patch is based on the schematics and has not been tested on an
actual board.
---
 .../sun50i-h5-orangepi-zero-plus.dts          | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
index 1238de25a969..3493eea7cf29 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
@@ -57,6 +57,26 @@
 		enable-active-high;
 		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
 	};
+
+	reg_vdd_cpux: vdd-cpux {
+		compatible = "regulator-gpio";
+		regulator-name = "vdd-cpux";
+		regulator-type = "voltage";
+		regulator-boot-on;
+		regulator-always-on;
+		regulator-min-microvolt = <1108475>;
+		regulator-max-microvolt = <1307810>;
+		regulator-ramp-delay = <50>; /* 4ms */
+		enable-gpios =  <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
+		gpios = <&r_pio 0 1 GPIO_ACTIVE_HIGH>; /* PL6 */
+		gpios-states = <0x1>;
+		states = <1108475 0x0
+			  1307810 0x1>;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&reg_vdd_cpux>;
 };
 
 &ehci0 {
-- 
2.20.1

