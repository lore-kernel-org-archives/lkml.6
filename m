Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrh3NgNn5FQOaprlBxW0yLSgtB+y6uaOc3eVk46fzkeZC/LLD2G4tShK/BdeyZReY/LOqW0
ARC-Seal: i=1; a=rsa-sha256; t=1526937610; cv=none;
        d=google.com; s=arc-20160816;
        b=TlbSyX6qkvdEmm33LXjNRdm0LcUH/CH3/n1Q3D76UksnlPpdmP+y/Ek3RxUtXyYGId
         nbCK7p0fL5BkkaoRpVlH6vV4WAA0tp9rlRkXpMVVnf+cal2zJNgpZqkbY7PyCs0NvZv0
         T+n6mRh+z8Y+BygGjgyDcGppNuA0eprDP2tmLz3rQT1eUJh/s2LK43uEVIqwSdWyxHQD
         m+PxDHTjUtf3m9dusuOfVIKrslPGnvduWnQtSuaut4/yFgQhFDZH1WczrRiT4Uyy4hEn
         03jRNnh/zImyhWivXNdH1B1Yb0LwEOsztuEi7tISvvqwnH6LerEyJYc/hnSpWoKHfpp7
         joJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=rNKDgGcCieHkEpeEKyLA9If4By1Yk9HClppuIxxNd1Q=;
        b=OSE/NfRMykDZb0gLXbPgKdYxU6QaFF7ZMgfM59hCq1CKABuJaoI4/PLSABTHpGnAkJ
         gKTEyRPWaIglJEyeuSb+5Ynvg8r8Kq4Q++fOc75O/6jclEyCz6nDvbGwneGKxkXSprNw
         2+l9uoNQajFdjkt+XfM/9iEtSvReM6R2CQQznYtx5+nmU2vBgI7OMDROoiZ0W5XTaAaI
         DMYdnk5YSOn0ZtgNmmfi6Y5na7rpLzEamc7hVsl+AWiM32sXjdNDzw+uhf1mvlSJxfst
         vNz1WI5eUCFH3ytCVlD+CP+TZP8sijyWhKDr74E/QpD5mw3duxkk1b4551DVOymTtwNM
         46EA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=oFYP87kt;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=oFYP87kt;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 56/95] x86/bugs/intel: Set proper CPU features and setup RDS
Date: Mon, 21 May 2018 23:11:46 +0200
Message-Id: <20180521210458.503710843@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109844632570010?=
X-GMAIL-MSGID: =?utf-8?q?1601110131304796653?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 772439717dbf703b39990be58d8d4e3e4ad0598a upstream

Intel CPUs expose methods to:

 - Detect whether RDS capability is available via CPUID.7.0.EDX[31],

 - The SPEC_CTRL MSR(0x48), bit 2 set to enable RDS.

 - MSR_IA32_ARCH_CAPABILITIES, Bit(4) no need to enable RRS.

With that in mind if spec_store_bypass_disable=[auto,on] is selected set at
boot-time the SPEC_CTRL MSR to enable RDS if the platform requires it.

Note that this does not fix the KVM case where the SPEC_CTRL is exposed to
guests which can muck with it, see patch titled :
 KVM/SVM/VMX/x86/spectre_v2: Support the combination of guest and host IBRS.

And for the firmware (IBRS to be set), see patch titled:
 x86/spectre_v2: Read SPEC_CTRL MSR during boot and re-use reserved bits

[ tglx: Distangled it from the intel implementation and kept the call order ]

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/msr-index.h |    6 ++++++
 arch/x86/kernel/cpu/bugs.c       |   30 ++++++++++++++++++++++++++++--
 arch/x86/kernel/cpu/common.c     |   10 ++++++----
 arch/x86/kernel/cpu/cpu.h        |    2 ++
 arch/x86/kernel/cpu/intel.c      |    1 +
 5 files changed, 43 insertions(+), 6 deletions(-)

--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -42,6 +42,7 @@
 #define MSR_IA32_SPEC_CTRL		0x00000048 /* Speculation Control */
 #define SPEC_CTRL_IBRS			(1 << 0)   /* Indirect Branch Restricted Speculation */
 #define SPEC_CTRL_STIBP			(1 << 1)   /* Single Thread Indirect Branch Predictors */
+#define SPEC_CTRL_RDS			(1 << 2)   /* Reduced Data Speculation */
 
 #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
 #define PRED_CMD_IBPB			(1 << 0)   /* Indirect Branch Prediction Barrier */
@@ -68,6 +69,11 @@
 #define MSR_IA32_ARCH_CAPABILITIES	0x0000010a
 #define ARCH_CAP_RDCL_NO		(1 << 0)   /* Not susceptible to Meltdown */
 #define ARCH_CAP_IBRS_ALL		(1 << 1)   /* Enhanced IBRS support */
