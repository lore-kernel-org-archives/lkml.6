Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F0DC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1546E20879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1546E20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbeLMRXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:23:38 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:39716 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbeLMRXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 12:23:37 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 8F5F972CC6C;
        Thu, 13 Dec 2018 20:23:35 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 8647D964E82; Thu, 13 Dec 2018 20:23:35 +0300 (MSK)
Date:   Thu, 13 Dec 2018 20:23:35 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     linux-kernel@vger.kernel.org
Cc:     Max Filippov <jcmvbkbc@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Chris Zankel <chris@zankel.net>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>, linux-xtensa@linux-xtensa.org,
        linux-audit@redhat.com
Subject: [PATCH v6 21/27] xtensa: define syscall_get_* functions
Message-ID: <20181213172335.GU6024@altlinux.org>
References: <20181213171833.GA5240@altlinux.org>
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

This adds all 5 syscall_get_* functions on xtensa as documented
in asm-generic/syscall.h: syscall_get_nr, syscall_get_arguments,
syscall_get_error, syscall_get_return_value, and syscall_get_arch.

Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>
Cc: linux-xtensa@linux-xtensa.org
Cc: linux-audit@redhat.com
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

Notes:
    v6: there is a tracehook support in xtensa tree where all syscall_get_*
        functions are implemented already, no need to pay attention at this patch
    v5: added syscall_get_nr, syscall_get_arguments, syscall_get_error,
        and syscall_get_return_value
    v2: added Acked-by
    v1: added syscall_get_arch

 arch/xtensa/include/asm/syscall.h | 65 +++++++++++++++++++++++++++++++
 include/uapi/linux/audit.h        |  1 +
 2 files changed, 66 insertions(+)

diff --git a/arch/xtensa/include/asm/syscall.h b/arch/xtensa/include/asm/syscall.h
index 3673ff1f1bc5..40c6de062ac8 100644
--- a/arch/xtensa/include/asm/syscall.h
+++ b/arch/xtensa/include/asm/syscall.h
@@ -8,6 +8,71 @@
  * Copyright (C) 2001 - 2007 Tensilica Inc.
  */
 
+#include <linux/err.h>
+#include <uapi/linux/audit.h>
+#include <asm/ptrace.h>
+#include <asm-generic/syscall.h>
+
+static inline int
+syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
+{
+	return regs->syscall;
+}
+
+static inline void
+__syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
+			unsigned int i, unsigned int n, unsigned long *args)
+{
+	switch (i) {
+	case 0:
+		if (!n--)
+			break;
+		*args++ = regs->areg[6];
+		/* fall through */
+	case 1:
+		if (!n--)
+			break;
+		*args++ = regs->areg[3];
+		/* fall through */
+	case 2:
+		if (!n--)
+			break;
+		*args++ = regs->areg[4];
+		/* fall through */
+	case 3:
+		if (!n--)
+			break;
+		*args++ = regs->areg[5];
+		/* fall through */
+	case 4:
+		if (!n--)
+			break;
+		*args++ = regs->areg[8];
+		/* fall through */
+	case 5:
+		if (!n--)
+			break;
+		*args++ = regs->areg[9];
+	}
+}
+
+static inline long
+syscall_get_error(struct task_struct *task, struct pt_regs *regs)
+{
+	return IS_ERR_VALUE(regs->areg[2]) ? regs->areg[2] : 0;
+
+static inline long
+syscall_get_return_value(struct task_struct *task, struct pt_regs *regs)
+{
+	return regs->areg[2];
+}
+
+static inline int
+syscall_get_arch(void)
+{
+	return AUDIT_ARCH_XTENSA;
+}
+
 struct pt_regs;
 asmlinkage long xtensa_ptrace(long, long, long, long);
 asmlinkage long xtensa_sigreturn(struct pt_regs*);
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 1e9808f3a240..bcc0619b046f 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -425,6 +425,7 @@ enum {
 #define AUDIT_ARCH_TILEGX32	(EM_TILEGX|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_TILEPRO	(EM_TILEPRO|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_X86_64	(EM_X86_64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
+#define AUDIT_ARCH_XTENSA	(EM_XTENSA)
 
 #define AUDIT_PERM_EXEC		1
 #define AUDIT_PERM_WRITE	2
-- 
ldv
