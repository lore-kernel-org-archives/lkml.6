Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CFEC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363D22082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363D22082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbeLJIIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:08:30 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:27830 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbeLJII3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:08:29 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43Cwgc1dsfz9v112;
        Mon, 10 Dec 2018 09:08:28 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id hWvKBBfROY8Q; Mon, 10 Dec 2018 09:08:28 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43Cwgc0Jq1z9v0sP;
        Mon, 10 Dec 2018 09:08:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 66C008B79D;
        Mon, 10 Dec 2018 09:08:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id tv8M8lNInAQq; Mon, 10 Dec 2018 09:08:28 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 39D618B74C;
        Mon, 10 Dec 2018 09:08:28 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2924E716C1; Mon, 10 Dec 2018 08:08:28 +0000 (UTC)
Message-Id: <40d63adb6058b1fbb4082ca6f15225cb6e76bd62.1544429175.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] lib: fix build failure in CONFIG_DEBUG_VIRTUAL test
To:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 10 Dec 2018 08:08:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On several arches, virt_to_phys() is in io.h

Build fails without it:

  CC      lib/test_debug_virtual.o
lib/test_debug_virtual.c: In function 'test_debug_virtual_init':
lib/test_debug_virtual.c:26:7: error: implicit declaration of function 'virt_to_phys' [-Werror=implicit-function-declaration]
  pa = virt_to_phys(va);
       ^

Fixes: e4dace361552 ("lib: add test module for CONFIG_DEBUG_VIRTUAL")
CC: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 lib/test_debug_virtual.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/test_debug_virtual.c b/lib/test_debug_virtual.c
index d5a06addeb27..bf864c73e462 100644
--- a/lib/test_debug_virtual.c
+++ b/lib/test_debug_virtual.c
@@ -5,6 +5,7 @@
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 #include <linux/sizes.h>
+#include <linux/io.h>
 
 #include <asm/page.h>
 #ifdef CONFIG_MIPS
-- 
2.13.3

