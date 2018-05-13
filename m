Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751648AbeEMMB5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 08:01:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41987 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeEMMB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 08:01:56 -0400
Date: Sun, 13 May 2018 05:01:51 -0700
From: tip-bot for David Wang <tipbot@zytor.com>
Message-ID: <tip-606e20959ef49f22cddb611f2cefef8e6501e3dd@git.kernel.org>
Cc: tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, davidwang@zhaoxin.com
Reply-To: linux-kernel@vger.kernel.org, davidwang@zhaoxin.com, hpa@zytor.com,
        mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <1525314766-18910-3-git-send-email-davidwang@zhaoxin.com>
References: <1525314766-18910-3-git-send-email-davidwang@zhaoxin.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/CPU: Move cpu_detect_cache_sizes() into
 init_intel_cacheinfo()
Git-Commit-ID: 606e20959ef49f22cddb611f2cefef8e6501e3dd
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

Commit-ID:  606e20959ef49f22cddb611f2cefef8e6501e3dd
Gitweb:     https://git.kernel.org/tip/606e20959ef49f22cddb611f2cefef8e6501e3dd
Author:     David Wang <davidwang@zhaoxin.com>
AuthorDate: Thu, 3 May 2018 10:32:45 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 13 May 2018 12:06:12 +0200

x86/CPU: Move cpu_detect_cache_sizes() into init_intel_cacheinfo()

There is no point in having the conditional cpu_detect_cache_sizes() call
at the callsite of init_intel_cacheinfo().

Move it into init_intel_cacheinfo() and make init_intel_cacheinfo() void.

[ tglx: Made the init_intel_cacheinfo() void as the return value was
  	pointless. Adjust changelog accordingly ]

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
Link: https://lkml.kernel.org/r/1525314766-18910-3-git-send-email-davidwang@zhaoxin.com

---
 arch/x86/kernel/cpu/cacheinfo.c |  5 +++--
 arch/x86/kernel/cpu/cpu.h       |  2 +-
 arch/x86/kernel/cpu/intel.c     | 13 +++----------
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 58d472c84ba2..38354c66df81 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -691,7 +691,7 @@ void init_amd_cacheinfo(struct cpuinfo_x86 *c)
 	}
 }
 
-unsigned int init_intel_cacheinfo(struct cpuinfo_x86 *c)
+void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 {
 	/* Cache sizes */
 	unsigned int trace = 0, l1i = 0, l1d = 0, l2 = 0, l3 = 0;
@@ -843,7 +843,8 @@ unsigned int init_intel_cacheinfo(struct cpuinfo_x86 *c)
 
 	c->x86_cache_size = l3 ? l3 : (l2 ? l2 : (l1i+l1d));
 
-	return l2;
+	if (!l2)
+		cpu_detect_cache_sizes(c);
 }
 
 static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index efd6ef8ad14e..49bf8a080105 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -51,7 +51,7 @@ extern void init_scattered_cpuid_features(struct cpuinfo_x86 *c);
 extern u32 get_scattered_cpuid_leaf(unsigned int level,
 				    unsigned int sub_leaf,
 				    enum cpuid_regs_idx reg);
-extern unsigned int init_intel_cacheinfo(struct cpuinfo_x86 *c);
+extern void init_intel_cacheinfo(struct cpuinfo_x86 *c);
 extern void init_amd_cacheinfo(struct cpuinfo_x86 *c);
 
 extern int detect_num_cpu_cores(struct cpuinfo_x86 *c);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index b54535be254a..615870420be2 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -635,8 +635,6 @@ static void init_intel_misc_features(struct cpuinfo_x86 *c)
 
 static void init_intel(struct cpuinfo_x86 *c)
 {
-	unsigned int l2 = 0;
-
 	early_init_intel(c);
 
 	intel_workarounds(c);
@@ -659,13 +657,7 @@ static void init_intel(struct cpuinfo_x86 *c)
 #endif
 	}
 
-	l2 = init_intel_cacheinfo(c);
-
-	/* Detect legacy cache sizes if init_intel_cacheinfo did not */
-	if (l2 == 0) {
-		cpu_detect_cache_sizes(c);
-		l2 = c->x86_cache_size;
-	}
+	init_intel_cacheinfo(c);
 
 	if (c->cpuid_level > 9) {
 		unsigned eax = cpuid_eax(10);
@@ -678,7 +670,8 @@ static void init_intel(struct cpuinfo_x86 *c)
 		set_cpu_cap(c, X86_FEATURE_LFENCE_RDTSC);
 
 	if (boot_cpu_has(X86_FEATURE_DS)) {
-		unsigned int l1;
+		unsigned int l1, l2;
+
 		rdmsr(MSR_IA32_MISC_ENABLE, l1, l2);
 		if (!(l1 & (1<<11)))
 			set_cpu_cap(c, X86_FEATURE_BTS);
