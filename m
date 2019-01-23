Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E635C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C843E21855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfAWTad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 14:30:33 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:52863 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfAWTad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 14:30:33 -0500
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id DDC011BF20E;
        Wed, 23 Jan 2019 19:30:28 +0000 (UTC)
From:   Remi Pommarel <repk@triplefau.lt>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH] arm64: dts: armada-3720-espressobin: Configure RGMII and SMI pins
Date:   Wed, 23 Jan 2019 20:39:46 +0100
Message-Id: <20190123193946.13594-1-repk@triplefau.lt>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be able to communicate with the 88e6341 switch some pins
have to be repurposed as RGMII and SMI pins.

This fixes ethernet support on system booted via a bootloader that
has not already configured those pins (e.g. mainline u-boot, or vendor
u-boot compiled without ethernet support).

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
This should be applied along with pinctrl fixes from
https://lkml.org/lkml/2018/12/21/507 which have been merged in next branch of
linux-pinctrl tree.
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts | 2 ++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi            | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
index 846003bb480c..b60897edc885 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
@@ -196,6 +196,8 @@
 };
 
 &eth0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_pins>, <&smi_pins>;
 	phy-mode = "rgmii-id";
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index e05594ea15fb..f61538910901 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -271,6 +271,11 @@
 					function = "mii";
 				};
 
+				smi_pins: smi-pins {
+					groups = "smi";
+					function = "smi";
+				};
+
 				sdio_pins: sdio-pins {
 					groups = "sdio_sb";
 					function = "sdio";
-- 
2.20.1

