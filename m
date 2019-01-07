Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE0EC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8463620838
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbfAGCxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 21:53:54 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:55004 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfAGCxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 21:53:54 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id EEDC872CC6C;
        Mon,  7 Jan 2019 05:53:50 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id E21708E5C51; Mon,  7 Jan 2019 05:53:50 +0300 (MSK)
Date:   Mon, 7 Jan 2019 05:53:50 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 11/22] nds32: define syscall_get_arch()
Message-ID: <20190107025350.GK1207@altlinux.org>
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

Acked-by: Paul Moore <paul@paul-moore.com>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
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
index b1602dcc13bc..1568ddc1c945 100644
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
