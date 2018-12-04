Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF30C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F832146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUKxXYCY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F832146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbeLDLEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:04:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:52132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728048AbeLDLEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:04:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A38E21508;
        Tue,  4 Dec 2018 11:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921487;
        bh=PNw2xhZ5F/JA0yP349XyWIHBlvw8ZEXnLpExiYK2fUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uUKxXYCYf0ekTOoD02hqHDb5p0dst9KNu4NiEmfrRsYZyhORyMQAfoxUFneg3JWDb
         TDL62ZBHP/D12n4+31c1WqX/kkRZpy3AjN3vQgCPswGH7EIjqHQZjdsffkhRTM5env
         80i7Sfkbmqe0GAFX9Sol+CDjRf3c0CL/Gbrfm66c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 4.14 090/146] x86/speculation: Rework SMT state change
Date:   Tue,  4 Dec 2018 11:49:36 +0100
Message-Id: <20181204103730.454371353@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner tglx@linutronix.de

commit a74cfffb03b73d41e08f84c2e5c87dec0ce3db9f upstream

arch_smt_update() is only called when the sysfs SMT control knob is
changed. This means that when SMT is enabled in the sysfs control knob the
system is considered to have SMT active even if all siblings are offline.

To allow finegrained control of the speculation mitigations, the actual SMT
state is more interesting than the fact that siblings could be enabled.

Rework the code, so arch_smt_update() is invoked from each individual CPU
hotplug function, and simplify the update function while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Casey Schaufler <casey.schaufler@intel.com>
Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Jon Masters <jcm@redhat.com>
Cc: Waiman Long <longman9394@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Dave Stewart <david.c.stewart@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20181125185004.521974984@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |   11 +++++------
 include/linux/sched/smt.h  |    2 ++
 kernel/cpu.c               |   15 +++++++++------
 3 files changed, 16 insertions(+), 12 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/nospec.h>
 #include <linux/prctl.h>
+#include <linux/sched/smt.h>
 
 #include <asm/spec-ctrl.h>
 #include <asm/cmdline.h>
@@ -342,16 +343,14 @@ void arch_smt_update(void)
 		return;
 
 	mutex_lock(&spec_ctrl_mutex);
-	mask = x86_spec_ctrl_base;
-	if (cpu_smt_control == CPU_SMT_ENABLED)
+
+	mask = x86_spec_ctrl_base & ~SPEC_CTRL_STIBP;
+	if (sched_smt_active())
 		mask |= SPEC_CTRL_STIBP;
-	else
-		mask &= ~SPEC_CTRL_STIBP;
 
 	if (mask != x86_spec_ctrl_base) {
 		pr_info("Spectre v2 cross-process SMT mitigation: %s STIBP\n",
-				cpu_smt_control == CPU_SMT_ENABLED ?
-				"Enabling" : "Disabling");
+			mask & SPEC_CTRL_STIBP ? "Enabling" : "Disabling");
 		x86_spec_ctrl_base = mask;
 		on_each_cpu(update_stibp_msr, NULL, 1);
 	}
--- a/include/linux/sched/smt.h
+++ b/include/linux/sched/smt.h
@@ -15,4 +15,6 @@ static __always_inline bool sched_smt_ac
 static inline bool sched_smt_active(void) { return false; }
 #endif
 
+void arch_smt_update(void);
+
 #endif
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -10,6 +10,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/hotplug.h>
 #include <linux/sched/task.h>
+#include <linux/sched/smt.h>
 #include <linux/unistd.h>
 #include <linux/cpu.h>
 #include <linux/oom.h>
@@ -347,6 +348,12 @@ void cpu_hotplug_enable(void)
 EXPORT_SYMBOL_GPL(cpu_hotplug_enable);
 #endif	/* CONFIG_HOTPLUG_CPU */
 
+/*
+ * Architectures that need SMT-specific errata handling during SMT hotplug
+ * should override this.
+ */
+void __weak arch_smt_update(void) { }
+
 #ifdef CONFIG_HOTPLUG_SMT
 enum cpuhp_smt_control cpu_smt_control __read_mostly = CPU_SMT_ENABLED;
 EXPORT_SYMBOL_GPL(cpu_smt_control);
@@ -998,6 +1005,7 @@ out:
 	 * concurrent CPU hotplug via cpu_add_remove_lock.
 	 */
 	lockup_detector_cleanup();
+	arch_smt_update();
 	return ret;
 }
 
@@ -1126,6 +1134,7 @@ static int _cpu_up(unsigned int cpu, int
 	ret = cpuhp_up_callbacks(cpu, st, target);
 out:
 	cpus_write_unlock();
+	arch_smt_update();
 	return ret;
 }
 
@@ -2045,12 +2054,6 @@ static void cpuhp_online_cpu_device(unsi
 	kobject_uevent(&dev->kobj, KOBJ_ONLINE);
 }
 
-/*
- * Architectures that need SMT-specific errata handling during SMT hotplug
- * should override this.
- */
-void __weak arch_smt_update(void) { };
-
 static int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 {
 	int cpu, ret = 0;


