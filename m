Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B5FC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB29C24CA3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB29C24CA3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933975AbeFYMj3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:39:29 -0400
Received: from inva021.nxp.com ([92.121.34.21]:42110 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933787AbeFYMjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:39:23 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5AD312000CA;
        Mon, 25 Jun 2018 14:39:21 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EC53E200078;
        Mon, 25 Jun 2018 14:39:20 +0200 (CEST)
Received: from az84smr01.freescale.net (az84smr01.freescale.net [10.64.34.197])
        by inv1260.na-rdc02.nxp.com (Postfix) with ESMTP id 5AB4040C72;
        Mon, 25 Jun 2018 05:39:20 -0700 (MST)
Received: from titan.ap.freescale.net ([10.192.208.233])
        by az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id w5PCd34P025070;
        Mon, 25 Jun 2018 05:39:17 -0700
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     netdev@vger.kernel.org, madalin.bucur@nxp.com,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v4, 04/10] powerpc/mpc85xx: move ptp timer out of fman in dts
Date:   Mon, 25 Jun 2018 20:37:10 +0800
Message-Id: <20180625123716.28993-5-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180625123716.28993-1-yangbo.lu@nxp.com>
References: <20180625123716.28993-1-yangbo.lu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to move ptp timer node out of fman.
Because ptp timer will be probed by ptp_qoriq driver,
it should be an independent device in case of conflict
memory mapping.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
Acked-by: Richard Cochran <richardcochran@gmail.com>
Acked-by: Madalin Bucur <madalin.bucur@nxp.com>
---
Changes for v2:
	- None.
Changes for v3:
	- None.
Changes for v4:
	- Added ACKs.
---
 arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi   |   14 ++++++++------
 arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi   |   14 ++++++++------
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi  |   14 ++++++++------
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi  |   14 ++++++++------
 arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi |   14 ++++++++------
 5 files changed, 40 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi
