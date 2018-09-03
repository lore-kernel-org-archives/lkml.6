Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0863FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A886F20652
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A886F20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbeICRgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:36:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35761 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbeICRgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:36:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w83DFuXk3313529
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Sep 2018 06:15:56 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w83DFtGR3313526;
        Mon, 3 Sep 2018 06:15:55 -0700
Date:   Mon, 3 Sep 2018 06:15:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jann Horn <tipbot@zytor.com>
Message-ID: <tip-a980c0ef9f6d8c45445d6ed0f5836bb6941c8c91@git.kernel.org>
Cc:     jannh@google.com, anil.s.keshavamurthy@intel.com, hpa@zytor.com,
        mingo@kernel.org, bp@alien8.de, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        tglx@linutronix.de, keescook@chromium.org,
        naveen.n.rao@linux.vnet.ibm.com, davem@davemloft.net,
        luto@kernel.org
Reply-To: davem@davemloft.net, luto@kernel.org,
          naveen.n.rao@linux.vnet.ibm.com, keescook@chromium.org,
          tglx@linutronix.de, mhiramat@kernel.org,
          linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
          bp@alien8.de, mingo@kernel.org, hpa@zytor.com, jannh@google.com,
          anil.s.keshavamurthy@intel.com
In-Reply-To: <20180828201421.157735-2-jannh@google.com>
References: <20180828201421.157735-2-jannh@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/core] x86/kprobes: Refactor kprobes_fault() like
 kprobe_exceptions_notify()
Git-Commit-ID: a980c0ef9f6d8c45445d6ed0f5836bb6941c8c91
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

Commit-ID:  a980c0ef9f6d8c45445d6ed0f5836bb6941c8c91
Gitweb:     https://git.kernel.org/tip/a980c0ef9f6d8c45445d6ed0f5836bb6941c8c91
Author:     Jann Horn <jannh@google.com>
AuthorDate: Tue, 28 Aug 2018 22:14:15 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 3 Sep 2018 15:12:08 +0200

x86/kprobes: Refactor kprobes_fault() like kprobe_exceptions_notify()

This is an extension of commit b506a9d08bae ("x86: code clarification patch
to Kprobes arch code"). As that commit explains, even though
kprobe_running() can't be called with preemption enabled, preemption does
not need to be disabled. If preemption is enabled, then this can't be
originate from a kprobe.

Also, use X86_TRAP_PF instead of 14.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Kees Cook <keescook@chromium.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: kernel-hardening@lists.openwall.com
Cc: dvyukov@google.com
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>
Link: https://lkml.kernel.org/r/20180828201421.157735-2-jannh@google.com

---
 arch/x86/mm/fault.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 47bebfe6efa7..d99edb2d567b 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -44,17 +44,19 @@ kmmio_fault(struct pt_regs *regs, unsigned long addr)
 
 static nokprobe_inline int kprobes_fault(struct pt_regs *regs)
 {
-	int ret = 0;
-
-	/* kprobe_running() needs smp_processor_id() */
-	if (kprobes_built_in() && !user_mode(regs)) {
-		preempt_disable();
-		if (kprobe_running() && kprobe_fault_handler(regs, 14))
-			ret = 1;
-		preempt_enable();
-	}
-
-	return ret;
+	if (!kprobes_built_in())
+		return 0;
+	if (user_mode(regs))
+		return 0;
+	/*
+	 * To be potentially processing a kprobe fault and to be allowed to call
+	 * kprobe_running(), we have to be non-preemptible.
+	 */
+	if (preemptible())
+		return 0;
+	if (!kprobe_running())
+		return 0;
+	return kprobe_fault_handler(regs, X86_TRAP_PF);
 }
 
 /*
