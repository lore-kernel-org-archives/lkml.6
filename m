Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC47FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934A52077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 934A52077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732001AbeICWBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:01:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49330 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbeICWBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:01:05 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4013BC75;
        Mon,  3 Sep 2018 17:39:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>, security@kernel.org
Subject: [PATCH 4.18 122/123] x86/dumpstack: Dont dump kernel memory based on usermode RIP
Date:   Mon,  3 Sep 2018 18:57:46 +0200
Message-Id: <20180903165724.647650510@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit 342db04ae71273322f0011384a9ed414df8bdae4 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/include/asm/stacktrace.h |    2 +-
 arch/x86/kernel/dumpstack.c       |   21 +++++++++++++++------
 arch/x86/mm/fault.c               |    2 +-
 3 files changed, 17 insertions(+), 8 deletions(-)

--- a/arch/x86/include/asm/stacktrace.h
+++ b/arch/x86/include/asm/stacktrace.h
@@ -111,6 +111,6 @@ static inline unsigned long caller_frame
 	return (unsigned long)frame;
 }
 
-void show_opcodes(u8 *rip, const char *loglvl);
+void show_opcodes(struct pt_regs *regs, const char *loglvl);
 void show_ip(struct pt_regs *regs, const char *loglvl);
 #endif /* _ASM_X86_STACKTRACE_H */
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -92,23 +92,32 @@ static void printk_stack_address(unsigne
  * Thus, the 2/3rds prologue and 64 byte OPCODE_BUFSIZE is just a random
  * guesstimate in attempt to achieve all of the above.
  */
-void show_opcodes(u8 *rip, const char *loglvl)
+void show_opcodes(struct pt_regs *regs, const char *loglvl)
 {
 	unsigned int code_prologue = OPCODE_BUFSIZE * 2 / 3;
 	u8 opcodes[OPCODE_BUFSIZE];
-	u8 *ip;
+	unsigned long ip;
 	int i;
+	bool bad_ip;
 
 	printk("%sCode: ", loglvl);
 
-	ip = (u8 *)rip - code_prologue;
-	if (probe_kernel_read(opcodes, ip, OPCODE_BUFSIZE)) {
+	ip = regs->ip - code_prologue;
+
+	/*
+	 * Make sure userspace isn't trying to trick us into dumping kernel
+	 * memory by pointing the userspace instruction pointer at it.
+	 */
+	bad_ip = user_mode(regs) &&
+		 __chk_range_not_ok(ip, OPCODE_BUFSIZE, TASK_SIZE_MAX);
+
+	if (bad_ip || probe_kernel_read(opcodes, (u8 *)ip, OPCODE_BUFSIZE)) {
 		pr_cont("Bad RIP value.\n");
 		return;
 	}
 
 	for (i = 0; i < OPCODE_BUFSIZE; i++, ip++) {
-		if (ip == rip)
+		if (ip == regs->ip)
 			pr_cont("<%02x> ", opcodes[i]);
 		else
 			pr_cont("%02x ", opcodes[i]);
@@ -123,7 +132,7 @@ void show_ip(struct pt_regs *regs, const
 #else
 	printk("%sRIP: %04x:%pS\n", loglvl, (int)regs->cs, (void *)regs->ip);
 #endif
-	show_opcodes((u8 *)regs->ip, loglvl);
+	show_opcodes(regs, loglvl);
 }
 
 void show_iret_regs(struct pt_regs *regs)
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -838,7 +838,7 @@ show_signal_msg(struct pt_regs *regs, un
 
 	printk(KERN_CONT "\n");
 
-	show_opcodes((u8 *)regs->ip, loglvl);
+	show_opcodes(regs, loglvl);
 }
 
 static void


