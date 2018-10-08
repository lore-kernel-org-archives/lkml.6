Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C38C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D44F2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="Xw6GkDyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D44F2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbeJIBda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:33:30 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:59420 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbeJIBdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:33:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 3C33C20B70;
        Mon,  8 Oct 2018 20:20:02 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1539022801; x=
        1541614802; bh=hEUYMo1Vz1NId4TzMsdN8D77MBMdDVkUeXmyqIkV8KM=; b=X
        w6GkDyQzP+EcZ69C3YCqCsKlhpKn3hGfJtPGiNrU13VAO1/lE/5HUsV/wQrWGYuA
        lsNAeCe5CgupCV/tbGqFQvIeWVB1XkFhmiAAMlnJjcwOWfwYu4lz/ThNCRgFQzKT
        taU70qsKo9qzsgD+Da3W4vY17a0mIVvT+Gw045lecAHizLAM9t5sjT5Zqpp7cNFL
        shXoN7pZlOhZ8AtvSDMt3sxs00WPrCtIkxIA6/pvJ3XUZz61zqGey+YEGdrydDFV
        +pvBqxD5yymgT50QXRuAJDcvtPAsgSErFmSEYW67apzS6sU9PltYDl+WEuO6mans
        X9g3pUDeO0/xXwB1eUivwxJH3Es8jOev1Q0k6xizHxXhpN55KbWDn2mwhAuSmx/2
        jm19W+5hGzDIuomFJ4RUQXhzZXleQwGblJh8z3e1WpU2DfUFsJGBvvTmCaui+uzI
        eLt0k0QQDGrOO+H+Xc0EHJtTeNKwmWIpIyfbCl8HGahllpJHOgZBZ0QzlZpH41mu
        r3sa+JQ9Fidrr8BKDZbx367DKvkq7ktNtVMCILFnjCwHerbAcY7AAJTOK1N6XkYu
        TBNUX/rVfNS9egfZr4/RNwjnUyoc0eHmtgXkq/tXQ+ikb6dQ0If5WvCDxiWbQtvJ
        YFUylqnYTW4xALs8b8slXOe+Ws1VYnCiLP2w9faTbc=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id JfW5OItQrX0l; Mon,  8 Oct 2018 20:20:01 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id D626220791;
        Mon,  8 Oct 2018 20:20:00 +0200 (CEST)
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
Subject: [PATCH v3 3/7] arm64: dts: allwinner: axp803: add AC and battery power supplies
Date:   Mon,  8 Oct 2018 21:19:04 +0300
Message-Id: <20181008181908.9456-4-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008181908.9456-1-oskari@lemmela.net>
References: <20181008181908.9456-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AXP803 is compatible with AXP813. Add DT nodes ADC, GPIO,
AC and battery power supplies.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
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

