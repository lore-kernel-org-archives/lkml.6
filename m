Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC284C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59C82075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="qr+JFNAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59C82075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbeJXDTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:19:46 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:45920 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbeJXDSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:18:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id A55C31FBE7;
        Tue, 23 Oct 2018 20:54:08 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1540320847; x=
        1542912848; bh=jXIX8izX1CAuHrKZL/jrJD5rwgJGf7wij/BFmTD06Lw=; b=q
        r+JFNAQbLQbIj7sSiLXvKpatI8CoWVAt7GTE8e+tAp+neP1tDLehuWl5D27nUHtV
        dE3a4pIaRMcypSjmYQAo4Jd+hxZneWleMmiPq+r59UwPmIDsj44eQm803gRXdOw4
        T4Iv05Ve6PbTyGC3AKNK9PTlLK4rGmkq/FqrZbtm8XCuFY+M6qPhB/U790dxFfDG
        OBugdTXAAmo4I8/EeG3aFqlJkQnCsA5aco5VA8r4B9TrFK9NGTDhaCb0es0pcY1F
        28910siQluV0JylQkX2iMBzhWpDD100rBk2S+hHwCF7x0y6iG4JInG/bVlUxsB0h
        zoPwt6jR5BCrg6s5/SRbfI2drmXY86187K2rwiHIFssLkMjy1ViVYeqjzFx8wFji
        lFLKDqnaZNGicUgvuL23NUdPSTmTMvi6c4bufmz5Xx5tLNr0il3RUgjND5ElfPgv
        o4N+HSi9SiMU+ljSSswAqMQybnso8mglQd1nk66ATlduNZ8Uy4jZmWldAvnkLrPD
        nnQ0ohnH6Gsabn/Cg39xctskj1lPaRQQWKRwLtHuwNQpfWOB4agZYDp0pHo3fwIp
        g1E/kf31F71sMV7v1xRwB9wzkBV+oNYQ33V1sQNer5fhcxm2DsWNNjRXOvNcl38U
        W3NNhfwaPu7jr9iyZ0zgfeYjGxO4+Ym2PNy6SYOxIY=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id TD1Vb_teMsEZ; Tue, 23 Oct 2018 20:54:07 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id A0D2A1FB8C;
        Tue, 23 Oct 2018 20:54:06 +0200 (CEST)
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
Subject: [PATCH v5 05/11] ARM: dts: axp81x: add AC power supply subnode
Date:   Tue, 23 Oct 2018 21:53:24 +0300
Message-Id: <20181023185330.10472-6-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181023185330.10472-1-oskari@lemmela.net>
References: <20181023185330.10472-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AC power supply subnode for AXP81X PMIC.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/boot/dts/axp81x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/axp81x.dtsi b/arch/arm/boot/dts/axp81x.dtsi
index 043c717dcef1..bd83962d3627 100644
--- a/arch/arm/boot/dts/axp81x.dtsi
+++ b/arch/arm/boot/dts/axp81x.dtsi
@@ -48,6 +48,11 @@
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
+	ac_power_supply: ac-power-supply {
+		compatible = "x-powers,axp813-ac-power-supply";
+		status = "disabled";
+	};
+
 	axp_adc: adc {
 		compatible = "x-powers,axp813-adc";
 		#io-channel-cells = <1>;
-- 
2.17.1

