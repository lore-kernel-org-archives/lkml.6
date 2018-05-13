Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbeEMMB3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 08:01:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45113 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeEMMB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 08:01:28 -0400
Date: Sun, 13 May 2018 05:01:20 -0700
From: tip-bot for David Wang <tipbot@zytor.com>
Message-ID: <tip-2cc61be60e37b1856a97ccbdcca3e86e593bf06a@git.kernel.org>
Cc: davidwang@zhaoxin.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com
Reply-To: davidwang@zhaoxin.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com
In-Reply-To: <1525314766-18910-2-git-send-email-davidwang@zhaoxin.com>
References: <1525314766-18910-2-git-send-email-davidwang@zhaoxin.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/CPU: Make intel_num_cpu_cores() generic
Git-Commit-ID: 2cc61be60e37b1856a97ccbdcca3e86e593bf06a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  2cc61be60e37b1856a97ccbdcca3e86e593bf06a
Gitweb:     https://git.kernel.org/tip/2cc61be60e37b1856a97ccbdcca3e86e593bf06a
Author:     David Wang <davidwang@zhaoxin.com>
AuthorDate: Thu, 3 May 2018 10:32:44 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 13 May 2018 12:06:12 +0200

x86/CPU: Make intel_num_cpu_cores() generic

intel_num_cpu_cores() is a static function in intel.c which can't be used
by other files. Define another function called detect_num_cpu_cores() in
common.c to replace this function so it can be reused.

Signed-off-by: David Wang <davidwang@zhaoxin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: lukelin@viacpu.com
Cc: qiyuanwang@zhaoxin.com
Cc: gregkh@linuxfoundation.org
Cc: brucechang@via-alliance.com
Cc: timguo@zhaoxin.com
Cc: cooperyan@zhaoxin.com
Cc: hpa@zytor.com
Cc: benjaminpan@viatech.com
Link: https://lkml.kernel.org/r/1525314766-18910-2-git-send-email-davidwang@zhaoxin.com

---
 arch/x86/kernel/cpu/common.c | 14 ++++++++++++++
 arch/x86/kernel/cpu/cpu.h    |  1 +
 arch/x86/kernel/cpu/intel.c  | 20 +-------------------
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 37c7c8334a00..6993842e788c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -584,6 +584,20 @@ static void get_model_name(struct cpuinfo_x86 *c)
 	*(s + 1) = '\0';
 }
 
+int detect_num_cpu_cores(struct cpuinfo_x86 *c)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	if (!IS_ENABLED(CONFIG_SMP) || c->cpuid_level < 4)
+		return 1;
+
+	cpuid_count(4, 0, &eax, &ebx, &ecx, &edx);
+	if (eax & 0x1f)
+		return (eax >> 26) + 1;
+	else
+		return 1;
+}
+
 void cpu_detect_cache_sizes(struct cpuinfo_x86 *c)
 {
 	unsigned int n, dummy, ebx, ecx, edx, l2size;
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index c415f99e9599..efd6ef8ad14e 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -54,6 +54,7 @@ extern u32 get_scattered_cpuid_leaf(unsigned int level,
 extern unsigned int init_intel_cacheinfo(struct cpuinfo_x86 *c);
 extern void init_amd_cacheinfo(struct cpuinfo_x86 *c);
 
+extern int detect_num_cpu_cores(struct cpuinfo_x86 *c);
 extern int detect_extended_topology(struct cpuinfo_x86 *c);
 extern void detect_ht(struct cpuinfo_x86 *c);
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index b9693b80fc21..b54535be254a 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -453,24 +453,6 @@ static void srat_detect_node(struct cpuinfo_x86 *c)
 #endif
 }
 
-/*
- * find out the number of processor cores on the die
- */
-static int intel_num_cpu_cores(struct cpuinfo_x86 *c)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	if (!IS_ENABLED(CONFIG_SMP) || c->cpuid_level < 4)
-		return 1;
-
-	/* Intel has a non-standard dependency on %ecx for this CPUID level. */
-	cpuid_count(4, 0, &eax, &ebx, &ecx, &edx);
-	if (eax & 0x1f)
-		return (eax >> 26) + 1;
-	else
-		return 1;
-}
-
 static void detect_vmx_virtcap(struct cpuinfo_x86 *c)
 {
 	/* Intel VMX MSR indicated features */
@@ -671,7 +653,7 @@ static void init_intel(struct cpuinfo_x86 *c)
 		 * let's use the legacy cpuid vector 0x1 and 0x4 for topology
 		 * detection.
 		 */
-		c->x86_max_cores = intel_num_cpu_cores(c);
+		c->x86_max_cores = detect_num_cpu_cores(c);
 #ifdef CONFIG_X86_32
 		detect_ht(c);
 #endif
