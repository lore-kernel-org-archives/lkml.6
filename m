Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99266C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC342082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC342082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbeH3Nmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 09:42:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34539 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbeH3Nmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 09:42:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7U9fLWh1703603
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 30 Aug 2018 02:41:21 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7U9fLim1703600;
        Thu, 30 Aug 2018 02:41:21 -0700
Date:   Thu, 30 Aug 2018 02:41:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jann Horn <tipbot@zytor.com>
Message-ID: <tip-f12d11c5c184626b4befdee3d573ec8237405a33@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        keescook@chromium.org, dvyukov@google.com, luto@kernel.org,
        glider@google.com, jannh@google.com, hpa@zytor.com,
        aryabinin@virtuozzo.com, tglx@linutronix.de
Reply-To: aryabinin@virtuozzo.com, tglx@linutronix.de, glider@google.com,
          jannh@google.com, hpa@zytor.com, luto@kernel.org,
          linux-kernel@vger.kernel.org, dvyukov@google.com,
          keescook@chromium.org, mingo@kernel.org
In-Reply-To: <20180828184033.93712-1-jannh@google.com>
References: <20180828184033.93712-1-jannh@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/entry/64: Wipe KASAN stack shadow before
 rewind_stack_do_exit()
Git-Commit-ID: f12d11c5c184626b4befdee3d573ec8237405a33
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

Commit-ID:  f12d11c5c184626b4befdee3d573ec8237405a33
Gitweb:     https://git.kernel.org/tip/f12d11c5c184626b4befdee3d573ec8237405a33
Author:     Jann Horn <jannh@google.com>
AuthorDate: Tue, 28 Aug 2018 20:40:33 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 30 Aug 2018 11:37:09 +0200

x86/entry/64: Wipe KASAN stack shadow before rewind_stack_do_exit()

Reset the KASAN shadow state of the task stack before rewinding RSP.
Without this, a kernel oops will leave parts of the stack poisoned, and
code running under do_exit() can trip over such poisoned regions and cause
nonsensical false-positive KASAN reports about stack-out-of-bounds bugs.

This does not wipe the exception stacks; if an oops happens on an exception
stack, it might result in random KASAN false-positives from other tasks
afterwards. This is probably relatively uninteresting, since if the kernel
oopses on an exception stack, there are most likely bigger things to worry
about. It'd be more interesting if vmapped stacks and KASAN were
compatible, since then handle_stack_overflow() would oops from exception
stack context.

Fixes: 2deb4be28077 ("x86/dumpstack: When OOPSing, rewind the stack before do_exit()")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: kasan-dev@googlegroups.com
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180828184033.93712-1-jannh@google.com

---
 arch/x86/kernel/dumpstack.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 9c8652974f8e..1596e6bfea6f 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -17,6 +17,7 @@
 #include <linux/bug.h>
 #include <linux/nmi.h>
 #include <linux/sysfs.h>
+#include <linux/kasan.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
@@ -346,7 +347,10 @@ void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 	 * We're not going to return, but we might be on an IST stack or
 	 * have very little stack space left.  Rewind the stack and kill
 	 * the task.
+	 * Before we rewind the stack, we have to tell KASAN that we're going to
+	 * reuse the task stack and that existing poisons are invalid.
 	 */
+	kasan_unpoison_task_stack(current);
 	rewind_stack_do_exit(signr);
 }
 NOKPROBE_SYMBOL(oops_end);
