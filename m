Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F853C00449
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 14:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10DB320882
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 14:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPya64jF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10DB320882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbeJGWAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 18:00:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42500 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbeJGWAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 18:00:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id c8-v6so8908698plo.9
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 07:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=QwlVY8Rq8z6tW5V0vwHSnSvi9n7x6WJWWS7PyA+5O5Q=;
        b=KPya64jFPGl8DSOLSPtRQaK5nwse5zrIl9I3XfoFFCmmCq7J46BnWiXc7uR3nvg1oj
         YSFkWJuVItHpLqrdfmmP53xGIpBWaHeJlGo4VyQqvvnX3i1G64mK/mbz53CNDXu0yfoT
         9T9Yc1i8U/zmTDRfjsEa5ZphqxHkX53IPAmuZl1exvhNBnqjeRzoIsM796g8E64+4KbK
         UQgWifkPnducA0KERBeQJiRg3oonh4OYlDUVXYasGQ34lWPfV3kgWJppyDyjJhKStNwg
         PbONH/mChT6OlH/Ca9LLRwlZYTECNC2qT+8yzPfQdl84HTEYZnQgupEmiUMaCaxBKjaB
         pORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=QwlVY8Rq8z6tW5V0vwHSnSvi9n7x6WJWWS7PyA+5O5Q=;
        b=Cam+ye8Eayj8ehMk9nUDT/3kunNkaR2WAwsbfgO33V9WLDopG5alFLZ8jfUOxvfnUI
         hP93DhCQgt7K7eujhXlE2tWfQeSFzZAfYJGixvs3+vk2T3NsJhj91WLW4Ty3cbUcqduf
         QeeQTzmXoKegy8qV/kt/CmScGzbJqHzpCZisnbnDGAR1tJtWoLSPF5ZkrORuDRvUL9zt
         b3smAGG2vEYFJKPvUaOstxPpEKSbNCxaLEOp6O6GHVzf3vQrIfGv2rL5WvrBF96veD8k
         WPF0eD0Nl/vXu7E6jJf27nNg+fHhzydam/ZUOwWR0w68TwI4VDm8X41Qxxkx+pT+ez+w
         moVw==
X-Gm-Message-State: ABuFfogxg8Xw4mGPOiM+OXHt0nmoCuNNFjzuv9DM1o4IazokfBtGtQTe
        I+ydKCOvoGodxVsdZ0PI53BWQoZV
X-Google-Smtp-Source: ACcGV62UkHUvCGvE5RmhAIGQ9wB3B60hZkO2xYq8dyQYtOkbKJnL7HS+Mdd3/fnjxbzgeyxGafOMtg==
X-Received: by 2002:a17:902:1566:: with SMTP id b35-v6mr20085215plh.135.1538924005736;
        Sun, 07 Oct 2018 07:53:25 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id p3-v6sm16941351pfo.130.2018.10.07.07.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 07:53:24 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ley Foon Tan <lftan@altera.com>
Cc:     nios2-dev@lists.rocketboards.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] nios2: ksyms: Add missing symbol exports
Date:   Sun,  7 Oct 2018 07:53:20 -0700
Message-Id: <1538924000-17898-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building nios2:allmodconfig fails as follows (each symbol is only listed
once).

ERROR: "__ashldi3" [drivers/md/dm-writecache.ko] undefined!
ERROR: "__ashrdi3" [fs/xfs/xfs.ko] undefined!
ERROR: "__ucmpdi2" [drivers/media/i2c/adv7842.ko] undefined!
ERROR: "__lshrdi3" [drivers/md/dm-zoned.ko] undefined!
ERROR: "flush_icache_range" [drivers/misc/lkdtm/lkdtm.ko] undefined!
ERROR: "empty_zero_page" [drivers/md/dm-mod.ko] undefined!

The problem is seen with gcc 7.3.0.

Export the missing symbols.

Fixes: 2fc8483fdcde ("nios2: Build infrastructure")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/nios2/kernel/nios2_ksyms.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/nios2/kernel/nios2_ksyms.c b/arch/nios2/kernel/nios2_ksyms.c
index bf2f55d10a4d..4e704046a150 100644
--- a/arch/nios2/kernel/nios2_ksyms.c
+++ b/arch/nios2/kernel/nios2_ksyms.c
@@ -9,12 +9,20 @@
 #include <linux/export.h>
 #include <linux/string.h>
 
+#include <asm/cacheflush.h>
+#include <asm/pgtable.h>
+
 /* string functions */
 
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(memmove);
 
+/* memory management */
+
+EXPORT_SYMBOL(empty_zero_page);
+EXPORT_SYMBOL(flush_icache_range);
+
 /*
  * libgcc functions - functions that are used internally by the
  * compiler...  (prototypes are not correct though, but that
@@ -31,3 +39,7 @@ DECLARE_EXPORT(__udivsi3);
 DECLARE_EXPORT(__umoddi3);
 DECLARE_EXPORT(__umodsi3);
 DECLARE_EXPORT(__muldi3);
+DECLARE_EXPORT(__ucmpdi2);
+DECLARE_EXPORT(__lshrdi3);
+DECLARE_EXPORT(__ashldi3);
+DECLARE_EXPORT(__ashrdi3);
-- 
2.7.4

