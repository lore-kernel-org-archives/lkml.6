Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79220C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436072086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="JUDeyeuP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 436072086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeK0CWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:22:45 -0500
Received: from plaes.org ([188.166.43.21]:49992 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbeK0CWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:22:44 -0500
Received: from localhost (85.253.196.132.cable.starman.ee [85.253.196.132])
        by plaes.org (Postfix) with ESMTPSA id 0970041C64;
        Mon, 26 Nov 2018 15:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1543246095; bh=OUsll2pSZ+358NKNJxIvPOwFWCiSRmYw6WUlwJb5uoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JUDeyeuPsJnifS/ateXI/uKf1+1hYIbC0VJnuf3ZPEugPFWQnUWo8XjIZ6vtuFesx
         XCSi6aN/qT4sQgUYGvLOcegxNnUELpkGUueu5XsqBd0MxG2xa+7LdwUMIrjL3Lj/hD
         duviv/2m4PHcT2pGDinQPj5Hmn7KD7mtet98ulCJ+P1YqziPO4I1hb8m66cjUv29dd
         +aWnYu2ygMNB11PARsm2U940A1Mf6Wm9MuKxB1Wirb/XCcDQv/iwSJewy0wYN6ubbR
         UbP98T9yFjdJKqRZiCkADXfEeXp0FxDtZnFMJ7KzHJqng14VGvLQXubM0y3vQqSSXJ
         7VUeFl7KqW1tw==
From:   Priit Laes <plaes@plaes.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     Priit Laes <plaes@plaes.org>, Olliver Schinagl <oliver@schinagl.nl>
Subject: [PATCH 09/14] regulator: dts: add full voltage range to LDO4 on the Lime2
Date:   Mon, 26 Nov 2018 17:27:50 +0200
Message-Id: <0b1aa5b28cb5efe17c04150a181ef1fa4027bc55.1543245984.git-series.plaes@plaes.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olliver Schinagl <oliver@schinagl.nl>

With commit b43776d65a33b46092 ("ARM: dts: sunxi: Use axp209.dtsi for
Olinuxino Lime2") we force them an arbitrary 2.8 volts. Granted, for
LDO3 this may be less arbitrary, but for LDO4 this is just wrong.

In the defense of LDO3, LDO3 is the regulator that feeds port bank E,
which has no other purpose then a CSI/TS interface, however the case
may still be, that the connected IO may be just as well be 3.3 volts.
The big misnomer is however, that the schematic names GPIO-2 pin4
LDO3_2.8V, rather then VDD-CSI0 or similar.

This is much worse for LDO4 however, which is not referenced on any
pin, is now set to 2.8 volts, but port bank G can also support various
other peripherals such as UARTS etc.

By having 2.8 volts however for LDO4, we thus now have peripherals that
no longer function properly all of the time.

Ideally, we want to set a supply voltage for each port bank, but the
monolithic nature of the sunxi pinctroller currently prevents this and
as such, the board should at least configure the LDO4 with the proper
ranges.

Until we can set the consumer at the port bank level, a child
device-tree has to do something like:

&reg_ldo4 {
    regulator-min-microvolt = <3300000>;
    regulator-max-microvolt = <3300000>;
};

While doing this the same way results in the same solution currently,
we force the hack into the final devicetree rather then having it wrong
at the board level.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index ffafe97..1b9867f 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -250,9 +250,10 @@
 };
 
 &reg_ldo4 {
-	regulator-min-microvolt = <2800000>;
-	regulator-max-microvolt = <2800000>;
-	regulator-name = "vddio-csi1";
+	regulator-always-on;
+	regulator-min-microvolt = <1250000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vdd-io-pg";
 };
 
 &reg_usb0_vbus {
-- 
git-series 0.9.1
