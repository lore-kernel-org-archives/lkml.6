Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6779C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 21:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE952243E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 21:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE952243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbeKMHD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 02:03:59 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39106 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeKMHD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 02:03:59 -0500
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so8888480ljh.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 13:09:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=qxuszTR3LwvrqFPDYOyXJJpAmPdQXyw0C/VLoea8Ewg=;
        b=lvrnmgyMaDAGVoFrOjrzuPcJU0h0W9nADgR5Mlm7+Bqx3zrYSx71qPQXKwJ+xKE/q0
         8pKn7CqCDNABGaPEn/2hmA17TGZApmlefFItZFQC3VYeSMQVFIq9qqwjiCyfp2EexOpU
         3AVi3+7TNUV7Zl0eQl8DIleU0a7Bris7Y5H+lejCEnqQCw0Y5JMHR9F601nA7uVfsxe+
         s2zxKHTsuSDbsg837lp639sx1uJUpPA4pFlS+ko4ZKA/824ZXIWs1tMvm/DdhANGY9ay
         TelImA+tPT6tVdj4wSmmGJyRasus16sSe8NlVqj7ZBnQADx9FRE9QfXv+sL9A0sFRVht
         ocHA==
X-Gm-Message-State: AGRZ1gI9Ys4BrEGpkJPKrfgMVvMpY2WperCwzIJJf+75ODIW8GUWGjyq
        Huk1KSdalvXnoT7ywmVreqg=
X-Google-Smtp-Source: AJdET5dzs8V/msDo7Ok268KZsTytGhGWhudK9yGUZ/CqqcNfWpiNZdRYgSHiByDOiwevFm1DZyGSjA==
X-Received: by 2002:a2e:197:: with SMTP id f23-v6mr1664189lji.144.1542056939843;
        Mon, 12 Nov 2018 13:08:59 -0800 (PST)
Received: from hobbit.lan (128-68-186-150.broadband.corbina.ru. [128.68.186.150])
        by smtp.gmail.com with ESMTPSA id t81sm3230292lfe.84.2018.11.12.13.08.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 13:08:59 -0800 (PST)
From:   Alexander Popov <alex.popov@linux.com>
To:     kernel-hardening@lists.openwall.com,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        alex.popov@linux.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] stackleak: Disable function tracing and kprobes for stackleak_erase()
Date:   Tue, 13 Nov 2018 00:08:48 +0300
Message-Id: <1542056928-10917-1-git-send-email-alex.popov@linux.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stackleak_erase() function is called on the trampoline stack at the end
of syscall. This stack is not big enough for ftrace and kprobes operations,
e.g. it can be exhausted if we use kprobe_events for stackleak_erase().

So let's disable function tracing and kprobes for stackleak_erase().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 kernel/stackleak.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index e428929..08cb57e 100644
--- a/kernel/stackleak.c
+++ b/kernel/stackleak.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/stackleak.h>
+#include <linux/kprobes.h>
 
 #ifdef CONFIG_STACKLEAK_RUNTIME_DISABLE
 #include <linux/jump_label.h>
@@ -47,7 +48,7 @@ int stack_erasing_sysctl(struct ctl_table *table, int write,
 #define skip_erasing()	false
 #endif /* CONFIG_STACKLEAK_RUNTIME_DISABLE */
 
-asmlinkage void stackleak_erase(void)
+asmlinkage void notrace stackleak_erase(void)
 {
 	/* It would be nice not to have 'kstack_ptr' and 'boundary' on stack */
 	unsigned long kstack_ptr = current->lowest_stack;
@@ -101,6 +102,7 @@ asmlinkage void stackleak_erase(void)
 	/* Reset the 'lowest_stack' value for the next syscall */
 	current->lowest_stack = current_top_of_stack() - THREAD_SIZE/64;
 }
+NOKPROBE_SYMBOL(stackleak_erase);
 
 void __used stackleak_track_stack(void)
 {
-- 
2.7.4

