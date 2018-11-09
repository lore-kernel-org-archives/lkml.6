Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23857C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DD520840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DD520840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbeKIM4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 07:56:09 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:50650 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbeKIM4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 07:56:09 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 06AA372CC59;
        Fri,  9 Nov 2018 06:17:31 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id F22687CD1FF; Fri,  9 Nov 2018 06:17:30 +0300 (MSK)
Date:   Fri, 9 Nov 2018 06:17:30 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Andy Lutomirski <luto@kernel.org>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        linux-xtensa@linux-xtensa.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] xtensa: define syscall_get_arch()
Message-ID: <20181109031730.GM21511@altlinux.org>
Mail-Followup-To: Andy Lutomirski <luto@kernel.org>,
        Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        linux-xtensa@linux-xtensa.org, linux-audit@redhat.com,
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
 arch/xtensa/include/asm/syscall.h | 7 +++++++
 include/uapi/linux/audit.h        | 1 +
 2 files changed, 8 insertions(+)

diff --git a/arch/xtensa/include/asm/syscall.h b/arch/xtensa/include/asm/syscall.h
index 3673ff1f1bc5..84144567095a 100644
--- a/arch/xtensa/include/asm/syscall.h
+++ b/arch/xtensa/include/asm/syscall.h
@@ -8,6 +8,13 @@
  * Copyright (C) 2001 - 2007 Tensilica Inc.
  */
 
+#include <uapi/linux/audit.h>
+
+static inline int syscall_get_arch(void)
+{
+	return AUDIT_ARCH_XTENSA;
+}
+
 struct pt_regs;
 asmlinkage long xtensa_ptrace(long, long, long, long);
 asmlinkage long xtensa_sigreturn(struct pt_regs*);
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index ad4105c602a1..28102e1430fa 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -418,6 +418,7 @@ enum {
 #define AUDIT_ARCH_TILEGX32	(EM_TILEGX|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_TILEPRO	(EM_TILEPRO|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_X86_64	(EM_X86_64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
+#define AUDIT_ARCH_XTENSA	(EM_XTENSA)
 
 #define AUDIT_PERM_EXEC		1
 #define AUDIT_PERM_WRITE	2
-- 
ldv
