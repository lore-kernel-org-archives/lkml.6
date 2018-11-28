Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E487C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9C920832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E9C920832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbeK1UyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:54:15 -0500
Received: from mga14.intel.com ([192.55.52.115]:51816 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbeK1UyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:54:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 01:53:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,290,1539673200"; 
   d="scan'208";a="113684944"
Received: from shbuild999.sh.intel.com ([10.239.146.218])
  by fmsmga004.fm.intel.com with ESMTP; 28 Nov 2018 01:53:08 -0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v3 2/2] kernel/sysctl: Add panic_print into sysctl
Date:   Wed, 28 Nov 2018 17:54:02 +0800
Message-Id: <1543398842-19295-3-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543398842-19295-1-git-send-email-feng.tang@intel.com>
References: <1543398842-19295-1-git-send-email-feng.tang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that we can also runtime chose to print out the needed
system info for panic, other than setting the kernel cmdline.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Feng Tang <feng.tang@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 Documentation/sysctl/kernel.txt | 17 +++++++++++++++++
 include/linux/kernel.h          |  1 +
 include/uapi/linux/sysctl.h     |  1 +
 kernel/panic.c                  |  2 +-
 kernel/sysctl.c                 |  7 +++++++
 kernel/sysctl_binary.c          |  1 +
 6 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
index 1b87752..c0527d8 100644
--- a/Documentation/sysctl/kernel.txt
+++ b/Documentation/sysctl/kernel.txt
@@ -60,6 +60,7 @@ show up in /proc/sys/kernel:
 - panic_on_stackoverflow
 - panic_on_unrecovered_nmi
 - panic_on_warn
+- panic_print
 - panic_on_rcu_stall
 - perf_cpu_time_max_percent
 - perf_event_paranoid
@@ -654,6 +655,22 @@ a kernel rebuild when attempting to kdump at the location of a WARN().
 
 ==============================================================
 
+panic_print:
+
+Bitmask for printing system info when panic happens. User can chose
+combination of the following bits:
+
+bit 0: print all tasks info
+bit 1: print system memory info
+bit 2: print timer info
+bit 3: print locks info if CONFIG_LOCKDEP is on
+bit 4: print ftrace buffer
+
+So for example to print tasks and memory info on panic, user can:
+  echo 3 > /proc/sys/kernel/panic_print
+
+==============================================================
+
 panic_on_rcu_stall:
 
 When set to 1, calls panic() after RCU stall detection messages. This
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d6aac75..8f0e68e 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -527,6 +527,7 @@ static inline u32 int_sqrt64(u64 x)
 extern void bust_spinlocks(int yes);
 extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
 extern int panic_timeout;
+extern unsigned long panic_print;
 extern int panic_on_oops;
 extern int panic_on_unrecovered_nmi;
 extern int panic_on_io_nmi;
diff --git a/include/uapi/linux/sysctl.h b/include/uapi/linux/sysctl.h
index d71013f..87aa2a6 100644
--- a/include/uapi/linux/sysctl.h
+++ b/include/uapi/linux/sysctl.h
@@ -153,6 +153,7 @@ enum
 	KERN_NMI_WATCHDOG=75, /* int: enable/disable nmi watchdog */
 	KERN_PANIC_ON_NMI=76, /* int: whether we will panic on an unrecovered */
 	KERN_PANIC_ON_WARN=77, /* int: call panic() in WARN() functions */
+	KERN_PANIC_PRINT=78, /* ulong: bitmask to print system info on panic */
 };
 
 
diff --git a/kernel/panic.c b/kernel/panic.c
index fb6ccd1..85c4d14 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -50,7 +50,7 @@ EXPORT_SYMBOL_GPL(panic_timeout);
 #define PANIC_PRINT_TIMER_INFO		0x00000004
 #define PANIC_PRINT_LOCK_INFO		0x00000008
 #define PANIC_PRINT_FTRACE_INFO		0x00000010
-static unsigned long panic_print;
+unsigned long panic_print;
 
 ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 5fc724e..818da9a 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -807,6 +807,13 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+	{
+		.procname	= "panic_print",
+		.data		= &panic_print,
+		.maxlen		= sizeof(unsigned long),
+		.mode		= 0644,
+		.proc_handler	= proc_doulongvec_minmax,
+	},
 #if defined CONFIG_PRINTK
 	{
 		.procname	= "printk",
diff --git a/kernel/sysctl_binary.c b/kernel/sysctl_binary.c
index 07148b4..73c1320 100644
--- a/kernel/sysctl_binary.c
+++ b/kernel/sysctl_binary.c
@@ -140,6 +140,7 @@ static const struct bin_table bin_kern_table[] = {
 	{ CTL_INT,	KERN_MAX_LOCK_DEPTH,		"max_lock_depth" },
 	{ CTL_INT,	KERN_PANIC_ON_NMI,		"panic_on_unrecovered_nmi" },
 	{ CTL_INT,	KERN_PANIC_ON_WARN,		"panic_on_warn" },
+	{ CTL_ULONG,	KERN_PANIC_PRINT,		"panic_print" },
 	{}
 };
 
-- 
2.7.4

