Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754264AbeEWHEK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 03:04:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:63944 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754042AbeEWHEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 03:04:06 -0400
Message-Id: <484449fcfad0f718ce6d63a056d2aafc073991e7.1527058932.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/mm: Use instruction symbolic names in
 store_updates_sp()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 23 May 2018 09:04:04 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use symbolic names defined in asm/ppc-opcode.h
instead of hardcoded values.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 Resending as inpependant of the do_page_fault() stuff

 arch/powerpc/include/asm/ppc-opcode.h |  1 +
 arch/powerpc/mm/fault.c               | 26 +++++++++++++-------------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 18883b8a6dac..4436887bc415 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -162,6 +162,7 @@
 /* VMX Vector Store Instructions */
 #define OP_31_XOP_STVX          231
 
+#define OP_31   31
 #define OP_LWZ  32
 #define OP_STFS 52
 #define OP_STFSU 53
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index c01d627e687a..0c99f9b45e8f 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -80,23 +80,23 @@ static bool store_updates_sp(struct pt_regs *regs)
 		return false;
 	/* check major opcode */
 	switch (inst >> 26) {
-	case 37:	/* stwu */
-	case 39:	/* stbu */
-	case 45:	/* sthu */
-	case 53:	/* stfsu */
-	case 55:	/* stfdu */
+	case OP_STWU:
+	case OP_STBU:
+	case OP_STHU:
+	case OP_STFSU:
+	case OP_STFDU:
 		return true;
-	case 62:	/* std or stdu */
+	case OP_STD:	/* std or stdu */
 		return (inst & 3) == 1;
-	case 31:
+	case OP_31:
 		/* check minor opcode */
 		switch ((inst >> 1) & 0x3ff) {
-		case 181:	/* stdux */
-		case 183:	/* stwux */
-		case 247:	/* stbux */
-		case 439:	/* sthux */
-		case 695:	/* stfsux */
-		case 759:	/* stfdux */
+		case OP_31_XOP_STDUX:
+		case OP_31_XOP_STWUX:
+		case OP_31_XOP_STBUX:
+		case OP_31_XOP_STHUX:
+		case OP_31_XOP_STFSUX:
+		case OP_31_XOP_STFDUX:
 			return true;
 		}
 	}
-- 
2.13.3
