Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754441AbeCVBp0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 21:45:26 -0400
Received: from akagi.fsij.org ([217.70.189.144]:38142 "EHLO akagi.fsij.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752527AbeCVBpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 21:45:22 -0400
From: NIIBE Yutaka <gniibe@fsij.org>
To: linux-kernel@vger.kernel.org
Cc: NIIBE Yutaka <gniibe@fsij.org>
Subject: [PATCH v2 1/4] signal/x86: Factor out nosig handling.
Date: Thu, 22 Mar 2018 10:44:10 +0900
Message-Id: <20180322014413.24099-2-gniibe@fsij.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180322014413.24099-1-gniibe@fsij.org>
References: <20180322014413.24099-1-gniibe@fsij.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make a function for swing at the ball but actually no ball.

Signed-off-by: NIIBE Yutaka <gniibe@fsij.org>
---
 arch/x86/include/asm/signal.h | 1 +
 arch/x86/kernel/signal.c      | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/signal.h b/arch/x86/include/asm/signal.h
index 5f9012ff52ed..6517df6d9938 100644
--- a/arch/x86/include/asm/signal.h
+++ b/arch/x86/include/asm/signal.h
@@ -36,6 +36,7 @@ typedef sigset_t compat_sigset_t;
 #include <uapi/asm/signal.h>
 #ifndef __ASSEMBLY__
 extern void do_signal(struct pt_regs *regs);
+extern void nosig_restart_syscall(struct pt_regs *regs);
 
 #define __ARCH_HAS_SA_RESTORER
 
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 4cdc0b27ec82..cdfb82031243 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -812,6 +812,11 @@ void do_signal(struct pt_regs *regs)
 		return;
 	}
 
+	nosig_restart_syscall(regs);
+}
+
+void nosig_restart_syscall(struct pt_regs *regs)
+{
 	/* Did we come from a system call? */
 	if (syscall_get_nr(current, regs) >= 0) {
 		/* Restart the system call - no handlers present */
-- 
2.11.0
