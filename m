Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3305EC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 14:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43CB21788
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 14:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43CB21788
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbeHYSLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 14:11:47 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:34844 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbeHYSLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 14:11:47 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41yLG92P5Tz9ttld;
        Sat, 25 Aug 2018 16:32:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id R6KBo7vTm_TR; Sat, 25 Aug 2018 16:32:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41yLG91gKkz9ttlQ;
        Sat, 25 Aug 2018 16:32:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F33798B74B;
        Sat, 25 Aug 2018 16:32:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Qq2bafMdF7cL; Sat, 25 Aug 2018 16:32:37 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [192.168.232.53])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9068F8B798;
        Sat, 25 Aug 2018 16:32:37 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 77FD7104918; Sat, 25 Aug 2018 16:27:02 +0200 (CEST)
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH RESEND 3/3] drivers/block/z2ram: use ioremap_wt() instead of
 __ioremap(_PAGE_WRITETHRU)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-block@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20180825142702.77FD7104918@pc16082vm.idsi0.si.c-s.fr>
Date:   Sat, 25 Aug 2018 16:27:02 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_PAGE_WRITETHRU is a target specific flag. Prefer generic functions.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/block/z2ram.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
index d0c5bc4e0703..cfbd70520eeb 100644
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -190,8 +190,7 @@ static int z2_open(struct block_device *bdev, fmode_t mode)
 			vfree(vmalloc (size));
 		}
 
-		vaddr = (unsigned long) __ioremap (paddr, size, 
-						   _PAGE_WRITETHRU);
+		vaddr = (unsigned long)ioremap_wt(paddr, size);
 
 #else
 		vaddr = (unsigned long)z_remap_nocache_nonser(paddr, size);
-- 
2.17.1

