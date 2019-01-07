Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C223C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5E520838
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfAGCyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 21:54:08 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:55208 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfAGCyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 21:54:07 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 798C272CC6C;
        Mon,  7 Jan 2019 05:54:04 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 72F3A8E5C51; Mon,  7 Jan 2019 05:54:04 +0300 (MSK)
Date:   Mon, 7 Jan 2019 05:54:04 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 13/22] m68k: add asm/syscall.h
Message-ID: <20190107025404.GM1207@altlinux.org>
References: <20190107025101.GA1182@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscall_get_* functions are required to be implemented on all
architectures in order to extend the generic ptrace API with
PTRACE_GET_SYSCALL_INFO request.

This introduces asm/syscall.h on m68k implementing all 5 syscall_get_*
functions as documented in asm-generic/syscall.h: syscall_get_nr,
syscall_get_arguments, syscall_get_error, syscall_get_return_value,
and syscall_get_arch.

Acked-by: Paul Moore <paul@paul-moore.com> # audit related parts
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: linux-m68k@lists.linux-m68k.org
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

Notes:
    v7: added Acked-by
    v6: added missing includes, use asm-generic/syscall.h
    v5: added syscall_get_nr, syscall_get_arguments, syscall_get_error,
        and syscall_get_return_value
    v1: added syscall_get_arch

 arch/m68k/include/asm/syscall.h | 42 +++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 arch/m68k/include/asm/syscall.h

diff --git a/arch/m68k/include/asm/syscall.h b/arch/m68k/include/asm/syscall.h
new file mode 100644
index 000000000000..c87b14417753
--- /dev/null
+++ b/arch/m68k/include/asm/syscall.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_M68K_SYSCALL_H
+#define _ASM_M68K_SYSCALL_H
+
+#include <asm/ptrace.h>
+#include <asm-generic/syscall.h>
+#include <linux/err.h>
+#include <uapi/linux/audit.h>
+
+static inline int
+syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
+{
+	return regs->orig_d0;
+}
+
+static inline void
+__syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
+			unsigned int i, unsigned int n, unsigned long *args)
+{
+	BUILD_BUG_ON(sizeof(regs->d1) != sizeof(args[0]));
+	memcpy(args, &regs->d1 + i, n * sizeof(args[0]));
+}
+
+static inline long
+syscall_get_error(struct task_struct *task, struct pt_regs *regs)
+{
+	return IS_ERR_VALUE(regs->d0) ? regs->d0 : 0;
+}
+
+static inline long
+syscall_get_return_value(struct task_struct *task, struct pt_regs *regs)
+{
+	return regs->d0;
+}
+
+static inline int
+syscall_get_arch(void)
+{
+	return AUDIT_ARCH_M68K;
+}
+
+#endif	/* _ASM_M68K_SYSCALL_H */
-- 
ldv
