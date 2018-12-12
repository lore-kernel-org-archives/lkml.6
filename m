Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8C7C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18AE02084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lUygrBnY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18AE02084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbeLLFRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 00:17:35 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57118 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeLLFRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 00:17:35 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBC5HFvb058057;
        Tue, 11 Dec 2018 23:17:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544591836;
        bh=nif3Z+6rwyCOad4evYCBPM1IQZ4r3vcTdSSFumT9Sx0=;
        h=From:To:CC:Subject:Date;
        b=lUygrBnY07WDh9lsQvR5i3UbN/3MatBFObMri5iR3W9guPU6nfKLwTU1XGQHJpEaL
         1xG8IavR1e8LHftH/+giV0fxi5P3fbW4VRrtZZk7A0w9MY2oZnckvTFO6CKwczZK8P
         gLPeFjqkMK4oGkRzWvMPxGr+2s0+rfpcmRDJVRxM=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBC5HF7f056235
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Dec 2018 23:17:15 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 11
 Dec 2018 23:17:15 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 11 Dec 2018 23:17:15 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBC5HDv1026449;
        Tue, 11 Dec 2018 23:17:13 -0600
From:   Vignesh R <vigneshr@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh R <vigneshr@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am654: Populate power-domain property for UART nodes
Date:   Wed, 12 Dec 2018 10:48:06 +0530
Message-ID: <20181212051806.21879-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Populate power-domain property for UART nodes, this is required for
Linux to enable UART clocks via PM calls. Without this UART instances
not initialized by bootloader (like main_uart1) fails to work in Linux.
Also, drop current-speed property from main_uart1 and main_uart2 nodes
as these UARTs are not initialized before Linux boots up and current
speed is unknown.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi   | 5 +++--
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi    | 1 +
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 6c71e67b8988..272cf8fc8d30 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -48,6 +48,7 @@
 		interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
+		power-domains = <&k3_pds 146>;
 	};
 
 	main_uart1: serial@2810000 {
@@ -57,7 +58,7 @@
 		reg-io-width = <4>;
 		interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
+		power-domains = <&k3_pds 147>;
 	};
 
 	main_uart2: serial@2820000 {
@@ -67,7 +68,7 @@
 		reg-io-width = <4>;
 		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
+		power-domains = <&k3_pds 148>;
 	};
 
 	main_pmx0: pinmux@11c000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 1aeae52fb239..593f718e8fb5 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -14,6 +14,7 @@
 			interrupts = <GIC_SPI 565 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <96000000>;
 			current-speed = <115200>;
+			power-domains = <&k3_pds 149>;
 	};
 
 	mcu_i2c0: i2c@40b00000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
index 9e8467ce7ad8..7cbdc0912ab7 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
@@ -50,6 +50,7 @@
 		interrupts = <GIC_SPI 697 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
+		power-domains = <&k3_pds 150>;
 	};
 
 	wkup_i2c0: i2c@42120000 {
-- 
2.19.2

