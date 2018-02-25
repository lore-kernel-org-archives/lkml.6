Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbeBYRXW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 12:23:22 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53868 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751899AbeBYRXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 12:23:12 -0500
X-Google-Smtp-Source: AH8x226ZSeR41aGgr1Zgje/TTIQpoANouvUQgcXvUPUGr+tJaJQuoWlZ1sbgrpBeqpUk9HmxfT4nxQ==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 19/21] powerpc: Add missing prototypes for hw_breakpoint_handler & arch_unregister_hw_breakpoint
Date: Sun, 25 Feb 2018 18:22:34 +0100
Message-Id: <20180225172236.29650-20-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180225172236.29650-1-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 5aae8a537080 ("powerpc, hw_breakpoints: Implement hw_breakpoints
for 64-bit server processors") function hw_breakpoint_handler and
arch_unregister_hw_breakpoint were added without function prototypes in
hw_breakpoint.h header.

Fix the following warning(s) (treated as error in W=1):

  AR      init/built-in.o
arch/powerpc/kernel/hw_breakpoint.c:106:6: error: no previous prototype for ‘arch_unregister_hw_breakpoint’ [-Werror=missing-prototypes]
 void arch_unregister_hw_breakpoint(struct perf_event *bp)
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/kernel/hw_breakpoint.c:209:5: error: no previous prototype for ‘hw_breakpoint_handler’ [-Werror=missing-prototypes]
 int hw_breakpoint_handler(struct die_args *args)
     ^~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/hw_breakpoint.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index ac6432d9be46..90c708e5e7c4 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -66,6 +66,7 @@ extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 						unsigned long val, void *data);
 int arch_install_hw_breakpoint(struct perf_event *bp);
 void arch_uninstall_hw_breakpoint(struct perf_event *bp);
+void arch_unregister_hw_breakpoint(struct perf_event *bp);
 void hw_breakpoint_pmu_read(struct perf_event *bp);
 extern void flush_ptrace_hw_breakpoint(struct task_struct *tsk);
 
@@ -82,6 +83,7 @@ static inline void hw_breakpoint_disable(void)
 	__set_breakpoint(&brk);
 }
 extern void thread_change_pc(struct task_struct *tsk, struct pt_regs *regs);
+int hw_breakpoint_handler(struct die_args *args);
 
 #else	/* CONFIG_HAVE_HW_BREAKPOINT */
 static inline void hw_breakpoint_disable(void) { }
-- 
2.11.0
