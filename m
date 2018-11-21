Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B24FC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA59213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA59213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeKULPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 06:15:02 -0500
Received: from mga05.intel.com ([192.55.52.43]:6936 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbeKULOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 06:14:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 16:42:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,259,1539673200"; 
   d="scan'208";a="251346826"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by orsmga004.jf.intel.com with ESMTP; 20 Nov 2018 16:42:04 -0800
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        stable@vger.kernel.org
Subject: [Patch v7 08/18] smt: Create cpu_smt_enabled static key for SMT specific code
Date:   Tue, 20 Nov 2018 16:08:47 -0800
Message-Id: <b0af92ab7e4db9b3ad14a4f65cf98ee6df0f4914.1542758656.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1542758656.git.tim.c.chen@linux.intel.com>
References: <cover.1542758656.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1542758656.git.tim.c.chen@linux.intel.com>
References: <cover.1542758656.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In later code, STIBP will be turned on/off in the context switch code
path when SMT is enabled.  Checks for SMT is best
avoided on such hot paths.

Create cpu_smt_enabled static key to turn on such SMT specific code
statically.

The key is enabled by default and its scope has nothing to do with CPU
hotplug. It depends on CONFIG_HOTPLUG_SMT which is the extra SMT control
code which is currently only enabled on x86.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 include/linux/cpu.h |  4 ++++
 kernel/cpu.c        | 12 ++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 218df7f..ce8267e 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -189,4 +189,8 @@ static inline void cpu_smt_check_topology_early(void) { }
 static inline void cpu_smt_check_topology(void) { }
 #endif
 
+#ifdef CONFIG_HOTPLUG_SMT
+DECLARE_STATIC_KEY_TRUE(cpu_smt_enabled);
+#endif
+
 #endif /* _LINUX_CPU_H_ */
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 3c7f3b4..e216154 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -370,6 +370,8 @@ static void lockdep_release_cpus_lock(void)
 #ifdef CONFIG_HOTPLUG_SMT
 enum cpuhp_smt_control cpu_smt_control __read_mostly = CPU_SMT_ENABLED;
 EXPORT_SYMBOL_GPL(cpu_smt_control);
+DEFINE_STATIC_KEY_TRUE(cpu_smt_enabled);
+EXPORT_SYMBOL_GPL(cpu_smt_enabled);
 
 static bool cpu_smt_available __read_mostly;
 
@@ -386,6 +388,7 @@ void __init cpu_smt_disable(bool force)
 		pr_info("SMT: disabled\n");
 		cpu_smt_control = CPU_SMT_DISABLED;
 	}
+	static_branch_disable(&cpu_smt_enabled);
 }
 
 /*
@@ -395,8 +398,10 @@ void __init cpu_smt_disable(bool force)
  */
 void __init cpu_smt_check_topology_early(void)
 {
-	if (!topology_smt_supported())
+	if (!topology_smt_supported()) {
 		cpu_smt_control = CPU_SMT_NOT_SUPPORTED;
+		static_branch_disable(&cpu_smt_enabled);
+	}
 }
 
 /*
@@ -408,8 +413,10 @@ void __init cpu_smt_check_topology_early(void)
  */
 void __init cpu_smt_check_topology(void)
 {
-	if (!cpu_smt_available)
+	if (!cpu_smt_available) {
 		cpu_smt_control = CPU_SMT_NOT_SUPPORTED;
+		static_branch_disable(&cpu_smt_enabled);
+	}
 }
 
 static int __init smt_cmdline_disable(char *str)
@@ -2101,6 +2108,7 @@ static int cpuhp_smt_enable(void)
 
 	cpu_maps_update_begin();
 	cpu_smt_control = CPU_SMT_ENABLED;
+	static_branch_enable(&cpu_smt_enabled);
 	arch_smt_update();
 	for_each_present_cpu(cpu) {
 		/* Skip online CPUs and CPUs on offline nodes */
-- 
2.9.4

