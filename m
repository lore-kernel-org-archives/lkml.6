Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032840AbeE0PtR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 11:49:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:28381 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032791AbeE0PqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 11:46:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,448,1520924400";
   d="scan'208";a="227741092"
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>
Cc: "Ashok Raj" <ashok.raj@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Rafael Wysocki" <rafael.j.wysocki@intel.com>,
        "Tony Luck" <tony.luck@intel.com>, "Alan Cox" <alan@linux.intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Arjan van de Ven" <arjan@infradead.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>, "x86" <x86@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [RFC PATCH 09/16] x86/split_lock: Add CONFIG to control #AC for split lock at boot time
Date: Sun, 27 May 2018 08:45:58 -0700
Message-Id: <1527435965-202085-10-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User wants to specify how to set up #AC for split lock at boot time.

CONFIG_SPLIT_LOCK_AC_ENABLE_DEFAULT is added to control split
lock setting at boot time.

Default value is 2: Don't explicitly enable or disable #AC for split lock.
Inherit setting of #AC for split lock from firmware.

Value 0 to explicitly disable split lock at boot time.

Value 1 to explicitly enable split lock at boot time.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/Kconfig               | 14 ++++++++++++++
 arch/x86/kernel/cpu/test_ctl.c | 12 ++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 043cde9a9b08..1d0dcd6fa69a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -461,6 +461,20 @@ config SPLIT_LOCK_AC
 
 	  Say N if unsure.
 
+config SPLIT_LOCK_AC_ENABLE_DEFAULT
+	int "#AC for split lock enable value (0-2) at boot time"
+	range 0 2
+	default "2"
+	depends on SPLIT_LOCK_AC
+	help
+	  Set #AC for split lock enable default value at boot time
+		0: Explicitly disable #AC for split lock at boot time.
+		1: Explicitly enable #AC for split lock at boot time.
+		2: Don't explicitly enable or disable #AC for split lock.
+		   Inherit setting of #AC for split lock from firmware.
+
+	  Leave this to the default value of 2 if you are unsure.
+
 if X86_32
 config X86_BIGSMP
 	bool "Support for big SMP systems with more than 8 CPUs"
diff --git a/arch/x86/kernel/cpu/test_ctl.c b/arch/x86/kernel/cpu/test_ctl.c
index 82440740b2b9..a2f84fcd4da1 100644
--- a/arch/x86/kernel/cpu/test_ctl.c
+++ b/arch/x86/kernel/cpu/test_ctl.c
@@ -21,6 +21,7 @@
 
 #define DISABLE_SPLIT_LOCK_AC		0
 #define ENABLE_SPLIT_LOCK_AC		1
+#define INHERIT_SPLIT_LOCK_AC_FIRMWARE	2
 
 /* After disabling #AC for split lock in handler, re-enable it 1 msec later. */
 #define reenable_split_lock_delay	msecs_to_jiffies(1)
@@ -71,6 +72,17 @@ void detect_split_lock_ac(void)
 		split_lock_ac_firmware = ENABLE_SPLIT_LOCK_AC;
 	else
 		split_lock_ac_firmware = DISABLE_SPLIT_LOCK_AC;
+
+	/*
+	 * By default configuration, kernel inherits firmware split lock
+	 * setting. Kernel can be configured to explicitly enable or disable
+	 * #AC for split lock to override firmware setting.
+	 */
+	if (CONFIG_SPLIT_LOCK_AC_ENABLE_DEFAULT ==
+	    INHERIT_SPLIT_LOCK_AC_FIRMWARE)
+		split_lock_ac_kernel = split_lock_ac_firmware;
+	else
+		split_lock_ac_kernel = CONFIG_SPLIT_LOCK_AC_ENABLE_DEFAULT;
 }
 
 static void _setup_split_lock(int split_lock_ac_val)
-- 
2.5.0
