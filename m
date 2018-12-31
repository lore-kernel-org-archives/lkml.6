Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CDCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 15:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2DE21720
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 15:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546270515;
	bh=6se/u0+oFZwTYQdYuQP98Ra9pgVDT6L+B1mmCAbJG2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cvbqTOGat9unQFjjt5zJ4b0XSNPOvvJLwjmIi5TGA9Qk6FiB/8A6GR72dl1PNoh6i
	 urb0HePa+yg1ri5CtXSmTnHm8ces+AF2n1oaqrbB7ScFVvbrqBXpBmgiyO0EKr9zmi
	 s97e7qMnU6bXZ/YaQQ+vLPBm2lFd/dXhz0ZrncUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeLaPfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 10:35:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:60386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbeLaPfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 10:35:13 -0500
Received: from localhost.localdomain (unknown [183.128.55.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B7EC21720;
        Mon, 31 Dec 2018 15:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546270512;
        bh=6se/u0+oFZwTYQdYuQP98Ra9pgVDT6L+B1mmCAbJG2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JLJP7bGo14+e19py4/SuVB/pgyjNdJdIRmDk3g26Bt4LFFDklaRvOnWtlUGLj+jY6
         ALGXrYqzc5SeN/4GYm78wUV6kyoXw1x6sG4qkb2WiGFDk2jNocB9YP9ZLP680mBnTS
         lviaf/UBCV1+hCztNJ1l/w4fJA9uGU3I8IP56j8M=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     guoren@kernel.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, oleg@redhat.com,
        linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 11/14] csky: basic ftrace supported
Date:   Mon, 31 Dec 2018 23:33:02 +0800
Message-Id: <1546270384-4590-10-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546270384-4590-1-git-send-email-guoren@kernel.org>
References: <1546270384-4590-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

When gcc with -pg, it'll add _mcount stub in every function. We need
implement the _mcount in kernel and ftrace depends on stackstrace.

To do: call-graph, dynamic ftrace

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/Kconfig              |  1 +
 arch/csky/abiv2/Makefile       |  1 +
 arch/csky/abiv2/mcount.S       | 24 ++++++++++++++++++++++++
 arch/csky/include/asm/ftrace.h |  9 +++++++++
 arch/csky/kernel/Makefile      |  5 +++++
 arch/csky/kernel/ftrace.c      | 24 ++++++++++++++++++++++++
 6 files changed, 64 insertions(+)
 create mode 100644 arch/csky/abiv2/mcount.S
 create mode 100644 arch/csky/include/asm/ftrace.h
 create mode 100644 arch/csky/kernel/ftrace.c

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 65804d1..0b9a290 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -29,6 +29,7 @@ config CSKY
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_FUNCTION_TRACER
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZO
diff --git a/arch/csky/abiv2/Makefile b/arch/csky/abiv2/Makefile
index 069ca72..b1d44f6 100644
--- a/arch/csky/abiv2/Makefile
+++ b/arch/csky/abiv2/Makefile
@@ -8,3 +8,4 @@ obj-y				+= strcmp.o
 obj-y				+= strcpy.o
 obj-y				+= strlen.o
 obj-y				+= strksyms.o
+obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o
diff --git a/arch/csky/abiv2/mcount.S b/arch/csky/abiv2/mcount.S
new file mode 100644
index 0000000..73377d5
--- /dev/null
+++ b/arch/csky/abiv2/mcount.S
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/linkage.h>
+
+ENTRY (_mcount)
+	subi	sp, 20
+	stw	a0, (sp, 0)
+	stw	a1, (sp, 4)
+	stw	a2, (sp, 8)
+	stw	a3, (sp, 12)
+	stw	lr, (sp, 16)
+	mov	a1, lr
+	ldw	a0, (sp, 20)
+	jsri    csky_mcount
+	ldw	a0, (sp, 0)
+	ldw	a1, (sp, 4)
+	ldw	a2, (sp, 8)
+	ldw	a3, (sp, 12)
+	ldw	t1, (sp, 16)
+	ldw	lr, (sp, 20)
+	addi	sp, 24
+	jmp	t1
+END (_mcount)
diff --git a/arch/csky/include/asm/ftrace.h b/arch/csky/include/asm/ftrace.h
new file mode 100644
index 0000000..1d22a17
--- /dev/null
+++ b/arch/csky/include/asm/ftrace.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef __ASM_CSKY_FTRACE_H
+#define __ASM_CSKY_FTRACE_H
+
+extern void _mcount(unsigned long from_pc);
+
+#endif /* __ASM_CSKY_FTRACE_H */
diff --git a/arch/csky/kernel/Makefile b/arch/csky/kernel/Makefile
index ba5ca48..3c0e2d1 100644
--- a/arch/csky/kernel/Makefile
+++ b/arch/csky/kernel/Makefile
@@ -6,4 +6,9 @@ obj-y += process.o cpu-probe.o ptrace.o dumpstack.o
 
 obj-$(CONFIG_MODULES)			+= module.o
 obj-$(CONFIG_SMP)			+= smp.o
+obj-$(CONFIG_FUNCTION_TRACER)		+= ftrace.o
 obj-$(CONFIG_STACKTRACE)		+= stacktrace.o
+
+ifdef CONFIG_FUNCTION_TRACER
+CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
+endif
diff --git a/arch/csky/kernel/ftrace.c b/arch/csky/kernel/ftrace.c
new file mode 100644
index 0000000..ad054f719
--- /dev/null
+++ b/arch/csky/kernel/ftrace.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/ftrace.h>
+#include <linux/uaccess.h>
+
+extern void (*ftrace_trace_function)(unsigned long, unsigned long,
+				     struct ftrace_ops*, struct pt_regs*);
+
+
+noinline void __naked ftrace_stub(unsigned long ip, unsigned long parent_ip,
+				  struct ftrace_ops *op, struct pt_regs *regs)
+{
+	asm volatile ("\n");
+}
+
+noinline void csky_mcount(unsigned long from_pc, unsigned long self_pc)
+{
+	if (ftrace_trace_function != ftrace_stub)
+		ftrace_trace_function(self_pc, from_pc, NULL, NULL);
+}
+
+/* _mcount is defined in abi's mcount.S */
+EXPORT_SYMBOL(_mcount);
-- 
2.7.4

