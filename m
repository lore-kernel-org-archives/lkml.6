Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B747AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883FD20851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 883FD20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732347AbeKTKmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:42:14 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:54994 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731074AbeKTKmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 05:42:13 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id A870F72CA65;
        Tue, 20 Nov 2018 03:15:58 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 7F44B7CD1FF; Tue, 20 Nov 2018 03:15:58 +0300 (MSK)
Date:   Tue, 20 Nov 2018 03:15:58 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Andy Lutomirski <luto@kernel.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        linux-c6x-dev@linux-c6x.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/15] c6x: define syscall_get_arch()
Message-ID: <20181120001558.GH11387@altlinux.org>
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

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
v2: unchanged since [PATCH 07/13 v2]

 arch/c6x/include/asm/syscall.h | 7 +++++++
 include/uapi/linux/audit.h     | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/arch/c6x/include/asm/syscall.h b/arch/c6x/include/asm/syscall.h
index ae2be315ee9c..39dbd1ef994c 100644
--- a/arch/c6x/include/asm/syscall.h
+++ b/arch/c6x/include/asm/syscall.h
@@ -11,6 +11,7 @@
 #ifndef __ASM_C6X_SYSCALL_H
 #define __ASM_C6X_SYSCALL_H
 
+#include <uapi/linux/audit.h>
 #include <linux/err.h>
 #include <linux/sched.h>
 
@@ -120,4 +121,10 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	}
 }
 
+static inline int syscall_get_arch(void)
+{
+	return IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)
+		? AUDIT_ARCH_C6XBE : AUDIT_ARCH_C6X;
+}
+
 #endif /* __ASM_C6X_SYSCALLS_H */
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index bedf3bf54c3a..72aeea0a740d 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -381,6 +381,8 @@ enum {
 #define AUDIT_ARCH_ARCV2BE	(EM_ARCV2)
 #define AUDIT_ARCH_ARM		(EM_ARM|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_ARMEB	(EM_ARM)
+#define AUDIT_ARCH_C6X		(EM_TI_C6000|__AUDIT_ARCH_LE)
+#define AUDIT_ARCH_C6XBE	(EM_TI_C6000)
 #define AUDIT_ARCH_CRIS		(EM_CRIS|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_FRV		(EM_FRV)
 #define AUDIT_ARCH_I386		(EM_386|__AUDIT_ARCH_LE)
-- 
ldv
