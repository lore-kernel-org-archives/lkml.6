Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EFEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F045220843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F045220843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbeICVaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:30:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40570 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729363AbeICVaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:30:18 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E006ED07;
        Mon,  3 Sep 2018 17:09:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>, kasan-dev@googlegroups.com
Subject: [PATCH 4.9 091/107] x86/entry/64: Wipe KASAN stack shadow before rewind_stack_do_exit()
Date:   Mon,  3 Sep 2018 18:56:55 +0200
Message-Id: <20180903165641.732052771@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165637.293735109@linuxfoundation.org>
References: <20180903165637.293735109@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit f12d11c5c184626b4befdee3d573ec8237405a33 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/dumpstack.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -15,6 +15,7 @@
 #include <linux/bug.h>
 #include <linux/nmi.h>
 #include <linux/sysfs.h>
+#include <linux/kasan.h>
 
 #include <asm/stacktrace.h>
 #include <asm/unwind.h>
@@ -229,7 +230,10 @@ void oops_end(unsigned long flags, struc
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


