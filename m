Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82488C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522FD2089F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 522FD2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732397AbeKTKm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:42:59 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:55976 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbeKTKm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 05:42:58 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 6D2E172CA65;
        Tue, 20 Nov 2018 03:16:41 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 359517CD1FF; Tue, 20 Nov 2018 03:16:40 +0300 (MSK)
Date:   Tue, 20 Nov 2018 03:16:40 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Andy Lutomirski <luto@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        linux-riscv@lists.infradead.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/15] riscv: define syscall_get_arch()
Message-ID: <20181120001640.GM11387@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120001128.GA11300@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscall_get_arch() is required to be implemented on all architectures
in order to extend the generic ptrace API with PTRACE_GET_SYSCALL_INFO
request.

Based-on-patch-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
v2: added Reviewed-by to [PATCH 12/13 v2]

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
index 205aa32d81ed..a97a29922de0 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -410,6 +410,8 @@ enum {
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
