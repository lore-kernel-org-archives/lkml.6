Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84572C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF3920838
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfAGCxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 21:53:31 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:54584 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfAGCxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 21:53:30 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 9FD5E72CC6C;
        Mon,  7 Jan 2019 05:53:27 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 9938D8E5C51; Mon,  7 Jan 2019 05:53:27 +0300 (MSK)
Date:   Mon, 7 Jan 2019 05:53:27 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        uclinux-h8-devel@lists.sourceforge.jp, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 07/22] h8300: define remaining syscall_get_* functions
Message-ID: <20190107025327.GG1207@altlinux.org>
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

This adds remaining 3 syscall_get_* functions as documented in
asm-generic/syscall.h: syscall_get_error, syscall_get_return_value,
and syscall_get_arch.

Acked-by: Paul Moore <paul@paul-moore.com> # audit related parts
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Eric Paris <eparis@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: uclinux-h8-devel@lists.sourceforge.jp
Cc: linux-audit@redhat.com
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

Notes:
    v7: added Acked-by
    v6: added missing includes
    v5: added syscall_get_error and syscall_get_return_value

 arch/h8300/include/asm/syscall.h | 19 +++++++++++++++++++
 include/uapi/linux/audit.h       |  1 +
 2 files changed, 20 insertions(+)

diff --git a/arch/h8300/include/asm/syscall.h b/arch/h8300/include/asm/syscall.h
index 924990401237..0a6565d12836 100644
--- a/arch/h8300/include/asm/syscall.h
+++ b/arch/h8300/include/asm/syscall.h
@@ -8,6 +8,8 @@
 #include <linux/linkage.h>
 #include <linux/types.h>
 #include <linux/ptrace.h>
+#include <linux/err.h>
+#include <uapi/linux/audit.h>
 
 static inline int
 syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
@@ -47,6 +49,23 @@ syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
 	}
 }
 
+static inline long
+syscall_get_error(struct task_struct *task, struct pt_regs *regs)
+{
+	return IS_ERR_VALUE(regs->er0) ? regs->er0 : 0;
+}
+
+static inline long
+syscall_get_return_value(struct task_struct *task, struct pt_regs *regs)
+{
+	return regs->er0;
+}
+
+static inline int
+syscall_get_arch(void)
+{
+	return AUDIT_ARCH_H8300;
+}
 
 
 /* Misc syscall related bits */
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index e3d0255b4fc2..c6a6e3a9ec9a 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -386,6 +386,7 @@ enum {
 #define AUDIT_ARCH_CRIS		(EM_CRIS|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_CSKY		(EM_CSKY|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_FRV		(EM_FRV)
+#define AUDIT_ARCH_H8300	(EM_H8_300)
 #define AUDIT_ARCH_I386		(EM_386|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_IA64		(EM_IA_64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_M32R		(EM_M32R)
-- 
ldv
