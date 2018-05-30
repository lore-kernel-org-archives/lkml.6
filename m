Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753305AbeE3LY4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:24:56 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33301 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751441AbeE3LYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:24:47 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Wang Nan" <wangnan0@huawei.com>,
        "" <oleg@redhat.com>, "" <dave.hansen@linux.intel.com>,
        "Masami Hiramatsu" <masami.hiramatsu.pt@hitachi.com>,
        "Ingo Molnar" <mingo@kernel.org>, "" <luto@amacapital.net>,
        "" <lizefan@huawei.com>, "Steven Rostedt" <rostedt@goodmis.org>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.709775825@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 022/153] x86/traps: Enable DEBUG_STACK after
 cpu_init() for TRAP_DB/BP
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Wang Nan <wangnan0@huawei.com>

commit b4d8327024637cb2a1f7910dcb5d0ad7a096f473 upstream.

Before this patch early_trap_init() installs DEBUG_STACK for
X86_TRAP_BP and X86_TRAP_DB. However, DEBUG_STACK doesn't work
correctly until cpu_init() <-- trap_init().

This patch passes 0 to set_intr_gate_ist() and
set_system_intr_gate_ist() instead of DEBUG_STACK to let it use
same stack as kernel, and installs DEBUG_STACK for them in
trap_init().

As core runs at ring 0 between early_trap_init() and
trap_init(), there is no chance to get a bad stack before
trap_init().

As NMI is also enabled in trap_init(), we don't need to care
about is_debug_stack() and related things used in
arch/x86/kernel/nmi.c.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Reviewed-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Acked-by: Steven Rostedt <rostedt@goodmis.org>
Cc: <dave.hansen@linux.intel.com>
Cc: <lizefan@huawei.com>
Cc: <luto@amacapital.net>
Cc: <oleg@redhat.com>
Link: http://lkml.kernel.org/r/1424929779-13174-1-git-send-email-wangnan0@huawei.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/traps.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -718,9 +718,17 @@ dotraplinkage void do_iret_error(struct
 /* Set of traps needed for early debugging. */
 void __init early_trap_init(void)
 {
-	set_intr_gate_ist(X86_TRAP_DB, &debug, DEBUG_STACK);
+	/*
+	 * Don't set ist to DEBUG_STACK as it doesn't work until TSS is
+	 * ready in cpu_init() <-- trap_init(). Before trap_init(), CPU
+	 * runs at ring 0 so it is impossible to hit an invalid stack.
+	 * Using the original stack works well enough at this early
+	 * stage. DEBUG_STACK will be equipped after cpu_init() in
+	 * trap_init().
+	 */
+	set_intr_gate_ist(X86_TRAP_DB, &debug, 0);
 	/* int3 can be called from all */
-	set_system_intr_gate_ist(X86_TRAP_BP, &int3, DEBUG_STACK);
+	set_system_intr_gate_ist(X86_TRAP_BP, &int3, 0);
 	set_intr_gate(X86_TRAP_PF, &page_fault);
 	load_idt(&idt_descr);
 }
@@ -781,5 +789,14 @@ void __init trap_init(void)
 	 */
 	cpu_init();
 
+	/*
+	 * X86_TRAP_DB and X86_TRAP_BP have been set
+	 * in early_trap_init(). However, DEBUG_STACK works only after
+	 * cpu_init() loads TSS. See comments in early_trap_init().
+	 */
+	set_intr_gate_ist(X86_TRAP_DB, &debug, DEBUG_STACK);
+	/* int3 can be called from all */
+	set_system_intr_gate_ist(X86_TRAP_BP, &int3, DEBUG_STACK);
+
 	x86_init.irqs.trap_init();
 }
