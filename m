Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63E0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700C220831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700C220831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392406AbeKVRrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:47:43 -0500
Received: from mga09.intel.com ([134.134.136.24]:47334 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbeKVRrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:47:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 23:09:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,264,1539673200"; 
   d="scan'208";a="106733299"
Received: from shbuild999.sh.intel.com ([10.239.146.218])
  by fmsmga002.fm.intel.com with ESMTP; 21 Nov 2018 23:09:36 -0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Feng Tang <feng.tang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH] panic: Add options to dump system info when panic happens
Date:   Thu, 22 Nov 2018 15:10:31 +0800
Message-Id: <1542870631-77074-1-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel panic issues are always painful to debug, partially
because of it's not easy to get enough information of the
context when panic happens.

And we have ramoops and kdump for that, while this commit
tries to a easier way to show the system info by adding a
cmdline parameter, referring some idea from sysrq handler.

Signed-off-by: Feng Tang <feng.tang@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
This patch is frequently used by us when debugging panic and system
stability bugs, and does help much. And the options could be expanded
more to cover other info like the ftrace, signal etc.

 Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
 kernel/panic.c                                  | 26 +++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 81d1d5a..8d349a8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3081,6 +3081,13 @@
 			timeout < 0: reboot immediately
 			Format: <timeout>
 
+	panic_dump=	Bitmask for dumping system info when panic happens.
+			User can chose combination of the following bits:
+			bit 0: dump all tasks info
+			bit 1: dump system memory info
+			bit 2: dump timer info
+			bit 3: dump locks info if CONFIG_LOCKDEP is on
+
 	panic_on_warn	panic() instead of WARN().  Useful to cause kdump
 			on a WARN().
 
diff --git a/kernel/panic.c b/kernel/panic.c
index f6d549a..8320d04 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -45,6 +45,12 @@ int panic_on_warn __read_mostly;
 int panic_timeout = CONFIG_PANIC_TIMEOUT;
 EXPORT_SYMBOL_GPL(panic_timeout);
 
+#define PANIC_DUMP_TASK_INFO	0x00000001
+#define PANIC_DUMP_MEM_INFO	0x00000002
+#define PANIC_DUMP_TIMER_INFO	0x00000004
+#define PANIC_DUMP_LOCK_INFO	0x00000008
+static unsigned long panic_dump;
+
 ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
 
 EXPORT_SYMBOL(panic_notifier_list);
@@ -124,6 +130,23 @@ void nmi_panic(struct pt_regs *regs, const char *msg)
 }
 EXPORT_SYMBOL(nmi_panic);
 
+static void panic_dump_sys_info(void)
+{
+	if (panic_dump & PANIC_DUMP_TASK_INFO)
+		show_state();
+
+	if (panic_dump & PANIC_DUMP_MEM_INFO)
+		show_mem(0, NULL);
+
+	if (panic_dump & PANIC_DUMP_TIMER_INFO)
+		sysrq_timer_list_show();
+
+#ifdef COFNIG_LOCKDEP
+	if (panic_dump & PANIC_DUMP_LOCK_INFO)
+		debug_show_all_locks();
+#endif
+}
+
 /**
  *	panic - halt the system
  *	@fmt: The text string to print
@@ -250,6 +273,8 @@ void panic(const char *fmt, ...)
 	debug_locks_off();
 	console_flush_on_panic();
 
+	panic_dump_sys_info();
+
 	if (!panic_blink)
 		panic_blink = no_blink;
 
@@ -654,6 +679,7 @@ void refcount_error_report(struct pt_regs *regs, const char *err)
 #endif
 
 core_param(panic, panic_timeout, int, 0644);
+core_param(panic_dump, panic_dump, ulong, 0644);
 core_param(pause_on_oops, pause_on_oops, int, 0644);
 core_param(panic_on_warn, panic_on_warn, int, 0644);
 core_param(crash_kexec_post_notifiers, crash_kexec_post_notifiers, bool, 0644);
-- 
2.7.4

