Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044DBC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1A720844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1A720844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbeGYNeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:34:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33523 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728757AbeGYNeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:34:44 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 84858207A8; Wed, 25 Jul 2018 14:23:15 +0200 (CEST)
Received: from localhost.localdomain (unknown [80.255.6.130])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1BB93206A6;
        Wed, 25 Jul 2018 14:23:05 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH] MIPS: mscc: ocelot: add MIIM1 bus
Date:   Wed, 25 Jul 2018 14:22:41 +0200
Message-Id: <20180725122241.31370-1-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an additional MIIM (MDIO) bus in this SoC so let's declare it
in the dtsi.

This bus requires GPIO 14 and 15 pins that need to be muxed. There is no
support for internal PHY reset on this bus on the contrary of MIIM0 so
there is only one register address space and not two.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 arch/mips/boot/dts/mscc/ocelot.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
index 7096915f26e0..d7f0e3551500 100644
--- a/arch/mips/boot/dts/mscc/ocelot.dtsi
+++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
@@ -178,6 +178,11 @@
 				pins = "GPIO_12", "GPIO_13";
 				function = "uart2";
 			};
+
+			miim1: miim1 {
+				pins = "GPIO_14", "GPIO_15";
+				function = "miim1";
+			};
 		};
 
 		mdio0: mdio@107009c {
@@ -201,5 +206,16 @@
 				reg = <3>;
 			};
 		};
+
+		mdio1: mdio@10700c0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "mscc,ocelot-miim";
+			reg = <0x10700c0 0x24>;
+			interrupts = <15>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&miim1>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.14.1

