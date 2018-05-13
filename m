Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbeEMR7j (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 13:59:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47253 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751357AbeEMR7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 13:59:38 -0400
Date: Sun, 13 May 2018 10:58:17 -0700
From: tip-bot for Masami Hiramatsu <tipbot@zytor.com>
Message-ID: <tip-13ebe18c94f5b0665c01ae7fad2717ae959f4212@git.kernel.org>
Cc: mhiramat@kernel.org, yhs@fb.com, torvalds@linux-foundation.org,
        bp@suse.de, luto@kernel.org, ricardo.neri-calderon@linux.intel.com,
        linux-kernel@vger.kernel.org, oleg@redhat.com, mingo@kernel.org,
        francis.deslauriers@efficios.com, rostedt@goodmis.org, ast@kernel.org,
        hpa@zytor.com, tglx@linutronix.de, davem@davemloft.net
Reply-To: mhiramat@kernel.org, bp@suse.de, torvalds@linux-foundation.org,
        yhs@fb.com, luto@kernel.org, oleg@redhat.com,
        linux-kernel@vger.kernel.org, ricardo.neri-calderon@linux.intel.com,
        mingo@kernel.org, francis.deslauriers@efficios.com,
        rostedt@goodmis.org, ast@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        davem@davemloft.net
In-Reply-To: <152587072544.17316.5950935243917346341.stgit@devbox>
References: <152587072544.17316.5950935243917346341.stgit@devbox>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] uprobes/x86: Prohibit probing on MOV SS
 instruction
Git-Commit-ID: 13ebe18c94f5b0665c01ae7fad2717ae959f4212
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

Commit-ID:  13ebe18c94f5b0665c01ae7fad2717ae959f4212
Gitweb:     https://git.kernel.org/tip/13ebe18c94f5b0665c01ae7fad2717ae959f4212
Author:     Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate: Wed, 9 May 2018 21:58:45 +0900
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 13 May 2018 19:52:56 +0200

uprobes/x86: Prohibit probing on MOV SS instruction

Since MOV SS and POP SS instructions will delay the exceptions until the
next instruction is executed, single-stepping on it by uprobes must be
prohibited.

uprobe already rejects probing on POP SS (0x1f), but allows probing on MOV
SS (0x8e and reg == 2).  This checks the target instruction and if it is
MOV SS or POP SS, returns -ENOTSUPP to reject probing.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Francis Deslauriers <francis.deslauriers@efficios.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "David S . Miller" <davem@davemloft.net>
Link: https://lkml.kernel.org/r/152587072544.17316.5950935243917346341.stgit@devbox

---
 arch/x86/kernel/uprobes.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 85c7ef23d99f..c84bb5396958 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -299,6 +299,10 @@ static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn, bool
 	if (is_prefix_bad(insn))
 		return -ENOTSUPP;
 
+	/* We should not singlestep on the exception masking instructions */
+	if (insn_masking_exception(insn))
+		return -ENOTSUPP;
+
 	if (x86_64)
 		good_insns = good_insns_64;
 	else
