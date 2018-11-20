Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DE3C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC70206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="Lmgm03Ku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC70206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbeKUEXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:23:06 -0500
Received: from mail1.kuutio.org ([92.222.216.83]:34452 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730329AbeKUEW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:22:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id A0E791F943;
        Tue, 20 Nov 2018 18:52:33 +0100 (CET)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1542736347; x=
        1545328348; bh=QYpt9U4kN0fxfLWGOuGgh6WV6Aux5m8kaZEfxenP2QE=; b=L
        mgm03KumE7jaGn7c64AZJQR3h4TVGb/OVIrSKFyIZ5gOBYTS2raHzdAVcKboLjCb
        xa1+H55WOgm0jKjxZrxiC2mssHldaYO2A0YzYK4AEj4A3KjMNnTD8l8cpnEeb4xK
        iVPB8gnXkeS9bEQfh4kuU/BrtEeNCsGgZ7tHfDDzCCMFIz0dqgJmGApBzQ0D+x51
        0MwUTndrVLWcXI28Sag4PhNrOAQCWlHoUTOUg0HBrauDjvan0/UJe64UGOsHp+ke
        /z1OEKksz6mgl3zU/64t1E08QlKB6I9USvwL7eH3Cno6WcI4DZ3wUtBcHuJqXp0s
        IjIP/wk7lTEnQxj1MXI3FvhuSN6hgOxPxUaUVEmSJ8R/dbIGb/GG11+HGlm8QZOp
        QRztDkTno2/LrE281Dv4sJPnM34sCZJVB1nJN0PoKBSf3q+YLDkgjUX++nCoEURn
        ev+IGo5yXoTcmYmXkvgNdegzaqDHXbzcDE0nWCr70/Q07C4T1/x5ysfls8gJwDOd
        VfR2TXqMZDOX5ZVC9pd67UZiBUJQMdeM6daL6BVT2spvV7cI1vMG1BH8T8CVJhTs
        Ghhhejs4iByfKCw2K6Us8jfn1CYYgfUU01iL4DlvFyzxT9BSf2+lxdyzOtlrCpFn
        9QJfgpIvXAiyQh/7VpTNyB8UVW2mI9MxaLO1jCbtN8=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id iFqO0yA123U8; Tue, 20 Nov 2018 18:52:27 +0100 (CET)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 3DC631F99C;
        Tue, 20 Nov 2018 18:52:27 +0100 (CET)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Oskari Lemmela <oskari@lemmela.net>
Subject: [PATCH v6 3/8] arm64: dts: allwinner: axp803: add AC and battery power supplies
Date:   Tue, 20 Nov 2018 19:52:06 +0200
Message-Id: <20181120175211.3913-4-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120175211.3913-1-oskari@lemmela.net>
References: <20181120175211.3913-1-oskari@lemmela.net>
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

