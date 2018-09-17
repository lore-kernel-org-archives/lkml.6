Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36C8ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D1E214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D1E214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbeIQRHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 13:07:08 -0400
Received: from shell.v3.sk ([90.176.6.54]:47113 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727491AbeIQRHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 13:07:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id C7ADAAE7E1;
        Mon, 17 Sep 2018 13:40:08 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6_3pXpW5yxEd; Mon, 17 Sep 2018 13:40:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 35750AD8FB;
        Mon, 17 Sep 2018 13:40:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0bCEc6N2vjwS; Mon, 17 Sep 2018 13:40:02 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id E0A36ACF8C;
        Mon, 17 Sep 2018 13:40:01 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/2] DT: marvell,mmp2: fix TWSI2
Date:   Mon, 17 Sep 2018 13:39:46 +0200
Message-Id: <20180917113947.12626-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180917113947.12626-1-lkundrak@v3.sk>
References: <20180917113947.12626-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marvell keeps their MMP2 datasheet secret, but there are good clues
that TWSI2 is not on 0xd4025000 on that platform, not does it use
IRQ 58. In fact, the IRQ 58 on MMP2 seems to be a signal processor:

   arch/arm/mach-mmp/irqs.h:#define IRQ_MMP2_MSP  58

I'm taking a somewhat educated guess that is probably a copy & paste
error from PXA168 or PXA910 and that the real controller in fact hides
at address 0xd4031000 and uses an interrupt line multiplexed via IRQ 17.

I'm also copying some properties from TWSI1 that were missing or
incorrect.

Tested on a OLPC XO 1.75 machine, where the RTC is on TWSI2.

Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 766bbb8495b6..47e5b63339d1 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -220,12 +220,15 @@
 				status = "disabled";
 			};
 
-			twsi2: i2c@d4025000 {
+			twsi2: i2c@d4031000 {
 				compatible = "mrvl,mmp-twsi";
-				reg = <0xd4025000 0x1000>;
-				interrupts = <58>;
+				reg = <0xd4031000 0x1000>;
+				interrupt-parent = <&intcmux17>;
+				interrupts = <0>;
 				clocks = <&soc_clocks MMP2_CLK_TWSI1>;
 				resets = <&soc_clocks MMP2_CLK_TWSI1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				status = "disabled";
 			};
 
-- 
2.17.1

