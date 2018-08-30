Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21905C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3142054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3142054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbeH3PO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:14:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53449 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbeH3POz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:14:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7UBD6xL1732548
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 30 Aug 2018 04:13:06 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7UBD6uq1732545;
        Thu, 30 Aug 2018 04:13:06 -0700
Date:   Thu, 30 Aug 2018 04:13:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jann Horn <tipbot@zytor.com>
Message-ID: <tip-a644cf538b1125410421584c68b2013fdbecbd79@git.kernel.org>
Cc:     mingo@kernel.org, luto@kernel.org, tglx@linutronix.de,
        keescook@chromium.org, linux-kernel@vger.kernel.org, bp@suse.de,
        hpa@zytor.com, jannh@google.com
Reply-To: keescook@chromium.org, tglx@linutronix.de, luto@kernel.org,
          mingo@kernel.org, jannh@google.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, bp@suse.de
In-Reply-To: <20180828154901.112726-1-jannh@google.com>
References: <20180828154901.112726-1-jannh@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/dumpstack: Don't dump kernel memory based on
 usermode RIP
Git-Commit-ID: a644cf538b1125410421584c68b2013fdbecbd79
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

Commit-ID:  a644cf538b1125410421584c68b2013fdbecbd79
Gitweb:     https://git.kernel.org/tip/a644cf538b1125410421584c68b2013fdbecbd79
Author:     Jann Horn <jannh@google.com>
AuthorDate: Tue, 28 Aug 2018 17:49:01 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 30 Aug 2018 13:10:09 +0200

x86/dumpstack: Don't dump kernel memory based on usermode RIP

show_opcodes() is used both for dumping kernel instructions and for dumping
user instructions. If userspace causes #PF by jumping to a kernel address,
show_opcodes() can be reached with regs->ip controlled by the user,
pointing to kernel code. Make sure that userspace can't trick us into
dumping kernel memory into dmesg.

Fixes: 7cccf0725cf7 ("x86/dumpstack: Add a show_ip() function")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: security@kernel.org
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180828154901.112726-1-jannh@google.com

---
 arch/x86/include/asm/stacktrace.h |  2 +-
 arch/x86/kernel/dumpstack.c       | 15 ++++++++++++---
 arch/x86/mm/fault.c               |  2 +-
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/stacktrace.h b/arch/x86/include/asm/stacktrace.h
index b6dc698f992a..f335aad404a4 100644
--- a/arch/x86/include/asm/stacktrace.h
+++ b/arch/x86/include/asm/stacktrace.h
@@ -111,6 +111,6 @@ static inline unsigned long caller_frame_pointer(void)
 	return (unsigned long)frame;
 }
 
-void show_opcodes(u8 *rip, const char *loglvl);
+void show_opcodes(struct pt_regs *regs, const char *loglvl);
 void show_ip(struct pt_regs *regs, const char *loglvl);
 #endif /* _ASM_X86_STACKTRACE_H */
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 1596e6bfea6f..605c60b1624f 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -90,14 +90,23 @@ static void printk_stack_address(unsigned long address, int reliable,
  * Thus, the 2/3rds prologue and 64 byte OPCODE_BUFSIZE is just a random
  * guesstimate in attempt to achieve all of the above.
  */
-void show_opcodes(u8 *rip, const char *loglvl)
+void show_opcodes(struct pt_regs *regs, const char *loglvl)
 {
 #define PROLOGUE_SIZE 42
 #define EPILOGUE_SIZE 21
 #define OPCODE_BUFSIZE (PROLOGUE_SIZE + 1 + EPILOGUE_SIZE)
 	u8 opcodes[OPCODE_BUFSIZE];
+	u8 *prologue = (u8 *)(regs->ip - PROLOGUE_SIZE);
+	bool bad_ip;
 
-	if (probe_kernel_read(opcodes, rip - PROLOGUE_SIZE, OPCODE_BUFSIZE)) {
+	/*
+	 * Make sure userspace isn't trying to trick us into dumping kernel
+	 * memory by pointing the userspace instruction pointer at it.
+	 */
+	bad_ip = user_mode(regs) &&
+		__range_not_ok(prologue, OPCODE_BUFSIZE, TASK_SIZE_MAX);
+
+	if (bad_ip || probe_kernel_read(opcodes, prologue, OPCODE_BUFSIZE)) {
 		printk("%sCode: Bad RIP value.\n", loglvl);
 	} else {
 		printk("%sCode: %" __stringify(PROLOGUE_SIZE) "ph <%02x> %"
@@ -113,7 +122,7 @@ void show_ip(struct pt_regs *regs, const char *loglvl)
 #else
 	printk("%sRIP: %04x:%pS\n", loglvl, (int)regs->cs, (void *)regs->ip);
 #endif
-	show_opcodes((u8 *)regs->ip, loglvl);
+	show_opcodes(regs, loglvl);
 }
 
 void show_iret_regs(struct pt_regs *regs)
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index b9123c497e0a..47bebfe6efa7 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -837,7 +837,7 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
 
 	printk(KERN_CONT "\n");
 
-	show_opcodes((u8 *)regs->ip, loglvl);
+	show_opcodes(regs, loglvl);
 }
 
 static void
