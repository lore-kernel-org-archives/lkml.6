Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13B3ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C4020673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C4020673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbeGSPgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:36:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51263 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeGSPgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:36:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JEpqg62318915
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 07:51:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JEppS12318909;
        Thu, 19 Jul 2018 07:51:51 -0700
Date:   Thu, 19 Jul 2018 07:51:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rasmus Villemoes <tipbot@zytor.com>
Message-ID: <tip-8e974b3b8eddd42a8c43a18e8ea66a3e7b803a0d@git.kernel.org>
Cc:     torvalds@linux-foundation.org, jpoimboe@redhat.com,
        mingo@kernel.org, hpa@zytor.com, linux@rasmusvillemoes.dk,
        penguin-kernel@I-love.SAKURA.ne.jp, luto@amacapital.net,
        peterz@infradead.org, linux-kernel@vger.kernel.org, bp@suse.de,
        tglx@linutronix.de
Reply-To: torvalds@linux-foundation.org, mingo@kernel.org,
          jpoimboe@redhat.com, linux@rasmusvillemoes.dk, hpa@zytor.com,
          luto@amacapital.net, penguin-kernel@I-love.SAKURA.ne.jp,
          peterz@infradead.org, linux-kernel@vger.kernel.org, bp@suse.de,
          tglx@linutronix.de
In-Reply-To: <1532009278-5953-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
References: <1532009278-5953-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/debug] x86: Avoid pr_cont() in show_opcodes()
Git-Commit-ID: 8e974b3b8eddd42a8c43a18e8ea66a3e7b803a0d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8e974b3b8eddd42a8c43a18e8ea66a3e7b803a0d
Gitweb:     https://git.kernel.org/tip/8e974b3b8eddd42a8c43a18e8ea66a3e7b803a0d
Author:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
AuthorDate: Thu, 19 Jul 2018 23:07:58 +0900
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 19 Jul 2018 16:46:23 +0200

x86: Avoid pr_cont() in show_opcodes()

If concurrent printk() messages are emitted, then pr_cont() is making it
extremly hard to decode which part of the output belongs to what. See the
convoluted example at:

  https://syzkaller.appspot.com/text?tag=CrashReport&x=139d342c400000

Avoid this by using a proper prefix for each line and by using %ph format
in show_opcodes() which emits the 'Code:' line in one go.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: joe@perches.com
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@suse.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lkml.kernel.org/r/1532009278-5953-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp

---
 arch/x86/kernel/dumpstack.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 666a284116ac..9c8652974f8e 100644
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
