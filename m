Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284A2C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF95D208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF95D208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933771AbeGJPNi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:13:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:5865 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933374AbeGJPNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:13:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2018 08:13:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,335,1526367600"; 
   d="scan'208";a="53973937"
Received: from otc-lr-04.jf.intel.com ([10.54.39.14])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jul 2018 08:13:36 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, sunil.k.pandey@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/intel: Disable LBR while checking LBR related MSRs
Date:   Tue, 10 Jul 2018 08:12:13 -0700
Message-Id: <1531235533-8958-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Skylake server has LBR support on hardware, but the support is
mistakenly and permanently disabled for perf on some machines,
for example:
  $ dmesg | grep -i PMU
  [    0.055783] Performance Events: PEBS fmt3+, Skylake events,
  full-width counters, Intel PMU driver.

Current code checks the LBR related MSRs before enabling LBR support
for perf. The code reads the current value of LBR MSR, change it and
read it back to see if it matches. If it doesn't match, LBR support
will be disabled permanently.
On some machines, the LBR bit of MSR_IA32_DEBUGCTLMSR may be set while
checking. If so, hardware may changes the LBR MSRs implicitly, which
misleading the check.

Explicitly disable LBR while checking LBR related MSRs. Restore the old
value after checking if it's changed.
  $ dmesg | grep -i PMU
  [    0.064000] Performance Events: PEBS fmt3+, Skylake events, 32-deep
  LBR, full-width counters, Intel PMU driver.

  $ perf record -a -e cycles:u -j any,u ls
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.109 MB perf.data (77 samples) ]

Reported-by: Pandey, Sunil K <sunil.k.pandey@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Pandey, Sunil K <sunil.k.pandey@intel.com>
---
 arch/x86/events/intel/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 707b2a9..d01e801 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3878,6 +3878,7 @@ __init int intel_pmu_init(void)
 	unsigned int unused;
 	struct extra_reg *er;
 	int version, i;
+	u64 debugctl;
 	char *name;
 
 	if (!cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
@@ -4382,6 +4383,14 @@ __init int intel_pmu_init(void)
 	}
 
 	/*
+	 * LBR bit may be set on some machines.
+	 * Disable LBR while checking LBR related MSRs.
+	 */
+	debugctl = get_debugctlmsr();
+	if (debugctl & DEBUGCTLMSR_LBR)
+		update_debugctlmsr(debugctl & ~DEBUGCTLMSR_LBR);
+
+	/*
 	 * Access LBR MSR may cause #GP under certain circumstances.
 	 * E.g. KVM doesn't support LBR MSR
 	 * Check all LBT MSR here.
@@ -4395,6 +4404,10 @@ __init int intel_pmu_init(void)
 			x86_pmu.lbr_nr = 0;
 	}
 
+	/* Restore the old value if changed */
+	if (debugctl & DEBUGCTLMSR_LBR)
+		update_debugctlmsr(debugctl);
+
 	x86_pmu.caps_attrs = intel_pmu_caps_attrs;
 
 	if (x86_pmu.lbr_nr) {
-- 
2.7.4

