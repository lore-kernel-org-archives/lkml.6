Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D35C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206BA208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 206BA208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbeH0Tw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 15:52:57 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:57877 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727026AbeH0Tw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 15:52:57 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41zcDZ1ZbQz9ttlb;
        Mon, 27 Aug 2018 18:05:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id sqZTX-JwgzyR; Mon, 27 Aug 2018 18:05:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41zcDZ0w4wz9ttl4;
        Mon, 27 Aug 2018 18:05:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AB6FF8B7D5;
        Mon, 27 Aug 2018 18:05:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id AizIPvofMrNr; Mon, 27 Aug 2018 18:05:42 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 841E58B7D1;
        Mon, 27 Aug 2018 18:05:42 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4BF1C71523; Mon, 27 Aug 2018 16:05:42 +0000 (UTC)
Message-Id: <19880223194e682a895f6685f6ae2c18994fd774.1535385164.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] drivers/video/fbdev: use ioremap_wc() instead of
 __ioremap(_PAGE_NO_CACHE)
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 27 Aug 2018 16:05:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_PAGE_NO_CACHE is a target specific flag. In addition, this flag
is misleading because one would think it requests a noncached page
whereas a noncached page is _PAGE_NO_CACHE | _PAGE_GUARDED

_PAGE_NO_CACHE alone means write combined noncached page, so lets
use ioremap_wc() instead.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: removed unnecessary include and enhanced commit log follow Segher's comment

 drivers/video/fbdev/chipsfb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/chipsfb.c b/drivers/video/fbdev/chipsfb.c
index f103665cad43..40182ed85648 100644
--- a/drivers/video/fbdev/chipsfb.c
+++ b/drivers/video/fbdev/chipsfb.c
@@ -27,7 +27,6 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/console.h>
-#include <asm/io.h>
 
 #ifdef CONFIG_PMAC_BACKLIGHT
 #include <asm/backlight.h>
@@ -401,7 +400,7 @@ static int chipsfb_pci_init(struct pci_dev *dp, const struct pci_device_id *ent)
 #endif /* CONFIG_PMAC_BACKLIGHT */
 
 #ifdef CONFIG_PPC
-	p->screen_base = __ioremap(addr, 0x200000, _PAGE_NO_CACHE);
+	p->screen_base = ioremap_wc(addr, 0x200000);
 #else
 	p->screen_base = ioremap(addr, 0x200000);
 #endif
-- 
2.13.3

