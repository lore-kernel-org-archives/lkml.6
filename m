Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754674AbeD3P7Y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:59:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39284 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754474AbeD3P7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:59:23 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 174BB60271
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From: Jeffrey Hugo <jhugo@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
        Jan Glauber <jan.glauber@caviumnetworks.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Laura Abbott <labbott@redhat.com>,
        Timur Tabi <timur@codeaurora.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v3] init: Fix false positives in W+X checking
Date: Mon, 30 Apr 2018 09:59:06 -0600
Message-Id: <1525103946-29526-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

load_module() creates W+X mappings via __vmalloc_node_range() (from
layout_and_allocate()->move_module()->module_alloc()) by using
PAGE_KERNEL_EXEC.  These mappings are later cleaned up via
"call_rcu_sched(&freeinit->rcu, do_free_init)" from do_init_module().

This is a problem because call_rcu_sched() queues work, which can be run
after debug_checkwx() is run, resulting in a race condition.  If hit, the
race results in a nasty splat about insecure W+X mappings, which results
in a poor user experience as these are not the mappings that
debug_checkwx() is intended to catch.

This issue is observed on multiple arm64 platforms, and has been
artificially triggered on an x86 platform.

Address the race by flushing the queued work before running the
arch-defined mark_rodata_ro() which then calls debug_checkwx().

Reported-by: Timur Tabi <timur@codeaurora.org>
Reported-by: Jan Glauber <jan.glauber@caviumnetworks.com>
Fixes: e1a58320a38d ("x86/mm: Warn on W^X mappings")
Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Will Deacon <will.deacon@arm.com>
---

v3:
-added comment to module code to establish matching connection
-added acks by Kees, Ingo, and Will

v2:
-was "arm64: mm: Fix false positives in W+X checking" (see [1])
-moved to common code based on review and confirmation of issue on x86

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-April/573776.html

 init/main.c     | 7 +++++++
 kernel/module.c | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/init/main.c b/init/main.c
index b795aa3..499d957 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1034,6 +1034,13 @@ static int __init set_debug_rodata(char *str)
 static void mark_readonly(void)
 {
 	if (rodata_enabled) {
+		/*
+		 * load_module() results in W+X mappings, which are cleaned up
+		 * with call_rcu_sched().  Let's make sure that queued work is
+		 * flushed so that we don't hit false positives looking for
+		 * insecure pages which are W+X.
+		 */
+		rcu_barrier_sched();
 		mark_rodata_ro();
 		rodata_test();
 	} else
diff --git a/kernel/module.c b/kernel/module.c
index a6e43a5..7b71c3c 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3516,6 +3516,11 @@ static noinline int do_init_module(struct module *mod)
 	 * walking this with preempt disabled.  In all the failure paths, we
 	 * call synchronize_sched(), but we don't want to slow down the success
 	 * path, so use actual RCU here.
+	 * Note that module_alloc() on most architectures creates W+X page
+	 * mappings which won't be cleaned up until do_free_init() runs.  Any
+	 * code such as mark_rodata_ro() which depends on those mappings to
+	 * be cleaned up needs to sync with the queued work - ie
+	 * rcu_barrier_sched()
 	 */
 	call_rcu_sched(&freeinit->rcu, do_free_init);
 	mutex_unlock(&module_mutex);
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
