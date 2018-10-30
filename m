Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3496C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E852080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E852080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbeJaERY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 00:17:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:23880 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728040AbeJaERY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 00:17:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 12:22:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,445,1534834800"; 
   d="scan'208";a="103876751"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by fmsmga001.fm.intel.com with ESMTP; 30 Oct 2018 12:22:39 -0700
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
Subject: [Patch v4 06/18] smt: Create cpu_smt_enabled static key for SMT specific code
Date:   Tue, 30 Oct 2018 11:49:13 -0700
Message-Id: <89b4d2ca342d18404535a3cc88956d85e4ec0279.1540923609.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1540923609.git.tim.c.chen@linux.intel.com>
References: <cover.1540923609.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1540923609.git.tim.c.chen@linux.intel.com>
References: <cover.1540923609.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create cpu_smt_enabled static key used for enabling
SMT specific code paths.

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
index 3adecda..03170c8 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -349,6 +349,8 @@ EXPORT_SYMBOL_GPL(cpu_hotplug_enable);
 #ifdef CONFIG_HOTPLUG_SMT
 enum cpuhp_smt_control cpu_smt_control __read_mostly = CPU_SMT_ENABLED;
 EXPORT_SYMBOL_GPL(cpu_smt_control);
+DEFINE_STATIC_KEY_TRUE(cpu_smt_enabled);
+EXPORT_SYMBOL_GPL(cpu_smt_enabled);
 
 static bool cpu_smt_available __read_mostly;
 
@@ -364,6 +366,7 @@ void __init cpu_smt_disable(bool force)
 	} else {
 		cpu_smt_control = CPU_SMT_DISABLED;
 	}
+	static_branch_disable(&cpu_smt_enabled);
 }
 
 /*
@@ -373,8 +376,10 @@ void __init cpu_smt_disable(bool force)
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
@@ -386,8 +391,10 @@ void __init cpu_smt_check_topology_early(void)
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
@@ -2072,6 +2079,7 @@ static int cpuhp_smt_enable(void)
 
 	cpu_maps_update_begin();
 	cpu_smt_control = CPU_SMT_ENABLED;
+	static_branch_enable(&cpu_smt_enabled);
 	arch_smt_update();
 	for_each_present_cpu(cpu) {
 		/* Skip online CPUs and CPUs on offline nodes */
-- 
2.9.4