index abd01d4..6b124f7 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi
@@ -37,12 +37,13 @@ fman0: fman@400000 {
 	#size-cells = <1>;
 	cell-index = <0>;
 	compatible = "fsl,fman";
-	ranges = <0 0x400000 0x100000>;
-	reg = <0x400000 0x100000>;
+	ranges = <0 0x400000 0xfe000>;
+	reg = <0x400000 0xfe000>;
 	interrupts = <96 2 0 0>, <16 2 1 1>;
 	clocks = <&clockgen 3 0>;
 	clock-names = "fmanclk";
 	fsl,qman-channel-range = <0x40 0xc>;
+	ptimer-handle = <&ptp_timer0>;
 
 	muram@0 {
 		compatible = "fsl,fman-muram";
@@ -93,9 +94,10 @@ fman0: fman@400000 {
 		reg = <0x87000 0x1000>;
 		status = "disabled";
 	};
+};
 
-	ptp_timer0: ptp-timer@fe000 {
-		compatible = "fsl,fman-ptp-timer";
-		reg = <0xfe000 0x1000>;
-	};
+ptp_timer0: ptp-timer@4fe000 {
+	compatible = "fsl,fman-ptp-timer";
+	reg = <0x4fe000 0x1000>;
+	interrupts = <96 2 0 0>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi
index debea75..b80aaf5 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi
@@ -37,12 +37,13 @@ fman1: fman@500000 {
 	#size-cells = <1>;
 	cell-index = <1>;
 	compatible = "fsl,fman";
-	ranges = <0 0x500000 0x100000>;
-	reg = <0x500000 0x100000>;
+	ranges = <0 0x500000 0xfe000>;
+	reg = <0x500000 0xfe000>;
 	interrupts = <97 2 0 0>, <16 2 1 0>;
 	clocks = <&clockgen 3 1>;
 	clock-names = "fmanclk";
 	fsl,qman-channel-range = <0x60 0xc>;
+	ptimer-handle = <&ptp_timer1>;
 
 	muram@0 {
 		compatible = "fsl,fman-muram";
@@ -93,9 +94,10 @@ fman1: fman@500000 {
 		reg = <0x87000 0x1000>;
 		status = "disabled";
 	};
+};
 
-	ptp_timer1: ptp-timer@fe000 {
-		compatible = "fsl,fman-ptp-timer";
-		reg = <0xfe000 0x1000>;
-	};
+ptp_timer1: ptp-timer@5fe000 {
+	compatible = "fsl,fman-ptp-timer";
+	reg = <0x5fe000 0x1000>;
+	interrupts = <97 2 0 0>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi
index 3a20e0d..d3720fd 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi
@@ -37,12 +37,13 @@ fman0: fman@400000 {
 	#size-cells = <1>;
 	cell-index = <0>;
 	compatible = "fsl,fman";
-	ranges = <0 0x400000 0x100000>;
-	reg = <0x400000 0x100000>;
+	ranges = <0 0x400000 0xfe000>;
+	reg = <0x400000 0xfe000>;
 	interrupts = <96 2 0 0>, <16 2 1 1>;
 	clocks = <&clockgen 3 0>;
 	clock-names = "fmanclk";
 	fsl,qman-channel-range = <0x800 0x10>;
+	ptimer-handle = <&ptp_timer0>;
 
 	muram@0 {
 		compatible = "fsl,fman-muram";
@@ -98,9 +99,10 @@ fman0: fman@400000 {
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xfd000 0x1000>;
 	};
+};
 
-	ptp_timer0: ptp-timer@fe000 {
-		compatible = "fsl,fman-ptp-timer";
-		reg = <0xfe000 0x1000>;
-	};
+ptp_timer0: ptp-timer@4fe000 {
+	compatible = "fsl,fman-ptp-timer";
+	reg = <0x4fe000 0x1000>;
+	interrupts = <96 2 0 0>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi
index 82750ac..ae34c20 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi
@@ -37,12 +37,13 @@ fman1: fman@500000 {
 	#size-cells = <1>;
 	cell-index = <1>;
 	compatible = "fsl,fman";
-	ranges = <0 0x500000 0x100000>;
-	reg = <0x500000 0x100000>;
+	ranges = <0 0x500000 0xfe000>;
+	reg = <0x500000 0xfe000>;
 	interrupts = <97 2 0 0>, <16 2 1 0>;
 	clocks = <&clockgen 3 1>;
 	clock-names = "fmanclk";
 	fsl,qman-channel-range = <0x820 0x10>;
+	ptimer-handle = <&ptp_timer1>;
 
 	muram@0 {
 		compatible = "fsl,fman-muram";
@@ -98,9 +99,10 @@ fman1: fman@500000 {
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xfd000 0x1000>;
 	};
+};
 
-	ptp_timer1: ptp-timer@fe000 {
-		compatible = "fsl,fman-ptp-timer";
-		reg = <0xfe000 0x1000>;
-	};
+ptp_timer1: ptp-timer@5fe000 {
+	compatible = "fsl,fman-ptp-timer";
+	reg = <0x5fe000 0x1000>;
+	interrupts = <97 2 0 0>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi
index 7f60b60..02f2755 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi
@@ -37,12 +37,13 @@ fman0: fman@400000 {
 	#size-cells = <1>;
 	cell-index = <0>;
 	compatible = "fsl,fman";
-	ranges = <0 0x400000 0x100000>;
-	reg = <0x400000 0x100000>;
+	ranges = <0 0x400000 0xfe000>;
+	reg = <0x400000 0xfe000>;
 	interrupts = <96 2 0 0>, <16 2 1 1>;
 	clocks = <&clockgen 3 0>;
 	clock-names = "fmanclk";
 	fsl,qman-channel-range = <0x800 0x10>;
+	ptimer-handle = <&ptp_timer0>;
 
 	muram@0 {
 		compatible = "fsl,fman-muram";
@@ -86,9 +87,10 @@ fman0: fman@400000 {
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xfd000 0x1000>;
 	};
+};
 
-	ptp_timer0: ptp-timer@fe000 {
-		compatible = "fsl,fman-ptp-timer";
-		reg = <0xfe000 0x1000>;
-	};
+ptp_timer0: ptp-timer@4fe000 {
+	compatible = "fsl,fman-ptp-timer";
+	reg = <0x4fe000 0x1000>;
+	interrupts = <96 2 0 0>;
 };
-- 
1.7.1

