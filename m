Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935018AbeEIM7M (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 08:59:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934798AbeEIM7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 08:59:10 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Alexei Starovoitov <ast@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, Yonghong Song <yhs@fb.com>
Subject: [PATCH 2/2] uprobes: x86: Prohibit probing on MOV SS instruction
Date: Wed,  9 May 2018 21:58:45 +0900
Message-Id: <152587072544.17316.5950935243917346341.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152587066475.17316.3035446966107675608.stgit@devbox>
References: <152587066475.17316.3035446966107675608.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since MOV SS and POP SS instructions will delay the exceptions
until the next instruction is executed, we should not do
single-stepping on it by uprobes.

uprobe already rejects probing on POP SS (0x1f), but allows
probing on MOV SS (0x8e and reg == 2).
This checks the target instruction and if it is MOV SS
or POP SS, returns -ENOTSUPP to reject probing.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/uprobes.c |    4 ++++
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
