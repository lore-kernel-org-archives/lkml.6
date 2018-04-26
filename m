Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932172AbeDZOXP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:23:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42461 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756111AbeDZOXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:23:13 -0400
Date: Thu, 26 Apr 2018 07:22:50 -0700
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-4dba072cd097f35fa8f77c49d909ada2b079a4c4@git.kernel.org>
Cc: jpoimboe@redhat.com, torvalds@linux-foundation.org,
        peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com,
        mingo@kernel.org, luto@amacapital.net, linux-kernel@vger.kernel.org,
        bp@suse.de
Reply-To: jpoimboe@redhat.com, torvalds@linux-foundation.org,
        peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com,
        mingo@kernel.org, luto@amacapital.net, linux-kernel@vger.kernel.org,
        bp@suse.de
In-Reply-To: <20180417161124.5294-10-bp@alien8.de>
References: <20180417161124.5294-10-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/dumpstack: Explain the reasoning for the
 prologue and buffer size
Git-Commit-ID: 4dba072cd097f35fa8f77c49d909ada2b079a4c4
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

Commit-ID:  4dba072cd097f35fa8f77c49d909ada2b079a4c4
Gitweb:     https://git.kernel.org/tip/4dba072cd097f35fa8f77c49d909ada2b079a4c4
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Tue, 17 Apr 2018 18:11:24 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 26 Apr 2018 16:15:28 +0200

x86/dumpstack: Explain the reasoning for the prologue and buffer size

The whole reasoning behind the amount of opcode bytes dumped and prologue
length isn't very clear so write down some of the reasons for why it is
done the way it is.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Link: https://lkml.kernel.org/r/20180417161124.5294-10-bp@alien8.de

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
