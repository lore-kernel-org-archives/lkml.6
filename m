Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F029FC43334
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D362152B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D362152B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbeHXUjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 16:39:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:17641 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbeHXUjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 16:39:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Aug 2018 10:04:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,283,1531810800"; 
   d="scan'208";a="67873080"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga008.jf.intel.com with ESMTP; 24 Aug 2018 10:04:14 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 8CCB2301B8F; Fri, 24 Aug 2018 10:04:14 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Michael Hocko <mhocko@suse.com>, vbabka@suse.cz
Subject: [PATCH 1/2] x86/speculation/l1tf: Increase l1tf memory limit for Nehalem+
Date:   Fri, 24 Aug 2018 10:03:50 -0700
Message-Id: <20180824170351.34874-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Andi Kleen <ak@linux.intel.com>

On Nehalem and newer core CPUs the CPU cache internally uses 44 bits physical
address space. The L1TF workaround is limited by this internal cache
address width, and needs to have one bit free there for the mitigation
to work.

Older client systems report only 36bit physical address space so
we warn that L1TF is not mitigated for a 36bit phys/32GB system
with some memory holes.

But since these actually have the larger internal cache width
this warning is bogus because it would only really be needed
if the system had more than 43bits of memory

This patch adds a new internal x86_cache_bits field. Normally
it is the same as the phys bits field reported by CPUID,
but for Nehalem and newer we force it to be at least 44bits.

Then change the L1TF memory size warning to use the new
cache_bits field to avoid bogus warnings.

I also removed a now known to be bogus comment about
the memory size.

Cc: Michael Hocko <mhocko@suse.com>
Cc: vbabka@suse.cz
Reported-by: xxxxxx xxxxxx <xxxxxx@xxxxxx.xxx>
Reported-by: Christopher Snowhill <kode54@gmail.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/include/asm/processor.h |  4 +++-
 arch/x86/kernel/cpu/bugs.c       | 41 ++++++++++++++++++++++++++++----
 arch/x86/kernel/cpu/common.c     |  1 +
 3 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index c24297268ebc..d53c54b842da 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -132,6 +132,8 @@ struct cpuinfo_x86 {
 	/* Index into per_cpu list: */
 	u16			cpu_index;
 	u32			microcode;
+	/* Address space bits used by the cache internally */
+	u8			x86_cache_bits;
 	unsigned		initialized : 1;
 } __randomize_layout;
 
@@ -183,7 +185,7 @@ extern void cpu_detect(struct cpuinfo_x86 *c);
 
 static inline unsigned long long l1tf_pfn_limit(void)
 {
-	return BIT_ULL(boot_cpu_data.x86_phys_bits - 1 - PAGE_SHIFT);
+	return BIT_ULL(boot_cpu_data.x86_cache_bits - 1 - PAGE_SHIFT);
 }
 
 extern void early_cpu_init(void);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 4c2313d0b9ca..e35d2c89af11 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -668,6 +668,40 @@ EXPORT_SYMBOL_GPL(l1tf_mitigation);
 enum vmx_l1d_flush_state l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_AUTO;
 EXPORT_SYMBOL_GPL(l1tf_vmx_mitigation);
 
+/*
+ * These CPUs all support 44bits internally in the cache but report a smaller
+ * number of bits for phys bits. For the L1TF max memory size warning
+ * we want to use the internal cache width to not give unnecessary
+ * warnings.
+ */
+static void override_cache_bits(struct cpuinfo_x86 *c)
+{
+	if (c->x86 != 6)
+		return;
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
+		/*
+		 * No need to add new model numbers, as this is only
+		 * used by workarounds for older CPUs.
+		 */
+		if (c->x86_cache_bits < 44)
+			c->x86_cache_bits = 44;
+		break;
+	}
+}
+
 static void __init l1tf_select_mitigation(void)
 {
 	u64 half_pa;
@@ -675,6 +709,8 @@ static void __init l1tf_select_mitigation(void)
 	if (!boot_cpu_has_bug(X86_BUG_L1TF))
 		return;
 
+	override_cache_bits(&boot_cpu_data);
+
 	switch (l1tf_mitigation) {
 	case L1TF_MITIGATION_OFF:
 	case L1TF_MITIGATION_FLUSH_NOWARN:
@@ -694,11 +730,6 @@ static void __init l1tf_select_mitigation(void)
 	return;
 #endif
 
-	/*
-	 * This is extremely unlikely to happen because almost all
-	 * systems have far more MAX_PA/2 than RAM can be fit into
-	 * DIMM slots.
-	 */
 	half_pa = (u64)l1tf_pfn_limit() << PAGE_SHIFT;
 	if (e820__mapped_any(half_pa, ULLONG_MAX - half_pa, E820_TYPE_RAM)) {
 		pr_warn("System has more than MAX_PA/2 memory. L1TF mitigation not effective.\n");
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 84dee5ab745a..44c4ef3d989b 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -919,6 +919,7 @@ void get_cpu_address_sizes(struct cpuinfo_x86 *c)
 	else if (cpu_has(c, X86_FEATURE_PAE) || cpu_has(c, X86_FEATURE_PSE36))
 		c->x86_phys_bits = 36;
 #endif
+	c->x86_cache_bits = c->x86_phys_bits;
 }
 
 static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
-- 
2.17.1

