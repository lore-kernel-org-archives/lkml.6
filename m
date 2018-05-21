Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqwHc/snVnjh2QHCrUKNTTF5kVquqLqUr7RxbJwL3/4Q4SonpDcRfs5TgSHbhFbjfcm6Q24
ARC-Seal: i=1; a=rsa-sha256; t=1526937336; cv=none;
        d=google.com; s=arc-20160816;
        b=JOlkf5SWRDnwCVKbj410K+ryRU3tEacYogwdQcSCvxgQRlIutwOTkl3PixxTCYI1CB
         iFLPMf0145t4J8rk+GMWpICNpvm+C9WWae5hZyF/GwX7TpPGnKLgqmVNCufc8/BuV792
         b4QlvctCikhuqU2l+LgxxPtdvECvRC1KCvSl+LfAFKwAWlJlxZ9nc3LlZ7S9w0vHTumr
         +9givxihHhLDWiKiXDPdLbrHls3rI1z2cDc0Mqvk7EMBBAZDeMYgPClr0uuzpLNZGpmO
         wE/hpJMfNr3BPx8tyMxh09JSVD2BoBoG/wQMOZ2Pbbwa4aUvFZbJiY7w8kyl8fLhPRKG
         XD+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=FdXkvBJmu9+IU5PpCMpeN1feW0Y643Rzu1VhIkITE44=;
        b=B+a6g3xmAaoZTfUblEQdnhwiQNmdDp/iVbh3PbagxGu006Ku88p7k0j1EEoNcK6J5B
         MkImTPKBoGpoCtMEZbqWrnM38HiFaWvoBqNVyiR6o77SH18zFq/lUgSAB13KTr/KjI7k
         KZeVPar5vz4HShV/7Jbk13Au0GTbWwuRAm1JQ7FdahcjDuCQunlF/34YDQ3+k7I7ZFFl
         GcxpFn7zTXgNK6hQlvKL1ZXjnDDPNapSLbYV7MJLihuIfL0pylcOvCwOb2AotohCSZXr
         CR0LYRDCrsyHMljq+T9jkhXAadZAVd/WGvIZs8uVOXAe+tKUelapeiLfjyIBXCDRy/X8
         C2Jw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=MiPLVyn8;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=MiPLVyn8;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>,
	Ingo Molnar <mingo@kernel.org>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 44/87] x86/bugs/intel: Set proper CPU features and setup RDS
Date: Mon, 21 May 2018 23:11:20 +0200
Message-Id: <20180521210424.539373995@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109844632570010?=
X-GMAIL-MSGID: =?utf-8?q?1601109844632570010?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/msr-index.h |    6 ++++++
 arch/x86/kernel/cpu/bugs.c       |   30 ++++++++++++++++++++++++++++--
 arch/x86/kernel/cpu/common.c     |   10 ++++++----
 arch/x86/kernel/cpu/cpu.h        |    3 +++
 arch/x86/kernel/cpu/intel.c      |    1 +
 5 files changed, 44 insertions(+), 6 deletions(-)

--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -40,6 +40,7 @@
 #define MSR_IA32_SPEC_CTRL		0x00000048 /* Speculation Control */
 #define SPEC_CTRL_IBRS			(1 << 0)   /* Indirect Branch Restricted Speculation */
 #define SPEC_CTRL_STIBP			(1 << 1)   /* Single Thread Indirect Branch Predictors */
+#define SPEC_CTRL_RDS			(1 << 2)   /* Reduced Data Speculation */
 
 #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
 #define PRED_CMD_IBPB			(1 << 0)   /* Indirect Branch Prediction Barrier */
@@ -61,6 +62,11 @@
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
@@ -116,7 +116,7 @@ static enum spectre_v2_mitigation spectr
 
 void x86_spec_ctrl_set(u64 val)
 {
-	if (val & ~SPEC_CTRL_IBRS)
+	if (val & ~(SPEC_CTRL_IBRS | SPEC_CTRL_RDS))
 		WARN_ONCE(1, "SPEC_CTRL MSR value 0x%16llx is unknown.\n", val);
 	else
 		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base | val);
@@ -443,8 +443,28 @@ static enum ssb_mitigation_cmd __init __
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
 
@@ -458,6 +478,12 @@ static void ssb_select_mitigation()
 
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
@@ -903,7 +903,11 @@ static void __init cpu_set_bug_bits(stru
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
@@ -915,9 +919,6 @@ static void __init cpu_set_bug_bits(stru
 	if (x86_match_cpu(cpu_no_meltdown))
 		return;
 
-	if (cpu_has(c, X86_FEATURE_ARCH_CAPABILITIES))
-		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
-
 	/* Rogue Data Cache Load? No! */
 	if (ia32_cap & ARCH_CAP_RDCL_NO)
 		return;
@@ -1339,6 +1340,7 @@ void identify_secondary_cpu(struct cpuin
 #endif
 	mtrr_ap_init();
 	validate_apic_and_package_id(c);
+	x86_spec_ctrl_setup_ap();
 }
 
 struct msr_range {
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -46,4 +46,7 @@ extern const struct cpu_dev *const __x86
 
 extern void get_cpu_cap(struct cpuinfo_x86 *c);
 extern void cpu_detect_cache_sizes(struct cpuinfo_x86 *c);
+
+extern void x86_spec_ctrl_setup_ap(void);
+
 #endif /* ARCH_X86_CPU_H */
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -154,6 +154,7 @@ static void early_init_intel(struct cpui
 		setup_clear_cpu_cap(X86_FEATURE_STIBP);
 		setup_clear_cpu_cap(X86_FEATURE_SPEC_CTRL);
 		setup_clear_cpu_cap(X86_FEATURE_INTEL_STIBP);
+		setup_clear_cpu_cap(X86_FEATURE_RDS);
 	}
 
 	/*
