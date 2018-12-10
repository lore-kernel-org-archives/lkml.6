Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44E7C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A932081C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A932081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbeLJE3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 23:29:32 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:38334 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbeLJE3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 23:29:32 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id E5DD272CC66;
        Mon, 10 Dec 2018 07:29:28 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id DB41E7CEFE9; Mon, 10 Dec 2018 07:29:28 +0300 (MSK)
Date:   Mon, 10 Dec 2018 07:29:28 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Guo Ren <guoren@kernel.org>, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 06/25] csky: define syscall_get_arch()
Message-ID: <20181210042928.GF6131@altlinux.org>
References: <20181210042352.GA6092@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscall_get_arch() is required to be implemented on all architectures
in order to extend the generic ptrace API with PTRACE_GET_SYSCALL_INFO
request.

Cc: Guo Ren <guoren@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: linux-audit@redhat.com
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 arch/csky/include/asm/syscall.h | 7 +++++++
 include/uapi/linux/audit.h      | 1 +
 2 files changed, 8 insertions(+)

diff --git a/arch/csky/include/asm/syscall.h b/arch/csky/include/asm/syscall.h
index 926a64a8b4ee..d637445737b7 100644
--- a/arch/csky/include/asm/syscall.h
+++ b/arch/csky/include/asm/syscall.h
@@ -6,6 +6,7 @@
 #include <linux/sched.h>
 #include <linux/err.h>
 #include <abi/regdef.h>
+#include <uapi/linux/audit.h>
 
 static inline int
 syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
@@ -68,4 +69,10 @@ syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
 	memcpy(&regs->a1 + i * sizeof(regs->a1), args, n * sizeof(regs->a0));
 }
 
+static inline int
+syscall_get_arch(void)
+{
+	return AUDIT_ARCH_CSKY;
+}
+
 #endif	/* __ASM_SYSCALL_H */
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 72aeea0a740d..55904a40d768 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -384,6 +384,7 @@ enum {
 #define AUDIT_ARCH_C6X		(EM_TI_C6000|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_C6XBE	(EM_TI_C6000)
 #define AUDIT_ARCH_CRIS		(EM_CRIS|__AUDIT_ARCH_LE)
+#define AUDIT_ARCH_CSKY		(EM_CSKY|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_FRV		(EM_FRV)
 #define AUDIT_ARCH_I386		(EM_386|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_IA64		(EM_IA_64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
-- 
ldv
