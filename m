Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F29C6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2930C20883
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2930C20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388866AbeGXVtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:49:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:42508 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388721AbeGXVtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:49:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2018 13:40:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,399,1526367600"; 
   d="scan'208";a="74172845"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jul 2018 13:40:30 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [RFC PATCH 5/7] x86/intel_rdt: Trigger pseudo-lock restore after wbinvd call
Date:   Tue, 24 Jul 2018 13:40:16 -0700
Message-Id: <f6fa0efeafa736c4a890aac22de5570ccef05e45.1532463771.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1532463771.git.reinette.chatre@intel.com>
References: <cover.1532463771.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1532463771.git.reinette.chatre@intel.com>
References: <cover.1532463771.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wbinvd instruction would evict all pseudo-locked data from a
pseudo-locked region within the hierarchy where the wbinvd instruction
was run. The expectation is that a platform with pseudo-locked regions
should not run code depending on the wbinvd instruction after the
pseudo-locked regions are created. If the wbinvd instruction is run it
is an unexpected and serious event that needs to be highlighted to the
user to trigger an audit of the software. At the same time the
pseudo-locked regions need to be restored.

Since wbinvd instructions may be called from anywhere in kernel the
instruction itself is modified to trigger pseudo-locked region
restoration after the instruction is run.

As they are moved the assembly calls of the wbinvd instructions
are modified to address the checkpatch complaint of required spaces
around the ':'.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/include/asm/special_insns.h        | 13 ++++++++++++-
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c |  2 +-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 317fc59b512c..01ff02eb0e5c 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -15,6 +15,9 @@
  * use a variable and mimic reads and writes to it to enforce serialization
  */
 extern unsigned long __force_order;
+#ifdef CONFIG_INTEL_RDT
+void intel_rdtgroup_pseudo_lock_restore_all(void);
+#endif
 
 static inline unsigned long native_read_cr0(void)
 {
@@ -131,7 +134,15 @@ static inline void __write_pkru(u32 pkru)
 
 static inline void native_wbinvd(void)
 {
-	asm volatile("wbinvd": : :"memory");
+	asm volatile("wbinvd" : : : "memory");
+#ifdef CONFIG_INTEL_RDT
+	intel_rdtgroup_pseudo_lock_restore_all();
+#endif
+}
+
+static inline void native_wbinvd_only(void)
+{
+	asm volatile("wbinvd" : : : "memory");
 }
 
 extern asmlinkage void native_load_gs_index(unsigned);
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index d395e6982467..298ac2b34089 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -477,7 +477,7 @@ static int pseudo_lock_fn(void *_rdtgrp)
 	 * increase likelihood that allocated cache portion will be filled
 	 * with associated memory.
 	 */
-	native_wbinvd();
+	native_wbinvd_only();
 
 	/*
 	 * Always called with interrupts enabled. By disabling interrupts
-- 
2.17.0

