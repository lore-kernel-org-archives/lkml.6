Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A384C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED95C20846
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED95C20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeH0MWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:22:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44117 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeH0MWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:22:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7R8YjUH511016
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 27 Aug 2018 01:34:45 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7R8YjCV511013;
        Mon, 27 Aug 2018 01:34:45 -0700
Date:   Mon, 27 Aug 2018 01:34:45 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-cc51e5428ea54f575d49cfcede1d4cb3a72b4ec4@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, xxxxxx@xxxxxx.xxx,
        ak@linux.intel.com, kode54@gmail.com, mhocko@suse.com,
        hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de
Reply-To: tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
          mhocko@suse.com, kode54@gmail.com, ak@linux.intel.com,
          xxxxxx@xxxxxx.xxx, linux-kernel@vger.kernel.org
In-Reply-To: <20180824170351.34874-1-andi@firstfloor.org>
References: <20180824170351.34874-1-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/speculation/l1tf: Increase l1tf memory limit
 for Nehalem+
Git-Commit-ID: cc51e5428ea54f575d49cfcede1d4cb3a72b4ec4
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

Commit-ID:  cc51e5428ea54f575d49cfcede1d4cb3a72b4ec4
Gitweb:     https://git.kernel.org/tip/cc51e5428ea54f575d49cfcede1d4cb3a72b4ec4
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Fri, 24 Aug 2018 10:03:50 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 27 Aug 2018 10:29:14 +0200

x86/speculation/l1tf: Increase l1tf memory limit for Nehalem+

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
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180824170351.34874-1-andi@firstfloor.org

---
 arch/x86/include/asm/processor.h |  4 +++-
 arch/x86/kernel/cpu/bugs.c       | 46 +++++++++++++++++++++++++++++++++++-----
 arch/x86/kernel/cpu/common.c     |  1 +
 3 files changed, 45 insertions(+), 6 deletions(-)

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
index 4c2313d0b9ca..40bdaea97fe7 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -668,6 +668,45 @@ EXPORT_SYMBOL_GPL(l1tf_mitigation);
 enum vmx_l1d_flush_state l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_AUTO;
 EXPORT_SYMBOL_GPL(l1tf_vmx_mitigation);
 
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
@@ -675,6 +714,8 @@ static void __init l1tf_select_mitigation(void)
 	if (!boot_cpu_has_bug(X86_BUG_L1TF))
 		return;
 
+	override_cache_bits(&boot_cpu_data);
+
 	switch (l1tf_mitigation) {
 	case L1TF_MITIGATION_OFF:
 	case L1TF_MITIGATION_FLUSH_NOWARN:
@@ -694,11 +735,6 @@ static void __init l1tf_select_mitigation(void)
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
