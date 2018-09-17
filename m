Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F40FECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431D32146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431D32146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbeIREVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:21:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45188 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbeIREVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:21:24 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 86D18CAD;
        Mon, 17 Sep 2018 22:51:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        xxxxxx xxxxxx <xxxxxx@xxxxxx.xxx>,
        Christopher Snowhill <kode54@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Michael Hocko <mhocko@suse.com>, vbabka@suse.cz
Subject: [PATCH 4.4 55/56] x86/speculation/l1tf: Increase l1tf memory limit for Nehalem+
Date:   Tue, 18 Sep 2018 00:42:28 +0200
Message-Id: <20180917213830.202014780@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917213827.913122591@linuxfoundation.org>
References: <20180917213827.913122591@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------


From: Andi Kleen <ak@linux.intel.com>

[upstream cc51e5428ea54f575d49cfcede1d4cb3a72b4ec4 for 4.4.
Note there might be still a trivial conflict with the backport
for b0a182f875689647b014bc01d36b340217792852, but should
be easy to resolve]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/processor.h |    4 ++-
 arch/x86/kernel/cpu/bugs.c       |   47 ++++++++++++++++++++++++++++++++++-----
 arch/x86/kernel/cpu/common.c     |    2 +
 3 files changed, 47 insertions(+), 6 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -104,6 +104,8 @@ struct cpuinfo_x86 {
 	__u8			x86_phys_bits;
 	/* CPUID returned core id bits: */
 	__u8			x86_coreid_bits;
+
+	__u8			x86_cache_bits;
 	/* Max extended CPUID function supported: */
 	__u32			extended_cpuid_level;
 	/* Maximum supported CPUID level, -1=no CPUID: */
@@ -174,7 +176,7 @@ extern void cpu_detect(struct cpuinfo_x8
 
 static inline unsigned long long l1tf_pfn_limit(void)
 {
-	return BIT_ULL(boot_cpu_data.x86_phys_bits - 1 - PAGE_SHIFT);
+	return BIT_ULL(boot_cpu_data.x86_cache_bits - 1 - PAGE_SHIFT);
 }
 
 extern void early_cpu_init(void);
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -634,6 +634,46 @@ void x86_spec_ctrl_setup_ap(void)
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"L1TF: " fmt
+
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
@@ -641,16 +681,13 @@ static void __init l1tf_select_mitigatio
 	if (!boot_cpu_has_bug(X86_BUG_L1TF))
 		return;
 
+	override_cache_bits(&boot_cpu_data);
+
 #if CONFIG_PGTABLE_LEVELS == 2
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
@@ -798,6 +798,8 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_phys_bits = 36;
 #endif
 
+	c->x86_cache_bits = c->x86_phys_bits;
+
 	if (c->extended_cpuid_level >= 0x8000000a)
 		c->x86_capability[CPUID_8000_000A_EDX] = cpuid_edx(0x8000000a);
 


