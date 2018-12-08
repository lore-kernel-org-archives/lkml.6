Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD39C64EB1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A9420989
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="GJ/rk24w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A9420989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbeLHRiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 12:38:18 -0500
Received: from mail1.kuutio.org ([92.222.216.83]:49708 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbeLHRiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 12:38:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id A56342092C;
        Sat,  8 Dec 2018 18:38:09 +0100 (CET)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1544290688; x=
        1546882689; bh=2Ufa8g2X6gl38LQeXSxK1nafFVhKZ/h1m5RVhJnwc00=; b=G
        J/rk24wTV3LF+sWsqF7w97R44D9BFo5crW2fQMcOzPhpgVaQqprcCeVRSycuUfoz
        MwS1unWimMKgfY2MwJvWkYPil9VENGJ3E65IBShtLoW+CuGBVzBHnU3RuwpwyfKw
        IhEGFMMeKE8jWn0Jz0fd4YJdfs8qG9Q+50TG4QT1zFAmEB5GOCUhpJHejjeqMAa9
        tiUYvduH/wse0zUAVVOSsS0n5pnxqW9ynylENX+Zfai/4tzG1jRqyy1Lu5jUK2h8
        ax8YF4MUIlxQ0XevLFKw+zEVn+BwBObVr0f8+RUJ+w349n3/ChCFQBwUa+Gol3yF
        nrlfbm3Wlrk6Uts4MamvCFjpsGAQ7H6C1boSq4l2Cr4q1foEP0c/RW8rFISvSsTF
        WAT7PJCSMdk2HOWqIwvgSN64NGQRZMPjN2dSWjv+6Lj4zhvQO5ZUS7DVVBsVmOEm
        R7IXmpmqDYmSwsslCiEk9lwWCHwnJJz8z8Cpv1S+gOLUy0psTQQVZuKuS5QfZCxX
        ffnDcxd4tTYSd5hdy9GgyDJoVIHMH78q2QnRBq4GtSncokQjEDRx841ws27BOngD
        oj/T55L9YNcsg2csYsBAbG1BDvJfynMYjnLQbqNJqAjHagTifBlb0yselWWeBSm8
        4jgI8DvTpzxgs6n8gcQsgcMMhag4aTOvoUCRv69R4Q=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id I1KkFdTi7BsM; Sat,  8 Dec 2018 18:38:08 +0100 (CET)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 6C71F1F96B;
        Sat,  8 Dec 2018 18:38:08 +0100 (CET)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Quentin Schulz <quentin.schulz@bootlin.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Oskari Lemmela <oskari@lemmela.net>
Subject: [PATCH v7 4/9] arm64: dts: allwinner: a64: sopine-baseboard: enable power supplies
Date:   Sat,  8 Dec 2018 19:36:13 +0200
Message-Id: <20181208173618.31395-5-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181208173618.31395-1-oskari@lemmela.net>
References: <20181208173618.31395-1-oskari@lemmela.net>
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
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
 .../boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts    | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index 53fcc9098df3..4695b0d407b6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -80,6 +80,14 @@
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
 &de {
 	status = "okay";
 };
-- 
2.17.1

