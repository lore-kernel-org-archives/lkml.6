Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D74C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACDC2157C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ACDC2157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392084AbeIVGOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:14:25 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44221 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391931AbeIVGKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:47 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdx-0008BO-OF; Sat, 22 Sep 2018 01:19:29 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdo-0000tE-Kj; Sat, 22 Sep 2018 01:19:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Tim Chen" <tim.c.chen@linux.intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Jiri Kosina" <jkosina@suse.cz>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Borislav Petkov" <bp@suse.de>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.342609694@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 44/63] x86/speculation: Protect against
 userspace-userspace spectreRSB
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Kosina <jkosina@suse.cz>

commit fdf82a7856b32d905c39afc85e34364491e46346 upstream.

The article "Spectre Returns! Speculation Attacks using the Return Stack
Buffer" [1] describes two new (sub-)variants of spectrev2-like attacks,
making use solely of the RSB contents even on CPUs that don't fallback to
BTB on RSB underflow (Skylake+).

Mitigate userspace-userspace attacks by always unconditionally filling RSB on
context switch when the generic spectrev2 mitigation has been enabled.

[1] https://arxiv.org/pdf/1807.07940.pdf

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lkml.kernel.org/r/nycvar.YFH.7.76.1807261308190.997@cbobk.fhfr.pm
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/cpu/bugs.c | 38 +++++++-------------------------------
 1 file changed, 7 insertions(+), 31 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -263,23 +263,6 @@ static enum spectre_v2_mitigation_cmd __
 	return cmd;
 }
 
-/* Check for Skylake-like CPUs (for RSB handling) */
-static bool __init is_skylake_era(void)
-{
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
-	    boot_cpu_data.x86 == 6) {
-		switch (boot_cpu_data.x86_model) {
-		case INTEL_FAM6_SKYLAKE_MOBILE:
-		case INTEL_FAM6_SKYLAKE_DESKTOP:
-		case INTEL_FAM6_SKYLAKE_X:
-		case INTEL_FAM6_KABYLAKE_MOBILE:
-		case INTEL_FAM6_KABYLAKE_DESKTOP:
-			return true;
-		}
-	}
-	return false;
-}
-
 static void __init spectre_v2_select_mitigation(void)
 {
 	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
@@ -340,22 +323,15 @@ retpoline_auto:
 	pr_info("%s\n", spectre_v2_strings[mode]);
 
 	/*
-	 * If neither SMEP nor PTI are available, there is a risk of
-	 * hitting userspace addresses in the RSB after a context switch
-	 * from a shallow call stack to a deeper one. To prevent this fill
-	 * the entire RSB, even when using IBRS.
+	 * If spectre v2 protection has been enabled, unconditionally fill
+	 * RSB during a context switch; this protects against two independent
+	 * issues:
 	 *
-	 * Skylake era CPUs have a separate issue with *underflow* of the
-	 * RSB, when they will predict 'ret' targets from the generic BTB.
-	 * The proper mitigation for this is IBRS. If IBRS is not supported
-	 * or deactivated in favour of retpolines the RSB fill on context
-	 * switch is required.
+	 *	- RSB underflow (and switch to BTB) on Skylake+
+	 *	- SpectreRSB variant of spectre v2 on X86_BUG_SPECTRE_V2 CPUs
 	 */
-	if ((!boot_cpu_has(X86_FEATURE_KAISER) &&
-	     !boot_cpu_has(X86_FEATURE_SMEP)) || is_skylake_era()) {
-		setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
-		pr_info("Spectre v2 mitigation: Filling RSB on context switch\n");
-	}
+	setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
+	pr_info("Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch\n");
 
 	/* Initialize Indirect Branch Prediction Barrier if supported */
 	if (boot_cpu_has(X86_FEATURE_IBPB)) {

