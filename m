Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751603AbeDXEQK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 00:16:10 -0400
Received: from ozlabs.org ([203.11.71.1]:48415 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750962AbeDXEQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 00:16:08 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com, msuchanek@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] powerpc/64s: Add barrier_nospec
Date: Tue, 24 Apr 2018 14:15:54 +1000
Message-Id: <20180424041559.32410-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Suchanek <msuchanek@suse.de>

A no-op form of ori (or immediate of 0 into r31 and the result stored
in r31) has been re-tasked as a speculation barrier. The instruction
only acts as a barrier on newer machines with appropriate firmware
support. On older CPUs it remains a harmless no-op.

Implement barrier_nospec using this instruction.

mpe: The semantics of the instruction are believed to be that it
prevents execution of subsequent instructions until preceding branches
have been fully resolved and are no longer executing speculatively.
There is no further documentation available at this time.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
mpe: Make it Book3S64 only, update comment & change log, add a
     memory clobber to the asm.
---
 arch/powerpc/include/asm/barrier.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index c7c63959ba91..e582d2c88092 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -76,6 +76,21 @@ do {									\
 	___p1;								\
 })
 
+#ifdef CONFIG_PPC_BOOK3S_64
+/*
+ * Prevent execution of subsequent instructions until preceding branches have
+ * been fully resolved and are no longer executing speculatively.
+ */
+#define barrier_nospec_asm ori 31,31,0
+
+// This also acts as a compiler barrier due to the memory clobber.
+#define barrier_nospec() asm (stringify_in_c(barrier_nospec_asm) ::: "memory")
+
+#else /* !CONFIG_PPC_BOOK3S_64 */
+#define barrier_nospec_asm
+#define barrier_nospec()
+#endif
+
 #include <asm-generic/barrier.h>
 
 #endif /* _ASM_POWERPC_BARRIER_H */
-- 
2.14.1
