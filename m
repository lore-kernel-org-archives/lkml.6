Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0ECC6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F221A20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F221A20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388756AbeGXVBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:01:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:38484 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388587AbeGXVBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:01:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B68B2B0A2;
        Tue, 24 Jul 2018 19:53:32 +0000 (UTC)
Date:   Tue, 24 Jul 2018 21:53:30 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Borislav Petkov <bp@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH] x86/bugs: protect against userspace-userspace spectreRSB
Message-ID: <nycvar.YFH.7.76.1807242147560.997@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

The article "Spectre Returns! Speculation Attacks using the Return Stack
Buffer" [1] describes two new (sub-)variants of spectrev2-like attack,
making use solely of the RSB contents even on CPUs that don't fallback to
BTB on RSB underflow (Skylake+).

Mitigate userspace-userspace attacks by always unconditionally filling RSB on
context switch when generic spectrev2 mitigation has been enabled.

[1] https://arxiv.org/pdf/1807.07940.pdf

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---

Note: this doesn't address the potential 'userspace-kernelspace' (maked as no.
4 in the article) attack variant. Mitigating that would require either filling
RSB on every kernel entry (as one of the very early Tim Chen's patches did as
part of spectrev2 mitigation proposal), or somehow (persumably throuhg objtool
or runtime ftrace-based counting) control the unmatched returns in the kernel;
and it's not yet clear whether this attack is practical at all in the first
place.

 arch/x86/kernel/cpu/bugs.c | 38 +++++++-------------------------------
 1 file changed, 7 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 5c0ea39311fe..5ae0c12390cd 100644
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
@@ -390,22 +373,15 @@ static void __init spectre_v2_select_mitigation(void)
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
+	 *	- sepctreRSB variant of spectre v2 on X86_BUG_SPECTRE_V2 CPUs
 	 */
-	if ((!boot_cpu_has(X86_FEATURE_PTI) &&
-	     !boot_cpu_has(X86_FEATURE_SMEP)) || is_skylake_era()) {
-		setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
-		pr_info("Spectre v2 mitigation: Filling RSB on context switch\n");
-	}
+	setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
+	pr_info("Spectre v2 / spectreRSB mitigation: Filling RSB on context switch\n");
 
 	/* Initialize Indirect Branch Prediction Barrier if supported */
 	if (boot_cpu_has(X86_FEATURE_IBPB)) {
-- 
Jiri Kosina
SUSE Labs

