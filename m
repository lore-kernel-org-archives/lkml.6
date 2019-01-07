Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A15C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6992E20838
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfAGCy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 21:54:29 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:55734 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbfAGCy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 21:54:27 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 3F26972CC6C;
        Mon,  7 Jan 2019 05:54:24 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 327358E5C51; Mon,  7 Jan 2019 05:54:24 +0300 (MSK)
Date:   Mon, 7 Jan 2019 05:54:24 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     linux-kernel@vger.kernel.org
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Moore <paul@paul-moore.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eric Paris <eparis@redhat.com>,
        linux-riscv@lists.infradead.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 17/22] riscv: define syscall_get_arch()
Message-ID: <20190107025424.GQ1207@altlinux.org>
References: <20190107025101.GA1182@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscall_get_arch() is required to be implemented on all architectures
in addition to already implemented syscall_get_nr(),
syscall_get_arguments(), syscall_get_error(), and
syscall_get_return_value() functions in order to extend the generic
ptrace API with PTRACE_GET_SYSCALL_INFO request.

Based-on-patch-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Eric Paris <eparis@redhat.com>
Cc: linux-riscv@lists.infradead.org
Cc: linux-audit@redhat.com
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

Notes:
    v7: added Acked-by
    v6: unchanged
    v5: added Cc
    v2: added Reviewed-by

 arch/riscv/include/asm/syscall.h | 10 ++++++++++
 include/uapi/linux/audit.h       |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
index 8d25f8904c00..bba3da6ef157 100644
--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -18,6 +18,7 @@
 #ifndef _ASM_RISCV_SYSCALL_H
 #define _ASM_RISCV_SYSCALL_H
 
+#include <uapi/linux/audit.h>
 #include <linux/sched.h>
 #include <linux/err.h>
 
@@ -99,4 +100,13 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	memcpy(&regs->a1 + i * sizeof(regs->a1), args, n * sizeof(regs->a0));
 }
 
+static inline int syscall_get_arch(void)
+{
+#ifdef CONFIG_64BIT
+	return AUDIT_ARCH_RISCV64;
+#else
+	return AUDIT_ARCH_RISCV32;
+#endif
+}
+
 #endif	/* _ASM_RISCV_SYSCALL_H */
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index efeb0bbd6c4d..bcc0619b046f 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -411,6 +411,8 @@ enum {
 /* do not define AUDIT_ARCH_PPCLE since it is not supported by audit */
 #define AUDIT_ARCH_PPC64	(EM_PPC64|__AUDIT_ARCH_64BIT)
 #define AUDIT_ARCH_PPC64LE	(EM_PPC64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
+#define AUDIT_ARCH_RISCV32	(EM_RISCV|__AUDIT_ARCH_LE)
+#define AUDIT_ARCH_RISCV64	(EM_RISCV|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_S390		(EM_S390)
 #define AUDIT_ARCH_S390X	(EM_S390|__AUDIT_ARCH_64BIT)
 #define AUDIT_ARCH_SH		(EM_SH)
-- 
ldv
