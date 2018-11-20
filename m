Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A64EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1951F20851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1951F20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbeKTKm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:42:29 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:55396 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbeKTKm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 05:42:29 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 310E172CA5E;
        Tue, 20 Nov 2018 03:16:13 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 266137CD1FF; Tue, 20 Nov 2018 03:16:13 +0300 (MSK)
Date:   Tue, 20 Nov 2018 03:16:13 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Andy Lutomirski <luto@kernel.org>,
        Richard Kuo <rkuo@codeaurora.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        linux-hexagon@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/15] hexagon: define syscall_get_arch()
Message-ID: <20181120001612.GJ11387@altlinux.org>
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
v2: unchanged since v1

 arch/hexagon/include/asm/syscall.h | 8 ++++++++
 include/uapi/linux/audit.h         | 1 +
 2 files changed, 9 insertions(+)

diff --git a/arch/hexagon/include/asm/syscall.h b/arch/hexagon/include/asm/syscall.h
index 4af9c7b6f13a..de3917aad3fd 100644
--- a/arch/hexagon/include/asm/syscall.h
+++ b/arch/hexagon/include/asm/syscall.h
@@ -21,6 +21,8 @@
 #ifndef _ASM_HEXAGON_SYSCALL_H
 #define _ASM_HEXAGON_SYSCALL_H
 
+#include <uapi/linux/audit.h>
+
 typedef long (*syscall_fn)(unsigned long, unsigned long,
 	unsigned long, unsigned long,
 	unsigned long, unsigned long);
@@ -43,4 +45,10 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	BUG_ON(i + n > 6);
 	memcpy(args, &(&regs->r00)[i], n * sizeof(args[0]));
 }
+
+static inline int syscall_get_arch(void)
+{
+	return AUDIT_ARCH_HEXAGON;
+}
+
 #endif
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index d7fa1ba8dc82..421953fc2f13 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -386,6 +386,7 @@ enum {
 #define AUDIT_ARCH_CRIS		(EM_CRIS|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_FRV		(EM_FRV)
 #define AUDIT_ARCH_H8300	(EM_H8_300)
+#define AUDIT_ARCH_HEXAGON	(EM_HEXAGON)
 #define AUDIT_ARCH_I386		(EM_386|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_IA64		(EM_IA_64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_M32R		(EM_M32R)
-- 
ldv
