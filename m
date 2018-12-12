Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EEFC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B967D20672
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="CAY+Q2YP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B967D20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbeLLWVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:21:55 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:44934 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbeLLWVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:21:42 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, od@zcrc.me,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v8 23/26] MIPS: GCW0: Move clocksource to TCU channel 2
Date:   Wed, 12 Dec 2018 23:13:17 +0100
Message-Id: <20181212221317.19335-1-paul@crapouillou.net>
In-Reply-To: <20181212220922.18759-1-paul@crapouillou.net>
References: <20181212220922.18759-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1544652805; bh=ksfFjOlJNPrs7C6s/v/Mewpebdp4w24yVLtWOe3+U9s=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=CAY+Q2YPio5G6HRWCc0vfgwV+iOCcsbipiUDvNv+zzRmC7sXv6i+5sl1pC2OZTbraIRztKZCOXJEvlrXtt+6mSf7unpP0AvhSGjUq4P7J83G4645COcbAhWQORNXjaGVDmjEeeQTtxWpRgxX9rfqjD83f04Zqdfj2l/hfRHlZqk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TCU channel 1, which is the default for the clocksource, is used as
PWM on the GCW Zero as it drives the backlight. Therefore we must use a
different TCU channel for the clocksource.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
     v8: New patch

 arch/mips/boot/dts/ingenic/gcw0.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/gcw0.dts b/arch/mips/boot/dts/ingenic/gcw0.dts
index 35f0291e8d38..8abab14eb852 100644
--- a/arch/mips/boot/dts/ingenic/gcw0.dts
+++ b/arch/mips/boot/dts/ingenic/gcw0.dts
@@ -60,3 +60,14 @@
 	/* The WiFi module is connected to the UHC. */
 	status = "okay";
 };
+
+&pwm {
+	/* Channels 1 and 3-7 are for PWM use */
+	reg = <0x50 0x10>, <0x70 0x50>;
+};
+
+&clocksource {
+	/* Use channel 2 for the clocksource */
+	reg = <0x60 0x10>;
+	clocks = <&tcu TCU_CLK_TIMER2>;
+};
-- 
2.11.0

