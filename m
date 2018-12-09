Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A1EC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6BA2081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6BA2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbeLIWYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:24:35 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34990 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726471AbeLIVzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:17 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72h-0002ic-Aq; Sun, 09 Dec 2018 21:55:15 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72e-0003RW-GO; Sun, 09 Dec 2018 21:55:12 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Andi Kleen" <ak@linux.intel.com>,
        vbabka@suse.cz, "Michael Hocko" <mhocko@suse.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Christopher Snowhill" <kode54@gmail.com>, x86@kernel.org,
        "xxxxxx xxxxxx" <xxxxxx@xxxxxx.xxx>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.357324436@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 165/328] x86/speculation/l1tf: Increase l1tf memory
 limit for Nehalem+
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andi Kleen <ak@linux.intel.com>

commit cc51e5428ea54f575d49cfcede1d4cb3a72b4ec4 upstream.

On Nehalem and newer core CPUs the CPU cache internally uses 44 bits
physical address space. The L1TF workaround is limited by this internal
cache address width, and needs to have one bit free there for the
mitigation to work.

Older client systems report only 36bit physical address space so the range
check decides that L1TF is not mitigated for a 36bit phys/32GB system with
some memory holes.

But since these actually have the larger internal cache width this warning
is bogus because it would only really be needed if the system had more than
43bits of memory.

Add a new internal x86_cache_bits field. Normally it is the same as the
physical bits field reported by CPUID, but for Nehalem and newerforce it to
be at least 44bits.

Change the L1TF memory size warning to use the new cache_bits field to
avoid bogus warnings and remove the bogus comment about memory size.

Fixes: 17dbca119312 ("x86/speculation/l1tf: Add sysfs reporting for l1tf")
Reported-by: xxxxxx xxxxxx <xxxxxx@xxxxxx.xxx>
Reported-by: Christopher Snowhill <kode54@gmail.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Michael Hocko <mhocko@suse.com>
Cc: vbabka@suse.cz
Link: https://lkml.kernel.org/r/20180824170351.34874-1-andi@firstfloor.org
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/processor.h |  4 ++-
 arch/x86/kernel/cpu/bugs.c       | 46 ++++++++++++++++++++++++++++----
 arch/x86/kernel/cpu/common.c     |  1 +
 3 files changed, 45 insertions(+), 6 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -127,6 +127,8 @@ struct cpuinfo_x86 {
 	/* Index into per_cpu list: */
 	u16			cpu_index;
 	u32			microcode;
+	/* Address space bits used by the cache internally */
+	u8			x86_cache_bits;
 } __attribute__((__aligned__(SMP_CACHE_BYTES)));
 
 #define X86_VENDOR_INTEL	0
@@ -167,7 +169,7 @@ extern void fpu_detect(struct cpuinfo_x8
 
 static inline unsigned long long l1tf_pfn_limit(void)
 {
-	return BIT_ULL(boot_cpu_data.x86_phys_bits - 1 - PAGE_SHIFT);
+	return BIT_ULL(boot_cpu_data.x86_cache_bits - 1 - PAGE_SHIFT);
 }
 
 extern void early_cpu_init(void);
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -696,6 +696,45 @@ void x86_spec_ctrl_setup_ap(void)
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"L1TF: " fmt
+/*
+ * These CPUs all support 44bits physical address space internally in the
+ * cache but CPUID can report a smaller number of physical address bits.
+ *
+ * The L1TF mitigation uses the top most address bit for the inversion of
+ * non present PTEs. When the installed memory reaches into the top most
+ * address bit due to memory holes, which has been observed on machines
+ * which report 36bits physical address bits and have 32G RAM installed,
+ * then the mitigation range check in l1tf_select_mitigation() triggers.
+ * This is a false positive because the mitigation is still possible due to
+ * the fact that the cache uses 44bit internally. Use the cache bits
+ * instead of the reported physical bits and adjust them on the affected
+ * machines to 44bit if the reported bits are less than 44.
+ */
+static void override_cache_bits(struct cpuinfo_x86 *c)
+{
+	if (c->x86 != 6)
+		return;
+
+	switch (c->x86_model) {
+	case INTEL_FAM6_NEHALEM:
+	case INTEL_FAM6_WESTMERE:
+	case INTEL_FAM6_SANDYBRIDGE:
+	case INTEL_FAM6_IVYBRIDGE:
+	case INTEL_FAM6_HASWELL_CORE:
+	case INTEL_FAM6_HASWELL_ULT:
+	case INTEL_FAM6_HASWELL_GT3E:
+	case INTEL_FAM6_BROADWELL_CORE:
+	case INTEL_FAM6_BROADWELL_GT3E:
+	case INTEL_FAM6_SKYLAKE_MOBILE:
+	case INTEL_FAM6_SKYLAKE_DESKTOP:
+	case INTEL_FAM6_KABYLAKE_MOBILE:
+	case INTEL_FAM6_KABYLAKE_DESKTOP:
+		if (c->x86_cache_bits < 44)
+			c->x86_cache_bits = 44;
+		break;
+	}
+}
+
 static void __init l1tf_select_mitigation(void)
 {
 	u64 half_pa;
@@ -703,16 +742,13 @@ static void __init l1tf_select_mitigatio
 	if (!boot_cpu_has_bug(X86_BUG_L1TF))
 		return;
 
+	override_cache_bits(&boot_cpu_data);
+
 #if defined(CONFIG_X86_32) && !defined(CONFIG_X86_PAE)
 	pr_warn("Kernel not compiled for PAE. No mitigation for L1TF\n");
 	return;
 #endif
 
-	/*
-	 * This is extremely unlikely to happen because almost all
-	 * systems have far more MAX_PA/2 than RAM can be fit into
-	 * DIMM slots.
-	 */
 	half_pa = (u64)l1tf_pfn_limit() << PAGE_SHIFT;
 	if (e820_any_mapped(half_pa, ULLONG_MAX - half_pa, E820_RAM)) {
 		pr_warn("System has more than MAX_PA/2 memory. L1TF mitigation not effective.\n");
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -772,6 +772,7 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 	else if (cpu_has(c, X86_FEATURE_PAE) || cpu_has(c, X86_FEATURE_PSE36))
 		c->x86_phys_bits = 36;
 #endif
+	c->x86_cache_bits = c->x86_phys_bits;
 
 	if (c->extended_cpuid_level >= 0x80000007)
 		c->x86_power = cpuid_edx(0x80000007);

