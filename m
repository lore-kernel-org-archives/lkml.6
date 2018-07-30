Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F816C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B4320890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B4320890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732124AbeGaA1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:27:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42369 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbeGaA1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:27:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6UMmov52474267
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 30 Jul 2018 15:48:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6UMmnfq2474259;
        Mon, 30 Jul 2018 15:48:49 -0700
Date:   Mon, 30 Jul 2018 15:48:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Kosina <tipbot@zytor.com>
Message-ID: <tip-fdf82a7856b32d905c39afc85e34364491e46346@git.kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, hpa@zytor.com, jkosina@suse.cz,
        konrad.wilk@oracle.com, tglx@linutronix.de,
        tim.c.chen@linux.intel.com, mingo@kernel.org, dwmw@amazon.co.uk,
        jpoimboe@redhat.com, bp@suse.de
Reply-To: konrad.wilk@oracle.com, bp@suse.de, tglx@linutronix.de,
          mingo@kernel.org, tim.c.chen@linux.intel.com, dwmw@amazon.co.uk,
          jpoimboe@redhat.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          jkosina@suse.cz, hpa@zytor.com
In-Reply-To: <nycvar.YFH.7.76.1807261308190.997@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1807261308190.997@cbobk.fhfr.pm>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Protect against userspace-userspace
 spectreRSB
Git-Commit-ID: fdf82a7856b32d905c39afc85e34364491e46346
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  fdf82a7856b32d905c39afc85e34364491e46346
Gitweb:     https://git.kernel.org/tip/fdf82a7856b32d905c39afc85e34364491e46346
Author:     Jiri Kosina <jkosina@suse.cz>
AuthorDate: Thu, 26 Jul 2018 13:14:55 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 31 Jul 2018 00:45:15 +0200

x86/speculation: Protect against userspace-userspace spectreRSB

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
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/nycvar.YFH.7.76.1807261308190.997@cbobk.fhfr.pm

---
 arch/x86/kernel/cpu/bugs.c | 38 +++++++-------------------------------
 1 file changed, 7 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 5c0ea39311fe..bc8c43b22460 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -313,23 +313,6 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
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
@@ -390,22 +373,15 @@ retpoline_auto:
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
-	if ((!boot_cpu_has(X86_FEATURE_PTI) &&
-	     !boot_cpu_has(X86_FEATURE_SMEP)) || is_skylake_era()) {
-		setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
-		pr_info("Spectre v2 mitigation: Filling RSB on context switch\n");
-	}
+	setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
+	pr_info("Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch\n");
 
 	/* Initialize Indirect Branch Prediction Barrier if supported */
 	if (boot_cpu_has(X86_FEATURE_IBPB)) {
