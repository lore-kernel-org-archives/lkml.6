Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A4FC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9DD2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="hhjVGp5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9DD2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbeJXDT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:19:26 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:45942 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728864AbeJXDSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:18:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id E261D1FB8C;
        Tue, 23 Oct 2018 20:54:08 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1540320848; x=
        1542912849; bh=XhBuIRDdG2aMlY9HegooyOogRtObOUjnZIit422Z228=; b=h
        hjVGp5OZnhpC6gRfw56rnroG8DgW+557Kvkq00g7xWxUzxtB9xBK0AasO5Py86Jz
        VJMBJ/zWbo9FUrbU08ubPCXic65ZKZq2FF3gVXUJly8U/ykSJYn4CIK6VPgJyBkS
        thnpNdoj4DNK+tuGfy4TrjJVHtTeq2pDkWuhTcOeY3gWkDpJaXspNh2zMR9fnDz6
        JIpsveo7w4rHbzBBcYwX/IKrgkVoZw8FSiCKt6zIH5iBVmk6VKUka9FDI0nA0Jlv
        U34ojws1hmb0dNRZzFs3xX9xyQGktL0ZZLY41I15zellvq64MMmJg+bVkGY3GMeO
        8zByF/s/szk1iIqkDXhQZVeS5QKvTv1Ar04ljxjTa7tSJ4u7arhSSttHDsQ899lF
        KyQIucdkEOLV6KGMJdt8fF2FkbOWY0XXi+O+5Ncs5UtpbH1WTEFPe4+9yWV0rgn0
        8hCSBJIMI0lqKttTjPTb/DTHH3Lseglg/QWG/Df0IB6biJu/0FEzhPrV/d1VVig/
        j/vWS0s03jDWQaT/CWtlXO8x5JLbwr4cVskc4dJhmhDxO6cYMGDtqKgW5RMMIryk
        AF7hh0sQzaUonnjLvzOGtkr6XjqAbz5qvoONcGwb0uhVJRDhWzX1wtCmgn59FiuH
        EuTZKbqT0bwmnu6uYd+PRjVetPthQH/Y5JhRGRZFJY=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id vvrhnbeh7EEn; Tue, 23 Oct 2018 20:54:08 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 791721FBA1;
        Tue, 23 Oct 2018 20:54:07 +0200 (CEST)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Oskari Lemmela <oskari@lemmela.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH v5 06/11] arm64: dts: allwinner: axp803: add AC and battery power supplies
Date:   Tue, 23 Oct 2018 21:53:25 +0300
Message-Id: <20181023185330.10472-7-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181023185330.10472-1-oskari@lemmela.net>
References: <20181023185330.10472-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parts of the AXP803 are compatible with their counterparts on the AXP813.
Add DT nodes ADC, GPIO, AC and battery power supplies.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
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

