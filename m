Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752911AbeDQOHc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:07:32 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:39558 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752387AbeDQOHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:07:30 -0400
From: Matt Redfearn <matt.redfearn@mips.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC: <linux-mips@linux-mips.org>, Matt Redfearn <matt.redfearn@mips.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] MIPS: memset.S: Reinstate delay slot indentation
Date: Tue, 17 Apr 2018 15:06:12 +0100
Message-ID: <1523973972-25633-3-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523973972-25633-1-git-send-email-matt.redfearn@mips.com>
References: <1523973972-25633-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1523973990-452060-18537-58458-3
X-BESS-VER: 2018.4.1-r1804121648
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192082
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assembly language within the MIPS kernel conventionally indents
instructions which are in a branch delay slot to make them easier to
see. Commit 8483b14aaa81 ("MIPS: lib: memset: Whitespace fixes") rather
inexplicably removed all of these indentations from memset.S. Reinstate
the convention for all instructions in a branch delay slot. This
effectively reverts the above commit, plus other locations introduced
with MIPSR6 support.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 arch/mips/lib/memset.S | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index 84e91f4fdf53..085cc86f624f 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -95,7 +95,7 @@
 
 	sltiu		t0, a2, STORSIZE	/* very small region? */
 	bnez		t0, .Lsmall_memset\@
-	andi		t0, a0, STORMASK	/* aligned? */
+	 andi		t0, a0, STORMASK	/* aligned? */
 
 #ifdef CONFIG_CPU_MICROMIPS
 	move		t8, a1			/* used by 'swp' instruction */
@@ -103,12 +103,12 @@
 #endif
 #ifndef CONFIG_CPU_DADDI_WORKAROUNDS
 	beqz		t0, 1f
-	PTR_SUBU	t0, STORSIZE		/* alignment in bytes */
+	 PTR_SUBU	t0, STORSIZE		/* alignment in bytes */
 #else
 	.set		noat
 	li		AT, STORSIZE
 	beqz		t0, 1f
-	PTR_SUBU	t0, AT			/* alignment in bytes */
+	 PTR_SUBU	t0, AT			/* alignment in bytes */
 	.set		at
 #endif
 
@@ -149,7 +149,7 @@
 1:	ori		t1, a2, 0x3f		/* # of full blocks */
 	xori		t1, 0x3f
 	beqz		t1, .Lmemset_partial\@	/* no block to fill */
-	andi		t0, a2, 0x40-STORSIZE
+	 andi		t0, a2, 0x40-STORSIZE
 
 	PTR_ADDU	t1, a0			/* end address */
 	.set		reorder
@@ -174,7 +174,7 @@
 	.set		at
 #endif
 	jr		t1
-	PTR_ADDU	a0, t0			/* dest ptr */
+	 PTR_ADDU	a0, t0			/* dest ptr */
 
 	.set		push
 	.set		noreorder
@@ -186,7 +186,7 @@
 
 	beqz		a2, 1f
 #ifndef CONFIG_CPU_MIPSR6
-	PTR_ADDU	a0, a2			/* What's left */
+	 PTR_ADDU	a0, a2			/* What's left */
 	R10KCBARRIER(0(ra))
 #ifdef __MIPSEB__
 	EX(LONG_S_R, a1, -1(a0), .Llast_fixup\@)
@@ -194,7 +194,7 @@
 	EX(LONG_S_L, a1, -1(a0), .Llast_fixup\@)
 #endif
 #else
-	PTR_SUBU	t0, $0, a2
+	 PTR_SUBU	t0, $0, a2
 	PTR_ADDIU	t0, 1
 	STORE_BYTE(0)
 	STORE_BYTE(1)
@@ -210,11 +210,11 @@
 0:
 #endif
 1:	jr		ra
-	move		a2, zero
+	 move		a2, zero
 
 .Lsmall_memset\@:
 	beqz		a2, 2f
-	PTR_ADDU	t1, a0, a2
+	 PTR_ADDU	t1, a0, a2
 
 1:	PTR_ADDIU	a0, 1			/* fill bytewise */
 	R10KCBARRIER(0(ra))
@@ -222,7 +222,7 @@
 	 EX(sb, a1, -1(a0), .Lsmall_fixup\@)
 
 2:	jr		ra			/* done */
-	move		a2, zero
+	 move		a2, zero
 	.if __memset == 1
 	END(memset)
 	.set __memset, 0
@@ -238,7 +238,7 @@
 
 .Lfirst_fixup\@:
 	jr	ra
-	nop
+	 nop
 
 .Lfwd_fixup\@:
 	PTR_L		t0, TI_TASK($28)
@@ -246,7 +246,7 @@
 	LONG_L		t0, THREAD_BUADDR(t0)
 	LONG_ADDU	a2, t1
 	jr		ra
-	LONG_SUBU	a2, t0
+	 LONG_SUBU	a2, t0
 
 .Lpartial_fixup\@:
 	PTR_L		t0, TI_TASK($28)
@@ -278,7 +278,7 @@
 LEAF(memset)
 EXPORT_SYMBOL(memset)
 	beqz		a1, 1f
-	move		v0, a0			/* result */
+	 move		v0, a0			/* result */
 
 	andi		a1, 0xff		/* spread fillword */
 	LONG_SLL		t1, a1, 8
-- 
2.7.4
