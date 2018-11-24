Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191ECC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 07:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835BE2082F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 07:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835BE2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeKXSZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 13:25:28 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:14982 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbeKXSZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 13:25:28 -0500
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wAO7btHD088370;
        Sat, 24 Nov 2018 16:37:55 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Sat, 24 Nov 2018 16:37:55 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wAO7boAf088362
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 24 Nov 2018 16:37:55 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] printk: Add caller information to printk() output.
Date:   Sat, 24 Nov 2018 16:37:55 +0900
Message-Id: <1543045075-3008-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes we want to print a whole line without being disturbed by
concurrent printk() from interrupts and/or other threads, for printk()
which does not end with '\n' can be disturbed.

We tried to allow printk() callers to explicitly use their local buffer
in order to make sure that a whole line is printed by one printk() call.
But it turned out that it is not realistic to ask printk() callers to
update their function arguments only for handling rare race conditions.
Also, like Steven Rostedt mentioned at [1], buffering sometimes makes
the situation worse. Therefore, we should not enforce buffering in a way
that requires modification of printk() callers.

I need to give up (at least for now) manipulating text which will be
passed to printk(). Instead, I propose allow saving caller information
as of calling log_store() and adding it as "T$thread_id" or
"C$processor_id" upon printing each line of printk() output.


Some examples for console output:

  [    0.293000] [T1] smpboot: CPU0: Intel(R) Core(TM) i5-4440S CPU @ 2.80GHz (family: 0x6, model: 0x3c, stepping: 0x3)
  [    0.299733] [T1] Performance Events: Haswell events, core PMU driver.
  [    2.813808] [T35] clocksource: Switched to clocksource tsc
  [    2.893984] [C0] random: fast init done

Some examples for /dev/kmsg output:

  6,21,0,-,from=T0;NX (Execute Disable) protection: active
  6,22,0,-,from=T0;SMBIOS 2.7 present.
  6,23,0,-,from=T0;DMI: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 05/19/2017
  6,24,0,-,from=T0;tsc: Fast TSC calibration using PIT
  6,25,0,-,from=T0;tsc: Detected 2793.552 MHz processor
  7,26,858,-,from=T0;e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
  7,27,864,-,from=T0;e820: remove [mem 0x000a0000-0x000fffff] usable
  6,28,882,-,from=T0;last_pfn = 0x140000 max_arch_pfn = 0x400000000
  7,29,953,-,from=T0;MTRR default type: uncachable
  6,512,753757,-,from=T1;PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
  6,513,757721,-,from=T1;ACPI: Enabled 4 GPEs in block 00 to 0F
  6,514,984829,-,from=T1;ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7f])
  6,515,985728,-,from=T1;acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
   SUBSYSTEM=acpi
   DEVICE=+acpi:PNP0A03:00
  6,516,987723,-,from=T1;acpi PNP0A03:00: _OSC: platform does not support [AER LTR]
   SUBSYSTEM=acpi
   DEVICE=+acpi:PNP0A03:00
  6,517,989723,-,from=T1;acpi PNP0A03:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
   SUBSYSTEM=acpi
   DEVICE=+acpi:PNP0A03:00
  5,1493,2893984,-,from=C0;random: fast init done


[1] https://lkml.kernel.org/r/20181123105634.4956c255@vmware.local.home

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 kernel/printk/printk.c | 33 +++++++++++++++++++++++++++++++++
 lib/Kconfig.debug      | 17 +++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5c2079d..5ace5ba 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -356,6 +356,9 @@ struct printk_log {
 	u8 facility;		/* syslog facility */
 	u8 flags:5;		/* internal record flags */
 	u8 level:3;		/* syslog level */
+#ifdef CONFIG_PRINTK_FROM
+	u32 from_id;            /* thread id or processor id */
+#endif
 }
 #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 __packed __aligned(4)
