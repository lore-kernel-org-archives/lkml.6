Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB51C67838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6A12082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6A12082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbeLJEa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 23:30:57 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:40030 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbeLJEay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 23:30:54 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id EC3CA72CC6C;
        Mon, 10 Dec 2018 07:30:50 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id D74EA7CEFE9; Mon, 10 Dec 2018 07:30:50 +0300 (MSK)
Date:   Mon, 10 Dec 2018 07:30:50 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Guan Xuetao <gxt@pku.edu.cn>, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 21/25] unicore32: add asm/syscall.h
Message-ID: <20181210043050.GU6131@altlinux.org>
References: <20181210042352.GA6092@altlinux.org>
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

Cc: Guan Xuetao <gxt@pku.edu.cn>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: linux-audit@redhat.com
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

Notes:
    v5: added syscall_get_nr, syscall_get_arguments, syscall_get_error,
        and syscall_get_return_value
    v1: added syscall_get_arch

 arch/unicore32/include/asm/syscall.h | 45 ++++++++++++++++++++++++++++
 include/uapi/linux/audit.h           |  1 +
 2 files changed, 46 insertions(+)
 create mode 100644 arch/unicore32/include/asm/syscall.h

diff --git a/arch/unicore32/include/asm/syscall.h b/arch/unicore32/include/asm/syscall.h
new file mode 100644
index 000000000000..e30d08acf359
--- /dev/null
+++ b/arch/unicore32/include/asm/syscall.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_UNICORE_SYSCALL_H
+#define _ASM_UNICORE_SYSCALL_H
+
+#include <uapi/linux/audit.h>
+
+static inline int
+syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
+{
+	return task_thread_info(task)->syscall;
+}
+
+static inline void
+syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
+		      unsigned int i, unsigned int n, unsigned long *args)
+{
+	BUG_ON(i + n > 6);
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
