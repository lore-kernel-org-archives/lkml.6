Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161963AbeCAVOT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:14:19 -0500
Received: from merlin.infradead.org ([205.233.59.134]:50308 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033189AbeCAVOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:14:15 -0500
To: LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] lib/Kconfig.debug: Debug Lockups and Hangs: keep SOFTLOCKUP
 options together
Message-ID: <6be2d9ed-4656-5b94-460d-7f051e2c7570@infradead.org>
Date: Thu, 1 Mar 2018 13:14:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Keep all of the SOFTLOCKUP kconfig symbols together (instead of
injecting the HARDLOCKUP symbols in the midst of them) so that
the config tools display them with their dependencies.

Fixes: 05a4a9527931 ("kernel/watchdog: split up config options")

Tested with 'make {menuconfig/nconfig/gconfig/xconfig}'.

Cc: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---

Is there a way to look at commit 05a4a9527931:

commit 05a4a95279311c3a4633b4277a5d21cfd616c6c7
Author: Nicholas Piggin <npiggin@gmail.com>
Date:   Wed Jul 12 14:35:46 2017 -0700

and determine which kernel versions a patch should be applied to for -stable?
(just in general -- not that I am saying this patch should go to -stable)
Or should I just answer this by looking at the dates that various kernels
were released and then choose the kernel version after 2017-July-12 as when
this patch was first used?


 lib/Kconfig.debug |   48 ++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

--- linux-next-20180301.orig/lib/Kconfig.debug
+++ linux-next-20180301/lib/Kconfig.debug
@@ -803,6 +803,30 @@ config SOFTLOCKUP_DETECTOR
 	  chance to run.  The current stack trace is displayed upon
 	  detection and the system will stay locked up.
 
+config BOOTPARAM_SOFTLOCKUP_PANIC
+	bool "Panic (Reboot) On Soft Lockups"
+	depends on SOFTLOCKUP_DETECTOR
+	help
+	  Say Y here to enable the kernel to panic on "soft lockups",
+	  which are bugs that cause the kernel to loop in kernel
+	  mode for more than 20 seconds (configurable using the watchdog_thresh
+	  sysctl), without giving other tasks a chance to run.
+
+	  The panic can be used in combination with panic_timeout,
+	  to cause the system to reboot automatically after a
+	  lockup has been detected. This feature is useful for
+	  high-availability systems that have uptime guarantees and
+	  where a lockup must be resolved ASAP.
+
+	  Say N if unsure.
+
+config BOOTPARAM_SOFTLOCKUP_PANIC_VALUE
+	int
+	depends on SOFTLOCKUP_DETECTOR
+	range 0 1
+	default 0 if !BOOTPARAM_SOFTLOCKUP_PANIC
+	default 1 if BOOTPARAM_SOFTLOCKUP_PANIC
+
 config HARDLOCKUP_DETECTOR_PERF
 	bool
 	select SOFTLOCKUP_DETECTOR
@@ -852,30 +876,6 @@ config BOOTPARAM_HARDLOCKUP_PANIC_VALUE
 	default 0 if !BOOTPARAM_HARDLOCKUP_PANIC
 	default 1 if BOOTPARAM_HARDLOCKUP_PANIC
 
-config BOOTPARAM_SOFTLOCKUP_PANIC
-	bool "Panic (Reboot) On Soft Lockups"
-	depends on SOFTLOCKUP_DETECTOR
-	help
-	  Say Y here to enable the kernel to panic on "soft lockups",
-	  which are bugs that cause the kernel to loop in kernel
-	  mode for more than 20 seconds (configurable using the watchdog_thresh
-	  sysctl), without giving other tasks a chance to run.
-
-	  The panic can be used in combination with panic_timeout,
-	  to cause the system to reboot automatically after a
-	  lockup has been detected. This feature is useful for
-	  high-availability systems that have uptime guarantees and
-	  where a lockup must be resolved ASAP.
-
-	  Say N if unsure.
-
-config BOOTPARAM_SOFTLOCKUP_PANIC_VALUE
-	int
-	depends on SOFTLOCKUP_DETECTOR
-	range 0 1
-	default 0 if !BOOTPARAM_SOFTLOCKUP_PANIC
-	default 1 if BOOTPARAM_SOFTLOCKUP_PANIC
-
 config DETECT_HUNG_TASK
 	bool "Detect Hung Tasks"
 	depends on DEBUG_KERNEL
