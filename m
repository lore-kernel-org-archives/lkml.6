Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85230C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48111214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="SteWWvxL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48111214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbeKLNAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 08:00:11 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:35038 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeKLNAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 08:00:11 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wAC37UKv026216;
        Mon, 12 Nov 2018 12:07:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wAC37UKv026216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541992051;
        bh=EQtZeS28ax5HpUb/J23GhibEmAIqFru8uBOxwQqeoXU=;
        h=From:To:Cc:Subject:Date:From;
        b=SteWWvxL+jWzGlye+zn54QpGvmG0absy/rqlZMLtv4cFJWzB5Ezy19/I9FA/Ra2+s
         6psxkj3Ko8kKmN6snWYZRfvgf1L0+I8I/hpbPVuVScPL8Lohh8x3BSJgGltYoQDOkM
         BQd+l+lFp58DeuCCwKmhe1Da/bRU0UXqnYkuYgex+TIKVhA4Y6o261+CCBZ8UuOy/T
         yfvtaps+rQw/i4Qz8z2j4wHgFsxfeZ6z66RFBen71JbZBQ8VYBMOsKEQthBPx+DdQI
         Yxm/Mclm85tRxQ0Y70ees455xo2hAOEZM3XVExKqQugtl+TC3p2tt0d/ny3aSeWHUN
         fjJzI5HPFlGLQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org, Sven Joachim <svenjoac@gmx.de>
Subject: [PATCH] x86: remove gcc-x86_*-has-stack-protector.sh checks
Date:   Mon, 12 Nov 2018 12:06:53 +0900
Message-Id: <1541992013-18657-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-x86_64-has-stack-protector.sh was introduced by commit 4f7fd4d7a791
("[PATCH] Add the -fstack-protector option to the CFLAGS") in 2006
to work around buggy compilers.

gcc-x86_32-has-stack-protector.sh was introduced by commit 60a5317ff0f4
("x86: implement x86_32 stack protector"), which did not clearly state
whether compilers were still producing broken code at that time.

Now, the minimum reuquired GCC version is 4.6, which was released in
2011. Probably, we can dump these old compiler checks.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/Kconfig                          | 10 +---------
 scripts/gcc-x86_32-has-stack-protector.sh |  4 ----
 scripts/gcc-x86_64-has-stack-protector.sh |  4 ----
 3 files changed, 1 insertion(+), 17 deletions(-)
 delete mode 100755 scripts/gcc-x86_32-has-stack-protector.sh
 delete mode 100755 scripts/gcc-x86_64-has-stack-protector.sh

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9d734f3..7240d50 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -187,7 +187,7 @@ config X86
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if X86_64 && (UNWINDER_FRAME_POINTER || UNWINDER_ORC) && STACK_VALIDATION
 	select HAVE_FUNCTION_ARG_ACCESS_API
-	select HAVE_STACKPROTECTOR		if CC_HAS_SANE_STACKPROTECTOR
+	select HAVE_STACKPROTECTOR
 	select HAVE_STACK_VALIDATION		if X86_64
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
@@ -352,14 +352,6 @@ config PGTABLE_LEVELS
 	default 3 if X86_PAE
 	default 2
 
-config CC_HAS_SANE_STACKPROTECTOR
-	bool
-	default $(success,$(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(CC)) if 64BIT
-	default $(success,$(srctree)/scripts/gcc-x86_32-has-stack-protector.sh $(CC))
-	help
-	   We have to make sure stack protector is unconditionally disabled if
-	   the compiler produces broken code.
-
 menu "Processor type and features"
 
 config ZONE_DMA
diff --git a/scripts/gcc-x86_32-has-stack-protector.sh b/scripts/gcc-x86_32-has-stack-protector.sh
deleted file mode 100755
index f5c1194..0000000
--- a/scripts/gcc-x86_32-has-stack-protector.sh
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m32 -O0 -fstack-protector - -o - 2> /dev/null | grep -q "%gs"
diff --git a/scripts/gcc-x86_64-has-stack-protector.sh b/scripts/gcc-x86_64-has-stack-protector.sh
deleted file mode 100755
index 75e4e22..0000000
--- a/scripts/gcc-x86_64-has-stack-protector.sh
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m64 -O0 -mcmodel=kernel -fno-PIE -fstack-protector - -o - 2> /dev/null | grep -q "%gs"
-- 
2.7.4

