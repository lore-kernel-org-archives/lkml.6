Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971633AbeCSUxe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:53:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:62509 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968557AbeCSSI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:08:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="39330611"
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: x86@kernel.org
Cc: luto@kernel.org, ak@linux.intel.com, hpa@zytor.com,
        markus.t.metzger@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH 15/15] x86/fsgsbase/64: Enable FSGSBASE by default and add a chicken bit
Date: Mon, 19 Mar 2018 10:49:27 -0700
Message-Id: <1521481767-22113-16-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

Now that FSGSBASE is fully supported, remove unsafe_fsgsbase, enable
FSGSBASE by default, and add nofsgsbase to disable it.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  3 +--
 arch/x86/kernel/cpu/common.c                    | 33 +++++++++++--------------
 2 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 87c2260..433dd17 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2567,8 +2567,7 @@
 			emulation library even if a 387 maths coprocessor
 			is present.
 
-	unsafe_fsgsbase	[X86] Allow FSGSBASE instructions.  This will be
-			replaced with a  nofsgsbase flag.
+	nofsgsbase	[X86] Disables FSGSBASE instructions.
 
 	no_console_suspend
 			[HW] Never suspend the console
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 019bdc3..f9b7eba 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -355,22 +355,21 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
 	cr4_clear_bits(X86_CR4_UMIP);
 }
 
-/*
- * Temporary hack: FSGSBASE is unsafe until a few kernel code paths are updated.
- * This allows us to get the kernel ready incrementally.  Setting
- * unsafe_fsgsbase will allow the series to be bisected if necessary.
- *
- * Once all the pieces are in place, this will go away and be replaced with
- * a nofsgsbase chicken flag.
- */
-static bool unsafe_fsgsbase;
-
-static __init int setup_unsafe_fsgsbase(char *arg)
+static __init int x86_nofsgsbase_setup(char *arg)
 {
-	unsafe_fsgsbase = true;
+	/* require an exact match without trailing characters */
+	if (strlen(arg))
+		return 0;
+
+	/* do not emit a message if the feature is not present */
+	if (!boot_cpu_has(X86_FEATURE_FSGSBASE))
+		return 1;
+
+	setup_clear_cpu_cap(X86_FEATURE_FSGSBASE);
+	pr_info("nofsgsbase: FSGSBASE disabled\n");
 	return 1;
 }
-__setup("unsafe_fsgsbase", setup_unsafe_fsgsbase);
+__setup("nofsgsbase", x86_nofsgsbase_setup);
 
 /*
  * Protection Keys are not available in 32-bit mode.
@@ -1256,12 +1255,8 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	setup_umip(c);
 
 	/* Enable FSGSBASE instructions if available. */
-	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
-		if (unsafe_fsgsbase)
-			cr4_set_bits(X86_CR4_FSGSBASE);
-		else
-			clear_cpu_cap(c, X86_FEATURE_FSGSBASE);
-	}
+	if (cpu_has(c, X86_FEATURE_FSGSBASE))
+		cr4_set_bits(X86_CR4_FSGSBASE);
 
 	/*
 	 * The vendor-specific functions might have changed features.
-- 
2.7.4
