Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753012AbeEPKGu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:06:50 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:26441 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753135AbeEPKFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:05:47 -0400
Message-Id: <3e89614babdc552bac10303aa5d63808ef7665db.1526464250.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1526464250.git.christophe.leroy@c-s.fr>
References: <cover.1526464250.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 11/14] powerpc/8xx: Free up SPRN_SPRG_SCRATCH2
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 16 May 2018 12:05:45 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can now use SPRN_M_TW in the DAR Fixup code, freeing
SPRN_SPRG_SCRATCH2

Then SPRN_SPRG_SCRATCH2 may be used for something else in the future.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 0c3cfaa4e6f3..f65bd6fd1572 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -624,7 +624,7 @@ InstructionBreakpoint:
  /* define if you don't want to use self modifying code */
 #define NO_SELF_MODIFYING_CODE
 FixupDAR:/* Entry point for dcbx workaround. */
-	mtspr	SPRN_SPRG_SCRATCH2, r10
+	mtspr	SPRN_M_TW, r10
 	/* fetch instruction from memory. */
 	mfspr	r10, SPRN_SRR0
 	mtspr	SPRN_MD_EPN, r10
@@ -668,7 +668,7 @@ _ENTRY(FixupDAR_cmp)
 	beq+	142f
 	cmpwi	cr0, r10, 1964	/* Is icbi? */
 	beq+	142f
-141:	mfspr	r10,SPRN_SPRG_SCRATCH2
+141:	mfspr	r10,SPRN_M_TW
 	b	DARFixed	/* Nope, go back to normal TLB processing */
 
 200:
@@ -703,7 +703,7 @@ modified_instr:
 	bne+	143f
 	subf	r10,r0,r10	/* r10=r10-r0, only if reg RA is r0 */
 143:	mtdar	r10		/* store faulting EA in DAR */
-	mfspr	r10,SPRN_SPRG_SCRATCH2
+	mfspr	r10,SPRN_M_TW
 	b	DARFixed	/* Go back to normal TLB handling */
 #else
 	mfctr	r10
@@ -757,7 +757,7 @@ modified_instr:
 	mfdar	r11
 	mtctr	r11			/* restore ctr reg from DAR */
 	mtdar	r10			/* save fault EA to DAR */
-	mfspr	r10,SPRN_SPRG_SCRATCH2
+	mfspr	r10,SPRN_M_TW
 	b	DARFixed		/* Go back to normal TLB handling */
 
 	/* special handling for r10,r11 since these are modified already */
-- 
2.13.3
