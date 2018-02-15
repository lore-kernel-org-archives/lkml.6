Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032396AbeBOAhf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 19:37:35 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55263 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032244AbeBOAhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 19:37:33 -0500
Date: Wed, 14 Feb 2018 16:27:07 -0800
From: tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-3b3a371cc9bc980429baabe0a8e5f307f3d1f463@git.kernel.org>
Cc: mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        brgerst@gmail.com, luto@kernel.org, dvlasenk@redhat.com,
        arjan@linux.intel.com, hpa@zytor.com, bp@alien8.de,
        peterz@infradead.org, jpoimboe@redhat.com,
        torvalds@linux-foundation.org
Reply-To: torvalds@linux-foundation.org, bp@alien8.de, peterz@infradead.org,
        hpa@zytor.com, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        arjan@linux.intel.com, dvlasenk@redhat.com, brgerst@gmail.com
In-Reply-To: <20180208194406.GD25181@hirez.programming.kicks-ass.net>
References: <20180208194406.GD25181@hirez.programming.kicks-ass.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/debug: Use UD2 for WARN()
Git-Commit-ID: 3b3a371cc9bc980429baabe0a8e5f307f3d1f463
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3b3a371cc9bc980429baabe0a8e5f307f3d1f463
Gitweb:     https://git.kernel.org/tip/3b3a371cc9bc980429baabe0a8e5f307f3d1f463
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Fri, 9 Feb 2018 13:16:59 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 15 Feb 2018 01:15:50 +0100

x86/debug: Use UD2 for WARN()

Since the Intel SDM added an ModR/M byte to UD0 and binutils followed
that specification, we now cannot disassemble our kernel anymore.

This now means Intel and AMD disagree on the encoding of UD0. And instead
of playing games with additional bytes that are valid ModR/M and single
byte instructions (0xd6 for instance), simply use UD2 for both WARN() and
BUG().

Requested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180208194406.GD25181@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/bug.h | 15 ++++++---------
 arch/x86/kernel/traps.c    |  2 +-
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 71e6f4bf..6804d66 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -5,23 +5,20 @@
 #include <linux/stringify.h>
 
 /*
- * Since some emulators terminate on UD2, we cannot use it for WARN.
- * Since various instruction decoders disagree on the length of UD1,
- * we cannot use it either. So use UD0 for WARN.
+ * Despite that some emulators terminate on UD2, we use it for WARN().
  *
- * (binutils knows about "ud1" but {en,de}codes it as 2 bytes, whereas
- *  our kernel decoder thinks it takes a ModRM byte, which seems consistent
- *  with various things like the Intel SDM instruction encoding rules)
+ * Since various instruction decoders/specs disagree on the encoding of
+ * UD0/UD1.
  */
 
-#define ASM_UD0		".byte 0x0f, 0xff"
+#define ASM_UD0		".byte 0x0f, 0xff" /* + ModRM (for Intel) */
 #define ASM_UD1		".byte 0x0f, 0xb9" /* + ModRM */
 #define ASM_UD2		".byte 0x0f, 0x0b"
 
 #define INSN_UD0	0xff0f
 #define INSN_UD2	0x0b0f
 
-#define LEN_UD0		2
+#define LEN_UD2		2
 
 #ifdef CONFIG_GENERIC_BUG
 
@@ -79,7 +76,7 @@ do {								\
 
 #define __WARN_FLAGS(flags)					\
 do {								\
-	_BUG_FLAGS(ASM_UD0, BUGFLAG_WARNING|(flags));		\
+	_BUG_FLAGS(ASM_UD2, BUGFLAG_WARNING|(flags));		\
 	annotate_reachable();					\
 } while (0)
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 446c9ef..3d9b230 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -181,7 +181,7 @@ int fixup_bug(struct pt_regs *regs, int trapnr)
 		break;
 
 	case BUG_TRAP_TYPE_WARN:
-		regs->ip += LEN_UD0;
+		regs->ip += LEN_UD2;
 		return 1;
 	}
 
