Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098BAC64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C176B20851
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gt3nGvK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C176B20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbeLBUYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 15:24:23 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32819 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbeLBUYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 15:24:22 -0500
Received: by mail-wm1-f66.google.com with SMTP id r24so5502411wmh.0;
        Sun, 02 Dec 2018 12:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zZAcd5DCVFwIJh7pdMnlLFltxq06uySPlY2MVRx9NcI=;
        b=gt3nGvK8NwsEwK5RJDBj/2x+YS+lOCQ7+bXLEo/6nmmzBptA+3rt1F6H2R5NvrVncP
         sRqCYhYPTatsdgL9k+nyP2gb4031HLQB39nU5GycYJ1iYAUxqYzpYpciwT7HD0FbwccX
         kKzMlu9IRNG3UDO86/4rUE/Pf4hut1HCRw+mN99B6xE9JSvGIB/Fodd9BgscSb2aKfH7
         UHxMEXHsiy7hb68SoXruVjOLFOK9yjCwFU7MvrI+Ba9aTDs22wl+2etMeHeargImX0YC
         0lgLMj1W3dMi/ayDzUUE5zgXyW1RsWix+BF6/adDxXq/b134LX13DwfJ4xtym9maIBdL
         ZkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zZAcd5DCVFwIJh7pdMnlLFltxq06uySPlY2MVRx9NcI=;
        b=hkjaO4lC1ucXwtbiTwn4F0oYG1xtXcJE+lARUYlRa4QRoepbk6hcrosD9BzTtRtTTl
         TjXqRO0AUXQEdVbZg8+E+qEVOALUORmvdumXMp+mVmJOEcgd+q9XfKiUlWBKteIIheDT
         yvY13DzAX9n3K5U0mmENGEwN9s7sqgvNCWYrQ9cQSJO4+dsxM96Wc3Cu3NI7M4Qw4zcO
         1JhleCL6vNeRoM8uwMJXgdhgeMQ2IrIr/D11ZFQ4KNPrOAMtjh9iTl+bzyhtwxpViCZ/
         kw/MNVFWHl6ihmtB61PhlGigZzRHiXuAKXl6isKfM0jdbVXrBU7UTjzW3Olu+5lVbrNw
         +F8w==
X-Gm-Message-State: AA+aEWbAsju0EvrU8VkYJxkHJFBe8WOM2P1EdZq3XaKAG42+J891oHds
        s/MpGYCWevnAPUQXqn/Y86hiy+brXF4=
X-Google-Smtp-Source: AFSGD/UN6jAOjEyAnAksPMWBNNew+GSzwYbOdZr/pbVEbOevS6G+zY9Ict6vDwwjDsLG75dyNEg4iQ==
X-Received: by 2002:a1c:f116:: with SMTP id p22mr5918334wmh.0.1543782255665;
        Sun, 02 Dec 2018 12:24:15 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
        by smtp.gmail.com with ESMTPSA id l3sm14451510wma.44.2018.12.02.12.24.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Dec 2018 12:24:15 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: [PATCH v6 03/17] ARM: sunxi: add Allwinner ARMv5 SoCs
Date:   Sun,  2 Dec 2018 23:23:37 +0300
Message-Id: <ea7d4f514fb002d909140854fed645ae02ef7dc2.1543781680.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543781680.git.mesihkilinc@gmail.com>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add option for Allwinner ARMv5 SoCs and SoC F1C100s (which has a die
used for many new F-series products, including F1C100A, F1C100s, F1C200s,
F1C500, F1C600).

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/mach-sunxi/Kconfig | 13 ++++++++++++-
 arch/arm/mach-sunxi/sunxi.c | 10 ++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 185c573..7fa6a3d 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1,6 +1,6 @@
 menuconfig ARCH_SUNXI
 	bool "Allwinner SoCs"
-	depends on ARCH_MULTI_V7
+	depends on ARCH_MULTI_V5 || ARCH_MULTI_V7
 	select ARCH_HAS_RESET_CONTROLLER
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
@@ -61,4 +61,15 @@ config ARCH_SUNXI_MC_SMP
 
 endif
 
+if ARCH_MULTI_V5
+
+config MACH_SUNIV
+	bool "Allwinner ARMv5 F-series (suniv) SoCs support"
+	default ARCH_SUNXI
+	help
+	  Support for Allwinner suniv ARMv5 SoCs.
+	  (F1C100A, F1C100s, F1C200s, F1C500, F1C600)
+
+endif
+
 endif
diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index de4b0e9..155cd9e 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -101,3 +101,13 @@ static const char * const sun9i_board_dt_compat[] = {
 DT_MACHINE_START(SUN9I_DT, "Allwinner sun9i Family")
 	.dt_compat	= sun9i_board_dt_compat,
 MACHINE_END
+
+static const char * const suniv_board_dt_compat[] = {
+	"allwinner,suniv-f1c100s",
+	NULL,
+};
+
+DT_MACHINE_START(SUNIV_DT, "Allwinner suniv Family")
+	.dt_compat	= suniv_board_dt_compat,
+MACHINE_END
+
-- 
2.7.4

