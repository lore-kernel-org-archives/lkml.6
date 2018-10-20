Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D107FC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 07:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7DA21502
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 07:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7DA21502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeJTPgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 11:36:19 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:65097 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbeJTPgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 11:36:19 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42cZ9559KQz9ttS7;
        Sat, 20 Oct 2018 09:26:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id MN86taMaP71s; Sat, 20 Oct 2018 09:26:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42cZ954Zlkz9ttCM;
        Sat, 20 Oct 2018 09:26:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DB6208B77B;
        Sat, 20 Oct 2018 09:26:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id kqnlCIC1IWIZ; Sat, 20 Oct 2018 09:26:49 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [192.168.232.53])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9486F8B74B;
        Sat, 20 Oct 2018 09:26:49 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 5B59310483E; Sat, 20 Oct 2018 09:26:49 +0200 (CEST)
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] idle/x86: remove the call to boot_init_stack_canary() from
 cpu_startup_entry()
Message-Id: <20181020072649.5B59310483E@pc16082vm.idsi0.si.c-s.fr>
Date:   Sat, 20 Oct 2018 09:26:49 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit d7880812b359 ("idle: Add the stack canary init to
cpu_startup_entry()") added the call to boot_init_stack_canary()
in cpu_startup_entry() in an #ifdef CONFIG_X86 statement, with
the intention to remove that #ifdef later.

While implementing stack protector for powerpc, it has been
observed that calling boot_init_stack_canary() is also needed
for powerpc which uses per task (TLS) stack canary like the X86.

However, calling boot_init_stack_canary() would break arches
using global stack canary (ARM, SH, MIPS and XTENSA).

Instead of modifying the #ifdef CONFIG_X86 in an
 #if defined(CONFIG_X86) || defined(CONFIG_PPC), powerpc
implemented the call to boot_init_stack_canary() in the function
calling cpu_startup_entry()

On x86, we have two functions calling cpu_startup_entry():
- start_secondary()
- cpu_bringup_and_idle()

start_secondary() already calls boot_init_stack_canary().

This patch adds the call to boot_init_stack_canary() in
cpu_bringup_and_idle() and removes it from cpu_startup_entry()

Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v3: Fixed linux/stackprotector.h inclusion

 v2: Revised commit log (#if defined  had been droped by 'git commit')

 arch/x86/xen/smp_pv.c |  2 ++
 kernel/sched/idle.c   | 15 ---------------
 kernel/sched/sched.h  |  1 -
 3 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index e3b18ad49889..145506f9fdbe 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -22,6 +22,7 @@
 #include <linux/tick.h>
 #include <linux/nmi.h>
 #include <linux/cpuhotplug.h>
+#include <linux/stackprotector.h>
 
 #include <asm/paravirt.h>
 #include <asm/desc.h>
@@ -88,6 +89,7 @@ static void cpu_bringup(void)
 asmlinkage __visible void cpu_bringup_and_idle(void)
 {
 	cpu_bringup();
+	boot_init_stack_canary();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 16f84142f2f4..f5516bae0c1b 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -347,21 +347,6 @@ EXPORT_SYMBOL_GPL(play_idle);
 
 void cpu_startup_entry(enum cpuhp_state state)
 {
-	/*
-	 * This #ifdef needs to die, but it's too late in the cycle to
-	 * make this generic (ARM and SH have never invoked the canary
-	 * init for the non boot CPUs!). Will be fixed in 3.11
-	 */
-#ifdef CONFIG_X86
-	/*
-	 * If we're the non-boot CPU, nothing set the stack canary up
-	 * for us. The boot CPU already has it initialized but no harm
-	 * in doing it again. This is a good place for updating it, as
-	 * we wont ever return from this function (so the invalid
-	 * canaries already on the stack wont ever trigger).
-	 */
-	boot_init_stack_canary();
-#endif
 	arch_cpu_idle_prepare();
 	cpuhp_online_idle(state);
 	while (1)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 455fa330de04..75a718ef771d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -56,7 +56,6 @@
 #include <linux/profile.h>
 #include <linux/rcupdate_wait.h>
 #include <linux/security.h>
-#include <linux/stackprotector.h>
 #include <linux/stop_machine.h>
 #include <linux/suspend.h>
 #include <linux/swait.h>
-- 
2.17.1

