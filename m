Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C242C282DB
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B3002085A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="SVdwtRih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfBBQHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 11:07:19 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:21080 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbfBBQHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 11:07:16 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x12G6SvO022387;
        Sun, 3 Feb 2019 01:06:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x12G6SvO022387
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549123590;
        bh=kYnafPl0RddfLsUZ65qo2ZmuBPvqJnmVRX8/uu8wmrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SVdwtRihI1bXSD4HB5uT7OOLoRIoebYIIhRRW26ed+/3CpgxcsggY1zsg7Ad1jetr
         IBKk29bAb7HIas9zFX+jZHYEIGBnfCQZ+LQ5xURxKSgeNyBoq7cTeDaT4YBlsbQmFR
         wRQvDHI7yOKnWkYvqt06i7Fakipr8pH6RPGQgpolLRvYHGBGP5zmJr7DcIFgwj5/9R
         r7EHb3uhQsFpo5OL1HfwXcWU3vjGUGnb1Dc3he4VaQ4r/kawVL8vUaN2ZjDioP6fHO
         X8XlsL7YewYv61fZuyPohHEVrT1dvH0d1zeIi3BACuGZlHkXS5x2OrmUc1mKeC5LYM
         0UT5J00buzdAg==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alex Elder <elder@linaro.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Zhang Yanmin <yanmin.zhang@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] linux/kernel.h: split *_MAX and *_MIN macros into <linux/limits.h>
Date:   Sun,  3 Feb 2019 01:06:25 +0900
Message-Id: <1549123585-13800-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549123585-13800-1-git-send-email-yamada.masahiro@socionext.com>
References: <1549123585-13800-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<linux/kernel.h> tends to be cluttered because we often put various
sort of unrelated stuff in it. So, we have split out a sensible chunk
of code into a separate header from time to time.

This commit splits out the *_MAX and *_MIN defines.

The standard header <limits.h> contains various MAX, MIN constants
including numerial limits. [1]

So, I think it makes sense to move in-kernel MAX, MIN constants into
include/linux/limits.h.

We already have include/uapi/linux/limits.h to contain some user-space
constants. I changed its include guard to _UAPI_LINUX_LIMITS_H. This
change has no impact to the user-space because scripts/headers_install.sh
rips off the '_UAPI' prefix from the include guards of exported headers.

[1] http://pubs.opengroup.org/onlinepubs/009604499/basedefs/limits.h.html

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Alex Elder <elder@linaro.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Zhang Yanmin <yanmin.zhang@intel.com>
---

 include/linux/kernel.h      | 29 +----------------------------
 include/linux/limits.h      | 36 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/limits.h |  4 ++--
 3 files changed, 39 insertions(+), 30 deletions(-)
 create mode 100644 include/linux/limits.h

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 110bac1..b80b965 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -4,6 +4,7 @@
 
 
 #include <stdarg.h>
+#include <linux/limits.h>
 #include <linux/linkage.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
@@ -16,34 +17,6 @@
 #include <asm/byteorder.h>
 #include <uapi/linux/kernel.h>
 
-#define USHRT_MAX	((unsigned short)(~0U))
-#define SHRT_MAX	((short)(USHRT_MAX>>1))
-#define SHRT_MIN	((short)(-SHRT_MAX - 1))
-#define INT_MAX		((int)(~0U>>1))
-#define INT_MIN		(-INT_MAX - 1)
-#define UINT_MAX	(~0U)
-#define LONG_MAX	((long)(~0UL>>1))
-#define LONG_MIN	(-LONG_MAX - 1)
-#define ULONG_MAX	(~0UL)
-#define LLONG_MAX	((long long)(~0ULL>>1))
-#define LLONG_MIN	(-LLONG_MAX - 1)
-#define ULLONG_MAX	(~0ULL)
-#define SIZE_MAX	(~(size_t)0)
-#define PHYS_ADDR_MAX	(~(phys_addr_t)0)
-
-#define U8_MAX		((u8)~0U)
-#define S8_MAX		((s8)(U8_MAX>>1))
-#define S8_MIN		((s8)(-S8_MAX - 1))
-#define U16_MAX		((u16)~0U)
-#define S16_MAX		((s16)(U16_MAX>>1))
-#define S16_MIN		((s16)(-S16_MAX - 1))
-#define U32_MAX		((u32)~0U)
-#define S32_MAX		((s32)(U32_MAX>>1))
-#define S32_MIN		((s32)(-S32_MAX - 1))
-#define U64_MAX		((u64)~0ULL)
-#define S64_MAX		((s64)(U64_MAX>>1))
-#define S64_MIN		((s64)(-S64_MAX - 1))
-
 #define STACK_MAGIC	0xdeadbeef
 
 /**
diff --git a/include/linux/limits.h b/include/linux/limits.h
new file mode 100644
index 0000000..01aeb53
--- /dev/null
+++ b/include/linux/limits.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_LIMITS_H
+#define _LINUX_LIMITS_H
+
+#include <uapi/linux/limits.h>
+#include <linux/types.h>
+
+#define USHRT_MAX	((unsigned short)(~0U))
+#define SHRT_MAX	((short)(USHRT_MAX >> 1))
+#define SHRT_MIN	((short)(-SHRT_MAX - 1))
+#define INT_MAX		((int)(~0U >> 1))
+#define INT_MIN		(-INT_MAX - 1)
+#define UINT_MAX	(~0U)
+#define LONG_MAX	((long)(~0UL >> 1))
+#define LONG_MIN	(-LONG_MAX - 1)
+#define ULONG_MAX	(~0UL)
+#define LLONG_MAX	((long long)(~0ULL >> 1))
+#define LLONG_MIN	(-LLONG_MAX - 1)
+#define ULLONG_MAX	(~0ULL)
+#define SIZE_MAX	(~(size_t)0)
+#define PHYS_ADDR_MAX	(~(phys_addr_t)0)
+
+#define U8_MAX		((u8)~0U)
+#define S8_MAX		((s8)(U8_MAX >> 1))
+#define S8_MIN		((s8)(-S8_MAX - 1))
+#define U16_MAX		((u16)~0U)
+#define S16_MAX		((s16)(U16_MAX >> 1))
+#define S16_MIN		((s16)(-S16_MAX - 1))
+#define U32_MAX		((u32)~0U)
+#define S32_MAX		((s32)(U32_MAX >> 1))
+#define S32_MIN		((s32)(-S32_MAX - 1))
+#define U64_MAX		((u64)~0ULL)
+#define S64_MAX		((s64)(U64_MAX >> 1))
+#define S64_MIN		((s64)(-S64_MAX - 1))
+
+#endif /* _LINUX_LIMITS_H */
diff --git a/include/uapi/linux/limits.h b/include/uapi/linux/limits.h
index c3547f0..6bcbe30 100644
--- a/include/uapi/linux/limits.h
+++ b/include/uapi/linux/limits.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _LINUX_LIMITS_H
-#define _LINUX_LIMITS_H
+#ifndef _UAPI_LINUX_LIMITS_H
+#define _UAPI_LINUX_LIMITS_H
 
 #define NR_OPEN	        1024
 
-- 
2.7.4

