Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713E1C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D24A2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="CQfTFwDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D24A2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbeJXDSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:18:51 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:45964 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728906AbeJXDSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:18:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 396C81F99A;
        Tue, 23 Oct 2018 20:54:10 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1540320849; x=
        1542912850; bh=16hydqWDFV4OIAB5F2BhOcjYauIKKaxTnGprPU0pMcU=; b=C
        QfTFwDFUr1PU2MD4ghri2HxTFlZBmaEiksGb73q6JZCpdWpawNtLVViUzhVLDC1M
        LjWnquKbwHRL4vOdH31DPnuXxPv889ZF99R+P1PsdxAMxZ701TeYfJfEsqK4QIYY
        c7dQlxy8r2wFtd6/UFEC+Ehg76qD2XapXApzc8rVm3SdsEtniK3OfnoDx8Vm8t63
        4mgBtcDwLrIVBkf25siB9TyI7UrwA3/v8CZv7GMjlgW2gohj02GOg1c5aQ8VkkmQ
        oU6IaPktbCnzn1PWlnawJ7AWRKklL+ZZSHi9cfki8By3cVud9NeZk7hfoQL64IP/
        gLscyL5/JacLT6aB3aI3lXNId5Va1PoAECdhnBZzEDPcAmLGJqNL0u3g9oMbEnNP
        PDoZ1p2ubFEAKFuzT2KkvXPew6zSdr6y2OuMnSEWC2xMB/eoj7i2SfwqA+42cNFX
        P2rfS4tpOIi8ruHreKyvPIpQZmUP6NWNipG/TmWbE3kzDT1x1ANScVE2HdBk6oth
        BXRWBoKhuIR+frgrZez0CUNDMXfj6fFVDYoCr4aP1R4u5ah3Gr7RyaGzEgAgMqjt
        7noXb5ZTwJD1oayc5LPLRFSOEuq8VSpHijPbI475Y4b85faYL9Gqv0ibqR4nrCaX
        UaT1GeH9FL3tys9+prM/UYbdBLEN8EAKdN92IwX/1Q=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id BC6marmYcYdG; Tue, 23 Oct 2018 20:54:09 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 515511FBA6;
        Tue, 23 Oct 2018 20:54:08 +0200 (CEST)
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
Subject: [PATCH v5 07/11] arm64: dts: allwinner: a64: sopine-baseboard: enable power supplies
Date:   Tue, 23 Oct 2018 21:53:26 +0300
Message-Id: <20181023185330.10472-8-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181023185330.10472-1-oskari@lemmela.net>
References: <20181023185330.10472-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AXP803 ACIN pins are routed from SOM to the DC jack on the baseboard.
AXP803 charger pins BATSENSE, LOADSENSE, N_BATDRV, LX_CHG, VIN_CHG
and IPSOUT are connected via PMOS driver to SOM VBAT pins. VBAT and
AXP803 TS pins are routed to the baseboard 3-pin battery connector.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 .../boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts    | 8 ++++++++
 1 file changed, 8 insertions(+)

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

