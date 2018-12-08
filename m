Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81757C64EB1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420A9208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="Qo7mQIWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 420A9208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbeLHRiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 12:38:22 -0500
Received: from mail1.kuutio.org ([92.222.216.83]:49760 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbeLHRiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 12:38:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 5CA3A2092A;
        Sat,  8 Dec 2018 18:38:11 +0100 (CET)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1544290690; x=
        1546882691; bh=cfMh6AcbyeWrvCk50dMKmOhXsNrpnTzv4+nFyu7Nu5E=; b=Q
        o7mQIWzM7VSoUQwlHRNzg9qZ0ETnUWNQ7o0YWU9uzzei2Hd+PKKyY/N2MFuyXZwt
        aoJpyR91Wzb8Nh30mmq6LwzLBxh7nPTJEzFnAcEGdf/zzHMAbskKvuHq+eu5jtd4
        159S37k3CCyLoD8/y0C01EvzmIhkmR2X3y+cJZJOYkX56rYwAve/8h/lbadw1BnR
        y/t/Imf1uDElx9XTc8zaYpaui3FQJlJGLNxGWLw5OwqUnBpnIEWXnTqoXspd8d8p
        lMeNHT0iPvR40exvmvDqRJoTOtbmvT48eYwg15Qy1te3lsqOuL9OU/zpGYQHIuMj
        f9FmsEkj11IUv+bkrNXTCly7P6Ans++alhMznvgsmWN7B6XoMCb5RZU8oO03UtIb
        KiGzh4xFnf4a4w/oOdU76p8MsX97Ui9m9s8O4icCjb+AT4R8/VMBn+UDzUbB8dOs
        VAckkgnUfCt/xzbpYzjbphnZkJzG9IImu8NGnH0IHAyVqwouVY8irdcCMQ8SbYwc
        4hT/b0mvtLw+D9DYo+QYMXJJCMrqRIVYQTdLoNRuoR0R8X1GE66SNoHa1oHrXYuR
        3pVSqt29+tn5l459FsRUAAZN1veFsQGPt2aYBM0SYCVGvGfvvvRmn95vWaD8TqVZ
        SQEoDdz/ybX8jgXlzjzEjng2WyKbkymYH7hynbG5u4=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 8nE9SaZ1zfsz; Sat,  8 Dec 2018 18:38:10 +0100 (CET)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 3D7FC1F965;
        Sat,  8 Dec 2018 18:38:10 +0100 (CET)
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
Subject: [PATCH v7 7/9] mfd: axp20x: Add AC power supply cell for AXP813
Date:   Sat,  8 Dec 2018 19:36:16 +0200
Message-Id: <20181208173618.31395-8-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181208173618.31395-1-oskari@lemmela.net>
References: <20181208173618.31395-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As axp20x-ac-power-supply now supports AXP813, add a cell for it.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/mfd/axp20x.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 0be511dd93d0..dfc3cff1d08b 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -778,6 +778,11 @@ static const struct mfd_cell axp813_cells[] = {
 	}, {
 		.name		= "axp20x-battery-power-supply",
 		.of_compatible	= "x-powers,axp813-battery-power-supply",
+	}, {
+		.name		= "axp20x-ac-power-supply",
+		.of_compatible	= "x-powers,axp813-ac-power-supply",
+		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
+		.resources	= axp20x_ac_power_supply_resources,
 	},
 };
 
-- 
2.17.1

