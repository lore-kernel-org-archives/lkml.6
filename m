Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9DCC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289D2208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289D2208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeH0T5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 15:57:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:29781 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbeH0T5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 15:57:39 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41zcKz4mLVz9ttmM;
        Mon, 27 Aug 2018 18:10:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 9ipMeZYZad-c; Mon, 27 Aug 2018 18:10:15 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41zcKz4D67z9ttlx;
        Mon, 27 Aug 2018 18:10:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 062B48B7D5;
        Mon, 27 Aug 2018 18:10:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JlP-wpgLAu3P; Mon, 27 Aug 2018 18:10:23 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BD88D8B7D1;
        Mon, 27 Aug 2018 18:10:23 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B7B9D711E6; Mon, 27 Aug 2018 16:10:23 +0000 (UTC)
Message-Id: <ead0a7af4be483bded58977f42471607a76e880c.1535385970.git.christophe.leroy@c-s.fr>
In-Reply-To: <ab6b6c60d921335b44c100c5018fcc6585f05c24.1535385970.git.christophe.leroy@c-s.fr>
References: <ab6b6c60d921335b44c100c5018fcc6585f05c24.1535385970.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 2/3] drivers/video/fbdev: use ioremap_wt() instead of
 __ioremap(_PAGE_WRITETHRU)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-block@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Date:   Mon, 27 Aug 2018 16:10:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_PAGE_WRITETHRU is a target specific flag. Prefer generic functions.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: removed unnecessary includes headers

 drivers/video/fbdev/controlfb.c  |  5 +----
 drivers/video/fbdev/platinumfb.c |  5 +----
 drivers/video/fbdev/valkyriefb.c | 12 ++++++------
 3 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/controlfb.c
index 8d14b29aafea..9cb0ef7ac29e 100644
--- a/drivers/video/fbdev/controlfb.c
+++ b/drivers/video/fbdev/controlfb.c
@@ -48,9 +48,7 @@
 #include <linux/nvram.h>
 #include <linux/adb.h>
 #include <linux/cuda.h>
-#include <asm/io.h>
 #include <asm/prom.h>
-#include <asm/pgtable.h>
 #include <asm/btext.h>
 
 #include "macmodes.h"
@@ -715,8 +713,7 @@ static int __init control_of_init(struct device_node *dp)
 		goto error_out;
 	}
 	/* map at most 8MB for the frame buffer */
-	p->frame_buffer = __ioremap(p->frame_buffer_phys, 0x800000,
-				    _PAGE_WRITETHRU);
+	p->frame_buffer = ioremap_wt(p->frame_buffer_phys, 0x800000);
 
 	if (!p->control_regs_phys ||
 	    !request_mem_region(p->control_regs_phys, p->control_regs_size,
diff --git a/drivers/video/fbdev/platinumfb.c b/drivers/video/fbdev/platinumfb.c
index 377d3399a3ad..bf6b7fb83cf4 100644
--- a/drivers/video/fbdev/platinumfb.c
+++ b/drivers/video/fbdev/platinumfb.c
@@ -32,9 +32,7 @@
 #include <linux/nvram.h>
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
-#include <asm/io.h>
 #include <asm/prom.h>
-#include <asm/pgtable.h>
 
 #include "macmodes.h"
 #include "platinumfb.h"
@@ -577,8 +575,7 @@ static int platinumfb_probe(struct platform_device* odev)
 
 	/* frame buffer - map only 4MB */
 	pinfo->frame_buffer_phys = pinfo->rsrc_fb.start;
-	pinfo->frame_buffer = __ioremap(pinfo->rsrc_fb.start, 0x400000,
-					_PAGE_WRITETHRU);
+	pinfo->frame_buffer = ioremap_wt(pinfo->rsrc_fb.start, 0x400000);
 	pinfo->base_frame_buffer = pinfo->frame_buffer;
 
 	/* registers */
diff --git a/drivers/video/fbdev/valkyriefb.c b/drivers/video/fbdev/valkyriefb.c
index 275fb98236d3..d51c3a8009cb 100644
--- a/drivers/video/fbdev/valkyriefb.c
+++ b/drivers/video/fbdev/valkyriefb.c
@@ -54,13 +54,11 @@
 #include <linux/nvram.h>
 #include <linux/adb.h>
 #include <linux/cuda.h>
-#include <asm/io.h>
 #ifdef CONFIG_MAC
 #include <asm/macintosh.h>
 #else
 #include <asm/prom.h>
 #endif
-#include <asm/pgtable.h>
 
 #include "macmodes.h"
 #include "valkyriefb.h"
@@ -318,7 +316,7 @@ static void __init valkyrie_choose_mode(struct fb_info_valkyrie *p)
 int __init valkyriefb_init(void)
 {
 	struct fb_info_valkyrie	*p;
-	unsigned long frame_buffer_phys, cmap_regs_phys, flags;
+	unsigned long frame_buffer_phys, cmap_regs_phys;
 	int err;
 	char *option = NULL;
 
@@ -337,7 +335,6 @@ int __init valkyriefb_init(void)
 	/* Hardcoded addresses... welcome to 68k Macintosh country :-) */
 	frame_buffer_phys = 0xf9000000;
 	cmap_regs_phys = 0x50f24000;
-	flags = IOMAP_NOCACHE_SER; /* IOMAP_WRITETHROUGH?? */
 #else /* ppc (!CONFIG_MAC) */
 	{
 		struct device_node *dp;
@@ -354,7 +351,6 @@ int __init valkyriefb_init(void)
 
 		frame_buffer_phys = r.start;
 		cmap_regs_phys = r.start + 0x304000;
-		flags = _PAGE_WRITETHRU;
 	}
 #endif /* ppc (!CONFIG_MAC) */
 
@@ -369,7 +365,11 @@ int __init valkyriefb_init(void)
 	}
 	p->total_vram = 0x100000;
 	p->frame_buffer_phys = frame_buffer_phys;
-	p->frame_buffer = __ioremap(frame_buffer_phys, p->total_vram, flags);
+#ifdef CONFIG_MAC
+	p->frame_buffer = ioremap_nocache(frame_buffer_phys, p->total_vram);
+#else
+	p->frame_buffer = ioremap_wt(frame_buffer_phys, p->total_vram);
+#endif
 	p->cmap_regs_phys = cmap_regs_phys;
 	p->cmap_regs = ioremap(p->cmap_regs_phys, 0x1000);
 	p->valkyrie_regs_phys = cmap_regs_phys+0x6000;
-- 
2.13.3

