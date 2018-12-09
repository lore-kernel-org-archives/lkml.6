Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E84C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E302081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E302081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbeLIWHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:07:54 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37254 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727925AbeLIWHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:07:47 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73C-0002ia-9k; Sun, 09 Dec 2018 21:55:46 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72d-0003OC-Dx; Sun, 09 Dec 2018 21:55:11 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Max Filippov" <jcmvbkbc@gmail.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.451716203@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 136/328] xtensa: limit offsets in __loop_cache_{all,page}
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

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

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/xtensa/include/asm/cacheasm.h | 65 ++++++++++++++++++------------
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
 
@@ -73,7 +84,8 @@
 
 	.macro	___unlock_dcache_all ar at
 
-	__loop_cache_all \ar \at diu XCHAL_DCACHE_SIZE XCHAL_DCACHE_LINEWIDTH
+	__loop_cache_all \ar \at diu XCHAL_DCACHE_SIZE \
+		XCHAL_DCACHE_LINEWIDTH 240
 
 	.endm
 
@@ -83,21 +95,24 @@
 
 	.macro	___unlock_icache_all ar at
 
-	__loop_cache_all \ar \at iiu XCHAL_ICACHE_SIZE XCHAL_ICACHE_LINEWIDTH
+	__loop_cache_all \ar \at iiu XCHAL_ICACHE_SIZE \
+		XCHAL_ICACHE_LINEWIDTH 240
 
 	.endm
 #endif
 
 	.macro	___flush_invalidate_dcache_all ar at
 
-	__loop_cache_all \ar \at diwbi XCHAL_DCACHE_SIZE XCHAL_DCACHE_LINEWIDTH
+	__loop_cache_all \ar \at diwbi XCHAL_DCACHE_SIZE \
+		XCHAL_DCACHE_LINEWIDTH 240
 
 	.endm
 
 
 	.macro	___flush_dcache_all ar at
 
-	__loop_cache_all \ar \at diwb XCHAL_DCACHE_SIZE XCHAL_DCACHE_LINEWIDTH
+	__loop_cache_all \ar \at diwb XCHAL_DCACHE_SIZE \
+		XCHAL_DCACHE_LINEWIDTH 240
 
 	.endm
 
@@ -105,7 +120,7 @@
 	.macro	___invalidate_dcache_all ar at
 
 	__loop_cache_all \ar \at dii __stringify(DCACHE_WAY_SIZE) \
-			 XCHAL_DCACHE_LINEWIDTH
+			 XCHAL_DCACHE_LINEWIDTH 1020
 
 	.endm
 
@@ -113,7 +128,7 @@
 	.macro	___invalidate_icache_all ar at
 
 	__loop_cache_all \ar \at iii __stringify(ICACHE_WAY_SIZE) \
-			 XCHAL_ICACHE_LINEWIDTH
+			 XCHAL_ICACHE_LINEWIDTH 1020
 
 	.endm
 
@@ -150,27 +165,27 @@
 
 	.macro	___flush_invalidate_dcache_page ar as
 
-	__loop_cache_page \ar \as dhwbi XCHAL_DCACHE_LINEWIDTH
+	__loop_cache_page \ar \as dhwbi XCHAL_DCACHE_LINEWIDTH 1020
 
 	.endm
 
 
 	.macro ___flush_dcache_page ar as
 
-	__loop_cache_page \ar \as dhwb XCHAL_DCACHE_LINEWIDTH
+	__loop_cache_page \ar \as dhwb XCHAL_DCACHE_LINEWIDTH 1020
 
 	.endm
 
 
 	.macro	___invalidate_dcache_page ar as
 
-	__loop_cache_page \ar \as dhi XCHAL_DCACHE_LINEWIDTH
+	__loop_cache_page \ar \as dhi XCHAL_DCACHE_LINEWIDTH 1020
 
 	.endm
 
 
 	.macro	___invalidate_icache_page ar as
 
-	__loop_cache_page \ar \as ihi XCHAL_ICACHE_LINEWIDTH
+	__loop_cache_page \ar \as ihi XCHAL_ICACHE_LINEWIDTH 1020
 
 	.endm

