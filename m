Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF2EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDA420840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FDA420840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeKIMzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 07:55:42 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:49714 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbeKIMzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 07:55:42 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id A614A72CC59;
        Fri,  9 Nov 2018 06:17:00 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 7CCA57CD1FF; Fri,  9 Nov 2018 06:17:00 +0300 (MSK)
Date:   Fri, 9 Nov 2018 06:17:00 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Andy Lutomirski <luto@kernel.org>, Ley Foon Tan <lftan@altera.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        nios2-dev@lists.rocketboards.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] nios2: define syscall_get_arch()
Message-ID: <20181109031700.GK21511@altlinux.org>
Mail-Followup-To: Andy Lutomirski <luto@kernel.org>,
        Ley Foon Tan <lftan@altera.com>, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        nios2-dev@lists.rocketboards.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109031303.GA20906@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscall_get_arch() is required to be implemented on all architectures
that use tracehook_report_syscall_entry() in order to extend
the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 arch/nios2/include/asm/syscall.h | 6 ++++++
 include/uapi/linux/audit.h       | 1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/nios2/include/asm/syscall.h b/arch/nios2/include/asm/syscall.h
index 9de220854c4a..cf35e210fc4d 100644
--- a/arch/nios2/include/asm/syscall.h
+++ b/arch/nios2/include/asm/syscall.h
@@ -17,6 +17,7 @@
 #ifndef __ASM_NIOS2_SYSCALL_H__
 #define __ASM_NIOS2_SYSCALL_H__
 
+#include <uapi/linux/audit.h>
 #include <linux/err.h>
 #include <linux/sched.h>
 
@@ -135,4 +136,9 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	}
 }
 
+static inline int syscall_get_arch(void)
+{
+	return AUDIT_ARCH_NIOS2;
+}
+
 #endif
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 99e2b63ef765..c4c8b131af48 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -397,6 +397,7 @@ enum {
 #define AUDIT_ARCH_MIPSEL64N32	(EM_MIPS|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE|\
 				 __AUDIT_ARCH_CONVENTION_MIPS64_N32)
 #define AUDIT_ARCH_NDS32	(EM_NDS32)
+#define AUDIT_ARCH_NIOS2	(EM_ALTERA_NIOS2|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_OPENRISC	(EM_OPENRISC)
 #define AUDIT_ARCH_PARISC	(EM_PARISC)
 #define AUDIT_ARCH_PARISC64	(EM_PARISC|__AUDIT_ARCH_64BIT)
-- 
ldv
