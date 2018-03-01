Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163477AbeCAXex (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:34:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:61783 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163178AbeCAXev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:34:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,409,1515484800";
   d="scan'208";a="34829814"
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@suse.de>
Cc: Tony Luck <tony.luck@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: [PATCH] x86/mce: Save microcode revision in machine check records
Date: Thu,  1 Mar 2018 15:34:49 -0800
Message-Id: <20180301233449.24311-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updating microcode used to be relatively rare. Now that it has become
more common we should save the microcode version in a machine check
record to make sure that those people looking at the error have this
important information bundled with the rest of the logged information.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/uapi/asm/mce.h  | 1 +
 arch/x86/kernel/cpu/mcheck/mce.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/uapi/asm/mce.h b/arch/x86/include/uapi/asm/mce.h
index 91723461dc1f..435db58a7bad 100644
--- a/arch/x86/include/uapi/asm/mce.h
+++ b/arch/x86/include/uapi/asm/mce.h
@@ -30,6 +30,7 @@ struct mce {
 	__u64 synd;	/* MCA_SYND MSR: only valid on SMCA systems */
 	__u64 ipid;	/* MCA_IPID MSR: only valid on SMCA systems */
 	__u64 ppin;	/* Protected Processor Inventory Number */
+	__u32 microcode;/* Microcode revision */
 };
 
 #define MCE_GET_RECORD_LEN   _IOR('M', 1, int)
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 8ff94d1e2dce..b9403c446e05 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -118,6 +118,8 @@ BLOCKING_NOTIFIER_HEAD(x86_mce_decoder_chain);
 /* Do initial initialization of a struct mce */
 void mce_setup(struct mce *m)
 {
+	struct cpuinfo_x86 *c;
+
 	memset(m, 0, sizeof(struct mce));
 	m->cpu = m->extcpu = smp_processor_id();
 	/* We hope get_seconds stays lockless */
@@ -130,6 +132,9 @@ void mce_setup(struct mce *m)
 
 	if (this_cpu_has(X86_FEATURE_INTEL_PPIN))
 		rdmsrl(MSR_PPIN, m->ppin);
+
+	c = &cpu_data(m->cpu);
+	m->microcode = c->microcode;
 }
 
 DEFINE_PER_CPU(struct mce, injectm);
-- 
2.14.1
