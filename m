Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD28C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8737C2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="Ws5OQI5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8737C2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbeJECf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:35:29 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:47766 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727642AbeJECf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 22:35:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id C093720657;
        Thu,  4 Oct 2018 21:34:44 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1538681683; x=
        1541273684; bh=/PFfFkGU2tveO+f1uD/iVS5pMKTkgRs5f1tx974Fqsg=; b=W
        s5OQI5dIBTo6sicaSx6tQN/hV30Uz+kGjyvobhMh7q193ONXVJllGxIU7JRC4Jt8
        txtAzRkRSet4YNyyn8nlaLsp0oMELYlayT77PnBSNwuVEdl96uUbb8XXQ4jp+ZpU
        PurWiMy9h1RbvLhDGHlHHSe5Pzsr9yuMNVKvQAo69OXe5BJRxutO6M6j3UkhyGZ2
        dObasgJov4VCv+pGZ6BoVS97VeBO9XNgQODGdAUEkk6JKoX9FBI8zVW/0BPp4EWw
        gduNlK6CZNSNeyuSYexOXDqbHGOCQtWBcBaq5gB1QmhGenr90K1oqavhN5n4k5Tt
        Dg6cFgw9KYZOEHxQFfgPlc4F19HFT4IO4EVfxeX/qxJfG40GSHGCm7CFiJoqdpbR
        ChXAHfYT4W5wSYfREhehX/fCMBCIvSUd4xLGxVDJle5727MZRnLV8XvRqtnKUXBP
        gp+yOStBK0quCz8XXruaDKKv0HDWNYqjUeOFa6IWh1EncWf5evxR40ddqwFdRMg8
        ssYX/uVaJ0bJ0ZCOhfbg48Qx8zc/GbpVa++Hz13F9ZNQZfEiTLCSVS4JR3/0vMiK
        TRI+yXkEK3L7YUCSOINSKx8z9/PKbV/syGm2LiCMyEdnuog+ecXsZK67AqgQw9OC
        ZH8aH2485EfmdldDvQ4Z0qf5LGp/ljICdlzUjpmDmM=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id LgYUfUWXGgUJ; Thu,  4 Oct 2018 21:34:43 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 39E041FBED;
        Thu,  4 Oct 2018 21:34:43 +0200 (CEST)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/4] arm64: allwinner: a64: add battery and AC power supply support
Date:   Thu,  4 Oct 2018 22:34:09 +0300
Message-Id: <20181004193410.7265-4-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004193410.7265-1-oskari@lemmela.net>
References: <20181004193410.7265-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AXP803 DT nodes for AC and battery power supplies.
Enable AC and battery power supplies for sopine-baseboard.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 arch/arm64/boot/dts/allwinner/axp803.dtsi     | 31 +++++++++++++++++++
 .../allwinner/sun50i-a64-sopine-baseboard.dts |  8 +++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/axp803.dtsi b/arch/arm64/boot/dts/allwinner/axp803.dtsi
index e5eae8bafc42..d23e5d1e9310 100644
--- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
+++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
@@ -49,6 +49,37 @@
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
+	axp_adc: adc {
+		compatible = "x-powers,axp803-adc";
+		#io-channel-cells = <1>;
+	};
+
+	axp_gpio: gpio {
+		compatible = "x-powers,axp803-gpio";
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
+	ac_power_supply: ac-power-supply {
+		compatible = "x-powers,axp803-ac-power-supply";
+		status = "disabled";
+	};
+
+	battery_power_supply: battery-power-supply {
+		compatible = "x-powers,axp803-battery-power-supply";
+		status = "disabled";
+	};
+
 	regulators {
 		/* Default work frequency for buck regulators */
 		x-powers,dcdc-freq = <3000>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index c21f2331add6..335cf2263d19 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -69,6 +69,14 @@
 	};
 };
 
+&ac_power_supply {
+	status = "okay";
+};
+
+&battery_power_supply {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
-- 
2.17.1

