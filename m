Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6869C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE2320685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Yafmn75o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE2320685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391998AbeKVNxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 08:53:07 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:51398 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732521AbeKVNxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 08:53:07 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wAM3EZ3E004964;
        Thu, 22 Nov 2018 12:14:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wAM3EZ3E004964
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542856476;
        bh=9OSyc5/6h79up3LZctr0MsZesAr0KVm6SQ4LlSnW5bY=;
        h=From:To:Cc:Subject:Date:From;
        b=Yafmn75oaOyr5NJXB53AXKyKEQ82YStVfgyWMUh75FHve14O2bMsA5BjYpzudQMbY
         zkeRiHteRqa3gn1Wjhu34jbQdOR2LsEjo1KY0ii3hZvpKa9F9MbX24ZDOfT6g93uRr
         ISZLKNlsMEbC3lCjGenOi875bafdv0twO7Ema2m0VabWiqc3G0E/INYb6737S++9bs
         dJnf3+9ZRoAuAM55XWUKbGPUYr981WISiRuMgXnl2U3xpbrcsQBBqg68GeRHn7vpdc
         hjiLt8NR7DW0uKc2ZJJ7PKGIalBNr9YOM9qUlU4FfreESbPi6S7OSdyXKYBrXjNUwK
         ZV236b42ZavRQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org, NeilBrown <neilb@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Crt Mori <cmo@melexis.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v4 1/3] kernel.h: disable type-checks in container_of() for Sparse
Date:   Thu, 22 Nov 2018 12:14:20 +0900
Message-Id: <1542856462-18836-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I tried to enable BUILD_BUG_ON for Sparse, the kbuild test robot
reported lots of "unknown expression" warnings from container_of(),
which seemed false positive.

I addressed this in [1], but fixing Sparse is the right thing to do.

The issue was fixed by Sparse commit 0eb8175d3e9c ("fix expansion of
function designator"), but it will take time until the fixed version
of Sparse is widely available.

Disable the container_of() type checks for Sparse for now.

[1] https://lore.kernel.org/lkml/1542623503-3755-1-git-send-email-yamada.masahiro@socionext.com/

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v4:
  - New patch

Changes in v3: None
Changes in v2: None

 include/linux/kernel.h | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d6aac75..d8c4adb 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -985,6 +985,21 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
 #define __CONCAT(a, b) a ## b
 #define CONCATENATE(a, b) __CONCAT(a, b)
 
+/*
+ * TODO:
+ * Sparse emits "unknown expression" warnings.
+ * It was fixed by commit 0eb8175d3e9c0d20354763d07ce3d4c0e543d988 in Sparse.
+ * Remove the following workaround when the fixed Sparse is widely available.
+ */
+#ifdef __CHECKER__
+#define TYPE_CHECK_CONTAINER_OF(ptr, type, member)	do {} while (0)
+#else
+#define TYPE_CHECK_CONTAINER_OF(ptr, type, member) \
+	BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&	\
+			 !__same_type(*(ptr), void),			\
+			 "pointer type mismatch in container_of()")
+#endif
+
 /**
  * container_of - cast a member of a structure out to the containing structure
  * @ptr:	the pointer to the member.
@@ -994,9 +1009,7 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
  */
 #define container_of(ptr, type, member) ({				\
 	void *__mptr = (void *)(ptr);					\
-	BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&	\
-			 !__same_type(*(ptr), void),			\
-			 "pointer type mismatch in container_of()");	\
+	TYPE_CHECK_CONTAINER_OF(ptr, type, member);			\
 	((type *)(__mptr - offsetof(type, member))); })
 
 /**
@@ -1009,9 +1022,7 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
  */
 #define container_of_safe(ptr, type, member) ({				\
 	void *__mptr = (void *)(ptr);					\
-	BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&	\
-			 !__same_type(*(ptr), void),			\
-			 "pointer type mismatch in container_of()");	\
+	TYPE_CHECK_CONTAINER_OF(ptr, type, member);			\
 	IS_ERR_OR_NULL(__mptr) ? ERR_CAST(__mptr) :			\
 		((type *)(__mptr - offsetof(type, member))); })
 
-- 
2.7.4

