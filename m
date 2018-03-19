Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971797AbeCSU4i (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:56:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:62510 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965309AbeCSSIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:08:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="39330583"
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: x86@kernel.org
Cc: luto@kernel.org, ak@linux.intel.com, hpa@zytor.com,
        markus.t.metzger@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH 08/15] x86/fsgsbase/64: Add 'unsafe_fsgsbase' to enable CR4.FSGSBASE
Date: Mon, 19 Mar 2018 10:49:20 -0700
Message-Id: <1521481767-22113-9-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

This is temporary.  It will allow the next few patches to be tested
incrementally.

Setting unsafe_fsgsbase is a root hole.  Don't do it.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
[chang: Fix the deactivated flag]
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 arch/x86/kernel/cpu/common.c                    | 25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1d1d53f..87c2260 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2567,6 +2567,9 @@
 			emulation library even if a 387 maths coprocessor
 			is present.
 
+	unsafe_fsgsbase	[X86] Allow FSGSBASE instructions.  This will be
+			replaced with a  nofsgsbase flag.
+
 	no_console_suspend
 			[HW] Never suspend the console
 			Disable suspending of consoles during suspend and
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 348cf48..019bdc3 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -356,6 +356,23 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
 }
 
 /*
+ * Temporary hack: FSGSBASE is unsafe until a few kernel code paths are updated.
+ * This allows us to get the kernel ready incrementally.  Setting
+ * unsafe_fsgsbase will allow the series to be bisected if necessary.
+ *
+ * Once all the pieces are in place, this will go away and be replaced with
+ * a nofsgsbase chicken flag.
+ */
+static bool unsafe_fsgsbase;
+
+static __init int setup_unsafe_fsgsbase(char *arg)
+{
+	unsafe_fsgsbase = true;
+	return 1;
+}
+__setup("unsafe_fsgsbase", setup_unsafe_fsgsbase);
+
+/*
  * Protection Keys are not available in 32-bit mode.
  */
 static bool pku_disabled;
@@ -1238,6 +1255,14 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	setup_smap(c);
 	setup_umip(c);
 
+	/* Enable FSGSBASE instructions if available. */
+	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
+		if (unsafe_fsgsbase)
+			cr4_set_bits(X86_CR4_FSGSBASE);
+		else
+			clear_cpu_cap(c, X86_FEATURE_FSGSBASE);
+	}
+
 	/*
 	 * The vendor-specific functions might have changed features.
 	 * Now we do "generic changes."
-- 
2.7.4
