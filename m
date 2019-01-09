Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5722C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9EE206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbfAIMmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:42:43 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:55722 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730006AbfAIMmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 07:42:40 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id E05CB72CC6C;
        Wed,  9 Jan 2019 15:42:37 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id D3A537CCE38; Wed,  9 Jan 2019 15:42:37 +0300 (MSK)
Date:   Wed, 9 Jan 2019 15:42:37 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Vineet Gupta <vgupta@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/14] arc: define syscall_get_arch()
Message-ID: <20190109124237.GB11981@altlinux.org>
References: <20190109124044.GA11935@altlinux.org>
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

Acked-by: Vineet Gupta <vgupta@synopsys.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-audit@redhat.com
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 arch/arc/include/asm/syscall.h | 11 +++++++++++
 include/uapi/linux/audit.h     |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arc/include/asm/syscall.h b/arch/arc/include/asm/syscall.h
index 29de09804306..c7fc4c0c3bcb 100644
--- a/arch/arc/include/asm/syscall.h
+++ b/arch/arc/include/asm/syscall.h
@@ -9,6 +9,7 @@
 #ifndef _ASM_ARC_SYSCALL_H
 #define _ASM_ARC_SYSCALL_H  1
 
+#include <uapi/linux/audit.h>
 #include <linux/err.h>
 #include <linux/sched.h>
 #include <asm/unistd.h>
@@ -68,4 +69,14 @@ syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
 	}
 }
 
+static inline int
+syscall_get_arch(void)
+{
+	return IS_ENABLED(CONFIG_ISA_ARCOMPACT)
+		? (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)
+			? AUDIT_ARCH_ARCOMPACTBE : AUDIT_ARCH_ARCOMPACT)
+		: (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)
+			? AUDIT_ARCH_ARCV2BE : AUDIT_ARCH_ARCV2);
+}
+
 #endif
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 36a7e3f18e69..41d8fa80ebad 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -375,6 +375,10 @@ enum {
 
 #define AUDIT_ARCH_AARCH64	(EM_AARCH64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_ALPHA	(EM_ALPHA|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
+#define AUDIT_ARCH_ARCOMPACT	(EM_ARCOMPACT|__AUDIT_ARCH_LE)
+#define AUDIT_ARCH_ARCOMPACTBE	(EM_ARCOMPACT)
+#define AUDIT_ARCH_ARCV2	(EM_ARCV2|__AUDIT_ARCH_LE)
+#define AUDIT_ARCH_ARCV2BE	(EM_ARCV2)
 #define AUDIT_ARCH_ARM		(EM_ARM|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_ARMEB	(EM_ARM)
 #define AUDIT_ARCH_CRIS		(EM_CRIS|__AUDIT_ARCH_LE)
-- 
ldv
