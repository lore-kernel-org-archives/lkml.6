Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754006AbeFDHKj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:10:39 -0400
Received: from inva020.nxp.com ([92.121.34.13]:54381 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753971AbeFDHKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:10:36 -0400
From: Yangbo Lu <yangbo.lu@nxp.com>
To: netdev@vger.kernel.org, madalin.bucur@nxp.com,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 05/10] arm64: dts: fsl: move ptp timer out of fman
Date: Mon,  4 Jun 2018 15:08:32 +0800
Message-Id: <20180604070837.19265-6-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180604070837.19265-1-yangbo.lu@nxp.com>
References: <20180604070837.19265-1-yangbo.lu@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to move ptp timer node out of fman.
Because ptp timer will be probed by ptp_qoriq driver,
it should be an independent device in case of conflict
memory mapping.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi
index 4dd0676..e745c0b 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi
@@ -11,13 +11,14 @@ fman0: fman@1a00000 {
 	#size-cells = <1>;
 	cell-index = <0>;
 	compatible = "fsl,fman";
-	ranges = <0x0 0x0 0x1a00000 0x100000>;
-	reg = <0x0 0x1a00000 0x0 0x100000>;
+	ranges = <0x0 0x0 0x1a00000 0xfe000>;
+	reg = <0x0 0x1a00000 0x0 0xfe000>;
 	interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
 		     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 	clocks = <&clockgen 3 0>;
 	clock-names = "fmanclk";
 	fsl,qman-channel-range = <0x800 0x10>;
+	ptimer-handle = <&ptp_timer0>;
 
 	muram@0 {
 		compatible = "fsl,fman-muram";
@@ -73,9 +74,10 @@ fman0: fman@1a00000 {
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xfd000 0x1000>;
 	};
+};
 
-	ptp_timer0: ptp-timer@fe000 {
-		compatible = "fsl,fman-ptp-timer";
-		reg = <0xfe000 0x1000>;
-	};
+ptp_timer0: ptp-timer@1afe000 {
+	compatible = "fsl,fman-ptp-timer";
+	reg = <0x1afe000 0x1000>;
+	interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 };
-- 
1.7.1
