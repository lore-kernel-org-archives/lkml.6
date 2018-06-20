Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7E7C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B580F20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B580F20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754295AbeFTA2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:28:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33295 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753073AbeFTA2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:28:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5K0Rwef3299819
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Jun 2018 17:27:58 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5K0Rueo3299816;
        Tue, 19 Jun 2018 17:27:56 -0700
Date:   Tue, 19 Jun 2018 17:27:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-48d2a87ab29b2f2275aa5af9effe2fef5116dfc0@git.kernel.org>
Cc:     tglx@linutronix.de, reinette.chatre@intel.com, mingo@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, reinette.chatre@intel.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <a87d0ae287964753841c6cc628715a05be6c0e7a.1527593971.git.reinette.chatre@intel.com>
References: <a87d0ae287964753841c6cc628715a05be6c0e7a.1527593971.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Discover supported platforms via
 prefetch disable bits
Git-Commit-ID: 48d2a87ab29b2f2275aa5af9effe2fef5116dfc0
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

Commit-ID:  48d2a87ab29b2f2275aa5af9effe2fef5116dfc0
Gitweb:     https://git.kernel.org/tip/48d2a87ab29b2f2275aa5af9effe2fef5116dfc0
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Tue, 29 May 2018 05:57:53 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 20 Jun 2018 00:56:37 +0200

x86/intel_rdt: Discover supported platforms via prefetch disable bits

Knowing the model specific prefetch disable bits is required to support
cache pseudo-locking because the hardware prefetchers need to be disabled
when the kernel memory is pseudo-locked to cache. We add these bits only
for platforms known to support cache pseudo-locking.

When the user requests locksetup mode to be entered it will fail if the
prefetch disabling bits are not known for the platform.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/a87d0ae287964753841c6cc628715a05be6c0e7a.1527593971.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 75 +++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index b145a7386b10..cbba4bc17522 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -12,8 +12,73 @@
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
 #include <linux/slab.h>
+#include <asm/intel-family.h>
 #include "intel_rdt.h"
 
+/*
+ * MSR_MISC_FEATURE_CONTROL register enables the modification of hardware
+ * prefetcher state. Details about this register can be found in the MSR
+ * tables for specific platforms found in Intel's SDM.
+ */
+#define MSR_MISC_FEATURE_CONTROL	0x000001a4
+
+/*
+ * The bits needed to disable hardware prefetching varies based on the
+ * platform. During initialization we will discover which bits to use.
+ */
+static u64 prefetch_disable_bits;
+
+/**
+ * get_prefetch_disable_bits - prefetch disable bits of supported platforms
+ *
+ * Capture the list of platforms that have been validated to support
+ * pseudo-locking. This includes testing to ensure pseudo-locked regions
+ * with low cache miss rates can be created under variety of load conditions
+ * as well as that these pseudo-locked regions can maintain their low cache
+ * miss rates under variety of load conditions for significant lengths of time.
+ *
+ * After a platform has been validated to support pseudo-locking its
+ * hardware prefetch disable bits are included here as they are documented
+ * in the SDM.
+ *
+ * Return:
+ * If platform is supported, the bits to disable hardware prefetchers, 0
+ * if platform is not supported.
+ */
+static u64 get_prefetch_disable_bits(void)
+{
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL ||
+	    boot_cpu_data.x86 != 6)
+		return 0;
+
+	switch (boot_cpu_data.x86_model) {
+	case INTEL_FAM6_BROADWELL_X:
+		/*
+		 * SDM defines bits of MSR_MISC_FEATURE_CONTROL register
+		 * as:
+		 * 0    L2 Hardware Prefetcher Disable (R/W)
+		 * 1    L2 Adjacent Cache Line Prefetcher Disable (R/W)
+		 * 2    DCU Hardware Prefetcher Disable (R/W)
+		 * 3    DCU IP Prefetcher Disable (R/W)
+		 * 63:4 Reserved
+		 */
+		return 0xF;
+	case INTEL_FAM6_ATOM_GOLDMONT:
+	case INTEL_FAM6_ATOM_GEMINI_LAKE:
+		/*
+		 * SDM defines bits of MSR_MISC_FEATURE_CONTROL register
+		 * as:
+		 * 0     L2 Hardware Prefetcher Disable (R/W)
+		 * 1     Reserved
+		 * 2     DCU Hardware Prefetcher Disable (R/W)
+		 * 63:3  Reserved
+		 */
+		return 0x5;
+	}
+
+	return 0;
+}
+
 /**
  * pseudo_lock_init - Initialize a pseudo-lock region
  * @rdtgrp: resource group to which new pseudo-locked region will belong
@@ -225,6 +290,16 @@ int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
 		return -EINVAL;
 	}
 
+	/*
+	 * Not knowing the bits to disable prefetching implies that this
+	 * platform does not support Cache Pseudo-Locking.
+	 */
+	prefetch_disable_bits = get_prefetch_disable_bits();
+	if (prefetch_disable_bits == 0) {
+		rdt_last_cmd_puts("pseudo-locking not supported\n");
+		return -EINVAL;
+	}
+
 	if (rdtgroup_monitor_in_progress(rdtgrp)) {
 		rdt_last_cmd_puts("monitoring in progress\n");
 		return -EINVAL;
