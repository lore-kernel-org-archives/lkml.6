Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E3EC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F086025A05
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F086025A05
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935100AbeF0Tlq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 15:41:46 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:45342 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934982AbeF0Tln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 15:41:43 -0400
Received: from belgarion.home ([90.55.203.186])
        by mwinf5d70 with ME
        id 3vhT1y00241oiFu03vhh3p; Wed, 27 Jun 2018 21:41:42 +0200
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 27 Jun 2018 21:41:42 +0200
X-ME-IP: 90.55.203.186
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 2/2] ARM: dts: pxa: fix the rtc controller
Date:   Wed, 27 Jun 2018 21:41:24 +0200
Message-Id: <20180627194124.26366-2-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180627194124.26366-1-robert.jarzmik@free.fr>
References: <20180627194124.26366-1-robert.jarzmik@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC controller is fed by an external fixed 32kHz clock. Yet the
driver wants to acquire this clock, even though it doesn't make any use
of it, ie. doesn't get the rate to make calculation.

Therefore, use the exported 32.768kHz clock in the PXA clock tree to
make the driver happy and working.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v1: change the dummy clock by the actual 32.768kHz
Since v3: remove spurious bracket
---
 arch/arm/boot/dts/pxa25x.dtsi | 4 ++++
 arch/arm/boot/dts/pxa27x.dtsi | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/pxa25x.dtsi b/arch/arm/boot/dts/pxa25x.dtsi
index 95d59be97213..8494b5787170 100644
--- a/arch/arm/boot/dts/pxa25x.dtsi
+++ b/arch/arm/boot/dts/pxa25x.dtsi
@@ -80,6 +80,10 @@
 			#pwm-cells = <1>;
 			clocks = <&clks CLK_PWM1>;
 		};
+
+		rtc@40900000 {
+			clocks = <&clks CLK_OSC32k768>;
+		};
 	};
 
 	timer@40a00000 {
diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index 747f750f675d..2ab6986433c8 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -113,6 +113,10 @@
 
 			status = "disabled";
 		};
+
+		rtc@40900000 {
+			clocks = <&clks CLK_OSC32k768>;
+		};
 	};
 
 	clocks {
-- 
2.11.0

