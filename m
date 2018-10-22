Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7FEECDE44
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 01:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C512083E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 01:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C512083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbeJVJut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 05:50:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59457 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbeJVJus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 05:50:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9M1XqeH2376134
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 21 Oct 2018 18:33:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9M1XpXk2376131;
        Sun, 21 Oct 2018 18:33:51 -0700
Date:   Sun, 21 Oct 2018 18:33:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masami Hiramatsu <tipbot@zytor.com>
Message-ID: <tip-2e62024c265aa69315ed02835623740030435380@git.kernel.org>
Cc:     tglx@linutronix.de, oleg@redhat.com, torvalds@linux-foundation.org,
        namit@vmware.com, mingo@kernel.org, alexei.starovoitov@gmail.com,
        hpa@zytor.com, mhiramat@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        stable@vger.kernel.org, bp@alien8.de
Reply-To: hpa@zytor.com, mingo@kernel.org, namit@vmware.com,
          alexei.starovoitov@gmail.com, torvalds@linux-foundation.org,
          oleg@redhat.com, tglx@linutronix.de, bp@alien8.de,
          stable@vger.kernel.org, mhiramat@kernel.org,
          peterz@infradead.org, luto@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <154002887331.7627.10194920925792947001.stgit@devbox>
References: <154002887331.7627.10194920925792947001.stgit@devbox>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] kprobes/x86: Use preempt_enable() in
 optimized_callback()
Git-Commit-ID: 2e62024c265aa69315ed02835623740030435380
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

Commit-ID:  2e62024c265aa69315ed02835623740030435380
Gitweb:     https://git.kernel.org/tip/2e62024c265aa69315ed02835623740030435380
Author:     Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate: Sat, 20 Oct 2018 18:47:53 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 22 Oct 2018 03:31:01 +0200

kprobes/x86: Use preempt_enable() in optimized_callback()

The following commit:

  a19b2e3d7839 ("kprobes/x86: Remove IRQ disabling from ftrace-based/optimized kprobes”)

removed local_irq_save/restore() from optimized_callback(), the handler
might be interrupted by the rescheduling interrupt and might be
rescheduled - so we must not use the preempt_enable_no_resched() macro.

Use preempt_enable() instead, to not lose preemption events.

[ mingo: Improved the changelog. ]

Reported-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <stable@vger.kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dwmw@amazon.co.uk
Fixes: a19b2e3d7839 ("kprobes/x86: Remove IRQ disabling from ftrace-based/optimized kprobes”)
Link: http://lkml.kernel.org/r/154002887331.7627.10194920925792947001.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/kprobes/opt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index eaf02f2e7300..40b16b270656 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -179,7 +179,7 @@ optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
 		opt_pre_handler(&op->kp, regs);
 		__this_cpu_write(current_kprobe, NULL);
 	}
-	preempt_enable_no_resched();
+	preempt_enable();
 }
 NOKPROBE_SYMBOL(optimized_callback);
 
