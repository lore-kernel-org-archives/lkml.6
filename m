Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753944AbeE1HKG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 03:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753694AbeE1HKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 03:10:00 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@redhat.com>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>, linux-arch@vger.kernel.org
Subject: [PATCH -tip v4 20/27] MIPS: kprobes: Don't call the ->break_handler() in MIPS kprobes code
Date: Mon, 28 May 2018 16:09:33 +0900
Message-Id: <152749137377.15132.7935753657096073570.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152749074878.15132.16693721906742461289.stgit@devbox>
References: <152749074878.15132.16693721906742461289.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't call the ->break_handler() from the MIPS kprobes code,
because it was only used by jprobes which got removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/mips/kernel/kprobes.c |   21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
index efdcd0b1ce12..7fd277bc59b9 100644
--- a/arch/mips/kernel/kprobes.c
+++ b/arch/mips/kernel/kprobes.c
@@ -326,19 +326,13 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
 				preempt_enable_no_resched();
 			}
 			return 1;
-		} else {
-			if (addr->word != breakpoint_insn.word) {
-				/*
-				 * The breakpoint instruction was removed by
-				 * another cpu right after we hit, no further
-				 * handling of this interrupt is appropriate
-				 */
-				ret = 1;
-				goto no_kprobe;
-			}
-			p = __this_cpu_read(current_kprobe);
-			if (p->break_handler && p->break_handler(p, regs))
-				goto ss_probe;
+		} else if (addr->word != breakpoint_insn.word) {
+			/*
+			 * The breakpoint instruction was removed by
+			 * another cpu right after we hit, no further
+			 * handling of this interrupt is appropriate
+			 */
+			ret = 1;
 		}
 		goto no_kprobe;
 	}
@@ -367,7 +361,6 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
 		return 1;
 	}
 
-ss_probe:
 	prepare_singlestep(p, regs, kcb);
 	if (kcb->flags & SKIP_DELAYSLOT) {
 		kcb->kprobe_status = KPROBE_HIT_SSDONE;
