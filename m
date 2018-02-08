Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbeBHToY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 14:44:24 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49306 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbeBHToW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 14:44:22 -0500
Date: Thu, 8 Feb 2018 20:44:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>,
        kbuild test robot <fengguang.wu@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [linus:master] BUILD REGRESSION
 a2e5790d841658485d642196dbb0927303d6c22f
Message-ID: <20180208194406.GD25181@hirez.programming.kicks-ass.net>
References: <20180207183543.GA8897@pd.tnic>
 <20180207184933.GA25201@hirez.programming.kicks-ass.net>
 <CA+55aFzS7w2SgC1H0MKWecHyhnZPypqWNmwuWbf9X93SHareWg@mail.gmail.com>
 <20180207191451.GC25201@hirez.programming.kicks-ass.net>
 <20180207192816.GA19536@pd.tnic>
 <CA+55aFzSZzdVZXatze=xjGSwpOPO7kvbWnz7JiZ3sTx_2Pohjw@mail.gmail.com>
 <20180208091302.GD25201@hirez.programming.kicks-ass.net>
 <CA+55aFySLxYkUQyNf5YcEvitjm2O1whEp4-iKNASPaOpxG1j9w@mail.gmail.com>
 <20180208180357.GC25181@hirez.programming.kicks-ass.net>
 <CA+55aFx7=cw0myoidwzhEfKd_L2Q6u0=AdcH_ZBmXu2_nD=4Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFx7=cw0myoidwzhEfKd_L2Q6u0=AdcH_ZBmXu2_nD=4Jw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 10:15:30AM -0800, Linus Torvalds wrote:
> On Thu, Feb 8, 2018 at 10:03 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > But yes, for our purposes UD2 is perfectly fine too, it will just mess
> > up the people doing bringup and the like.
> 
> Oh, we'll inconvenience people inside Intel?
> 
> The same people who changed and screwed up the definition of UD0 just
> a couple of months ago?
> 
> I'm *so* sorry for the inconvenience to those people /s.
> 
> F*ck them. They introduced the problem, they get to live with it.

OK, here's the patch.. It leaves the UD0 in traps.c such that people
could recompile their kernel with a simple change.

---
Subject: x86: Use UD2 for WARN

Since the Intel SDM added an ModR/M byte to UD0 and binutils followed
that specification, we now cannot disassemble our kernel anymore.

This now mean Intel and AMD disagree on the encoding of UD0. And instead
of playing games with additional bytes that are valid ModR/M and single
byte instructions (0xd6 for instance), simply use UD2 for both WARN and
BUG.

Requested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/bug.h | 15 ++++++---------
 arch/x86/kernel/traps.c    |  2 +-
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 34d99af43994..2ea100e7a60f 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -5,23 +5,20 @@
 #include <linux/stringify.h>
 
 /*
- * Since some emulators terminate on UD2, we cannot use it for WARN.
- * Since various instruction decoders disagree on the length of UD1,
- * we cannot use it either. So use UD0 for WARN.
+ * Despite that some emulators terminate on UD2, we use it for WARN.
  *
- * (binutils knows about "ud1" but {en,de}codes it as 2 bytes, whereas
- *  our kernel decoder thinks it takes a ModRM byte, which seems consistent
- *  with various things like the Intel SDM instruction encoding rules)
+ * Since various instruction decoders/specs disagree on the encoding of
+ * UD0/UD1,
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
 
@@ -77,7 +74,7 @@ do {								\
 	unreachable();						\
 } while (0)
 
-#define __WARN_FLAGS(flags)	_BUG_FLAGS(ASM_UD0, BUGFLAG_WARNING|(flags))
+#define __WARN_FLAGS(flags)	_BUG_FLAGS(ASM_UD2, BUGFLAG_WARNING|(flags))
 
 #include <asm-generic/bug.h>
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 446c9ef8cfc3..3d9b2308e7fa 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -181,7 +181,7 @@ int fixup_bug(struct pt_regs *regs, int trapnr)
 		break;
 
 	case BUG_TRAP_TYPE_WARN:
-		regs->ip += LEN_UD0;
+		regs->ip += LEN_UD2;
 		return 1;
 	}
 
