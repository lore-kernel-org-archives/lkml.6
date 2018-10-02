Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69747C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1DC206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D1DC206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeJBSdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:33:12 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:36828 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbeJBSdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:33:12 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23994586AbeJBLuQ0I31M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:50:16 +0200
Date:   Tue, 2 Oct 2018 12:50:16 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] MIPS: memset: Limit excessive `noreorder' assembly mode
 use
In-Reply-To: <alpine.LFD.2.21.1810020209310.20762@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.21.1810020337090.20762@eddie.linux-mips.org>
References: <alpine.LFD.2.21.1810020209310.20762@eddie.linux-mips.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrite to use the `reorder' assembly mode and remove manually scheduled 
delay slots except where GAS cannot schedule a delay-slot instruction 
due to a data dependency or a section switch (as is the case with the EX 
macro).  No change in machine code produced.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 arch/mips/lib/memset.S |   48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

linux-mips-memset-reorder.patch
Index: linux-20180930-3maxp-defconfig/arch/mips/lib/memset.S
===================================================================
--- linux-20180930-3maxp-defconfig.orig/arch/mips/lib/memset.S
+++ linux-20180930-3maxp-defconfig/arch/mips/lib/memset.S
@@ -78,7 +78,6 @@
 #endif
 	.endm
 
-	.set	noreorder
 	.align	5
 
 	/*
@@ -94,13 +93,16 @@
 	.endif
 
 	sltiu		t0, a2, STORSIZE	/* very small region? */
+	.set		noreorder
 	bnez		t0, .Lsmall_memset\@
 	 andi		t0, a0, STORMASK	/* aligned? */
+	.set		reorder
 
 #ifdef CONFIG_CPU_MICROMIPS
 	move		t8, a1			/* used by 'swp' instruction */
 	move		t9, a1
 #endif
+	.set		noreorder
 #ifndef CONFIG_CPU_DADDI_WORKAROUNDS
 	beqz		t0, 1f
 	 PTR_SUBU	t0, STORSIZE		/* alignment in bytes */
@@ -111,6 +113,7 @@
 	 PTR_SUBU	t0, AT			/* alignment in bytes */
 	.set		at
 #endif
+	.set		reorder
 
 #ifndef CONFIG_CPU_MIPSR6
 	R10KCBARRIER(0(ra))
@@ -125,8 +128,10 @@
 #else /* CONFIG_CPU_MIPSR6 */
 #define STORE_BYTE(N)				\
 	EX(sb, a1, N(a0), .Lbyte_fixup\@);	\
+	.set		noreorder;		\
 	beqz		t0, 0f;			\
-	PTR_ADDU	t0, 1;
+	 PTR_ADDU	t0, 1;			\
+	.set		reorder;
 
 	PTR_ADDU	a2, t0			/* correct size */
 	PTR_ADDU	t0, 1
@@ -148,16 +153,14 @@
 #endif /* CONFIG_CPU_MIPSR6 */
 1:	ori		t1, a2, 0x3f		/* # of full blocks */
 	xori		t1, 0x3f
+	andi		t0, a2, 0x40-STORSIZE
 	beqz		t1, .Lmemset_partial\@	/* no block to fill */
-	 andi		t0, a2, 0x40-STORSIZE
 
 	PTR_ADDU	t1, a0			/* end address */
-	.set		reorder
 1:	PTR_ADDIU	a0, 64
 	R10KCBARRIER(0(ra))
 	f_fill64 a0, -64, FILL64RG, .Lfwd_fixup\@, \mode
 	bne		t1, a0, 1b
-	.set		noreorder
 
 .Lmemset_partial\@:
 	R10KCBARRIER(0(ra))
@@ -173,20 +176,18 @@
 	PTR_SUBU	t1, AT
 	.set		at
 #endif
+	PTR_ADDU	a0, t0			/* dest ptr */
 	jr		t1
