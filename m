Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14951C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93A720868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93A720868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeICRhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:37:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49917 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbeICRhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:37:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w83DH1RM3313591
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Sep 2018 06:17:01 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w83DH1uw3313588;
        Mon, 3 Sep 2018 06:17:01 -0700
Date:   Mon, 3 Sep 2018 06:17:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jann Horn <tipbot@zytor.com>
Message-ID: <tip-e3e4d5019c2dd0f91600f6df377b215a73d506fe@git.kernel.org>
Cc:     keescook@chromium.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org, hpa@zytor.com,
        naveen.n.rao@linux.vnet.ibm.com, jannh@google.com, bp@alien8.de,
        tglx@linutronix.de, luto@kernel.org, davem@davemloft.net,
        mingo@kernel.org, anil.s.keshavamurthy@intel.com
Reply-To: hpa@zytor.com, naveen.n.rao@linux.vnet.ibm.com,
          mhiramat@kernel.org, linux-kernel@vger.kernel.org,
          viro@zeniv.linux.org.uk, keescook@chromium.org, mingo@kernel.org,
          anil.s.keshavamurthy@intel.com, davem@davemloft.net,
          luto@kernel.org, tglx@linutronix.de, bp@alien8.de,
          jannh@google.com
In-Reply-To: <20180828201421.157735-4-jannh@google.com>
References: <20180828201421.157735-4-jannh@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/core] x86/kprobes: Stop calling fixup_exception() from
 kprobe_fault_handler()
Git-Commit-ID: e3e4d5019c2dd0f91600f6df377b215a73d506fe
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

Commit-ID:  e3e4d5019c2dd0f91600f6df377b215a73d506fe
Gitweb:     https://git.kernel.org/tip/e3e4d5019c2dd0f91600f6df377b215a73d506fe
Author:     Jann Horn <jannh@google.com>
AuthorDate: Tue, 28 Aug 2018 22:14:17 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 3 Sep 2018 15:12:08 +0200

x86/kprobes: Stop calling fixup_exception() from kprobe_fault_handler()

This removes the call into exception fixup that was added in commit
c28f896634f2 ("[PATCH] kprobes: fix broken fault handling for x86_64").

On X86, kprobe_fault_handler() is called from two places:
do_general_protection() (for #GP) and kprobes_fault() (for #PF).  In both
paths, the fixup_exception() call in the kprobe fault handler is redundant.

In case of #GP, fixup_exception() is called immediately before
kprobe_fault_handler() is invoked, so no need to try that again. This
assumes that the kprobe's fault handler isn't going to do something crazy
like changing RIP so that it suddenly points to an instruction that does
userspace access.

For #PF on a kernel address from kernel space, after the kprobe fault
handler has run, no_context() is invoked, which calls fixup_exception().

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Kees Cook <keescook@chromium.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: kernel-hardening@lists.openwall.com
Cc: linux-kernel@vger.kernel.org
Cc: dvyukov@google.com
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>
Link: https://lkml.kernel.org/r/20180828201421.157735-4-jannh@google.com

---
 arch/x86/kernel/kprobes/core.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 467ac22691b0..f72a47b602e2 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1020,15 +1020,6 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 		 */
 		if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
 			return 1;
-
-		/*
-		 * In case the user-specified fault handler returned
-		 * zero, try to fix up.
-		 */
-		if (fixup_exception(regs, trapnr))
-			return 1;
-
-		/* fixup routine could not handle it. */
 	}
 
 	return 0;