@@ -609,6 +612,12 @@ static int log_store(int facility, int level,
 
 	/* fill message */
 	msg = (struct printk_log *)(log_buf + log_next_idx);
+#ifdef CONFIG_PRINTK_FROM
+	if (in_task())
+		msg->from_id = current->pid;
+	else
+		msg->from_id = 0x80000000 + raw_smp_processor_id();
+#endif
 	memcpy(log_text(msg), text, text_len);
 	msg->text_len = text_len;
 	if (trunc_msg_len) {
@@ -690,9 +699,17 @@ static ssize_t msg_print_ext_header(char *buf, size_t size,
 
 	do_div(ts_usec, 1000);
 
+#ifdef CONFIG_PRINTK_FROM
+	return scnprintf(buf, size, "%u,%llu,%llu,%c,from=%c%u;",
+			 (msg->facility << 3) | msg->level, seq, ts_usec,
+			 msg->flags & LOG_CONT ? 'c' : '-',
+			 msg->from_id & 0x80000000 ? 'C' : 'T',
+			 msg->from_id & ~0x80000000);
+#else
 	return scnprintf(buf, size, "%u,%llu,%llu,%c;",
 		       (msg->facility << 3) | msg->level, seq, ts_usec,
 		       msg->flags & LOG_CONT ? 'c' : '-');
+#endif
 }
 
 static ssize_t msg_print_ext_body(char *buf, size_t size,
@@ -1037,6 +1054,9 @@ void log_buf_vmcoreinfo_setup(void)
 	VMCOREINFO_OFFSET(printk_log, len);
 	VMCOREINFO_OFFSET(printk_log, text_len);
 	VMCOREINFO_OFFSET(printk_log, dict_len);
+#ifdef CONFIG_PRINTK_FROM
+	VMCOREINFO_OFFSET(printk_log, from_id);
+#endif
 }
 #endif
 
@@ -1242,6 +1262,16 @@ static size_t print_time(u64 ts, char *buf)
 		       (unsigned long)ts, rem_nsec / 1000);
 }
 
+#ifdef CONFIG_PRINTK_FROM
+static size_t print_from(u32 id, char *buf)
+{
+	char tmp[16];
+
+	return sprintf(buf ? buf : tmp, "[%c%u] ", id & 0x80000000 ? 'C' : 'T',
+		       id & ~0x80000000);
+}
+#endif
+
 static size_t print_prefix(const struct printk_log *msg, bool syslog, char *buf)
 {
 	size_t len = 0;
@@ -1262,6 +1292,9 @@ static size_t print_prefix(const struct printk_log *msg, bool syslog, char *buf)
 	}
 
 	len += print_time(msg->ts_nsec, buf ? buf + len : NULL);
+#ifdef CONFIG_PRINTK_FROM
+	len += print_from(msg->from_id, buf ? buf + len : NULL);
+#endif
 	return len;
 }
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1af29b8..bf84fdc 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -17,6 +17,23 @@ config PRINTK_TIME
 	  The behavior is also controlled by the kernel command line
 	  parameter printk.time=1. See Documentation/admin-guide/kernel-parameters.rst
 
+config PRINTK_FROM
+	bool "Show caller information on printks"
+	depends on PRINTK
+	help
+	  Selecting this option causes "thread id" (if in task context) or
+	  "processor id" (if not in task context) of the printk() messages
+	  to be added.
+
+	  This option is intended for environments where multiple threads
+	  concurrently call printk() for many times, for it is difficult to
+	  interpret without knowing where these lines (or sometimes individual
+	  line which was divided into multiple lines due to race) came from.
+
+	  Since this is currently an experimental functionality which might be
+	  changed/reverted in the future, there is no option to enable/disable
+	  at the kernel command line parameter or sysfs interface.
+
 config CONSOLE_LOGLEVEL_DEFAULT
 	int "Default console loglevel (1-15)"
 	range 1 15
-- 
1.8.3.1

