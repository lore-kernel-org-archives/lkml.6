Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754507AbeDTKNX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 06:13:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33551 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754294AbeDTKNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 06:13:21 -0400
Date: Fri, 20 Apr 2018 03:13:10 -0700
From: tip-bot for David Wang <tipbot@zytor.com>
Message-ID: <tip-60882cc159e1416fb1d17210de60d4a3ba04e613@git.kernel.org>
Cc: davidwang@zhaoxin.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        mingo@kernel.org, tglx@linutronix.de
Reply-To: davidwang@zhaoxin.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <1524212968-28998-1-git-send-email-davidwang@zhaoxin.com>
References: <1524212968-28998-1-git-send-email-davidwang@zhaoxin.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/Centaur: Initialize supported CPU features
 properly
Git-Commit-ID: 60882cc159e1416fb1d17210de60d4a3ba04e613
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

Commit-ID:  60882cc159e1416fb1d17210de60d4a3ba04e613
Gitweb:     https://git.kernel.org/tip/60882cc159e1416fb1d17210de60d4a3ba04e613
Author:     David Wang <davidwang@zhaoxin.com>
AuthorDate: Fri, 20 Apr 2018 16:29:28 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Apr 2018 12:08:17 +0200

x86/Centaur: Initialize supported CPU features properly

Centaur CPUs have some Intel compatible capabilities,including Permformance
Monitoring Counters and CPU virtualization capabilities. Initialize them in
the Centaur specific init code.

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
Link: https://lkml.kernel.org/r/1524212968-28998-1-git-send-email-davidwang@zhaoxin.com

---
 arch/x86/kernel/cpu/centaur.c | 48 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
index e5ec0f11c0de..80d5110481ec 100644
--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -18,6 +18,13 @@
 #define RNG_ENABLED	(1 << 3)
 #define RNG_ENABLE	(1 << 6)	/* MSR_VIA_RNG */
 
+#define X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW	0x00200000
+#define X86_VMX_FEATURE_PROC_CTLS_VNMI		0x00400000
+#define X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS	0x80000000
+#define X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC	0x00000001
+#define X86_VMX_FEATURE_PROC_CTLS2_EPT		0x00000002
+#define X86_VMX_FEATURE_PROC_CTLS2_VPID		0x00000020
+
 static void init_c3(struct cpuinfo_x86 *c)
 {
 	u32  lo, hi;
@@ -112,6 +119,31 @@ static void early_init_centaur(struct cpuinfo_x86 *c)
 	}
 }
 
+static void centaur_detect_vmx_virtcap(struct cpuinfo_x86 *c)
+{
+	u32 vmx_msr_low, vmx_msr_high, msr_ctl, msr_ctl2;
+
+	rdmsr(MSR_IA32_VMX_PROCBASED_CTLS, vmx_msr_low, vmx_msr_high);
+	msr_ctl = vmx_msr_high | vmx_msr_low;
+
+	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW)
+		set_cpu_cap(c, X86_FEATURE_TPR_SHADOW);
+	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_VNMI)
+		set_cpu_cap(c, X86_FEATURE_VNMI);
+	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS) {
+		rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2,
+		      vmx_msr_low, vmx_msr_high);
+		msr_ctl2 = vmx_msr_high | vmx_msr_low;
+		if ((msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC) &&
+		    (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW))
+			set_cpu_cap(c, X86_FEATURE_FLEXPRIORITY);
+		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_EPT)
+			set_cpu_cap(c, X86_FEATURE_EPT);
+		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VPID)
+			set_cpu_cap(c, X86_FEATURE_VPID);
+	}
+}
+
 static void init_centaur(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_X86_32
@@ -128,6 +160,19 @@ static void init_centaur(struct cpuinfo_x86 *c)
 	clear_cpu_cap(c, 0*32+31);
 #endif
 	early_init_centaur(c);
+
+	if (c->cpuid_level > 9) {
+		unsigned int eax = cpuid_eax(10);
+
+		/*
+		 * Check for version and the number of counters
+		 * Version(eax[7:0]) can't be 0;
+		 * Counters(eax[15:8]) should be greater than 1;
+		 */
+		if ((eax & 0xff) && (((eax >> 8) & 0xff) > 1))
+			set_cpu_cap(c, X86_FEATURE_ARCH_PERFMON);
+	}
+
 	switch (c->x86) {
 #ifdef CONFIG_X86_32
 	case 5:
@@ -199,6 +244,9 @@ static void init_centaur(struct cpuinfo_x86 *c)
 #ifdef CONFIG_X86_64
 	set_cpu_cap(c, X86_FEATURE_LFENCE_RDTSC);
 #endif
+
+	if (cpu_has(c, X86_FEATURE_VMX))
+		centaur_detect_vmx_virtcap(c);
 }
 
 #ifdef CONFIG_X86_32
