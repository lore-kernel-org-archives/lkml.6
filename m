Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266E8C3712F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006B92085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfAUVnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 16:43:37 -0500
Received: from mga06.intel.com ([134.134.136.31]:12712 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727338AbfAUVnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 16:43:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2019 13:43:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,504,1539673200"; 
   d="scan'208";a="129583695"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by orsmga001.jf.intel.com with ESMTP; 21 Jan 2019 13:43:32 -0800
From:   kan.liang@linux.intel.com
To:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bp@alien8.de, peterz@infradead.org, mingo@redhat.com
Cc:     ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V6 3/5] perf/x86/intel: Clean up SNB pebs quirk
Date:   Mon, 21 Jan 2019 13:42:29 -0800
Message-Id: <1548106951-4811-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548106951-4811-1-git-send-email-kan.liang@linux.intel.com>
References: <1548106951-4811-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Clean up SNB pebs quirk to use the new facility to check for min
microcode revisions.

Only check the boot CPU, assuming models and features are consistent
over all CPUs.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V5:
- New patch to address Peter's comments.

 arch/x86/events/intel/core.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 13baff5..a3c7845 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3780,36 +3780,21 @@ static void intel_check_isolation(void)
 	x86_pmu.pebs_no_isolation = !x86_cpu_has_min_microcode_rev(isolation_ucodes);
 }
 
-static int intel_snb_pebs_broken(int cpu)
-{
-	u32 rev = UINT_MAX; /* default to broken for unknown models */
-
-	switch (cpu_data(cpu).x86_model) {
-	case INTEL_FAM6_SANDYBRIDGE:
-		rev = 0x28;
-		break;
-
-	case INTEL_FAM6_SANDYBRIDGE_X:
-		switch (cpu_data(cpu).x86_stepping) {
-		case 6: rev = 0x618; break;
-		case 7: rev = 0x70c; break;
-		}
-	}
+static const struct x86_cpu_desc pebs_ucodes[] = {
+	INTEL_CPU_DESC(INTEL_FAM6_SANDYBRIDGE,		7, 0x00000028),
+	INTEL_CPU_DESC(INTEL_FAM6_SANDYBRIDGE_X,	6, 0x00000618),
+	INTEL_CPU_DESC(INTEL_FAM6_SANDYBRIDGE_X,	7, 0x0000070c),
+	{}
+};
 
-	return (cpu_data(cpu).microcode < rev);
+static bool intel_snb_pebs_broken(void)
+{
+	return !x86_cpu_has_min_microcode_rev(pebs_ucodes);
 }
 
 static void intel_snb_check_microcode(void)
 {
-	int pebs_broken = 0;
-	int cpu;
-
-	for_each_online_cpu(cpu) {
-		if ((pebs_broken = intel_snb_pebs_broken(cpu)))
-			break;
-	}
-
-	if (pebs_broken == x86_pmu.pebs_broken)
+	if (intel_snb_pebs_broken() == x86_pmu.pebs_broken)
 		return;
 
 	/*
-- 
2.7.4

