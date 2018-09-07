Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4613BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09ED20645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F09ED20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbeIHCCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:02:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45138 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728581AbeIHCCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:02:23 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D70DCF07;
        Fri,  7 Sep 2018 21:19:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 4.18 095/145] xtensa: limit offsets in __loop_cache_{all,page}
Date:   Fri,  7 Sep 2018 23:09:21 +0200
Message-Id: <20180907210911.787911361@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Filippov <jcmvbkbc@gmail.com>

commit be75de25251f7cf3e399ca1f584716a95510d24a upstream.

When building kernel for xtensa cores with big cache lines (e.g. 128
bytes or more) __loop_cache_all and __loop_cache_page may generate
assembly instructions with immediate fields that are too big. This
results in the following build errors:

  arch/xtensa/mm/misc.S: Assembler messages:
  arch/xtensa/mm/misc.S:464: Error: operand 2 of 'diwbi' has invalid value '256'
  arch/xtensa/mm/misc.S:464: Error: operand 2 of 'diwbi' has invalid value '384'
  arch/xtensa/kernel/head.S: Assembler messages:
  arch/xtensa/kernel/head.S:172: Error: operand 2 of 'diu' has invalid value '256'
  arch/xtensa/kernel/head.S:172: Error: operand 2 of 'diu' has invalid value '384'
  arch/xtensa/kernel/head.S:176: Error: operand 2 of 'iiu' has invalid value '256'
  arch/xtensa/kernel/head.S:176: Error: operand 2 of 'iiu' has invalid value '384'
  arch/xtensa/kernel/head.S:255: Error: operand 2 of 'diwb' has invalid value '256'
  arch/xtensa/kernel/head.S:255: Error: operand 2 of 'diwb' has invalid value '384'

Add parameter max_immed to these macros and use it to limit values of
immediate operands. Extract common code of these macros into the new
macro __loop_cache_unroll.

Cc: stable@vger.kernel.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/xtensa/include/asm/cacheasm.h |   65 ++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 25 deletions(-)

--- a/arch/xtensa/include/asm/cacheasm.h
+++ b/arch/xtensa/include/asm/cacheasm.h
@@ -31,16 +31,32 @@
  *
  */
 
-	.macro	__loop_cache_all ar at insn size line_width
 
-	movi	\ar, 0
+	.macro	__loop_cache_unroll ar at insn size line_width max_immed
+
+	.if	(1 << (\line_width)) > (\max_immed)
+	.set	_reps, 1
+	.elseif	(2 << (\line_width)) > (\max_immed)
+	.set	_reps, 2
+	.else
+	.set	_reps, 4
+	.endif
+
+	__loopi	\ar, \at, \size, (_reps << (\line_width))
+	.set	_index, 0
+	.rep	_reps
+	\insn	\ar, _index << (\line_width)
+	.set	_index, _index + 1
+	.endr
+	__endla	\ar, \at, _reps << (\line_width)
+
+	.endm
+
 
-	__loopi	\ar, \at, \size, (4 << (\line_width))
-	\insn	\ar, 0 << (\line_width)
-	\insn	\ar, 1 << (\line_width)
-	\insn	\ar, 2 << (\line_width)
-	\insn	\ar, 3 << (\line_width)
-	__endla	\ar, \at, 4 << (\line_width)
+	.macro	__loop_cache_all ar at insn size line_width max_immed
+
+	movi	\ar, 0
+	__loop_cache_unroll \ar, \at, \insn, \size, \line_width, \max_immed
 
 	.endm
 
@@ -57,14 +73,9 @@
 	.endm
 
 
-	.macro	__loop_cache_page ar at insn line_width
+	.macro	__loop_cache_page ar at insn line_width max_immed
 
-	__loopi	\ar, \at, PAGE_SIZE, 4 << (\line_width)
-	\insn	\ar, 0 << (\line_width)
-	\insn	\ar, 1 << (\line_width)
-	\insn	\ar, 2 << (\line_width)
-	\insn	\ar, 3 << (\line_width)
-	__endla	\ar, \at, 4 << (\line_width)
+	__loop_cache_unroll \ar, \at, \insn, PAGE_SIZE, \line_width, \max_immed
 
 	.endm
 
