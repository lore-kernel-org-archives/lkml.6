Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5BEECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE212075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE212075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbeGRKb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:31:26 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:29271 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbeGRKb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:31:26 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6I9sJWL028170;
        Wed, 18 Jul 2018 18:54:19 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Wed, 18 Jul 2018 18:54:19 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6I9sCFX028097
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 18 Jul 2018 18:54:18 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     mingo@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     joe@perches.com, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v5] x86: Avoid pr_cont() in show_opcodes().
Date:   Wed, 18 Jul 2018 18:54:03 +0900
Message-Id: <1531907643-3367-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since syzbot is confused by concurrent printk() messages [1],
this patch changes show_opcodes() to use %ph format string.

When we start adding prefix to each line of printk() output,
we will be able to handle concurrent printk() messages.

[1] https://syzkaller.appspot.com/text?tag=CrashReport&x=139d342c400000

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Borislav Petkov <bp@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
---
 arch/x86/kernel/dumpstack.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 666a284..0821da3 100644
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
@@ -93,26 +91,17 @@ static void printk_stack_address(unsigned long address, int reliable,
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
 
-	ip = (u8 *)rip - code_prologue;
-	if (probe_kernel_read(opcodes, ip, OPCODE_BUFSIZE)) {
-		pr_cont("Bad RIP value.\n");
-		return;
-	}
-
-	for (i = 0; i < OPCODE_BUFSIZE; i++, ip++) {
-		if (ip == rip)
-			pr_cont("<%02x> ", opcodes[i]);
-		else
-			pr_cont("%02x ", opcodes[i]);
-	}
-	pr_cont("\n");
+	if (probe_kernel_read(opcodes, rip - PROLOGUE_SIZE, OPCODE_BUFSIZE))
+		printk("%sCode: Bad RIP value.\n", loglvl);
+	else
+		printk("%sCode: %" __stringify(PROLOGUE_SIZE) "ph <%02x> %"
+		       __stringify(EPILOGUE_SIZE) "ph\n", loglvl, opcodes,
+		       opcodes[PROLOGUE_SIZE], opcodes + PROLOGUE_SIZE + 1);
 }
 
 void show_ip(struct pt_regs *regs, const char *loglvl)
-- 
1.8.3.1

