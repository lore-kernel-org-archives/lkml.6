Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82D8C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC1B2081C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC1B2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbeKJXzL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 18:55:11 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:59546 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729013AbeKJXzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 18:55:11 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 38C9372CC6B;
        Sat, 10 Nov 2018 17:10:01 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 00E587CD1FF; Sat, 10 Nov 2018 17:10:00 +0300 (MSK)
Date:   Sat, 10 Nov 2018 17:10:00 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Andy Lutomirski <luto@kernel.org>, Guan Xuetao <gxt@pku.edu.cn>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 15/13] unicore32: define syscall_get_arch()
Message-ID: <20181110140959.GB12698@altlinux.org>
References: <20181107042751.3b519062@akathisia>
 <CALCETrV1v-DPRfDRwiH=xn29bxWxiHdZtAH1nw=dsmDtnT0YGQ@mail.gmail.com>
 <20181109031303.GA20906@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20181109031303.GA20906@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscall_get_arch() is required to be implemented on all architectures
in order to extend the generic ptrace API with PTRACE_GET_SYSCALL_INFO
request.

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
Apparently, we need to implement syscall_get_arch() on all architectures
where linux/tracehook.h is compiled, not just those that use
tracehook_report_syscall_entry().
This adds one more architecture to the initial list of 9 architectures
where syscall_get_arch() has to be implemented.

 arch/unicore32/include/asm/syscall.h | 12 ++++++++++++
 include/uapi/linux/audit.h           |  1 +
 2 files changed, 13 insertions(+)
 create mode 100644 arch/unicore32/include/asm/syscall.h

diff --git a/arch/unicore32/include/asm/syscall.h b/arch/unicore32/include/asm/syscall.h
new file mode 100644
index 000000000000..3a6b885476b4
--- /dev/null
+++ b/arch/unicore32/include/asm/syscall.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_UNICORE_SYSCALL_H
+#define _ASM_UNICORE_SYSCALL_H
+
+#include <uapi/linux/audit.h>
+
+static inline int syscall_get_arch(void)
+{
+	return AUDIT_ARCH_UNICORE;
+}
+
+#endif	/* _ASM_UNICORE_SYSCALL_H */
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index c3127e6cde2c..904d713f6cdd 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -423,6 +423,7 @@ enum {
 #define AUDIT_ARCH_TILEGX	(EM_TILEGX|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_TILEGX32	(EM_TILEGX|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_TILEPRO	(EM_TILEPRO|__AUDIT_ARCH_LE)
+#define AUDIT_ARCH_UNICORE	(EM_UNICORE|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_X86_64	(EM_X86_64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_XTENSA	(EM_XTENSA)
 
-- 
ldv
