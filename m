Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1231ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 21:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7419208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 21:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="MVJrHLV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7419208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeJGEZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 00:25:28 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:53316 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbeJGEY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 00:24:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 942601F99C;
        Sat,  6 Oct 2018 23:20:08 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1538860807; x=
        1541452808; bh=W+ktF4hdPsTh260RGfj4QSBAZhAjSZBjQblCUDMIGJE=; b=M
        VJrHLV3wpkl4WJhcfFA31P6sGQKFpxlwSBwGLMqWFoqDQxQ3aquKVG39XGwpPjYD
        McLMr8MdvoYg9guvk4xogT7YrRmLUtNWOLngyepEKB9tdy61SNaGwDnVY4wygVVJ
        s3OIJWLD61mmHAt20oKdN6GO4O6JX5F0OSNGSQF9SOClEX1OYNZWQJHBnxeF5YPU
        oUO9R5bOiO/WeGtQg4lS9DVyuVGBPx6pK3WtNJ4JYfxdUQXToAKgzUzdzKf4bNJb
        AFO2MrM3ss/ym5ZvBI77pH3oO9S8OgkNsF8IjPZGsFfZg2jDHQ9haN2Pmih6kteN
        XOJ0nDwF92e/6gHWN5GEoj2gGyLDjkqNyWDz4mDJcew8Iqz9Y1v7pMjdcQ/Sjtdu
        MuiuuXJ8a5iPqcgAk0CFCvbqM/00fZ8xqhh5IKs99TL9qopGgQYiRDD+HyRIdqmk
        nmK7WJzQ9tdUVf/MPfZdnRPX0d+QpQraKKbEoD5Nqgto3vYMwKkyanD7Qw/iiNF9
        0VHB7lOQ4nuoTJEFnxH8ptH8V0F4qLfp93w8Slh6eV0eDCnNeQDcgqL4rdbmEOJ9
        vOb2gUwH8eNvUQDwro4d46Lpyi4jmLeyNxn/5n5Xo4ftmLkgmJn2W78QDvcjcR1O
        SXtnciSEDb9pXc+aqvnZgHzww3GEVQPiCYludrfZSM=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id pB62PhBHXOSq; Sat,  6 Oct 2018 23:20:07 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 4B0C11FBED;
        Sat,  6 Oct 2018 23:20:07 +0200 (CEST)
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
Subject: [PATCH v2 3/6] arm64: dts: allwinner: axp803: add AC and battery power supplies
Date:   Sun,  7 Oct 2018 00:18:33 +0300
Message-Id: <20181006211836.28253-4-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181006211836.28253-1-oskari@lemmela.net>
References: <20181004193410.7265-1-oskari@lemmela.net>
 <20181006211836.28253-1-oskari@lemmela.net>
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
index e5eae8bafc42..533987b2fe7a 100644
--- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
+++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
@@ -49,6 +49,37 @@
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
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
+	ac_power_supply: ac-power-supply {
+		compatible = "x-powers,axp813-ac-power-supply";
+		status = "disabled";
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

