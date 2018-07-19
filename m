Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79874ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F0C20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F0C20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbeGSXLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:11:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40935 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730469AbeGSXLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:11:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JMQEjo2438874
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 15:26:14 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JMQCSC2438871;
        Thu, 19 Jul 2018 15:26:12 -0700
Date:   Thu, 19 Jul 2018 15:26:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pavel Tatashin <tipbot@zytor.com>
Message-ID: <tip-8990cac6e5ea7fa57607736019fe8dca961b998f@git.kernel.org>
Cc:     bp@suse.de, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, hpa@zytor.com,
        pasha.tatashin@oracle.com
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@suse.de,
          hpa@zytor.com, peterz@infradead.org, mingo@kernel.org,
          pasha.tatashin@oracle.com
In-Reply-To: <20180719205545.16512-10-pasha.tatashin@oracle.com>
References: <20180719205545.16512-10-pasha.tatashin@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/jump_label: Initialize static branching early
Git-Commit-ID: 8990cac6e5ea7fa57607736019fe8dca961b998f
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

Commit-ID:  8990cac6e5ea7fa57607736019fe8dca961b998f
Gitweb:     https://git.kernel.org/tip/8990cac6e5ea7fa57607736019fe8dca961b998f
Author:     Pavel Tatashin <pasha.tatashin@oracle.com>
AuthorDate: Thu, 19 Jul 2018 16:55:28 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 00:02:38 +0200

x86/jump_label: Initialize static branching early

Static branching is useful to runtime patch branches that are used in hot
path, but are infrequently changed.

The x86 clock framework is one example that uses static branches to setup
the best clock during boot and never changes it again.

It is desired to enable the TSC based sched clock early to allow fine
grained boot time analysis early on. That requires the static branching
functionality to be functional early as well.

Static branching requires patching nop instructions, thus,
arch_init_ideal_nops() must be called prior to jump_label_init().

Do all the necessary steps to call arch_init_ideal_nops() right after
early_cpu_init(), which also allows to insert a call to jump_label_init()
right after that. jump_label_init() will be called again from the generic
init code, but the code is protected against reinitialization already.

[ tglx: Massaged changelog ]

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: steven.sistare@oracle.com
Cc: daniel.m.jordan@oracle.com
Cc: linux@armlinux.org.uk
Cc: schwidefsky@de.ibm.com
Cc: heiko.carstens@de.ibm.com
Cc: john.stultz@linaro.org
Cc: sboyd@codeaurora.org
Cc: hpa@zytor.com
Cc: douly.fnst@cn.fujitsu.com
Cc: prarit@redhat.com
Cc: feng.tang@intel.com
Cc: pmladek@suse.com
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: linux-s390@vger.kernel.org
Cc: boris.ostrovsky@oracle.com
Cc: jgross@suse.com
Cc: pbonzini@redhat.com
Link: https://lkml.kernel.org/r/20180719205545.16512-10-pasha.tatashin@oracle.com

---
 arch/x86/kernel/cpu/amd.c    | 13 ++++++++-----
 arch/x86/kernel/cpu/common.c | 38 ++++++++++++++++++++------------------
 arch/x86/kernel/setup.c      |  4 ++--
 3 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 38915fbfae73..b732438c1a1e 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -232,8 +232,6 @@ static void init_amd_k7(struct cpuinfo_x86 *c)
 		}
 	}
 
-	set_cpu_cap(c, X86_FEATURE_K7);
-
 	/* calling is from identify_secondary_cpu() ? */
 	if (!c->cpu_index)
 		return;
@@ -617,6 +615,14 @@ static void early_init_amd(struct cpuinfo_x86 *c)
 
 	early_init_amd_mc(c);
 
+#ifdef CONFIG_X86_32
+	if (c->x86 == 6)
+		set_cpu_cap(c, X86_FEATURE_K7);
+#endif
+
+	if (c->x86 >= 0xf)
+		set_cpu_cap(c, X86_FEATURE_K8);
+
 	rdmsr_safe(MSR_AMD64_PATCH_LEVEL, &c->microcode, &dummy);
 
 	/*
@@ -863,9 +869,6 @@ static void init_amd(struct cpuinfo_x86 *c)
 
 	init_amd_cacheinfo(c);
 
-	if (c->x86 >= 0xf)
-		set_cpu_cap(c, X86_FEATURE_K8);
-
 	if (cpu_has(c, X86_FEATURE_XMM2)) {
 		unsigned long long val;
 		int ret;
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index eb4cb3efd20e..71281ac43b15 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1015,6 +1015,24 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	setup_force_cpu_bug(X86_BUG_CPU_MELTDOWN);
 }
 
+/*
+ * The NOPL instruction is supposed to exist on all CPUs of family >= 6;
+ * unfortunately, that's not true in practice because of early VIA
+ * chips and (more importantly) broken virtualizers that are not easy
+ * to detect. In the latter case it doesn't even *fail* reliably, so
+ * probing for it doesn't even work. Disable it completely on 32-bit
+ * unless we can find a reliable way to detect all the broken cases.
+ * Enable it explicitly on 64-bit for non-constant inputs of cpu_has().
+ */
+static void detect_nopl(struct cpuinfo_x86 *c)
+{
+#ifdef CONFIG_X86_32
+	clear_cpu_cap(c, X86_FEATURE_NOPL);
+#else
+	set_cpu_cap(c, X86_FEATURE_NOPL);
+#endif
+}
+
 /*
  * Do minimum CPU detection early.
  * Fields really needed: vendor, cpuid_level, family, model, mask,
@@ -1089,6 +1107,8 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 	 */
 	if (!pgtable_l5_enabled())
 		setup_clear_cpu_cap(X86_FEATURE_LA57);
+
+	detect_nopl(c);
 }
 
 void __init early_cpu_init(void)
@@ -1124,24 +1144,6 @@ void __init early_cpu_init(void)
 	early_identify_cpu(&boot_cpu_data);
 }
 
-/*
- * The NOPL instruction is supposed to exist on all CPUs of family >= 6;
- * unfortunately, that's not true in practice because of early VIA
- * chips and (more importantly) broken virtualizers that are not easy
- * to detect. In the latter case it doesn't even *fail* reliably, so
- * probing for it doesn't even work. Disable it completely on 32-bit
- * unless we can find a reliable way to detect all the broken cases.
- * Enable it explicitly on 64-bit for non-constant inputs of cpu_has().
- */
-static void detect_nopl(struct cpuinfo_x86 *c)
-{
-#ifdef CONFIG_X86_32
-	clear_cpu_cap(c, X86_FEATURE_NOPL);
-#else
-	set_cpu_cap(c, X86_FEATURE_NOPL);
-#endif
-}
-
 static void detect_null_seg_behavior(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index da1dbd99cb6e..7490de925a81 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -866,6 +866,8 @@ void __init setup_arch(char **cmdline_p)
 
 	idt_setup_early_traps();
 	early_cpu_init();
+	arch_init_ideal_nops();
+	jump_label_init();
 	early_ioremap_init();
 
 	setup_olpc_ofw_pgd();
@@ -1268,8 +1270,6 @@ void __init setup_arch(char **cmdline_p)
 
 	mcheck_init();
 
-	arch_init_ideal_nops();
-
 	register_refined_jiffies(CLOCK_TICK_RATE);
 
 #ifdef CONFIG_EFI
