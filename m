Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E11FC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DF520870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51DF520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbeLMRWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:22:43 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:38492 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729768AbeLMRWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 12:22:42 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 8B51072CC6C;
        Thu, 13 Dec 2018 20:22:39 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 80A47964E82; Thu, 13 Dec 2018 20:22:39 +0300 (MSK)
Date:   Thu, 13 Dec 2018 20:22:39 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 13/27] nds32: define syscall_get_arch()
Message-ID: <20181213172239.GM6024@altlinux.org>
References: <20181213171833.GA5240@altlinux.org>
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

Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
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
    v6: unchanged
    v5: added Cc
    v2: apparently, this architecture can be configured as big-endian,
        so changed AUDIT_ARCH_NDS32 to be little-endian, and added
        AUDIT_ARCH_NDS32BE.

 arch/nds32/include/asm/syscall.h | 8 ++++++++
 include/uapi/linux/audit.h       | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/arch/nds32/include/asm/syscall.h b/arch/nds32/include/asm/syscall.h
index f7e5e86765fe..569149ca25da 100644
--- a/arch/nds32/include/asm/syscall.h
+++ b/arch/nds32/include/asm/syscall.h
@@ -5,6 +5,7 @@
 #ifndef _ASM_NDS32_SYSCALL_H
 #define _ASM_NDS32_SYSCALL_H	1
 
+#include <uapi/linux/audit.h>
 #include <linux/err.h>
 struct task_struct;
 struct pt_regs;
@@ -185,4 +186,11 @@ void syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
 
 	memcpy(&regs->uregs[0] + i, args, n * sizeof(args[0]));
 }
+
+static inline int syscall_get_arch(void)
+{
+	return IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)
+		? AUDIT_ARCH_NDS32BE : AUDIT_ARCH_NDS32;
+}
+
 #endif /* _ASM_NDS32_SYSCALL_H */
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index b8e848736031..54551adb3d5d 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -401,6 +401,8 @@ enum {
 #define AUDIT_ARCH_MIPSEL64	(EM_MIPS|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_MIPSEL64N32	(EM_MIPS|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE|\
 				 __AUDIT_ARCH_CONVENTION_MIPS64_N32)
+#define AUDIT_ARCH_NDS32	(EM_NDS32|__AUDIT_ARCH_LE)
+#define AUDIT_ARCH_NDS32BE	(EM_NDS32)
 #define AUDIT_ARCH_OPENRISC	(EM_OPENRISC)
 #define AUDIT_ARCH_PARISC	(EM_PARISC)
 #define AUDIT_ARCH_PARISC64	(EM_PARISC|__AUDIT_ARCH_64BIT)
-- 
ldv
