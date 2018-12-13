Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D74AC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3CDC20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3CDC20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbeLMRWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:22:31 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:38230 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729768AbeLMRW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 12:22:28 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 3678872CC6C;
        Thu, 13 Dec 2018 20:22:25 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 1E034964E82; Thu, 13 Dec 2018 20:22:24 +0300 (MSK)
Date:   Thu, 13 Dec 2018 20:22:24 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Richard Kuo <rkuo@codeaurora.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        linux-hexagon@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 11/27] hexagon: define remaining syscall_get_* functions
Message-ID: <20181213172224.GK6024@altlinux.org>
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

This adds remaining 3 syscall_get_* functions as documented in
asm-generic/syscall.h: syscall_get_error, syscall_get_return_value,
and syscall_get_arch.

Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: linux-hexagon@vger.kernel.org
Cc: linux-audit@redhat.com
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

Notes:
    v6: added missing includes
    v5: added syscall_get_error and syscall_get_return_value

 arch/hexagon/include/asm/syscall.h | 22 ++++++++++++++++++++++
 include/uapi/linux/audit.h         |  1 +
 2 files changed, 23 insertions(+)

diff --git a/arch/hexagon/include/asm/syscall.h b/arch/hexagon/include/asm/syscall.h
index 4af9c7b6f13a..c3290c0bc458 100644
--- a/arch/hexagon/include/asm/syscall.h
+++ b/arch/hexagon/include/asm/syscall.h
@@ -21,6 +21,10 @@
 #ifndef _ASM_HEXAGON_SYSCALL_H
 #define _ASM_HEXAGON_SYSCALL_H
 
+#include <linux/err.h>
+#include <asm/ptrace.h>
+#include <uapi/linux/audit.h>
+
 typedef long (*syscall_fn)(unsigned long, unsigned long,
 	unsigned long, unsigned long,
 	unsigned long, unsigned long);
@@ -43,4 +47,22 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	BUG_ON(i + n > 6);
 	memcpy(args, &(&regs->r00)[i], n * sizeof(args[0]));
 }
+
+static inline long syscall_get_error(struct task_struct *task,
+				     struct pt_regs *regs)
+{
+	return IS_ERR_VALUE(regs->r00) ? regs->r00 : 0;
+}
+
+static inline long syscall_get_return_value(struct task_struct *task,
+					    struct pt_regs *regs)
+{
+	return regs->r00;
+}
+
+static inline int syscall_get_arch(void)
+{
+	return AUDIT_ARCH_HEXAGON;
+}
+
 #endif
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 672c6d9d7577..b8e848736031 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -387,6 +387,7 @@ enum {
 #define AUDIT_ARCH_CSKY		(EM_CSKY|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_FRV		(EM_FRV)
 #define AUDIT_ARCH_H8300	(EM_H8_300)
+#define AUDIT_ARCH_HEXAGON	(EM_HEXAGON)
 #define AUDIT_ARCH_I386		(EM_386|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_IA64		(EM_IA_64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_M32R		(EM_M32R)
-- 
ldv