-	 PTR_ADDU	a0, t0			/* dest ptr */
 
-	.set		push
-	.set		noreorder
-	.set		nomacro
 	/* ... but first do longs ... */
 	f_fill64 a0, -64, FILL64RG, .Lpartial_fixup\@, \mode
-2:	.set		pop
-	andi		a2, STORMASK		/* At most one long to go */
+2:	andi		a2, STORMASK		/* At most one long to go */
 
+	.set		noreorder
 	beqz		a2, 1f
 #ifndef CONFIG_CPU_MIPSR6
 	 PTR_ADDU	a0, a2			/* What's left */
+	.set		reorder
 	R10KCBARRIER(0(ra))
 #ifdef __MIPSEB__
 	EX(LONG_S_R, a1, -1(a0), .Llast_fixup\@)
@@ -195,6 +196,7 @@
 #endif
 #else
 	 PTR_SUBU	t0, $0, a2
+	.set		reorder
 	move		a2, zero		/* No remaining longs */
 	PTR_ADDIU	t0, 1
 	STORE_BYTE(0)
@@ -210,20 +212,22 @@
 #endif
 0:
 #endif
-1:	jr		ra
-	 move		a2, zero
+1:	move		a2, zero
+	jr		ra
 
 .Lsmall_memset\@:
+	PTR_ADDU	t1, a0, a2
 	beqz		a2, 2f
-	 PTR_ADDU	t1, a0, a2
 
 1:	PTR_ADDIU	a0, 1			/* fill bytewise */
 	R10KCBARRIER(0(ra))
+	.set		noreorder
 	bne		t1, a0, 1b
 	 EX(sb, a1, -1(a0), .Lsmall_fixup\@)
+	.set		reorder
 
-2:	jr		ra			/* done */
-	 move		a2, zero
+2:	move		a2, zero
+	jr		ra			/* done */
 	.if __memset == 1
 	END(memset)
 	.set __memset, 0
@@ -237,14 +241,13 @@
 	 *      a2     =             a2                -              t0                   + 1
 	 */
 	PTR_SUBU	a2, t0
+	PTR_ADDIU	a2, 1
 	jr		ra
-	 PTR_ADDIU	a2, 1
 #endif /* CONFIG_CPU_MIPSR6 */
 
 .Lfirst_fixup\@:
 	/* unset_bytes already in a2 */
 	jr	ra
-	 nop
 
 .Lfwd_fixup\@:
 	/*
@@ -255,8 +258,8 @@
 	andi		a2, 0x3f
 	LONG_L		t0, THREAD_BUADDR(t0)
 	LONG_ADDU	a2, t1
+	LONG_SUBU	a2, t0
 	jr		ra
-	 LONG_SUBU	a2, t0
 
 .Lpartial_fixup\@:
 	/*
@@ -267,24 +270,21 @@
 	andi		a2, STORMASK
 	LONG_L		t0, THREAD_BUADDR(t0)
 	LONG_ADDU	a2, a0
+	LONG_SUBU	a2, t0
 	jr		ra
-	 LONG_SUBU	a2, t0
 
 .Llast_fixup\@:
 	/* unset_bytes already in a2 */
 	jr		ra
-	 nop
 
 .Lsmall_fixup\@:
 	/*
 	 * unset_bytes = end_addr - current_addr + 1
 	 *      a2     =    t1    -      a0      + 1
 	 */
-	.set		reorder
 	PTR_SUBU	a2, t1, a0
 	PTR_ADDIU	a2, 1
 	jr		ra
-	.set		noreorder
 
 	.endm
 
@@ -298,8 +298,8 @@
 
 LEAF(memset)
 EXPORT_SYMBOL(memset)
+	move		v0, a0			/* result */
 	beqz		a1, 1f
-	 move		v0, a0			/* result */
 
 	andi		a1, 0xff		/* spread fillword */
 	LONG_SLL		t1, a1, 8
