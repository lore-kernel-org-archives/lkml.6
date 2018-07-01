Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599C2C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB5D245C7
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB5D245C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032469AbeGAQoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:44:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37982 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032052AbeGAQoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:44:08 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2401AA73;
        Sun,  1 Jul 2018 16:44:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 4.17 166/220] arm: dts: mt7623: fix invalid memory node being generated
Date:   Sun,  1 Jul 2018 18:23:10 +0200
Message-Id: <20180701160915.204589308@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Wang <sean.wang@mediatek.com>

commit c0b0d540db1a8bfb041166c4991dd6f624e8de45 upstream.

Below two wrong nodes in existing DTS files would cause a fail boot since
in fact the address 0 is not the correct place the memory device locates
at.

memory {
        device_type = "memory";
        reg = <0x0 0x0 0x0 0x0>;
};

memory@80000000 {
        reg = <0x0 0x80000000 0x0 0x40000000>;
};

In order to avoid having a memory node starting at address 0, we can't
include file skeleton64.dtsi and instead need to explicitly manually
define a few of properties the DTS relies on such as #address-cells
and #size-cells in root node and device_type in the node memory@80000000.

Cc: stable@vger.kernel.org
Fixes: 31ac0d69a1d4 ("ARM: dts: mediatek: add MT7623 basic support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/mt7623.dtsi                 |    3 ++-
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts |    1 +
 arch/arm/boot/dts/mt7623n-rfb.dtsi            |    1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -22,11 +22,12 @@
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/reset/mt2701-resets.h>
 #include <dt-bindings/thermal/thermal.h>
-#include "skeleton64.dtsi"
 
 / {
 	compatible = "mediatek,mt7623";
 	interrupt-parent = <&sysirq>;
+	#address-cells = <2>;
+	#size-cells = <2>;
 
 	cpu_opp_table: opp-table {
 		compatible = "operating-points-v2";
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -109,6 +109,7 @@
 	};
 
 	memory@80000000 {
+		device_type = "memory";
 		reg = <0 0x80000000 0 0x40000000>;
 	};
 };
--- a/arch/arm/boot/dts/mt7623n-rfb.dtsi
+++ b/arch/arm/boot/dts/mt7623n-rfb.dtsi
@@ -47,6 +47,7 @@
 	};
 
 	memory@80000000 {
+		device_type = "memory";
 		reg = <0 0x80000000 0 0x40000000>;
 	};
 


