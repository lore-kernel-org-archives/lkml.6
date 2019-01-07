Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754C8C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F19B20838
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfAGCwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 21:52:47 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:54032 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfAGCwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 21:52:46 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 4E9D372CC6C;
        Mon,  7 Jan 2019 05:52:44 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 4601B8E5C51; Mon,  7 Jan 2019 05:52:44 +0300 (MSK)
Date:   Mon, 7 Jan 2019 05:52:44 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 02/22] asm-generic/syscall.h: turn
 syscall_[gs]et_arguments into wrappers
Message-ID: <20190107025244.GB1207@altlinux.org>
References: <20190107025101.GA1182@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a generic wrapper syscall_get_arguments() that checks
its arguments and calls arch-specific __syscall_get_arguments().

Likewise, add a generic wrapper syscall_set_arguments() that checks
its arguments and calls arch-specific __syscall_set_arguments().

This is the first step on the way of getting rid of BUGs, BUG_ONs,
and replicated error checks in arch-specific asm/syscall.h files.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

Notes:
    v7: unchanged
    v6: initial revision

 include/asm-generic/syscall.h | 47 +++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/syscall.h b/include/asm-generic/syscall.h
index 9863a5f8fbe8..fdefe27fa63f 100644
--- a/include/asm-generic/syscall.h
+++ b/include/asm-generic/syscall.h
@@ -122,10 +122,34 @@ syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
  * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
  * It's invalid to call this with @i + @n > 6; we only support system calls
  * taking up to 6 arguments.
+ *
+ * This function is a wrapper around arch-specific __syscall_get_arguments.
  */
 static void
+__syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
+			unsigned int i, unsigned int n, unsigned long *args);
+
+static inline void
 syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
-		      unsigned int i, unsigned int n, unsigned long *args);
+		      unsigned int i, unsigned int n, unsigned long *args)
+{
+	/*
+	 * Ideally there should have been a BUILD_BUG_ON(i + n > 6)
+	 * instead of these checks because it is a "cannot happen"
+	 * kind of assertion.
+	 */
+	if (WARN_ON_ONCE(i > 6)) {
+		memset(args, 0, n * sizeof(args[0]));
+		return;
+	}
+	if (WARN_ON_ONCE(n > 6 - i)) {
+		unsigned int extra = n - (6 - i);
+
+		n = 6 - i;
+		memset(&args[n], 0, extra * sizeof(args[0]));
+	}
+	__syscall_get_arguments(task, regs, i, n, args);
+}
 
 /**
  * syscall_set_arguments - change system call parameter value
@@ -143,11 +167,30 @@ syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
  * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
  * It's invalid to call this with @i + @n > 6; we only support system calls
  * taking up to 6 arguments.
+ *
+ * This function is a wrapper around arch-specific __syscall_set_arguments.
  */
 static void
+__syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
+			unsigned int i, unsigned int n,
+			const unsigned long *args);
+
+static inline void
 syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
 		      unsigned int i, unsigned int n,
-		      const unsigned long *args);
+		      const unsigned long *args)
+{
+	/*
+	 * Ideally there should have been a BUILD_BUG_ON(i + n > 6)
+	 * instead of these checks because it is a "cannot happen"
+	 * kind of assertion.
+	 */
+	if (WARN_ON_ONCE(i > 6))
+		return;
+	if (WARN_ON_ONCE(n > 6 - i))
+		n = 6 - i;
+	__syscall_set_arguments(task, regs, i, n, args);
+}
 
 /**
  * syscall_get_arch - return the AUDIT_ARCH for the current system call
-- 
ldv
