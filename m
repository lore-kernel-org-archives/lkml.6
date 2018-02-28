Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932304AbeB1PHT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 10:07:19 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52721 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932250AbeB1PHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:07:15 -0500
Date: Wed, 28 Feb 2018 07:07:06 -0800
From: tip-bot for Juergen Gross <tipbot@zytor.com>
Message-ID: <tip-71c208dd54ab971036d83ff6d9837bae4976e623@git.kernel.org>
Cc: jgross@suse.com, linux-kernel@vger.kernel.org, jbeulich@suse.com,
        hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org
Reply-To: mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        jbeulich@suse.com, jgross@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20180226140818.4849-1-jgross@suse.com>
References: <20180226140818.4849-1-jgross@suse.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/xen: Zero MSR_IA32_SPEC_CTRL before suspend
Git-Commit-ID: 71c208dd54ab971036d83ff6d9837bae4976e623
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  71c208dd54ab971036d83ff6d9837bae4976e623
Gitweb:     https://git.kernel.org/tip/71c208dd54ab971036d83ff6d9837bae4976e623
Author:     Juergen Gross <jgross@suse.com>
AuthorDate: Mon, 26 Feb 2018 15:08:18 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Feb 2018 16:03:19 +0100

x86/xen: Zero MSR_IA32_SPEC_CTRL before suspend

Older Xen versions (4.5 and before) might have problems migrating pv
guests with MSR_IA32_SPEC_CTRL having a non-zero value. So before
suspending zero that MSR and restore it after being resumed.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jan Beulich <jbeulich@suse.com>
Cc: stable@vger.kernel.org
Cc: xen-devel@lists.xenproject.org
Cc: boris.ostrovsky@oracle.com
Link: https://lkml.kernel.org/r/20180226140818.4849-1-jgross@suse.com

---
 arch/x86/xen/suspend.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/xen/suspend.c b/arch/x86/xen/suspend.c
index d9f96cc5d743..1d83152c761b 100644
--- a/arch/x86/xen/suspend.c
+++ b/arch/x86/xen/suspend.c
@@ -1,12 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/types.h>
 #include <linux/tick.h>
+#include <linux/percpu-defs.h>
 
 #include <xen/xen.h>
 #include <xen/interface/xen.h>
 #include <xen/grant_table.h>
 #include <xen/events.h>
 
+#include <asm/cpufeatures.h>
+#include <asm/msr-index.h>
 #include <asm/xen/hypercall.h>
 #include <asm/xen/page.h>
 #include <asm/fixmap.h>
@@ -15,6 +18,8 @@
 #include "mmu.h"
 #include "pmu.h"
 
+static DEFINE_PER_CPU(u64, spec_ctrl);
+
 void xen_arch_pre_suspend(void)
 {
 	xen_save_time_memory_area();
@@ -35,6 +40,9 @@ void xen_arch_post_suspend(int cancelled)
 
 static void xen_vcpu_notify_restore(void *data)
 {
+	if (xen_pv_domain() && boot_cpu_has(X86_FEATURE_SPEC_CTRL))
+		wrmsrl(MSR_IA32_SPEC_CTRL, this_cpu_read(spec_ctrl));
+
 	/* Boot processor notified via generic timekeeping_resume() */
 	if (smp_processor_id() == 0)
 		return;
@@ -44,7 +52,15 @@ static void xen_vcpu_notify_restore(void *data)
 
 static void xen_vcpu_notify_suspend(void *data)
 {
+	u64 tmp;
+
 	tick_suspend_local();
+
+	if (xen_pv_domain() && boot_cpu_has(X86_FEATURE_SPEC_CTRL)) {
+		rdmsrl(MSR_IA32_SPEC_CTRL, tmp);
+		this_cpu_write(spec_ctrl, tmp);
+		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+	}
 }
 
 void xen_arch_resume(void)
