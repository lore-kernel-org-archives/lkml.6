Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360B7C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39DF2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39DF2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbeH1TC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:02:26 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:42582 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbeH1TCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:02:25 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id UfAD1y0063XaVaC01fADgb; Tue, 28 Aug 2018 17:10:16 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fufdF-00004q-Bm; Tue, 28 Aug 2018 17:10:13 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fufdF-0003ff-AR; Tue, 28 Aug 2018 17:10:13 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/2] ARM: shmobile: Remove the ARCH_SHMOBILE Kconfig symbol
Date:   Tue, 28 Aug 2018 17:10:10 +0200
Message-Id: <20180828151011.14065-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828151011.14065-1-geert+renesas@glider.be>
References: <20180828151011.14065-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All drivers for Renesas ARM SoCs have gained proper ARCH_RENESAS
platform dependencies.  Hence finish the conversion from ARCH_SHMOBILE
to ARCH_RENESAS for Renesas 32-bit ARM SoCs, as started by commit
9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by,
  - Drop RFC, now all dependencies have been merged,
  - Rebase.

JFTR, after this, the following symbols for drivers supporting only
Renesas SuperH "SH-Mobile" SoCs can no longer be selected:
  - CONFIG_KEYBOARD_SH_KEYSC,
  - CONFIG_VIDEO_SH_VOU,
  - CONFIG_DRM_SHMOBILE[*].
(changes for a shmobile_defconfig .config)

[*] CONFIG_DRM_SHMOBILE has a dependency on ARM, but it was never wired
    up.
    From the use of sh_mobile_meram, I guess it was meant for SH-Mobile
    AP4 on Mackerel or AP4EVB, which are long gone.  So the only
    remaining upstream platforms that could make use of it are legacy
    SuperH SH-Mobile SoCs.
---
 arch/arm/mach-shmobile/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 94e9431d92b87405..1dfe3b80bae9e4fd 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -1,6 +1,3 @@
-config ARCH_SHMOBILE
-	bool
-
 config PM_RMOBILE
 	bool
 	select PM
@@ -30,7 +27,6 @@ config ARCH_RMOBILE
 menuconfig ARCH_RENESAS
 	bool "Renesas ARM SoCs"
 	depends on ARCH_MULTI_V7 && MMU
-	select ARCH_SHMOBILE
 	select ARM_GIC
 	select GPIOLIB
 	select HAVE_ARM_SCU if SMP
-- 
2.17.1

