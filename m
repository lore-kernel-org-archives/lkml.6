Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD9AC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6591A2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="Rsf61yTn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6591A2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbeJXDSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:18:51 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:45988 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728922AbeJXDSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:18:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 1129F1FBA6;
        Tue, 23 Oct 2018 20:54:11 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1540320850; x=
        1542912851; bh=5RROUQkSifGdtX7kU95flOowMcA+erVzsiJE8kzvFYE=; b=R
        sf61yTnK1iTXYkxOaQa9ON2s3JgmXMkImM+x2EKE26ZgI41umz8+OgYOR37Mjuuj
        UU6qoz2Vz/YFjhxXfwr+0VfUQo7WUDzYfoSNCDXGNC3wU3AQkF4NMH4bQyYWENJZ
        VcRffMfgEWZIIIUBDdAZHLHjKTXjY5tUKD1emfYLBXAQ91J1Ct2boHujWP6z2yPK
        7+DBkL+JkjerigVCAcxrHWGWSS4snFS0SqpPMmLJ8LiOZxVSLrtObYoEeU/SJXqn
        PawtbazPsYweTUWy0x8b/c2+IGa1HZxeIj4c9vIAcquhJdFFqi4ox4ySY28/BAi7
        M1wztrO+vfzeGfnMmTgSblt+vYWtJN90crzf2Au4h4gYa3FV9dz4YrtThxzp55ry
        NzQlLsOW+c9jCRLjWhaZCv5OZgxxS1qsq8qotiGJPlWgV0Fuag0pF0BmNdGWdPrM
        R5M6IVyaOQCF2N2u+t0ZEmGYxUfKggbZj1LNpdYKqG/j25HGUzIGZQuQWnj32taN
        ZiouKRcA60WWgRVsIKjlKAqF7IiVqqkXPq0JIGXeCt+K1FtyTVl4W1TGijXvIvIf
        /l8DL5B37QA1UKmMXr5ipSmZaqOO9JRP5d6ZGVC75avawGsPdTD2YSpWBmnWu+Cu
        3otd6SlXoIXfmiFKelLVGtW5UgTpqVxlRR0/aaPa4Y=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id ot7sKz_Ao7j9; Tue, 23 Oct 2018 20:54:10 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id A1E511FBA1;
        Tue, 23 Oct 2018 20:54:09 +0200 (CEST)
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
Subject: [PATCH v5 08/11] arm64: dts: allwinner: a64: pinebook: enable power supplies
Date:   Tue, 23 Oct 2018 21:53:27 +0300
Message-Id: <20181023185330.10472-9-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181023185330.10472-1-oskari@lemmela.net>
References: <20181023185330.10472-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Khoruzhick <anarsoul@gmail.com>

Pinebook has ACIN connector and 10000 mAh battery.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 897e60cbe38d..4fabe22ece47 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -149,6 +149,14 @@
 
 #include "axp803.dtsi"
 
+&ac_power_supply {
+	status = "okay";
+};
+
+&battery_power_supply {
+	status = "okay";
+};
+
 &reg_aldo1 {
 	regulator-min-microvolt = <2800000>;
 	regulator-max-microvolt = <2800000>;
-- 
2.17.1

