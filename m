Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C236C43334
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 14:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4AF721788
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 14:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4AF721788
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbeHYSLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 14:11:49 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:40894 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbeHYSLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 14:11:48 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41yLG92LLFz9ttlT;
        Sat, 25 Aug 2018 16:32:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ErRHT0WfECVH; Sat, 25 Aug 2018 16:32:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41yLG91bZ5z9ttgH;
        Sat, 25 Aug 2018 16:32:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 018258B79A;
        Sat, 25 Aug 2018 16:32:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id U9fm3zdA_11T; Sat, 25 Aug 2018 16:32:37 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [192.168.232.53])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8BA0C8B796;
        Sat, 25 Aug 2018 16:32:37 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 6C0DD104917; Sat, 25 Aug 2018 16:27:00 +0200 (CEST)
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH RESEND 2/3] drivers/video/fbdev: use ioremap_wt() instead of
 __ioremap(_PAGE_WRITETHRU)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-block@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20180825142700.6C0DD104917@pc16082vm.idsi0.si.c-s.fr>
Date:   Sat, 25 Aug 2018 16:27:00 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_PAGE_WRITETHRU is a target specific flag. Prefer generic functions.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/video/fbdev/controlfb.c  |  3 +--
 drivers/video/fbdev/platinumfb.c |  3 +--
 drivers/video/fbdev/valkyriefb.c | 10 ++++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/controlfb.c
index 8d14b29aafea..058093990218 100644
--- a/drivers/video/fbdev/controlfb.c
+++ b/drivers/video/fbdev/controlfb.c
@@ -715,8 +715,7 @@ static int __init control_of_init(struct device_node *dp)
 		goto error_out;
 	}
 	/* map at most 8MB for the frame buffer */
-	p->frame_buffer = __ioremap(p->frame_buffer_phys, 0x800000,
-				    _PAGE_WRITETHRU);
+	p->frame_buffer = ioremap_wt(p->frame_buffer_phys, 0x800000);
 
 	if (!p->control_regs_phys ||
 	    !request_mem_region(p->control_regs_phys, p->control_regs_size,
diff --git a/drivers/video/fbdev/platinumfb.c b/drivers/video/fbdev/platinumfb.c
index 377d3399a3ad..df79f102fbc6 100644
--- a/drivers/video/fbdev/platinumfb.c
+++ b/drivers/video/fbdev/platinumfb.c
@@ -577,8 +577,7 @@ static int platinumfb_probe(struct platform_device* odev)
 
 	/* frame buffer - map only 4MB */
 	pinfo->frame_buffer_phys = pinfo->rsrc_fb.start;
-	pinfo->frame_buffer = __ioremap(pinfo->rsrc_fb.start, 0x400000,
-					_PAGE_WRITETHRU);
+	pinfo->frame_buffer = ioremap_wt(pinfo->rsrc_fb.start, 0x400000);
 	pinfo->base_frame_buffer = pinfo->frame_buffer;
 
 	/* registers */
diff --git a/drivers/video/fbdev/valkyriefb.c b/drivers/video/fbdev/valkyriefb.c
index 275fb98236d3..0c6c1eede800 100644
--- a/drivers/video/fbdev/valkyriefb.c
+++ b/drivers/video/fbdev/valkyriefb.c
@@ -318,7 +318,7 @@ static void __init valkyrie_choose_mode(struct fb_info_valkyrie *p)
 int __init valkyriefb_init(void)
 {
 	struct fb_info_valkyrie	*p;
-	unsigned long frame_buffer_phys, cmap_regs_phys, flags;
+	unsigned long frame_buffer_phys, cmap_regs_phys;
 	int err;
 	char *option = NULL;
 
@@ -337,7 +337,6 @@ int __init valkyriefb_init(void)
 	/* Hardcoded addresses... welcome to 68k Macintosh country :-) */
 	frame_buffer_phys = 0xf9000000;
 	cmap_regs_phys = 0x50f24000;
-	flags = IOMAP_NOCACHE_SER; /* IOMAP_WRITETHROUGH?? */
 #else /* ppc (!CONFIG_MAC) */
 	{
 		struct device_node *dp;
@@ -354,7 +353,6 @@ int __init valkyriefb_init(void)
 
 		frame_buffer_phys = r.start;
 		cmap_regs_phys = r.start + 0x304000;
-		flags = _PAGE_WRITETHRU;
 	}
 #endif /* ppc (!CONFIG_MAC) */
 
@@ -369,7 +367,11 @@ int __init valkyriefb_init(void)
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
2.17.1

