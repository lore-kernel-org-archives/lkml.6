Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B884BC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E2E2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E2E2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbeLJE16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 23:27:58 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:37138 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeLJE16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 23:27:58 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id D47E372CC66;
        Mon, 10 Dec 2018 07:27:54 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id CA3A27CEFE9; Mon, 10 Dec 2018 07:27:54 +0300 (MSK)
Date:   Mon, 10 Dec 2018 07:27:54 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/25] alpha: define remaining syscall_get_* functions
Message-ID: <20181210042754.GA6131@altlinux.org>
References: <20181210042352.GA6092@altlinux.org>
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

This adds remaining 4 syscall_get_* functions as documented
in asm-generic/syscall.h: syscall_get_nr, syscall_get_arguments,
syscall_get_error, and syscall_get_return_value.

Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: linux-alpha@vger.kernel.org
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 arch/alpha/include/asm/syscall.h | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/include/asm/syscall.h b/arch/alpha/include/asm/syscall.h
index d73a6fcb519c..437758bdc49f 100644
--- a/arch/alpha/include/asm/syscall.h
+++ b/arch/alpha/include/asm/syscall.h
@@ -4,7 +4,34 @@
 
 #include <uapi/linux/audit.h>
 
-static inline int syscall_get_arch(void)
+static inline int
+syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
+{
+	return regs->r0;
+}
+
+static inline void
+syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
+		      unsigned int i, unsigned int n, unsigned long *args)
+{
+	BUG_ON(i + n > 6);
+	memcpy(args, &regs->r16 + i, n * sizeof(args[0]));
+}
+
+static inline long
+syscall_get_error(struct task_struct *task, struct pt_regs *regs)
+{
+	return regs->r19 ? -regs->r0 : 0;
+}
+
+static inline long
+syscall_get_return_value(struct task_struct *task, struct pt_regs *regs)
+{
+	return regs->r0;
+}
+
+static inline int
+syscall_get_arch(void)
 {
 	return AUDIT_ARCH_ALPHA;
 }
-- 
ldv
