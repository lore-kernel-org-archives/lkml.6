Return-Path: <DavidWang@zhaoxin.com>
X-Google-Smtp-Source: AIpwx4/Bkys7hKrZ4P6FTX5jluBERanMQ1VQiyMR7UOkDVuJNRyaCubYnvRGI1IJcXteajoJbHvy
ARC-Seal: i=1; a=rsa-sha256; t=1524739655; cv=none;
        d=google.com; s=arc-20160816;
        b=NUycyBuiDqcQG46GQ/jBCibIVQas9y69d97jO3BtseT1sCq+mDzhr23Skkt8fXvJid
         KxivHRyCCMb6wmO8jrrxbxkeaLl3Edv6zrYtD0PEFomhriW7h9JyFtjImmMjcZlw4rd8
         2kBAnf+Wio289RqKDEWxGZswEPtaEOUrZiebTgtj5Jvwv64v/hU1PHd/Lp/PwnqA95wx
         Jj4/RCzQqLEX1Om1q3xTivgVEWc3oIXSXNEJlzm5Ld7EesSSAN6iiIpMph/nj1rH5exY
         +viks0/Q/lnD1jNThh3GTPeaqFafCy3oCaXHPsel61EUpcKfDnasVuDWFAI4pKwPcbE5
         PyVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=3wA/lSlupvgTpYom109prSUkanAkjG9YdBpCfj1gGyQ=;
        b=Zp7Hlpl6M5eyUEXN8OwaGMf3fJKqMnaBnFhxctKz6c9G3Qc3EBCOMlwjgCEmclzpOf
         a83CT3vRwaY62BlCU/A6SGU6BVrdr/ILUbBFQxXZ3XSOnRaARES4t0BM7VFj5xLgZFGQ
         rav3uc1Gc4OViF65+NPthNmXcrq1q5Uoh0+j4ZJO1zYFuXsRSVXAw5c1budGfGO3B+hg
         TmO+leX9HNYCiH9Ix/xrH+HiWHo1s5YfbZxPcnV4i9hOtiNrKEfa9m52RrH/rnbrUppB
         jZXM5neiA4R25hMI5KsK3KBMzL6JHws78pCJwBwoJVoXOzJDatHo9GAatsZU8BAEpL4P
         TQTA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 203.148.12.81 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 203.148.12.81 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
From: David Wang <davidwang@zhaoxin.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
	<gregkh@linuxfoundation.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <brucechang@via-alliance.com>, <cooperyan@zhaoxin.com>,
	<qiyuanwang@zhaoxin.com>, <benjaminpan@viatech.com>, <lukelin@viacpu.com>,
	<timguo@zhaoxin.com>, David Wang <davidwang@zhaoxin.com>
Subject: [PATCH v3] report correct CPU/cache topology
Date: Thu, 26 Apr 2018 18:47:27 +0800
Message-ID: <1524739647-30980-1-git-send-email-davidwang@zhaoxin.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.8.54]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598805408410089263?=
X-GMAIL-MSGID: =?utf-8?q?1598805408410089263?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Centaur CPUs enumerate the cache topology in the same way as Intel CPUs,
but the function is unused so far.
The Centaur init code also misses to initialize x86_info::max_cores, so
the CPU topology can't be described correctly.

Initialize x86_info::max_cores and invoke init_intel_cachinfo() to make
CPU and cache topology information avaliable and correct

Signed-off-by: David Wang <davidwang@zhaoxin.com>

Changes from v2 to v3:
*1 define new detect_num_cpu_cores() in common.c to replace the original
intel_num_cpu_cores;  
*2 move cpu_detect_cache_sizes inside init_intel_cacheinfo.

Changes from v1 to v2:
*1 replace centaur_num_cpu_cores with early_init_centaur_mc according to 
suggestions from tglx;
*2 call cpu_detect_cache_sizes when init_intel_cacheinfo returns 0. For
some very old Centaur CPUs can't support the mechanisms defined in init_
intel_cacheinfo.

---
 arch/x86/include/asm/processor.h      |  1 +
 arch/x86/kernel/cpu/centaur.c         |  5 +++++
 arch/x86/kernel/cpu/common.c          | 14 ++++++++++++++
 arch/x86/kernel/cpu/intel.c           | 28 ++--------------------------
 arch/x86/kernel/cpu/intel_cacheinfo.c |  6 ++++++
 5 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 21a1149..96e9070 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -192,6 +192,7 @@ extern u32 get_scattered_cpuid_leaf(unsigned int level,
 				    enum cpuid_regs_idx reg);
 extern unsigned int init_intel_cacheinfo(struct cpuinfo_x86 *c);
 extern void init_amd_cacheinfo(struct cpuinfo_x86 *c);
+extern int detect_num_cpu_cores(struct cpuinfo_x86 *c);
 
 extern void detect_extended_topology(struct cpuinfo_x86 *c);
 extern void detect_ht(struct cpuinfo_x86 *c);
diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
index 80d5110..c265494 100644
--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -160,6 +160,11 @@ static void init_centaur(struct cpuinfo_x86 *c)
 	clear_cpu_cap(c, 0*32+31);
 #endif
 	early_init_centaur(c);
+	init_intel_cacheinfo(c);
+	c->x86_max_cores = detect_num_cpu_cores(c);
+#ifdef CONFIG_X86_32
+	detect_ht(c);
+#endif
 
 	if (c->cpuid_level > 9) {
 		unsigned int eax = cpuid_eax(10);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 8a5b185..0c80d50 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -577,6 +577,20 @@ static void get_model_name(struct cpuinfo_x86 *c)
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
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index b9693b8..e1138da 100644
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
@@ -671,19 +653,13 @@ static void init_intel(struct cpuinfo_x86 *c)
 		 * let's use the legacy cpuid vector 0x1 and 0x4 for topology
 		 * detection.
 		 */
-		c->x86_max_cores = intel_num_cpu_cores(c);
+		c->x86_max_cores = detect_num_cpu_cores(c);
 #ifdef CONFIG_X86_32
 		detect_ht(c);
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
diff --git a/arch/x86/kernel/cpu/intel_cacheinfo.c b/arch/x86/kernel/cpu/intel_cacheinfo.c
index 54d04d5..2a0597c 100644
--- a/arch/x86/kernel/cpu/intel_cacheinfo.c
+++ b/arch/x86/kernel/cpu/intel_cacheinfo.c
@@ -20,6 +20,8 @@
 #include <asm/amd_nb.h>
 #include <asm/smp.h>
 
+#include "cpu.h"
+
 #define LVL_1_INST	1
 #define LVL_1_DATA	2
 #define LVL_2		3
@@ -802,6 +804,10 @@ unsigned int init_intel_cacheinfo(struct cpuinfo_x86 *c)
 
 	c->x86_cache_size = l3 ? l3 : (l2 ? l2 : (l1i+l1d));
 
+	if (!l2) {
+		cpu_detect_cache_sizes(c);
+		l2 = c->x86_cache_size;
+	}
 	return l2;
 }
 
-- 
1.9.1
