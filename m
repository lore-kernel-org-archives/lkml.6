Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D884EC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4BB20665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC4BB20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbeJXDIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:08:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:55091 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728900AbeJXDIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:08:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 11:43:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,417,1534834800"; 
   d="scan'208";a="243726597"
Received: from chang-linux-2.sc.intel.com ([10.3.52.139])
  by orsmga004.jf.intel.com with ESMTP; 23 Oct 2018 11:43:29 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [v3 10/12] x86/fsgsbase/64: Enable FSGSBASE by default and add a chicken bit
Date:   Tue, 23 Oct 2018 11:42:32 -0700
Message-Id: <20181023184234.14025-11-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181023184234.14025-1-chang.seok.bae@intel.com>
References: <20181023184234.14025-1-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

Now that FSGSBASE is fully supported, remove unsafe_fsgsbase, enable
FSGSBASE by default, and add nofsgsbase to disable it.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
---
 .../admin-guide/kernel-parameters.txt         |  3 +-
 arch/x86/kernel/cpu/common.c                  | 35 ++++++++-----------
 2 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index dfc2023b796b..72ed1a5ed832 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2729,8 +2729,7 @@
 	no5lvl		[X86-64] Disable 5-level paging mode. Forces
 			kernel to use 4-level paging instead.
 
-	unsafe_fsgsbase	[X86] Allow FSGSBASE instructions.  This will be
-			replaced with a  nofsgsbase flag.
+	nofsgsbase	[X86] Disables FSGSBASE instructions.
 
 	no_console_suspend
 			[HW] Never suspend the console
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 6c54e6d2fdfb..f20edc754532 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -365,24 +365,21 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
 	cr4_clear_bits(X86_CR4_UMIP);
 }
 
-/*
- * Temporary hack: FSGSBASE is unsafe until a few kernel code paths are
- * updated. This allows us to get the kernel ready incrementally. Setting
- * unsafe_fsgsbase and TAINT_INSECURE flags will allow the series to be
- * bisected if necessary.
- *
- * Once all the pieces are in place, these will go away and be replaced with
- * a nofsgsbase chicken flag.
- */
-static bool unsafe_fsgsbase;
-
-static __init int setup_unsafe_fsgsbase(char *arg)
+static __init int x86_nofsgsbase_setup(char *arg)
 {
-	unsafe_fsgsbase = true;
-	add_taint(TAINT_INSECURE, LOCKDEP_STILL_OK);
+	/* Require an exact match without trailing characters. */
+	if (strlen(arg))
+		return 0;
+
+	/* Do not emit a message if the feature is not present. */
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
@@ -1372,12 +1369,8 @@ static void identify_cpu(struct cpuinfo_x86 *c)
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
2.19.1

