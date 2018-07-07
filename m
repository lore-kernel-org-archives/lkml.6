Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A941BC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 06:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA0E217A6
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 06:09:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA0E217A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751663AbeGGGJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 02:09:29 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52092 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbeGGGJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 02:09:28 -0400
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6769QUZ034923;
        Sat, 7 Jul 2018 15:09:26 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Sat, 07 Jul 2018 15:09:26 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w67679db034201
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 7 Jul 2018 15:09:25 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SKAURA.ne.jp>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] x86: Avoid pr_cont() in show_opcodes()
Date:   Sat,  7 Jul 2018 15:07:05 +0900
Message-Id: <1530943625-3288-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@I-love.SKAURA.ne.jp>

Since syzbot is confused by concurrent printk() messages [1],
this patch changes show_opcodes() to use snprintf().

When we start adding prefix to each line of printk() output,
we will be able to handle concurrent printk() messages.

[1] https://syzkaller.appspot.com/text?tag=CrashReport&x=139d342c400000

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SKAURA.ne.jp>
Cc: Borislav Petkov <bp@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
---
 arch/x86/kernel/dumpstack.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 666a284..bb47426 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -97,22 +97,24 @@ void show_opcodes(u8 *rip, const char *loglvl)
 	u8 opcodes[OPCODE_BUFSIZE];
 	u8 *ip;
 	int i;
-
-	printk("%sCode: ", loglvl);
+	int pos = 0;
+	char buf[(3 * OPCODE_BUFSIZE + 2) + 1];
 
 	ip = (u8 *)rip - code_prologue;
 	if (probe_kernel_read(opcodes, ip, OPCODE_BUFSIZE)) {
-		pr_cont("Bad RIP value.\n");
+		printk("%sCode: Bad RIP value.\n", loglvl);
 		return;
 	}
 
 	for (i = 0; i < OPCODE_BUFSIZE; i++, ip++) {
 		if (ip == rip)
-			pr_cont("<%02x> ", opcodes[i]);
+			pos += snprintf(buf + pos, sizeof(buf) - pos,
+					"<%02x> ", opcodes[i]);
 		else
-			pr_cont("%02x ", opcodes[i]);
+			pos += snprintf(buf + pos, sizeof(buf) - pos,
+					"%02x ", opcodes[i]);
 	}
-	pr_cont("\n");
+	printk("%sCode: %s\n", loglvl, buf);
 }
 
 void show_ip(struct pt_regs *regs, const char *loglvl)
-- 
2.7.4
