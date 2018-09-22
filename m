Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A878ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 22:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7AF2150F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 22:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CofXdrPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7AF2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbeIWEiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 00:38:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53258 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeIWEiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 00:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:Cc:From:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OY1A++wB+jR9cgcmXSN1Uz2OhvfcfIz3BiXZ4S23Wlk=; b=CofXdrPZOOcpshesojjk52NW8
        Cp0XwtiUeXz5dvF/KQNJ2y3Ds5YgkNMuDdMUtlpAA5wglWkryY/Ch6pFCalFQjVsCVy/2jCEqi87y
        r8kKlM4yekCqAVTUoUOTtHd7RQvXylfw5jrNGqTHLZkY5yfj5+Bt3mlj3B3tJ/LAsgBwdRccGyWc2
        wS2axHOgdCxklw5EOGAhPNlZJ8MuzhoIvZemvjMEmhkrtJEXuG8e6ioRcCpvH0HQDN4NcChXrdHUY
        LYK7VuoeWm6BU3wCXs1Ey997n2VpB9c05ImCxkiGPCKVwlowEYiYYmaal0WYa6EPadjM9GNpAq2M3
        euF2YXfpA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g3qcH-00074D-Pn; Sat, 22 Sep 2018 22:43:09 +0000
To:     Linux Fbdev development list <linux-fbdev@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Alexander Shiyan <shc_work@mail.ru>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] fbdev: fix broken menu dependencies
Message-ID: <1feb7db2-12b8-77c4-c325-cb4bdc76548e@infradead.org>
Date:   Sat, 22 Sep 2018 15:43:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

The framebuffer options and devices menu is unintentionally split
or broken because some items in it do not depend on FB (including
several under omap and mmp).
Fix this by moving FB_CMDLINE, FB_NOTIFY, and FB_CLPS711X_OLD to
just before the FB Kconfig symbol definition and by moving the
omap, omap2, and mmp menus to last, following FB_SM712.

Also, the FB_VIA dependencies are duplicated by both being inside
an "if FB_VIA/endif" block and "depends on FB_VIA", so drop the
"depends on FB_VIA" lines since they are redundant.

Fixes: ea6763c104c9 ("video/fbdev: Always built-in video= cmdline parsing")
Fixes: 5ec9653806ba ("fbdev: Make fb-notify a no-op if CONFIG_FB=n")
Fixes: ef74d46a4ef3 ("video: clps711x: Add new Cirrus Logic CLPS711X framebuffer driver")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Alexander Shiyan <shc_work@mail.ru>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/Kconfig |   34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

--- linux-next-20180921.orig/drivers/video/fbdev/Kconfig
+++ linux-next-20180921/drivers/video/fbdev/Kconfig
@@ -2,6 +2,18 @@
 # fbdev configuration
 #
 
+config FB_CMDLINE
+	bool
+
+config FB_NOTIFY
+	bool
+
+config FB_CLPS711X_OLD
+	tristate
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+
 menuconfig FB
 	tristate "Support for frame buffer devices"
 	select FB_CMDLINE
@@ -54,12 +66,6 @@ config FIRMWARE_EDID
 	 combination with certain motherboards and monitors are known to
 	 suffer from this problem.
 
-config FB_CMDLINE
-	bool
-
-config FB_NOTIFY
-	bool
-
 config FB_DDC
        tristate
        depends on FB
@@ -329,12 +335,6 @@ config FB_ACORN
 	  hardware found in Acorn RISC PCs and other ARM-based machines.  If
 	  unsure, say N.
 
-config FB_CLPS711X_OLD
-	tristate
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-
 config FB_CLPS711X
 	tristate "CLPS711X LCD support"
 	depends on FB && (ARCH_CLPS711X || COMPILE_TEST)
@@ -1456,7 +1456,6 @@ if FB_VIA
 
 config FB_VIA_DIRECT_PROCFS
 	bool "direct hardware access via procfs (DEPRECATED)(DANGEROUS)"
-	depends on FB_VIA
 	default n
 	help
 	  Allow direct hardware access to some output registers via procfs.
@@ -1466,7 +1465,6 @@ config FB_VIA_DIRECT_PROCFS
 
 config FB_VIA_X_COMPATIBILITY
 	bool "X server compatibility"
-	depends on FB_VIA
 	default n
 	help
 	  This option reduces the functionality (power saving, ...) of the
@@ -2308,10 +2306,6 @@ config FB_SIMPLE
 	  Configuration re: surface address, size, and format must be provided
 	  through device tree, or plain old platform data.
 
-source "drivers/video/fbdev/omap/Kconfig"
-source "drivers/video/fbdev/omap2/Kconfig"
-source "drivers/video/fbdev/mmp/Kconfig"
-
 config FB_SSD1307
 	tristate "Solomon SSD1307 framebuffer support"
 	depends on FB && I2C
@@ -2341,3 +2335,7 @@ config FB_SM712
 	  This driver is also available as a module. The module will be
 	  called sm712fb. If you want to compile it as a module, say M
 	  here and read <file:Documentation/kbuild/modules.txt>.
+
+source "drivers/video/fbdev/omap/Kconfig"
+source "drivers/video/fbdev/omap2/Kconfig"
+source "drivers/video/fbdev/mmp/Kconfig"


