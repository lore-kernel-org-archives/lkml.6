Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A14DC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2902077B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2902077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbeKQMn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 07:43:27 -0500
Received: from mga14.intel.com ([192.55.52.115]:45898 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731093AbeKQMmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 07:42:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2018 18:27:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,242,1539673200"; 
   d="scan'208";a="281852610"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by fmsmga006.fm.intel.com with ESMTP; 16 Nov 2018 18:27:42 -0800
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
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
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [Patch v5 08/16] smt: Create cpu_smt_enabled static key for SMT specific code
Date:   Fri, 16 Nov 2018 17:53:51 -0800
Message-Id: <91b719e53640f60666b40a3516da2b80703b2f76.1542418937.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1542418936.git.tim.c.chen@linux.intel.com>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1542418936.git.tim.c.chen@linux.intel.com>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In later code, STIBP will be turned on/off in the context switch code
path when SMT is enabled.  Checks for SMT is best
avoided on such hot paths.

Create cpu_smt_enabled static key to turn on such SMT specific code
statically.

This key is set in code under hot plug, so it is limited in
scope to architecture supporting CPU hotplug, like x86.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 include/linux/cpu.h |  1 +
 kernel/cpu.c        | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 218df7f..b54f085 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -188,5 +188,6 @@ static inline void cpu_smt_disable(bool force) { }
 static inline void cpu_smt_check_topology_early(void) { }
 static inline void cpu_smt_check_topology(void) { }
 #endif
+DECLARE_STATIC_KEY_TRUE(cpu_smt_enabled);
 
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

