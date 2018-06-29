Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DDFC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC65527D8E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC65527D8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937181AbeF2Tbc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 15:31:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:39929 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937054AbeF2Tb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 15:31:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 12:31:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,287,1526367600"; 
   d="scan'208";a="52938164"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 29 Jun 2018 12:31:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B2AA3610; Fri, 29 Jun 2018 22:31:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/6] x86/tsc: Convert to use x86_match_cpu() and INTEL_CPU_FAM6()
Date:   Fri, 29 Jun 2018 22:31:09 +0300
Message-Id: <20180629193113.84425-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180629193113.84425-1-andriy.shevchenko@linux.intel.com>
References: <20180629193113.84425-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the code to use recently introduced INTEL_CPU_FAM6() macro and
drop custom version of x86_match_cpu() function.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/tsc_msr.c | 83 ++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 41 deletions(-)

diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
index 19afdbd7d0a7..c12e9cd92272 100644
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -8,9 +8,11 @@
  */
 
 #include <linux/kernel.h>
-#include <asm/processor.h>
-#include <asm/setup.h>
+
 #include <asm/apic.h>
+#include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
+#include <asm/msr.h>
 #include <asm/param.h>
 
 #define MAX_NUM_FREQS	9
@@ -23,44 +25,43 @@
  * field msr_plat does.
  */
 struct freq_desc {
-	u8 x86_family;	/* CPU family */
-	u8 x86_model;	/* model */
 	u8 msr_plat;	/* 1: use MSR_PLATFORM_INFO, 0: MSR_IA32_PERF_STATUS */
 	u32 freqs[MAX_NUM_FREQS];
 };
 
-static struct freq_desc freq_desc_tables[] = {
-	/* PNW */
-	{ 6, 0x27, 0, { 0, 0, 0, 0, 0, 99840, 0, 83200 } },
-	/* CLV+ */
-	{ 6, 0x35, 0, { 0, 133200, 0, 0, 0, 99840, 0, 83200 } },
-	/* TNG - Intel Atom processor Z3400 series */
-	{ 6, 0x4a, 1, { 0, 100000, 133300, 0, 0, 0, 0, 0 } },
-	/* VLV2 - Intel Atom processor E3000, Z3600, Z3700 series */
-	{ 6, 0x37, 1, { 83300, 100000, 133300, 116700, 80000, 0, 0, 0 } },
-	/* ANN - Intel Atom processor Z3500 series */
-	{ 6, 0x5a, 1, { 83300, 100000, 133300, 100000, 0, 0, 0, 0 } },
-	/* AMT - Intel Atom processor X7-Z8000 and X5-Z8000 series */
-	{ 6, 0x4c, 1, { 83300, 100000, 133300, 116700,
-			80000, 93300, 90000, 88900, 87500 } },
+static const struct freq_desc freq_desc_pnw = {
+	0, { 0, 0, 0, 0, 0, 99840, 0, 83200 }
 };
 
-static int match_cpu(u8 family, u8 model)
-{
-	int i;
+static const struct freq_desc freq_desc_clv = {
+	0, { 0, 133200, 0, 0, 0, 99840, 0, 83200 }
+};
 
-	for (i = 0; i < ARRAY_SIZE(freq_desc_tables); i++) {
-		if ((family == freq_desc_tables[i].x86_family) &&
-			(model == freq_desc_tables[i].x86_model))
-			return i;
-	}
+static const struct freq_desc freq_desc_byt = {
+	1, { 83300, 100000, 133300, 116700, 80000, 0, 0, 0 }
+};
 
-	return -1;
-}
+static const struct freq_desc freq_desc_cht = {
+	1, { 83300, 100000, 133300, 116700, 80000, 93300, 90000, 88900, 87500 }
+};
 
-/* Map CPU reference clock freq ID(0-7) to CPU reference clock freq(KHz) */
-#define id_to_freq(cpu_index, freq_id) \
-	(freq_desc_tables[cpu_index].freqs[freq_id])
+static const struct freq_desc freq_desc_tng = {
+	1, { 0, 100000, 133300, 0, 0, 0, 0, 0 }
+};
+
+static const struct freq_desc freq_desc_ann = {
+	1, { 83300, 100000, 133300, 100000, 0, 0, 0, 0 }
+};
+
+static const struct x86_cpu_id tsc_msr_cpu_ids[] = {
+	INTEL_CPU_FAM6(ATOM_PENWELL,		freq_desc_pnw),
+	INTEL_CPU_FAM6(ATOM_CLOVERVIEW,		freq_desc_clv),
+	INTEL_CPU_FAM6(ATOM_SILVERMONT1,	freq_desc_byt),
+	INTEL_CPU_FAM6(ATOM_AIRMONT,		freq_desc_cht),
+	INTEL_CPU_FAM6(ATOM_MERRIFIELD,		freq_desc_tng),
+	INTEL_CPU_FAM6(ATOM_MOOREFIELD,		freq_desc_ann),
+	{}
+};
 
 /*
  * MSR-based CPU/TSC frequency discovery for certain CPUs.
@@ -70,18 +71,17 @@ static int match_cpu(u8 family, u8 model)
  */
 unsigned long cpu_khz_from_msr(void)
 {
-	u32 lo, hi, ratio, freq_id, freq;
+	u32 lo, hi, ratio, freq;
+	const struct freq_desc *freq_desc;
+	const struct x86_cpu_id *id;
 	unsigned long res;
-	int cpu_index;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+	id = x86_match_cpu(tsc_msr_cpu_ids);
+	if (!id)
 		return 0;
 
-	cpu_index = match_cpu(boot_cpu_data.x86, boot_cpu_data.x86_model);
-	if (cpu_index < 0)
-		return 0;
-
-	if (freq_desc_tables[cpu_index].msr_plat) {
+	freq_desc = (struct freq_desc *)id->driver_data;
+	if (freq_desc->msr_plat) {
 		rdmsr(MSR_PLATFORM_INFO, lo, hi);
 		ratio = (lo >> 8) & 0xff;
 	} else {
@@ -91,8 +91,9 @@ unsigned long cpu_khz_from_msr(void)
 
 	/* Get FSB FREQ ID */
 	rdmsr(MSR_FSB_FREQ, lo, hi);
-	freq_id = lo & 0x7;
-	freq = id_to_freq(cpu_index, freq_id);
+
+	/* Map CPU reference clock freq ID(0-7) to CPU reference clock freq(KHz) */
+	freq = freq_desc->freqs[lo & 0x7];
 
 	/* TSC frequency = maximum resolved freq * maximum resolved bus ratio */
 	res = freq * ratio;
-- 
2.18.0

