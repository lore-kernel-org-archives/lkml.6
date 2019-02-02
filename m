Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A78AC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08272085A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="lGKcH/eL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfBBQHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 11:07:08 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:20935 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbfBBQHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 11:07:07 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x12G6SvN022387;
        Sun, 3 Feb 2019 01:06:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x12G6SvN022387
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549123589;
        bh=JwopK9+7lX0V7SLAw43HF2FU5AbmP5n4htsIsh/Ga6s=;
        h=From:To:Cc:Subject:Date:From;
        b=lGKcH/eLdz2aFQfKfB0EGHjSN+x0exJEefHg9Gtewshe/jWDIP81Lknur8S9jawkT
         PSk1yUWaau4zOXwFEGFFq6PdkmntAafmhE1hk9jBJboDJnchvDSbdznnSrEo/2bMVP
         XVSF7SWCMS/xPq+XS8C5YjNQVJJCZEMPg30SrzCU+O+gKuObgrcr65tohlkFzIJ0bQ
         Pu4RW1+8TAXILYrR08EJLFpBySNEXqZ9hrcIkhBCnNMeyVYvsRZfhuAvLa6Kea6l99
         qB6i/2clzyJitQexHn2KnWSolMP9SdNGNYjcnEkFTdIudbmbUfcrE4/g3kOrrnrUP8
         oGBS0gc34Nchw==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Zhang Yanmin <yanmin.zhang@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] linux/kernel.h: use 'short' to define USHRT_MAX, SHRT_MAX, SHRT_MIN
Date:   Sun,  3 Feb 2019 01:06:24 +0900
Message-Id: <1549123585-13800-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The log of commit 44f564a4bf6a ("ipc: add definitions of USHORT_MAX
and others") did not explain why it used (s16) and (u16) instead of
(short) and (unsigned short).

Let's use (short) and (unsigned short), which is more sensible, and
more consistent with the other MAX/MIN defines.

As you see in include/uapi/asm-generic/int-ll64.h, s16/u16 are
typedef'ed as signed/unsigned short. So, this commit does not have
a functional change.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Zhang Yanmin <yanmin.zhang@intel.com>
---

 include/linux/kernel.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 8f0e68e..110bac1 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -16,9 +16,9 @@
 #include <asm/byteorder.h>
 #include <uapi/linux/kernel.h>
 
-#define USHRT_MAX	((u16)(~0U))
-#define SHRT_MAX	((s16)(USHRT_MAX>>1))
-#define SHRT_MIN	((s16)(-SHRT_MAX - 1))
+#define USHRT_MAX	((unsigned short)(~0U))
+#define SHRT_MAX	((short)(USHRT_MAX>>1))
+#define SHRT_MIN	((short)(-SHRT_MAX - 1))
 #define INT_MAX		((int)(~0U>>1))
 #define INT_MIN		(-INT_MAX - 1)
 #define UINT_MAX	(~0U)
-- 
2.7.4

