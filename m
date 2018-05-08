Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753954AbeEHDAk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 23:00:40 -0400
Received: from exmail.andestech.com ([59.124.169.137]:21712 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753869AbeEHDAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 23:00:39 -0400
From: Alan Kao <alankao@andestech.com>
To: Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Alan Kao <alankao@andestech.com>,
        Greentime Hu <greentime@andestech.com>, Zong Li <zong@andestech.com>,
        Vincent Chen <vincentc@andestech.com>
Subject: [PATCH] riscv: Fix the bug in memory access fixup code
Date: Tue, 8 May 2018 10:59:33 +0800
Message-ID: <1525748373-3841-1-git-send-email-alankao@andestech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w482pw5H020985
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A piece of fixup code is currently shared by __copy_user and
__clear_user.  It first disables the access to user-space memory
and then returns the "n" argument, which represents #(bytes not processed).
However,__copy_user's "n" is in register a2, while __clear_user's in a1,
and thus it causes errors for programs like setdomainname02 testcase in LTP.

This patch fixes this issue by separating their fixup code and returning
the right value for the kernel to handle a relative fault properly.

Signed-off-by: Alan Kao <alankao@andestech.com>
Cc: Greentime Hu <greentime@andestech.com>
Cc: Zong Li <zong@andestech.com>
Cc: Vincent Chen <vincentc@andestech.com>
---
 arch/riscv/lib/uaccess.S | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
index 58fb2877c865..0173ea296baa 100644
--- a/arch/riscv/lib/uaccess.S
+++ b/arch/riscv/lib/uaccess.S
@@ -84,7 +84,7 @@ ENTRY(__clear_user)
 	bgeu t0, t1, 2f
 	bltu a0, t0, 4f
 1:
-	fixup REG_S, zero, (a0), 10f
+	fixup REG_S, zero, (a0), 11f
 	addi a0, a0, SZREG
 	bltu a0, t1, 1b
 2:
@@ -96,12 +96,12 @@ ENTRY(__clear_user)
 	li a0, 0
 	ret
 4: /* Edge case: unalignment */
-	fixup sb, zero, (a0), 10f
+	fixup sb, zero, (a0), 11f
 	addi a0, a0, 1
 	bltu a0, t0, 4b
 	j 1b
 5: /* Edge case: remainder */
-	fixup sb, zero, (a0), 10f
+	fixup sb, zero, (a0), 11f
 	addi a0, a0, 1
 	bltu a0, a3, 5b
 	j 3b
@@ -109,9 +109,14 @@ ENDPROC(__clear_user)
 
 	.section .fixup,"ax"
 	.balign 4
+	/* Fixup code for __copy_user(10) and __clear_user(11) */
 10:
 	/* Disable access to user memory */
 	csrs sstatus, t6
-	sub a0, a3, a0
+	mv a0, a2
+	ret
+11:
+	csrs sstatus, t6
+	mv a0, a1
 	ret
 	.previous
-- 
2.17.0
