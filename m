Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AD0C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A244206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387614AbfAPWtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:49:13 -0500
Received: from mga02.intel.com ([134.134.136.20]:57462 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387565AbfAPWtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:49:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2019 14:49:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,487,1539673200"; 
   d="scan'208";a="117288379"
Received: from chang-linux-2.sc.intel.com ([10.3.52.165])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jan 2019 14:49:08 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 02/13] x86/fsgsbase/64: Add 'unsafe_fsgsbase' to enable CR4.FSGSBASE
Date:   Wed, 16 Jan 2019 14:48:38 -0800
Message-Id: <20190116224849.8617-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190116224849.8617-1-chang.seok.bae@intel.com>
References: <20190116224849.8617-1-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

This is temporary.  It will allow the next few patches to be tested
incrementally.

Setting unsafe_fsgsbase is a root hole.  Don't do it.

[ chang: Minor fix. Add the TAINT_INSECURE flag. ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
---
 .../admin-guide/kernel-parameters.txt         |  3 +++
 arch/x86/kernel/cpu/common.c                  | 27 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d59dff450614..871260e3e832 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2760,6 +2760,9 @@
 	no5lvl		[X86-64] Disable 5-level paging mode. Forces
 			kernel to use 4-level paging instead.
 
+	unsafe_fsgsbase	[X86] Allow FSGSBASE instructions.  This will be
+			replaced with a nofsgsbase flag.
+
 	no_console_suspend
 			[HW] Never suspend the console
 			Disable suspending of consoles during suspend and
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index cb28e98a0659..6e2cba21328f 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -365,6 +365,25 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
 	cr4_clear_bits(X86_CR4_UMIP);
 }
 
+/*
+ * Temporary hack: FSGSBASE is unsafe until a few kernel code paths are
+ * updated. This allows us to get the kernel ready incrementally. Setting
+ * unsafe_fsgsbase and TAINT_INSECURE flags will allow the series to be
+ * bisected if necessary.
+ *
+ * Once all the pieces are in place, these will go away and be replaced with
+ * a nofsgsbase chicken flag.
+ */
+static bool unsafe_fsgsbase;
+
+static __init int setup_unsafe_fsgsbase(char *arg)
+{
+	unsafe_fsgsbase = true;
+	add_taint(TAINT_INSECURE, LOCKDEP_STILL_OK);
+	return 1;
+}
+__setup("unsafe_fsgsbase", setup_unsafe_fsgsbase);
+
 /*
  * Protection Keys are not available in 32-bit mode.
  */
@@ -1352,6 +1371,14 @@ static void identify_cpu(struct cpuinfo_x86 *c)
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
2.19.1

