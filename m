Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5241C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E85217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbfB0QGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:06:13 -0500
Received: from mga02.intel.com ([134.134.136.20]:24153 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729825AbfB0QF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:05:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 08:05:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,420,1544515200"; 
   d="scan'208";a="303011737"
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
  by orsmga005.jf.intel.com with ESMTP; 27 Feb 2019 08:05:55 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>
Cc:     Ashok Raj <ashok.raj@intel.com>, Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [RFC PATCH v2 13/14] watchdog/hardlockup/hpet: Only enable the HPET watchdog via a boot parameter
Date:   Wed, 27 Feb 2019 08:05:17 -0800
Message-Id: <1551283518-18922-14-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep the HPET-based hardlockup detector disabled unless explicitly enabled
via a command line argument. If such parameter is not given, the hardlockup
detector will fallback to use the perf-based implementation.

The function hardlockup_panic_setup() is updated to return 0 in order to
to allow __setup functions of specific hardlockup detectors (in this case
hardlockup_detector_hpet_setup()) to inspect the nmi_watchdog boot
parameter.

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Nayna Jain <nayna@linux.ibm.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

--
checkpatch gives the following warning:

CHECK: __setup appears un-documented -- check Documentation/admin-guide/kernel-parameters.rst
+__setup("nmi_watchdog=", hardlockup_detector_hpet_setup);

This is a false-positive as the option nmi_watchdog is already
documented. The option is re-evaluated in this file as well.
---
 .../admin-guide/kernel-parameters.txt         |  6 +++++-
 arch/x86/kernel/watchdog_hld_hpet.c           | 20 +++++++++++++++++++
 kernel/watchdog.c                             |  2 +-
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cf8f5877d85f..c6270ddeb130 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2739,7 +2739,7 @@
 			Format: [state][,regs][,debounce][,die]
 
 	nmi_watchdog=	[KNL,BUGS=X86] Debugging features for SMP kernels
-			Format: [panic,][nopanic,][num]
+			Format: [panic,][nopanic,][num,][hpet]
 			Valid num: 0 or 1
 			0 - turn hardlockup detector in nmi_watchdog off
 			1 - turn hardlockup detector in nmi_watchdog on
@@ -2749,6 +2749,10 @@
 			please see 'nowatchdog'.
 			This is useful when you use a panic=... timeout and
 			need the box quickly up again.
+			When hpet is specified, the NMI watchdog will be driven
+			by an HPET timer, if available in the system. Otherwise,
+			the perf-based implementation will be used. Specifying
+			hpet implies that nmi_watchdog is on.
 
 			These settings can be accessed at runtime via
 			the nmi_watchdog and hardlockup_panic sysctls.
diff --git a/arch/x86/kernel/watchdog_hld_hpet.c b/arch/x86/kernel/watchdog_hld_hpet.c
index 65b4699f249a..4402deff4b77 100644
--- a/arch/x86/kernel/watchdog_hld_hpet.c
+++ b/arch/x86/kernel/watchdog_hld_hpet.c
@@ -20,6 +20,7 @@
 #include <asm/hpet.h>
 
 static struct hpet_hld_data *hld_data;
+static bool hardlockup_use_hpet;
 
 /**
  * get_count() - Get the current count of the HPET timer
@@ -391,6 +392,22 @@ void hardlockup_detector_hpet_stop(void)
 	disable_timer(hld_data);
 }
 
+/**
+ * hardlockup_detector_hpet_setup() - Parse command-line parameters
+ * @str:	A string containing the kernel command line
+ *
+ * Parse the nmi_watchdog parameter from the kernel command line. If
+ * selected by the user, use this implementation to detect hardlockups.
+ */
+static int __init hardlockup_detector_hpet_setup(char *str)
+{
+	if (strstr(str, "hpet"))
+		hardlockup_use_hpet = true;
+
+	return 0;
+}
+__setup("nmi_watchdog=", hardlockup_detector_hpet_setup);
+
 /**
  * hardlockup_detector_hpet_init() - Initialize the hardlockup detector
  *
@@ -405,6 +422,9 @@ int __init hardlockup_detector_hpet_init(void)
 {
 	int ret;
 
+	if (!hardlockup_use_hpet)
+		return -ENODEV;
+
 	if (!is_hpet_enabled())
 		return -ENODEV;
 
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 367aa81294ef..28cad7310378 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -78,7 +78,7 @@ static int __init hardlockup_panic_setup(char *str)
 		nmi_watchdog_user_enabled = 0;
 	else if (!strncmp(str, "1", 1))
 		nmi_watchdog_user_enabled = 1;
-	return 1;
+	return 0;
 }
 __setup("nmi_watchdog=", hardlockup_panic_setup);
 
-- 
2.17.1

