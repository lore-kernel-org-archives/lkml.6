Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509D8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E96220989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E96220989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbeK0SLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:11:20 -0500
Received: from mga11.intel.com ([192.55.52.93]:5255 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727463AbeK0SLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:11:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 23:14:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,285,1539673200"; 
   d="scan'208";a="92941709"
Received: from shbuild999.sh.intel.com ([10.239.146.218])
  by fmsmga008.fm.intel.com with ESMTP; 26 Nov 2018 23:14:23 -0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Feng Tang <feng.tang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2] panic: Add options to print system info when panic happens
Date:   Tue, 27 Nov 2018 15:15:20 +0800
Message-Id: <1543302920-13044-1-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel panic issues are always painful to debug, partially
because it's not easy to get enough information of the
context when panic happens.

And we have ramoops and kdump for that, while this commit
tries to provide a easier way to show the system info by adding
a cmdline parameter, referring some idea from sysrq handler.

Signed-off-by: Feng Tang <feng.tang@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
Changelog:
 v2:
    - change text "dump/DUMP" to "print/PRINT" which
      is more accurate, suggested by Andrew Morton 
    - add code to print ftrace buffer 

 Documentation/admin-guide/kernel-parameters.txt |  8 +++++++
 kernel/panic.c                                  | 28 +++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 19f4423..80c819a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3081,6 +3081,14 @@
 			timeout < 0: reboot immediately
 			Format: <timeout>
 
+	panic_print=	Bitmask for printing system info when panic happens.
+			User can chose combination of the following bits:
+			bit 0: print all tasks info
+			bit 1: print system memory info
+			bit 2: print timer info
+			bit 3: print locks info if CONFIG_LOCKDEP is on
+			bit 4: print ftrace buffer
+
 	panic_on_warn	panic() instead of WARN().  Useful to cause kdump
 			on a WARN().
 
diff --git a/kernel/panic.c b/kernel/panic.c
index f6d549a..fb6ccd1 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -45,6 +45,13 @@ int panic_on_warn __read_mostly;
 int panic_timeout = CONFIG_PANIC_TIMEOUT;
 EXPORT_SYMBOL_GPL(panic_timeout);
 
+#define PANIC_PRINT_TASK_INFO		0x00000001
+#define PANIC_PRINT_MEM_INFO		0x00000002
+#define PANIC_PRINT_TIMER_INFO		0x00000004
+#define PANIC_PRINT_LOCK_INFO		0x00000008
+#define PANIC_PRINT_FTRACE_INFO		0x00000010
+static unsigned long panic_print;
+
 ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
 
 EXPORT_SYMBOL(panic_notifier_list);
@@ -124,6 +131,24 @@ void nmi_panic(struct pt_regs *regs, const char *msg)
 }
 EXPORT_SYMBOL(nmi_panic);
 
+static void panic_print_sys_info(void)
+{
+	if (panic_print & PANIC_PRINT_TASK_INFO)
+		show_state();
+
+	if (panic_print & PANIC_PRINT_MEM_INFO)
+		show_mem(0, NULL);
+
+	if (panic_print & PANIC_PRINT_TIMER_INFO)
+		sysrq_timer_list_show();
+
+	if (panic_print & PANIC_PRINT_LOCK_INFO)
+		debug_show_all_locks();
+
+	if (panic_print & PANIC_PRINT_FTRACE_INFO)
+		ftrace_dump(DUMP_ALL);
+}
+
 /**
  *	panic - halt the system
  *	@fmt: The text string to print
@@ -250,6 +275,8 @@ void panic(const char *fmt, ...)
 	debug_locks_off();
 	console_flush_on_panic();
 
+	panic_print_sys_info();
+
 	if (!panic_blink)
 		panic_blink = no_blink;
 
@@ -654,6 +681,7 @@ void refcount_error_report(struct pt_regs *regs, const char *err)
 #endif
 
 core_param(panic, panic_timeout, int, 0644);
+core_param(panic_print, panic_print, ulong, 0644);
 core_param(pause_on_oops, pause_on_oops, int, 0644);
 core_param(panic_on_warn, panic_on_warn, int, 0644);
 core_param(crash_kexec_post_notifiers, crash_kexec_post_notifiers, bool, 0644);
-- 
2.7.4