+#define ARCH_CAP_RDS_NO			(1 << 4)   /*
+						    * Not susceptible to Speculative Store Bypass
+						    * attack, so no Reduced Data Speculation control
+						    * required.
+						    */
 
 #define MSR_IA32_BBL_CR_CTL		0x00000119
 #define MSR_IA32_BBL_CR_CTL3		0x0000011e
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -117,7 +117,7 @@ static enum spectre_v2_mitigation spectr
 
 void x86_spec_ctrl_set(u64 val)
 {
-	if (val & ~SPEC_CTRL_IBRS)
+	if (val & ~(SPEC_CTRL_IBRS | SPEC_CTRL_RDS))
 		WARN_ONCE(1, "SPEC_CTRL MSR value 0x%16llx is unknown.\n", val);
 	else
 		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base | val);
@@ -444,8 +444,28 @@ static enum ssb_mitigation_cmd __init __
 		break;
 	}
 
-	if (mode != SPEC_STORE_BYPASS_NONE)
+	/*
+	 * We have three CPU feature flags that are in play here:
+	 *  - X86_BUG_SPEC_STORE_BYPASS - CPU is susceptible.
+	 *  - X86_FEATURE_RDS - CPU is able to turn off speculative store bypass
+	 *  - X86_FEATURE_SPEC_STORE_BYPASS_DISABLE - engage the mitigation
+	 */
+	if (mode != SPEC_STORE_BYPASS_NONE) {
 		setup_force_cpu_cap(X86_FEATURE_SPEC_STORE_BYPASS_DISABLE);
+		/*
+		 * Intel uses the SPEC CTRL MSR Bit(2) for this, while AMD uses
+		 * a completely different MSR and bit dependent on family.
+		 */
+		switch (boot_cpu_data.x86_vendor) {
+		case X86_VENDOR_INTEL:
+			x86_spec_ctrl_base |= SPEC_CTRL_RDS;
+			x86_spec_ctrl_set(SPEC_CTRL_RDS);
+			break;
+		case X86_VENDOR_AMD:
+			break;
+		}
+	}
+
 	return mode;
 }
 
@@ -459,6 +479,12 @@ static void ssb_select_mitigation()
 
 #undef pr_fmt
 
+void x86_spec_ctrl_setup_ap(void)
+{
+	if (boot_cpu_has(X86_FEATURE_IBRS))
+		x86_spec_ctrl_set(x86_spec_ctrl_base & (SPEC_CTRL_IBRS | SPEC_CTRL_RDS));
+}
+
 #ifdef CONFIG_SYSFS
 
 ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -918,7 +918,11 @@ static void __init cpu_set_bug_bits(stru
 {
 	u64 ia32_cap = 0;
 
-	if (!x86_match_cpu(cpu_no_spec_store_bypass))
+	if (cpu_has(c, X86_FEATURE_ARCH_CAPABILITIES))
+		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
+
+	if (!x86_match_cpu(cpu_no_spec_store_bypass) &&
+	   !(ia32_cap & ARCH_CAP_RDS_NO))
 		setup_force_cpu_bug(X86_BUG_SPEC_STORE_BYPASS);
 
 	if (x86_match_cpu(cpu_no_speculation))
@@ -930,9 +934,6 @@ static void __init cpu_set_bug_bits(stru
 	if (x86_match_cpu(cpu_no_meltdown))
 		return;
 
-	if (cpu_has(c, X86_FEATURE_ARCH_CAPABILITIES))
-		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
-
 	/* Rogue Data Cache Load? No! */
 	if (ia32_cap & ARCH_CAP_RDCL_NO)
 		return;
@@ -1346,6 +1347,7 @@ void identify_secondary_cpu(struct cpuin
 #endif
 	mtrr_ap_init();
 	validate_apic_and_package_id(c);
+	x86_spec_ctrl_setup_ap();
 }
 
 static __init int setup_noclflush(char *arg)
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -50,4 +50,6 @@ extern void cpu_detect_cache_sizes(struc
 
 unsigned int aperfmperf_get_khz(int cpu);
 
+extern void x86_spec_ctrl_setup_ap(void);
+
 #endif /* ARCH_X86_CPU_H */
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -189,6 +189,7 @@ static void early_init_intel(struct cpui
 		setup_clear_cpu_cap(X86_FEATURE_STIBP);
 		setup_clear_cpu_cap(X86_FEATURE_SPEC_CTRL);
 		setup_clear_cpu_cap(X86_FEATURE_INTEL_STIBP);
+		setup_clear_cpu_cap(X86_FEATURE_RDS);
 	}
 
 	/*
