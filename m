Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756097AbeDQQOR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 12:14:17 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57054 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755997AbeDQQOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:14:14 -0400
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 9/9] x86/dumpstack: Explain the reasoning for the prologue and buffer size
Date: Tue, 17 Apr 2018 18:11:24 +0200
Message-Id: <20180417161124.5294-10-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180417161124.5294-1-bp@alien8.de>
References: <20180417161124.5294-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

The whole reasoning behind the amount of opcode bytes dumped and
prologue length isn't very clear so let's hold down some of the reasons
for why it is done the way it is.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/dumpstack.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index ee344030fd0a..666a284116ac 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -72,6 +72,25 @@ static void printk_stack_address(unsigned long address, int reliable,
 	printk("%s %s%pB\n", log_lvl, reliable ? "" : "? ", (void *)address);
 }
 
+/*
+ * There are a couple of reasons for the 2/3rd prologue, courtesy of Linus:
+ *
+ * In case where we don't have the exact kernel image (which, if we did, we can
+ * simply disassemble and navigate to the RIP), the purpose of the bigger
+ * prologue is to have more context and to be able to correlate the code from
+ * the different toolchains better.
+ *
+ * In addition, it helps in recreating the register allocation of the failing
+ * kernel and thus make sense of the register dump.
+ *
+ * What is more, the additional complication of a variable length insn arch like
+ * x86 warrants having longer byte sequence before rIP so that the disassembler
+ * can "sync" up properly and find instruction boundaries when decoding the
+ * opcode bytes.
+ *
+ * Thus, the 2/3rds prologue and 64 byte OPCODE_BUFSIZE is just a random
+ * guesstimate in attempt to achieve all of the above.
+ */
 void show_opcodes(u8 *rip, const char *loglvl)
 {
 	unsigned int code_prologue = OPCODE_BUFSIZE * 2 / 3;
-- 
2.13.0
