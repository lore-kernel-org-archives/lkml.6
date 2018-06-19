Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED6BC1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08EF20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08EF20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754560AbeFTDFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 23:05:36 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:58289 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754093AbeFTDDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 23:03:42 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 19 Jun 2018 20:03:06 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 26C8940DED;
        Tue, 19 Jun 2018 20:03:40 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v5 4/9] x86: alternatives: macrofy locks for better inlining
Date:   Tue, 19 Jun 2018 12:48:49 -0700
Message-ID: <20180619194854.69486-5-namit@vmware.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180619194854.69486-1-namit@vmware.com>
References: <20180619194854.69486-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC considers the number of statements in inlined assembly blocks,
according to new-lines and semicolons, as an indication to the cost of
the block in time and space. This data is distorted by the kernel code,
which puts information in alternative sections. As a result, the
compiler may perform incorrect inlining and branch optimizations.

The solution is to set an assembly macro and call it from the inlined
assembly block. As a result GCC considers the inline assembly block as
a single instruction.

This patch handles the LOCK prefix, allowing more aggresive inlining.

   text	   data	    bss	    dec	    hex	filename
18140140 10225284 2957312 31322736 1ddf270 ./vmlinux before
18146889 10225380 2957312 31329581 1de0d2d ./vmlinux after (+6845)

Static text symbols:
Before:	40286
After:	40218	(-68)

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Josh Poimboeuf <jpoimboe@redhat.com>

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/alternative-asm.h | 20 ++++++++++++++------
 arch/x86/include/asm/alternative.h     | 11 ++---------
 arch/x86/kernel/macros.S               |  1 +
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/alternative-asm.h b/arch/x86/include/asm/alternative-asm.h
index 31b627b43a8e..8e4ea39e55d0 100644
--- a/arch/x86/include/asm/alternative-asm.h
+++ b/arch/x86/include/asm/alternative-asm.h
@@ -7,16 +7,24 @@
 #include <asm/asm.h>
 
 #ifdef CONFIG_SMP
-	.macro LOCK_PREFIX
-672:	lock
+.macro LOCK_PREFIX_HERE
 	.pushsection .smp_locks,"a"
 	.balign 4
-	.long 672b - .
+	.long 671f - .		# offset
 	.popsection
-	.endm
+671:
+.endm
+
+.macro LOCK_PREFIX insn:vararg
+	LOCK_PREFIX_HERE
+	lock \insn
+.endm
 #else
-	.macro LOCK_PREFIX
-	.endm
+.macro LOCK_PREFIX_HERE
+.endm
+
+.macro LOCK_PREFIX insn:vararg
+.endm
 #endif
 
 /*
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 4cd6a3b71824..d7faa16622d8 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -31,15 +31,8 @@
  */
 
 #ifdef CONFIG_SMP
-#define LOCK_PREFIX_HERE \
-		".pushsection .smp_locks,\"a\"\n"	\
-		".balign 4\n"				\
-		".long 671f - .\n" /* offset */		\
-		".popsection\n"				\
-		"671:"
-
-#define LOCK_PREFIX LOCK_PREFIX_HERE "\n\tlock; "
-
+#define LOCK_PREFIX_HERE "LOCK_PREFIX_HERE\n\t"
+#define LOCK_PREFIX "LOCK_PREFIX "
 #else /* ! CONFIG_SMP */
 #define LOCK_PREFIX_HERE ""
 #define LOCK_PREFIX ""
diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
index f1fe1d570365..852487a9fc56 100644
--- a/arch/x86/kernel/macros.S
+++ b/arch/x86/kernel/macros.S
@@ -8,3 +8,4 @@
 
 #include <linux/compiler.h>
 #include <asm/refcount.h>
+#include <asm/alternative-asm.h>
-- 
2.17.0

