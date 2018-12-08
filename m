Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A495AC64EB1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2512146D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="q/u62eXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2512146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbeLHRiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 12:38:16 -0500
Received: from mail1.kuutio.org ([92.222.216.83]:49694 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbeLHRiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 12:38:13 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 43D621F988;
        Sat,  8 Dec 2018 18:38:09 +0100 (CET)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1544290688; x=
        1546882689; bh=QYpt9U4kN0fxfLWGOuGgh6WV6Aux5m8kaZEfxenP2QE=; b=q
        /u62eXUqo+65WEG/riC1UH9fT228GyddmsW4dCvPdK3M1SWkTAYuUoh+WkUWfR2E
        KMIL2AGWrGThV5SlhoQn/JNdoxXExim1u1jY73Lzs8kMDFc49TCqucVptjqPmyme
        WvgwpGaWomaRkUxwiejiy/WW+qPGdqe7p4GWiB7g7i9U1e2no1NZK7Z+q6GJpAmT
        yWsjhj/fEEra7VafQam8EJ6B+Ddn7Kat7VaLKb0SWy2Zs5riE/WkmsQ9LIMHdt2k
        BwShmI0J2m7L7ByCyhY9fRZJpChZXeEOXrwSdp6kAl+iiLFGXH1f14AhfMOTg2ND
        d8ksJ3UCA3ArJGo4Ip5NJz+vtoiyxELip2kfBWpTQHeEmNqC8rYB26eKEgOLb3lW
        jSr/1ge9Zi+dyblDIQGRWD2fsm7b6Son/YwG+z93QoRcP/vyddV8/l8Ywqkx2vw0
        bpq1vQzUm04KeEmBNiZAeGRwpxT1rt2QZDRzRU/Yt2IWYTYN/HD+HtAdJ8dJJTji
        n9cIh3q3llgvF/l0HhsOjg8ssbS8ToubBfhXH9KU1N0CNhLEM619xRJFnjHvR+9t
        TOkUEvW6ialnwJM7WxvlYFu6+/E9M+61f1hTVTWfrevZxGEsPNJ3OaIVSIbCS7DX
        EmDa3Kb6PFApD0m/6lEi4yZ1nlpcJgc+to9uGbZggE=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Bfcy23ozd_Yt; Sat,  8 Dec 2018 18:38:08 +0100 (CET)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id CFF8B1F965;
        Sat,  8 Dec 2018 18:38:07 +0100 (CET)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Quentin Schulz <quentin.schulz@bootlin.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Oskari Lemmela <oskari@lemmela.net>
Subject: [PATCH v7 3/9] arm64: dts: allwinner: axp803: add AC and battery power supplies
Date:   Sat,  8 Dec 2018 19:36:12 +0200
Message-Id: <20181208173618.31395-4-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181208173618.31395-1-oskari@lemmela.net>
References: <20181208173618.31395-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parts of the AXP803 are compatible with their counterparts on the AXP813.
Add DT nodes ADC, GPIO, AC and battery power supplies.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm64/boot/dts/allwinner/axp803.dtsi | 33 +++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/axp803.dtsi b/arch/arm64/boot/dts/allwinner/axp803.dtsi
index e5eae8bafc42..c3a618e1279a 100644
--- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
+++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
@@ -49,6 +49,39 @@
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
+	ac_power_supply: ac-power-supply {
+		compatible = "x-powers,axp803-ac-power-supply",
+			     "x-powers,axp813-ac-power-supply";
+		status = "disabled";
+	};
+
+	axp_adc: adc {
+		compatible = "x-powers,axp803-adc", "x-powers,axp813-adc";
+		#io-channel-cells = <1>;
+	};
+
+	axp_gpio: gpio {
+		compatible = "x-powers,axp803-gpio", "x-powers,axp813-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio0_ldo: gpio0-ldo {
+			pins = "GPIO0";
+			function = "ldo";
+		};
+
+		gpio1_ldo: gpio1-ldo {
+			pins = "GPIO1";
+			function = "ldo";
+		};
+	};
+
+	battery_power_supply: battery-power-supply {
+		compatible = "x-powers,axp803-battery-power-supply",
+			     "x-powers,axp813-battery-power-supply";
+		status = "disabled";
+	};
+
 	regulators {
 		/* Default work frequency for buck regulators */
 		x-powers,dcdc-freq = <3000>;
-- 
2.17.1

