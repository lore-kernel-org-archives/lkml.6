Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B25C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AEDD20838
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfAGCyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 21:54:41 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:56014 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfAGCyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 21:54:40 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id C526472CC6C;
        Mon,  7 Jan 2019 05:54:37 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id B655C8E5C51; Mon,  7 Jan 2019 05:54:37 +0300 (MSK)
Date:   Mon, 7 Jan 2019 05:54:37 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Guan Xuetao <gxt@pku.edu.cn>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 19/22] unicore32: add asm/syscall.h
Message-ID: <20190107025437.GS1207@altlinux.org>
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

This introduces asm/syscall.h on unicore32 implementing all 5
syscall_get_* functions as documented in asm-generic/syscall.h:
syscall_get_nr, syscall_get_arguments, syscall_get_error,
syscall_get_return_value, and syscall_get_arch.

A note for the unicore32 architecture maintainer: I have no idea about
the syscall semantics on this architecture, and the code is of little
help here.  All I could infer from the code is that it looks very
similar to ARM, so the implementation of syscall_get_* functions
is also similar to ARM.

Acked-by: Paul Moore <paul@paul-moore.com> # audit related parts
Cc: Guan Xuetao <gxt@pku.edu.cn>
Cc: Eric Paris <eparis@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: linux-audit@redhat.com
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

Notes:
    v7: added Acked-by
    v6: made use of asm-generic/syscall.h
    v5: added syscall_get_nr, syscall_get_arguments, syscall_get_error,
        and syscall_get_return_value
    v1: added syscall_get_arch

 arch/unicore32/include/asm/syscall.h | 47 ++++++++++++++++++++++++++++
 include/uapi/linux/audit.h           |  1 +
 2 files changed, 48 insertions(+)
 create mode 100644 arch/unicore32/include/asm/syscall.h

diff --git a/arch/unicore32/include/asm/syscall.h b/arch/unicore32/include/asm/syscall.h
new file mode 100644
index 000000000000..267e97e256bd
--- /dev/null
+++ b/arch/unicore32/include/asm/syscall.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_UNICORE_SYSCALL_H
+#define _ASM_UNICORE_SYSCALL_H
+
+#include <linux/err.h>
+#include <asm/ptrace.h>
+#include <asm-generic/syscall.h>
+#include <uapi/linux/audit.h>
+
+static inline int
+syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
+{
+	return task_thread_info(task)->syscall;
+}
+
+static inline void
+__syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
+			unsigned int i, unsigned int n, unsigned long *args)
+{
+	if (i == 0) {
+		args[0] = regs->UCreg_ORIG_00;
+		args++;
+		i++;
+		n--;
+	}
+	memcpy(args, &regs->UCreg_00 + i, n * sizeof(args[0]));
+}
+
+static inline long
+syscall_get_error(struct task_struct *task, struct pt_regs *regs)
+{
+	return IS_ERR_VALUE(regs->UCreg_00) ? regs->UCreg_00 : 0;
+}
+
+static inline long
+syscall_get_return_value(struct task_struct *task, struct pt_regs *regs)
+{
+	return regs->UCreg_00;
+}
+
+static inline int
+syscall_get_arch(void)
+{
+	return AUDIT_ARCH_UNICORE;
+}
+
+#endif	/* _ASM_UNICORE_SYSCALL_H */
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index bcc0619b046f..3901c51c0b93 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -424,6 +424,7 @@ enum {
 #define AUDIT_ARCH_TILEGX	(EM_TILEGX|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_TILEGX32	(EM_TILEGX|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_TILEPRO	(EM_TILEPRO|__AUDIT_ARCH_LE)
+#define AUDIT_ARCH_UNICORE	(EM_UNICORE|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_X86_64	(EM_X86_64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_XTENSA	(EM_XTENSA)
 
-- 
ldv
