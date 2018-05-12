Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750974AbeELIVX (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 04:21:23 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:37526 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbeELIVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 04:21:22 -0400
Date: Sat, 12 May 2018 18:21:16 +1000
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] powerpc: Fix "integer constant is too large" build failure
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-Id: <S1750974AbeELIVX/20180512082124Z+17@vger.kernel.org>

My powerpc-linux-gnu-gcc v4.4.5 compiler can't build a 32-bit kernel
any more:

arch/powerpc/lib/sstep.c: In function 'do_popcnt':
arch/powerpc/lib/sstep.c:1068: error: integer constant is too large for 'long' type
arch/powerpc/lib/sstep.c:1069: error: integer constant is too large for 'long' type
arch/powerpc/lib/sstep.c:1069: error: integer constant is too large for 'long' type
arch/powerpc/lib/sstep.c:1070: error: integer constant is too large for 'long' type
arch/powerpc/lib/sstep.c:1079: error: integer constant is too large for 'long' type
arch/powerpc/lib/sstep.c: In function 'do_prty':
arch/powerpc/lib/sstep.c:1117: error: integer constant is too large for 'long' type

This file gets compiled with -std=gnu89 which means a constant can be
given the type 'long' even if it won't fit. Fix the errors with a 'ULL'
suffix on the relevant constants.

Fixes: 2c979c489fee ("powerpc/lib/sstep: Add prty instruction emulation")
Fixes: dcbd19b48d31 ("powerpc/lib/sstep: Add popcnt instruction emulation")
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
This change was compile tested but not regression tested.
---
 arch/powerpc/lib/sstep.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 34d68f1b1b40..49427a3ee104 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1065,9 +1065,10 @@ static nokprobe_inline void do_popcnt(const struct pt_regs *regs,
 {
 	unsigned long long out = v1;
 
-	out -= (out >> 1) & 0x5555555555555555;
-	out = (0x3333333333333333 & out) + (0x3333333333333333 & (out >> 2));
-	out = (out + (out >> 4)) & 0x0f0f0f0f0f0f0f0f;
+	out -= (out >> 1) & 0x5555555555555555ULL;
+	out = (0x3333333333333333ULL & out) +
+	      (0x3333333333333333ULL & (out >> 2));
+	out = (out + (out >> 4)) & 0x0f0f0f0f0f0f0f0fULL;
 
 	if (size == 8) {	/* popcntb */
 		op->val = out;
@@ -1076,7 +1077,7 @@ static nokprobe_inline void do_popcnt(const struct pt_regs *regs,
 	out += out >> 8;
 	out += out >> 16;
 	if (size == 32) {	/* popcntw */
-		op->val = out & 0x0000003f0000003f;
+		op->val = out & 0x0000003f0000003fULL;
 		return;
 	}
 
@@ -1114,7 +1115,7 @@ static nokprobe_inline void do_prty(const struct pt_regs *regs,
 
 	res ^= res >> 16;
 	if (size == 32) {		/* prtyw */
-		op->val = res & 0x0000000100000001;
+		op->val = res & 0x0000000100000001ULL;
 		return;
 	}
 
-- 
2.16.1
