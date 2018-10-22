Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3079DC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 05:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82B920644
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 05:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D82B920644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeJVNVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 09:21:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49235 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbeJVNVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 09:21:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9M53omf2444299
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 21 Oct 2018 22:03:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9M53nVG2444296;
        Sun, 21 Oct 2018 22:03:49 -0700
Date:   Sun, 21 Oct 2018 22:03:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Christophe Leroy <tipbot@zytor.com>
Message-ID: <tip-977e4be5eb714c48a67afc26a6c477f24130a1f2@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, jgross@suse.com,
        boris.ostrovsky@oracle.com, mingo@kernel.org, peterz@infradead.org,
        christophe.leroy@c-s.fr, tglx@linutronix.de,
        torvalds@linux-foundation.org, hpa@zytor.com, bp@alien8.de
Reply-To: tglx@linutronix.de, torvalds@linux-foundation.org, bp@alien8.de,
          hpa@zytor.com, linux-kernel@vger.kernel.org, jgross@suse.com,
          boris.ostrovsky@oracle.com, peterz@infradead.org,
          christophe.leroy@c-s.fr, mingo@kernel.org
In-Reply-To: <20181020072649.5B59310483E@pc16082vm.idsi0.si.c-s.fr>
References: <20181020072649.5B59310483E@pc16082vm.idsi0.si.c-s.fr>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/stackprotector: Remove the call to
 boot_init_stack_canary() from cpu_startup_entry()
Git-Commit-ID: 977e4be5eb714c48a67afc26a6c477f24130a1f2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  977e4be5eb714c48a67afc26a6c477f24130a1f2
Gitweb:     https://git.kernel.org/tip/977e4be5eb714c48a67afc26a6c477f24130a1f2
Author:     Christophe Leroy <christophe.leroy@c-s.fr>
AuthorDate: Sat, 20 Oct 2018 09:26:49 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 22 Oct 2018 04:07:24 +0200

x86/stackprotector: Remove the call to boot_init_stack_canary() from cpu_startup_entry()

The following commit:

  d7880812b359 ("idle: Add the stack canary init to cpu_startup_entry()")

... added an x86 specific boot_init_stack_canary() call to the generic
cpu_startup_entry() as a temporary hack, with the intention to remove
the #ifdef CONFIG_X86 later.

More than 5 years later let's finally realize that plan! :-)

While implementing stack protector support for PowerPC, we found
that calling boot_init_stack_canary() is also needed for PowerPC
which uses per task (TLS) stack canary like the X86.

However, calling boot_init_stack_canary() would break architectures
using a global stack canary (ARM, SH, MIPS and XTENSA).

Instead of modifying the #ifdef CONFIG_X86 to an even messier:

   #if defined(CONFIG_X86) || defined(CONFIG_PPC)

PowerPC implemented the call to boot_init_stack_canary() in the function
calling cpu_startup_entry().

Let's try the same cleanup on the x86 side as well.

On x86 we have two functions calling cpu_startup_entry():

 - start_secondary()
 - cpu_bringup_and_idle()

start_secondary() already calls boot_init_stack_canary(), so
it's good, and this patch adds the call to boot_init_stack_canary()
in cpu_bringup_and_idle().

I.e. now x86 catches up to the rest of the world and the ugly init
sequence in init/main.c can be removed from cpu_startup_entry().

As a final benefit we can also remove the <linux/stackprotector.h>
dependency from <linux/sched.h>.

[ mingo: Improved the changelog a bit, added language explaining x86 borkage and sched.h change. ]
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: xen-devel@lists.xenproject.org
Link: http://lkml.kernel.org/r/20181020072649.5B59310483E@pc16082vm.idsi0.si.c-s.fr
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
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
index 4a2e8cae63c4..5b00a816a4b3 100644
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
