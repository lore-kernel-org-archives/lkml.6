Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8366DC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460EB20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 460EB20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731703AbeGSOve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:51:34 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:31882 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbeGSOvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:51:33 -0400
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6JE8Bsf021333;
        Thu, 19 Jul 2018 23:08:11 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp);
 Thu, 19 Jul 2018 23:08:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6JE7xUh021271
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 23:08:11 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     mingo@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     joe@perches.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v7] x86: Avoid pr_cont() in show_opcodes().
Date:   Thu, 19 Jul 2018 23:07:58 +0900
Message-Id: <1532009278-5953-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Since syzbot is confused by concurrent printk() messages [1],
this patch changes show_opcodes() to use %ph format string.

When we start adding prefix to each line of printk() output,
we will be able to handle concurrent printk() messages.

[1] https://syzkaller.appspot.com/text?tag=CrashReport&x=139d342c400000

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Borislav Petkov <bp@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
---
 arch/x86/kernel/dumpstack.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 666a284..9c86529 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -22,8 +22,6 @@
 #include <asm/stacktrace.h>
 #include <asm/unwind.h>
 
-#define OPCODE_BUFSIZE 64
-
 int panic_on_unrecovered_nmi;
 int panic_on_io_nmi;
 static int die_counter;
@@ -93,26 +91,18 @@ static void printk_stack_address(unsigned long address, int reliable,
  */
 void show_opcodes(u8 *rip, const char *loglvl)
 {
-	unsigned int code_prologue = OPCODE_BUFSIZE * 2 / 3;
+#define PROLOGUE_SIZE 42
+#define EPILOGUE_SIZE 21
+#define OPCODE_BUFSIZE (PROLOGUE_SIZE + 1 + EPILOGUE_SIZE)
 	u8 opcodes[OPCODE_BUFSIZE];
-	u8 *ip;
-	int i;
-
-	printk("%sCode: ", loglvl);
-
-	ip = (u8 *)rip - code_prologue;
-	if (probe_kernel_read(opcodes, ip, OPCODE_BUFSIZE)) {
-		pr_cont("Bad RIP value.\n");
-		return;
-	}
 
-	for (i = 0; i < OPCODE_BUFSIZE; i++, ip++) {
-		if (ip == rip)
-			pr_cont("<%02x> ", opcodes[i]);
-		else
-			pr_cont("%02x ", opcodes[i]);
+	if (probe_kernel_read(opcodes, rip - PROLOGUE_SIZE, OPCODE_BUFSIZE)) {
+		printk("%sCode: Bad RIP value.\n", loglvl);
+	} else {
+		printk("%sCode: %" __stringify(PROLOGUE_SIZE) "ph <%02x> %"
+		       __stringify(EPILOGUE_SIZE) "ph\n", loglvl, opcodes,
+		       opcodes[PROLOGUE_SIZE], opcodes + PROLOGUE_SIZE + 1);
 	}
-	pr_cont("\n");
 }
 
 void show_ip(struct pt_regs *regs, const char *loglvl)
-- 
1.8.3.1

