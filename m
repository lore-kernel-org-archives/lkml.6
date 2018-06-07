Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id SzcIG3lDGVviCAAAmS7hNA
	; Thu, 07 Jun 2018 14:41:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D3325608BA; Thu,  7 Jun 2018 14:41:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 47356607DC;
	Thu,  7 Jun 2018 14:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 47356607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934582AbeFGOl1 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:41:27 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40586 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932931AbeFGOlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:41:23 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvba-0005Zw-Ja; Thu, 07 Jun 2018 15:09:34 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb8-00035x-VN; Thu, 07 Jun 2018 15:09:06 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Will Deacon" <will.deacon@arm.com>,
        "Laura Abbott" <labbott@redhat.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.657368770@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 266/410] arm64: traps: Don't print stack or raw PC/LR
 values in backtraces
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit a25ffd3a6302a67814280274d8f1aa4ae2ea4b59 upstream.

Printing raw pointer values in backtraces has potential security
implications and are of questionable value anyway.

This patch follows x86's lead and removes the "Exception stack:" dump
from kernel backtraces, as well as converting PC/LR values to symbols
such as "sysrq_handle_crash+0x20/0x30".

Tested-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
[bwh: Backported to 3.16:
 - Deleted code in dump_mem() and dump_backtrace_entry() is a bit different
 - Leave dump_backtrace() unchanged, since it doesn't use dump_mem()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -198,11 +198,9 @@ void __show_regs(struct pt_regs *regs)
 	}
 
 	show_regs_print_info(KERN_DEFAULT);
-	print_symbol("PC is at %s\n", instruction_pointer(regs));
-	print_symbol("LR is at %s\n", lr);
-	printk("pc : [<%016llx>] lr : [<%016llx>] pstate: %08llx\n",
-	       regs->pc, lr, regs->pstate);
-	printk("sp : %016llx\n", sp);
+	print_symbol("pc : %s\n", regs->pc);
+	print_symbol("lr : %s\n", lr);
+	printk("sp : %016llx pstate : %08llx\n", sp, regs->pstate);
 	for (i = top_reg; i >= 0; i--) {
 		printk("x%-2d: %016llx ", i, regs->regs[i]);
 		if (i % 2 == 0)
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -47,53 +47,9 @@ static const char *handler[]= {
 
 int show_unhandled_signals = 1;
 
-/*
- * Dump out the contents of some memory nicely...
- */
-static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
-		     unsigned long top)
-{
-	unsigned long first;
-	mm_segment_t fs;
-	int i;
-
-	/*
-	 * We need to switch to kernel mode so that we can use __get_user
-	 * to safely read from kernel space.
-	 */
-	fs = get_fs();
-	set_fs(KERNEL_DS);
-
-	printk("%s%s(0x%016lx to 0x%016lx)\n", lvl, str, bottom, top);
-
-	for (first = bottom & ~31; first < top; first += 32) {
-		unsigned long p;
-		char str[sizeof(" 12345678") * 8 + 1];
-
-		memset(str, ' ', sizeof(str));
-		str[sizeof(str) - 1] = '\0';
-
-		for (p = first, i = 0; i < 8 && p < top; i++, p += 4) {
-			if (p >= bottom && p < top) {
-				unsigned int val;
-				if (__get_user(val, (unsigned int *)p) == 0)
-					sprintf(str + i * 9, " %08x", val);
-				else
-					sprintf(str + i * 9, " ????????");
-			}
-		}
-		printk("%s%04lx:%s\n", lvl, first & 0xffff, str);
-	}
-
-	set_fs(fs);
-}
-
 static void dump_backtrace_entry(unsigned long where, unsigned long stack)
 {
-	print_ip_sym(where);
-	if (in_exception_text(where))
-		dump_mem("", "Exception stack", stack,
-			 stack + sizeof(struct pt_regs));
+	printk(" %pS\n", (void *)where);
 }
 
 static void __dump_instr(const char *lvl, struct pt_regs *regs)
