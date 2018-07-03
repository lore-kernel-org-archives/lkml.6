Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E0CC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9888D219EE
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9888D219EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753003AbeGCLO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:14:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36155 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752508AbeGCLO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:14:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w63BEGgD258072
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 3 Jul 2018 04:14:16 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w63BEGSf258066;
        Tue, 3 Jul 2018 04:14:16 -0700
Date:   Tue, 3 Jul 2018 04:14:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Shevchenko <tipbot@zytor.com>
Message-ID: <tip-397d3ad18dc431456baf8bce96606fa1d18b30b0@git.kernel.org>
Cc:     andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        pasha.tatashin@oracle.com
Reply-To: mingo@kernel.org, tglx@linutronix.de,
          andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
          pasha.tatashin@oracle.com, hpa@zytor.com
In-Reply-To: <20180629193113.84425-3-andriy.shevchenko@linux.intel.com>
References: <20180629193113.84425-3-andriy.shevchenko@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/tsc: Convert to use x86_match_cpu() and
 INTEL_CPU_FAM6()
Git-Commit-ID: 397d3ad18dc431456baf8bce96606fa1d18b30b0
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

Commit-ID:  397d3ad18dc431456baf8bce96606fa1d18b30b0
Gitweb:     https://git.kernel.org/tip/397d3ad18dc431456baf8bce96606fa1d18b30b0
Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate: Fri, 29 Jun 2018 22:31:09 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 3 Jul 2018 13:08:20 +0200

x86/tsc: Convert to use x86_match_cpu() and INTEL_CPU_FAM6()

Move the code to use recently introduced INTEL_CPU_FAM6() macro and
drop custom version of x86_match_cpu() function.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Link: https://lkml.kernel.org/r/20180629193113.84425-3-andriy.shevchenko@linux.intel.com

---
 arch/x86/kernel/tsc_msr.c | 83 ++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 41 deletions(-)

diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
index 5532d1be7687..1465aaee543a 100644
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
 #include <asm/tsc.h>
 
@@ -24,44 +26,43 @@
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
@@ -71,18 +72,17 @@ static int match_cpu(u8 family, u8 model)
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
@@ -92,8 +92,9 @@ unsigned long cpu_khz_from_msr(void)
 
 	/* Get FSB FREQ ID */
 	rdmsr(MSR_FSB_FREQ, lo, hi);
-	freq_id = lo & 0x7;
-	freq = id_to_freq(cpu_index, freq_id);
+
+	/* Map CPU reference clock freq ID(0-7) to CPU reference clock freq(KHz) */
+	freq = freq_desc->freqs[lo & 0x7];
 
 	/* TSC frequency = maximum resolved freq * maximum resolved bus ratio */
 	res = freq * ratio;
