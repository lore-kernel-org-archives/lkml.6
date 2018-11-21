Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C796C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651CC214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6VfHML0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651CC214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731480AbeKVFHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:07:11 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53512 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbeKVFHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:07:10 -0500
Received: by mail-wm1-f67.google.com with SMTP id y1so3287335wmi.3;
        Wed, 21 Nov 2018 10:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s9bcD6A9iwk7zqNy7pS9kX1j1yEfgiEVlC+/BUWHVNs=;
        b=Z6VfHML0hlqINpMyhLCNawFI6IHfuxcqGAL8eQeZHgrPhZoKbxIVDStjtT3gDK/Bia
         cxBgozdRbOvpElXv09OZ/+f/Jcl9I2y8dX38FH1LLAMthnUwtgBmVLdNtaDnmn90J2m8
         s7zfdo8+yUN7ghZZurcBLCsPE5komXu/GUb1YY7Nuk/kUg8AS4dKF2dH4R9bGqf4kngS
         Btrw66N1lpvZFkjFrezqM2cQd3WEmfz0ImQq5sVf9Ry5apBbqwUvFiqEzqzSqLOJ6Lfw
         N+pIYxCkTeMWiKvBf7iY8Mmi4xLlCIaSEkeUlTulS7gMMAeIZDHc7ZA1/WmPsn3C6+OK
         jorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s9bcD6A9iwk7zqNy7pS9kX1j1yEfgiEVlC+/BUWHVNs=;
        b=g3MiXw63/KH8KCCnSLImnNHIkwbTM06oZewOptYFtqSCoE/zZL5YMgS9WNmDDufcHQ
         tmdVNnPmVfFEcVPv180kW0ev0WUptjiSLIulyhcgyAYlkw3AObgr6CM8dIac/VSe4em9
         sgKiotJn2Dvu3d1cNZkTPjRDa8TiqrIoXLO4VDYAvp5GTvFlB8IFsSPDA+P0J3XNfVx0
         qnFMLgiIudrzuTOnY1Ae9LRP0ARIwFqWA9FKFtfePyfG8dN+/QbZ7uNsfiW7QKukKxiS
         KMEZj78apMyWZgDD5GtibCwd7ESVtq/MI7VWZTISpLIhnIbCG9/K8zrW1oJkTSfS/Ltz
         2hSQ==
X-Gm-Message-State: AA+aEWadOMCZo67LIC0dhalWX2XFinARfWKdcb5AvR2l9yZePXoyw/TE
        Aos904CKma5UjLpegIWJBf9bRMZHS28=
X-Google-Smtp-Source: AJdET5dlsDVRbHTPYCCUQ9k4nWBR6nv8KU10OKmtGn9n3gZDfPRJhRAYp9H0yhk+BNHVxLuMyqcqUg==
X-Received: by 2002:a1c:9690:: with SMTP id y138-v6mr7151954wmd.67.1542825101310;
        Wed, 21 Nov 2018 10:31:41 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.229])
        by smtp.gmail.com with ESMTPSA id e66-v6sm2568779wmf.40.2018.11.21.10.31.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Nov 2018 10:31:40 -0800 (PST)
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
Subject: [RFC PATCH v3 01/17] ARM: add CONFIG_ARCH_SUNXI_V7 for differentiate ARMv5/v7 Allwinner SoCs
Date:   Wed, 21 Nov 2018 21:30:34 +0300
Message-Id: <267ffcf3b91930a82f20d93e1fad1fceaf8b9b0e.1542824904.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542824904.git.mesihkilinc@gmail.com>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner also has some ARMv5 SoCs.

In order to add support for them, add a CONFIG_ARCH_SUNXI_V7 bool config
which is selected when a ARMv7 soc is selected, and make CONFIG_ARCH_SUNXI
a common option which is selected by both V7 and V5 sunxi option.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 arch/arm/mach-sunxi/Kconfig | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index d9c8ecf..7e5f173 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -6,31 +6,38 @@ menuconfig ARCH_SUNXI
 	select GENERIC_IRQ_CHIP
 	select GPIOLIB
 	select PINCTRL
-	select PM_OPP
 	select SUN4I_TIMER
 	select RESET_CONTROLLER
+	help
+	  Support for Allwinner ARM-based family of processors
 
 if ARCH_SUNXI
 
+if ARCH_MULTI_V7
+
+config ARCH_SUNXI_V7
+	bool
+	select PM_OPP
+
 config MACH_SUN4I
 	bool "Allwinner A10 (sun4i) SoCs support"
-	default ARCH_SUNXI
+	select ARCH_SUNXI_V7
 
 config MACH_SUN5I
 	bool "Allwinner A10s / A13 (sun5i) SoCs support"
-	default ARCH_SUNXI
+	select ARCH_SUNXI_V7
 	select SUN5I_HSTIMER
 
 config MACH_SUN6I
 	bool "Allwinner A31 (sun6i) SoCs support"
-	default ARCH_SUNXI
+	select ARCH_SUNXI_V7
 	select ARM_GIC
 	select MFD_SUN6I_PRCM
 	select SUN5I_HSTIMER
 
 config MACH_SUN7I
 	bool "Allwinner A20 (sun7i) SoCs support"
-	default ARCH_SUNXI
+	select ARCH_SUNXI_V7
 	select ARM_GIC
 	select ARM_PSCI
 	select ARCH_SUPPORTS_BIG_ENDIAN
@@ -39,13 +46,13 @@ config MACH_SUN7I
 
 config MACH_SUN8I
 	bool "Allwinner sun8i Family SoCs support"
-	default ARCH_SUNXI
+	select ARCH_SUNXI_V7
 	select ARM_GIC
 	select MFD_SUN6I_PRCM
 
 config MACH_SUN9I
 	bool "Allwinner (sun9i) SoCs support"
-	default ARCH_SUNXI
+	select ARCH_SUNXI_V7
 	select ARM_GIC
 
 config ARCH_SUNXI_MC_SMP
@@ -56,3 +63,5 @@ config ARCH_SUNXI_MC_SMP
 	select ARM_CPU_SUSPEND
 
 endif
+
+endif
-- 
2.7.4

