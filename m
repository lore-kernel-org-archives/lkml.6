Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3136C71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 08:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92CF20835
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 08:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="brIVdavj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92CF20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbeJMPpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 11:45:50 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:44342 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbeJMPpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 11:45:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 194432092C;
        Sat, 13 Oct 2018 10:09:34 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1539418173; x=
        1542010174; bh=n0Xmd7FY193JX3x7QDQasOjJ464JZkigDA3BIx9ytj0=; b=b
        rIVdavjE+NwgO0XgleVrIdL6uRCKzklO457+aXJX5z9C9e/sOKuIgcvy5iO7JGLN
        nQpNU695tZ6l1TkV0qwik1SbOKXDOQzsTsWKN07scpZMbEfPWet0lWl2vKdnY16E
        mRqx4cvP6bLjhVh5rkLqnnuIfG1W2lqPRmy0LKenGe279Js9GjA9+Ef7t5SBBx+L
        1WCyw321PvXzHl+kRM0Jet+h+b7Vdov0BgK4mo/QTqHwH2ArLJuJ3vl80F+wkBhz
        n7J5H++IqQK4aRzAAqzyHwY6Yq+e4CD/DpBZ1iEU1bMa/xsgCfQPm6PB16S1J2kR
        xuenvId1Gl9Zm/ipvP5RpT7GBOqvly1ElPzzLgmQyJVh+gTNIXYRHEM60jUnsLzN
        uEwOKL/et+FmZnfKpE9w4iba+/HjfDbnkkXmvu5yL0Rb9sxdZleJU6IWKsZHH4WR
        eJuzvb6OpOTB+Euete9+dQyqNOv0uCk5k7HTrubwX/xCVoC7I9VbOQ0SbfyiS9SP
        V7NQgP1BLAVfUQBHPAlAnaTgM6WIJCB7/xQYvhnbgf+6DNxF80CJuV0plUd85pDZ
        ccqNO7D922Mq7nJjHIO7J1opWMj7Nl/DOXRm5J8gg+8VVI97PZmrA2W54CdTxGbp
        G8kBYxBN1heDvEz6EVo7/fxIC/HxbhAC05LAai3n2Q=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id S9_uVqHw9KHL; Sat, 13 Oct 2018 10:09:33 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id E3C1E1F99C;
        Sat, 13 Oct 2018 10:09:32 +0200 (CEST)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Oskari Lemmela <oskari@lemmela.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 3/7] arm64: dts: allwinner: axp803: add AC and battery power supplies
Date:   Sat, 13 Oct 2018 11:08:44 +0300
Message-Id: <20181013080848.29894-4-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181013080848.29894-1-oskari@lemmela.net>
References: <20181013080848.29894-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AXP803 is compatible with AXP813. Add DT nodes ADC, GPIO,
AC and battery power supplies.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 arch/arm64/boot/dts/allwinner/axp803.dtsi | 31 +++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/axp803.dtsi b/arch/arm64/boot/dts/allwinner/axp803.dtsi
index e5eae8bafc42..128177178615 100644
--- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
+++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
@@ -49,6 +49,37 @@
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
+	ac_power_supply: ac-power-supply {
+		compatible = "x-powers,axp813-ac-power-supply";
+		status = "disabled";
+	};
+
+	axp_adc: adc {
+		compatible = "x-powers,axp813-adc";
+		#io-channel-cells = <1>;
+	};
+
+	axp_gpio: gpio {
+		compatible = "x-powers,axp813-gpio";
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
+		compatible = "x-powers,axp813-battery-power-supply";
+		status = "disabled";
+	};
+
 	regulators {
 		/* Default work frequency for buck regulators */
 		x-powers,dcdc-freq = <3000>;
-- 
2.17.1

