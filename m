Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E479C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40137210E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40137210E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933383AbeFUP7M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 11:59:12 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:39020 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933218AbeFUP7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 11:59:11 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id 1Tz71y00o3XaVaC06Tz72i; Thu, 21 Jun 2018 17:59:10 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fW1zH-0002fs-RM; Thu, 21 Jun 2018 17:59:07 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fW1zH-0003LW-Om; Thu, 21 Jun 2018 17:59:07 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Russell King <linux@armlinux.org.uk>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] [RFC] arm: Replace "multiple platforms" by "common platform"
Date:   Thu, 21 Jun 2018 17:59:06 +0200
Message-Id: <20180621155906.12821-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"ARM multiplatform" has actually two meanings:
  1. It groups platforms that follow the "ARM multiplatform" software
     framework,
  2. It allows to build a single kernel that can be booted on multiple
     platforms.

Currently support for XIP and/or NOMMU cannot be enabled on platforms
that follow the "ARM multiplatform" framework, without duplicating their
machine selection logic under a new Kconfig symbol.  As (in theory) all
platforms can be used with XIP and/or NOMMU, this is not sustainable.

Hence clarify the meaning of ARCH_MULTIPLATFORM:
  1. Replace "multiple platforms" by "common platform", as it allows to
     select one or more platforms adhering to the common framework,
  2. Note that a single kernel may not boot on all platforms if XIP or
     NOMMU is enabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
References:
  - "[PATCHv4 0/4] arm/versatile: no-MMU support"
    (http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/584555.html)

  - "[PATCH 0/2] ARM: ARMv7 (with MMU) XIP without ARCH_MULTIPLATFORM"
    (http://lists.infradead.org/pipermail/linux-arm-kernel/2017-February/486835.html)

 arch/arm/Kconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 54eeb8d00bc62a9f..6b286c018cf748c7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -329,7 +329,7 @@ choice
 	default ARCH_MULTIPLATFORM if MMU
 
 config ARCH_MULTIPLATFORM
-	bool "Allow multiple platforms to be selected"
+	bool "Common platforms (\"multiplatform\")"
 	depends on MMU
 	select ARM_HAS_SG_CHAIN
 	select ARM_PATCH_PHYS_VIRT
@@ -342,6 +342,13 @@ config ARCH_MULTIPLATFORM
 	select PCI_DOMAINS if PCI
 	select SPARSE_IRQ
 	select USE_OF
+	help
+	  Support for systems implemented using the common "multiplatform"
+	  framework.
+
+	  Unless specialized options depending on intimate platform
+	  details, like XIP or NOMMU, are enabled, this allows to build a
+	  single kernel that boots on multiple platforms.
 
 config ARM_SINGLE_ARMV7M
 	bool "ARMv7-M based platforms (Cortex-M0/M3/M4)"
-- 
2.17.1

