Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755548AbeDXEQW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 00:16:22 -0400
Received: from ozlabs.org ([203.11.71.1]:38691 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750962AbeDXEQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 00:16:12 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com, msuchanek@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] powerpc/64: Use barrier_nospec in syscall entry
Date: Tue, 24 Apr 2018 14:15:59 +1000
Message-Id: <20180424041559.32410-6-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180424041559.32410-1-mpe@ellerman.id.au>
References: <20180424041559.32410-1-mpe@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our syscall entry is done in assembly so patch in an explicit
barrier_nospec.

Based on a patch by Michal Suchanek.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
mpe: Move the barrier to immediately prior to the vulnerable load,
     and add a comment trying to explain why. Drop the barrier from
     syscall_dotrace, because that syscall number comes from the
     kernel.
---
 arch/powerpc/kernel/entry_64.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 51695608c68b..de30f9a34c0c 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -36,6 +36,7 @@
 #include <asm/context_tracking.h>
 #include <asm/tm.h>
 #include <asm/ppc-opcode.h>
+#include <asm/barrier.h>
 #include <asm/export.h>
 #ifdef CONFIG_PPC_BOOK3S
 #include <asm/exception-64s.h>
@@ -178,6 +179,15 @@ system_call:			/* label this so stack traces look sane */
 	clrldi	r8,r8,32
 15:
 	slwi	r0,r0,4
+
+	barrier_nospec_asm
+	/*
+	 * Prevent the load of the handler below (based on the user-passed
+	 * system call number) being speculatively executed until the test
+	 * against NR_syscalls and branch to .Lsyscall_enosys above has
+	 * committed.
+	 */
+
 	ldx	r12,r11,r0	/* Fetch system call handler [ptr] */
 	mtctr   r12
 	bctrl			/* Call handler */
-- 
2.14.1
