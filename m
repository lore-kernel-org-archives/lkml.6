Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C7FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F05208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F05208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeH0T5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 15:57:46 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:1876 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbeH0T5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 15:57:46 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41zcL63f7qz9ttmB;
        Mon, 27 Aug 2018 18:10:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id P-oTDU93ZEd9; Mon, 27 Aug 2018 18:10:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41zcL636fCz9ttlx;
        Mon, 27 Aug 2018 18:10:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 025368B7D5;
        Mon, 27 Aug 2018 18:10:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id CK4_p2hkd1Mx; Mon, 27 Aug 2018 18:10:25 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C8FBF8B7D1;
        Mon, 27 Aug 2018 18:10:25 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id BD4A7711E6; Mon, 27 Aug 2018 16:10:25 +0000 (UTC)
Message-Id: <48bcbeb8e5f57c958e6e0bc7a29feae44821901d.1535385970.git.christophe.leroy@c-s.fr>
In-Reply-To: <ab6b6c60d921335b44c100c5018fcc6585f05c24.1535385970.git.christophe.leroy@c-s.fr>
References: <ab6b6c60d921335b44c100c5018fcc6585f05c24.1535385970.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 3/3] drivers/block/z2ram: use ioremap_wt() instead of
 __ioremap(_PAGE_WRITETHRU)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-block@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Date:   Mon, 27 Aug 2018 16:10:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_PAGE_WRITETHRU is a target specific flag. Prefer generic functions.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: no change

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
2.13.3

