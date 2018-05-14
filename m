Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752311AbeENSxv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:53:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:55033 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752061AbeENSwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:52:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,401,1520924400";
   d="scan'208";a="39244647"
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Rafael Wysocki" <rafael.j.wysocki@intel.com>,
        "Arjan van de Ven" <arjan@infradead.org>,
        "Alan Cox" <alan@linux.intel.com>
Cc: "x86" <x86@kernel.org>, "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 09/15] x86/split_lock: Explicitly enable or disable #AC for split locked accesses
Date: Mon, 14 May 2018 11:52:19 -0700
Message-Id: <1526323945-211107-10-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
References: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, we don't set or clear the bit 29 in TEST_CTL MSR 0x33 and
the bit is inherited from BIOS/hardware setting.

The kernel parameter "split_lock_ac=on/off" explicitly sets or clears
the bit during boot time.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
 arch/x86/kernel/cpu/split_lock.c                | 16 ++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 11fc28ecdb6d..862758533346 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4030,6 +4030,17 @@
 	spia_pedr=
 	spia_peddr=
 
+	split_lock_ac=	[X86] Enable or disable #AC exception for
+			split locked accesses
+			By default, kernel just inherits setting by
+			hardware and BIOS which may enable or disable
+			the feature. User can explicitly enable or disable
+			the feature by this parameter to override
+			BIOS/hardware setting.
+
+		on	Enable #AC exception for split locked accesses.
+		off	Disable #AC exception for split locked accesses.
+
 	srcutree.counter_wrap_check [KNL]
 			Specifies how frequently to check for
 			grace-period sequence counter wrap for the
diff --git a/arch/x86/kernel/cpu/split_lock.c b/arch/x86/kernel/cpu/split_lock.c
index 5187a9c6cea6..bc66c21b0ca9 100644
--- a/arch/x86/kernel/cpu/split_lock.c
+++ b/arch/x86/kernel/cpu/split_lock.c
@@ -85,6 +85,22 @@ void __init enumerate_split_lock(void)
 	pr_info("#AC exception for split locked accesses is supported\n");
 }
 
+static __init int setup_split_lock_ac(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	if (!strncmp(str, "on", 2))
+		split_lock_ac = ENABLE_SPLIT_LOCK_AC;
+	else if (!strncmp(str, "off", 3))
+		split_lock_ac = DISABLE_SPLIT_LOCK_AC;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+__setup("split_lock_ac=", setup_split_lock_ac);
+
 static bool _setup_split_lock(int split_lock_ac_val)
 {
 	u32 l, h;
-- 
2.5.0