@@ -72,7 +83,8 @@
 	.macro	___unlock_dcache_all ar at
 
 #if XCHAL_DCACHE_LINE_LOCKABLE && XCHAL_DCACHE_SIZE
-	__loop_cache_all \ar \at diu XCHAL_DCACHE_SIZE XCHAL_DCACHE_LINEWIDTH
+	__loop_cache_all \ar \at diu XCHAL_DCACHE_SIZE \
+		XCHAL_DCACHE_LINEWIDTH 240
 #endif
 
 	.endm
@@ -81,7 +93,8 @@
 	.macro	___unlock_icache_all ar at
 
 #if XCHAL_ICACHE_LINE_LOCKABLE && XCHAL_ICACHE_SIZE
-	__loop_cache_all \ar \at iiu XCHAL_ICACHE_SIZE XCHAL_ICACHE_LINEWIDTH
+	__loop_cache_all \ar \at iiu XCHAL_ICACHE_SIZE \
+		XCHAL_ICACHE_LINEWIDTH 240
 #endif
 
 	.endm
@@ -90,7 +103,8 @@
 	.macro	___flush_invalidate_dcache_all ar at
 
 #if XCHAL_DCACHE_SIZE
-	__loop_cache_all \ar \at diwbi XCHAL_DCACHE_SIZE XCHAL_DCACHE_LINEWIDTH
+	__loop_cache_all \ar \at diwbi XCHAL_DCACHE_SIZE \
+		XCHAL_DCACHE_LINEWIDTH 240
 #endif
 
 	.endm
@@ -99,7 +113,8 @@
 	.macro	___flush_dcache_all ar at
 
 #if XCHAL_DCACHE_SIZE
-	__loop_cache_all \ar \at diwb XCHAL_DCACHE_SIZE XCHAL_DCACHE_LINEWIDTH
+	__loop_cache_all \ar \at diwb XCHAL_DCACHE_SIZE \
+		XCHAL_DCACHE_LINEWIDTH 240
 #endif
 
 	.endm
@@ -109,7 +124,7 @@
 
 #if XCHAL_DCACHE_SIZE
 	__loop_cache_all \ar \at dii __stringify(DCACHE_WAY_SIZE) \
-			 XCHAL_DCACHE_LINEWIDTH
+			 XCHAL_DCACHE_LINEWIDTH 1020
 #endif
 
 	.endm
@@ -119,7 +134,7 @@
 
 #if XCHAL_ICACHE_SIZE
 	__loop_cache_all \ar \at iii __stringify(ICACHE_WAY_SIZE) \
-			 XCHAL_ICACHE_LINEWIDTH
+			 XCHAL_ICACHE_LINEWIDTH 1020
 #endif
 
 	.endm
@@ -166,7 +181,7 @@
 	.macro	___flush_invalidate_dcache_page ar as
 
 #if XCHAL_DCACHE_SIZE
-	__loop_cache_page \ar \as dhwbi XCHAL_DCACHE_LINEWIDTH
+	__loop_cache_page \ar \as dhwbi XCHAL_DCACHE_LINEWIDTH 1020
 #endif
 
 	.endm
@@ -175,7 +190,7 @@
 	.macro ___flush_dcache_page ar as
 
 #if XCHAL_DCACHE_SIZE
-	__loop_cache_page \ar \as dhwb XCHAL_DCACHE_LINEWIDTH
+	__loop_cache_page \ar \as dhwb XCHAL_DCACHE_LINEWIDTH 1020
 #endif
 
 	.endm
@@ -184,7 +199,7 @@
 	.macro	___invalidate_dcache_page ar as
 
 #if XCHAL_DCACHE_SIZE
-	__loop_cache_page \ar \as dhi XCHAL_DCACHE_LINEWIDTH
+	__loop_cache_page \ar \as dhi XCHAL_DCACHE_LINEWIDTH 1020
 #endif
 
 	.endm
@@ -193,7 +208,7 @@
 	.macro	___invalidate_icache_page ar as
 
 #if XCHAL_ICACHE_SIZE
-	__loop_cache_page \ar \as ihi XCHAL_ICACHE_LINEWIDTH
+	__loop_cache_page \ar \as ihi XCHAL_ICACHE_LINEWIDTH 1020
 #endif
 
 	.endm


