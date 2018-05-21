Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqWccm87+n5vOuguCe0RfmGkkWFzyvhd1eeQTa2g7X7qR8i9C9K0PcNOur2Gv+/ksbSX1CZ
ARC-Seal: i=1; a=rsa-sha256; t=1526937615; cv=none;
        d=google.com; s=arc-20160816;
        b=UcO+ih6O0jcvoK8Io+6bnixkomOsNc83SBHUG8N5WX6Uwff9dz6emd8c5ycFu2AEC/
         WBem9jWq89+TTGwZYhs353FQya/m+znl8bwn1sVoBYiHInuL4FARfS84tbetLix4QMa/
         UHjo4pVoUZ4xjTXqE6F7MCLlcDzmLSPC5BXjv38t6Dlu9gc2urVJuVIdq0vFuWDg/Cyo
         ULI2Di9PYW2xf2VyN3N6k9ZWsI3BhWJi0nUosmWMaxgd9/o7cSPOAkesn6xGU+Wh6bjA
         HxwCjyFcVUlkgFDSpITPCH0eklkteSibd1WA49AghKxLxtreT5CwDLJVQvaz+0S+b+eG
         8QIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=K07vJylc4rxtEv+iHdrJ9GkGx/239o8N71i0UpR0Uh8=;
        b=x6NoHPlASVKrPuG2YNxXwfgLrI9xvKoO98fHXS25UqDmVoi6cmPoIKopUQNw5s+3VC
         hyqGiej/1qCk7Ux8AHk1OzqSk0JkqdTXwKsz2awoi28N1QUhgY4ULmzLYCxl4AijicMr
         6E1EjOcNqTQDRFk+Q0TFLaTtigNsrW7awRgJA2yJK5FIIxEqt+wOodZPwFMxDl8KSjVv
         QnWmsEK9xV4bVgsYPVT5YwgjpphduuQmxwdRcgrtV/w9U/etz8Yp53t0W5GscT+vyO14
         gFR5EbI/sLSbX1AE0dwndYA+TasBYgfBl8eYmfx907FhMCfi7EAVuDb6MtAvMaFLAw3x
         B/6w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Ae+fW0a0;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Ae+fW0a0;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 58/95] x86/bugs/AMD: Add support to disable RDS on Fam[15,16,17]h if requested
Date: Mon, 21 May 2018 23:11:48 +0200
Message-Id: <20180521210458.669340999@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109853456079328?=
X-GMAIL-MSGID: =?utf-8?q?1601110137596013993?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 764f3c21588a059cd783c6ba0734d4db2d72822d upstream

AMD does not need the Speculative Store Bypass mitigation to be enabled.

The parameters for this are already available and can be done via MSR
C001_1020. Each family uses a different bit in that MSR for this.

[ tglx: Expose the bit mask via a variable and move the actual MSR fiddling
  	into the bugs code as that's the right thing to do and also required
	to prepare for dynamic enable/disable ]

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/cpufeatures.h   |    1 +
 arch/x86/include/asm/nospec-branch.h |    4 ++++
 arch/x86/kernel/cpu/amd.c            |   26 ++++++++++++++++++++++++++
 arch/x86/kernel/cpu/bugs.c           |   27 ++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/common.c         |    4 ++++
 5 files changed, 61 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -213,6 +213,7 @@
 #define X86_FEATURE_USE_IBPB		( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled */
 #define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* "" Use IBRS during runtime firmware calls */
 #define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /* "" Disable Speculative Store Bypass. */
+#define X86_FEATURE_AMD_RDS		(7*32+24)  /* "" AMD RDS implementation */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -244,6 +244,10 @@ enum ssb_mitigation {
 	SPEC_STORE_BYPASS_DISABLE,
 };
 
+/* AMD specific Speculative Store Bypass MSR data */
+extern u64 x86_amd_ls_cfg_base;
+extern u64 x86_amd_ls_cfg_rds_mask;
+
 extern char __indirect_thunk_start[];
 extern char __indirect_thunk_end[];
 
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -10,6 +10,7 @@
 #include <asm/processor.h>
 #include <asm/apic.h>
 #include <asm/cpu.h>
+#include <asm/nospec-branch.h>
 #include <asm/smp.h>
 #include <asm/pci-direct.h>
 #include <asm/delay.h>
@@ -554,6 +555,26 @@ static void bsp_init_amd(struct cpuinfo_
 		rdmsrl(MSR_FAM10H_NODE_ID, value);
 		nodes_per_socket = ((value >> 3) & 7) + 1;
 	}
+
+	if (c->x86 >= 0x15 && c->x86 <= 0x17) {
+		unsigned int bit;
+
+		switch (c->x86) {
+		case 0x15: bit = 54; break;
+		case 0x16: bit = 33; break;
+		case 0x17: bit = 10; break;
+		default: return;
+		}
+		/*
+		 * Try to cache the base value so further operations can
+		 * avoid RMW. If that faults, do not enable RDS.
+		 */
+		if (!rdmsrl_safe(MSR_AMD64_LS_CFG, &x86_amd_ls_cfg_base)) {
+			setup_force_cpu_cap(X86_FEATURE_RDS);
+			setup_force_cpu_cap(X86_FEATURE_AMD_RDS);
+			x86_amd_ls_cfg_rds_mask = 1ULL << bit;
+		}
+	}
 }
 
 static void early_init_amd(struct cpuinfo_x86 *c)
@@ -872,6 +893,11 @@ static void init_amd(struct cpuinfo_x86
 	/* AMD CPUs don't reset SS attributes on SYSRET, Xen does. */
 	if (!cpu_has(c, X86_FEATURE_XENPV))
 		set_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
+
+	if (boot_cpu_has(X86_FEATURE_AMD_RDS)) {
+		set_cpu_cap(c, X86_FEATURE_RDS);
+		set_cpu_cap(c, X86_FEATURE_AMD_RDS);
+	}
 }
 
 #ifdef CONFIG_X86_32
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -41,6 +41,13 @@ static u64 __ro_after_init x86_spec_ctrl
  */
 static u64 __ro_after_init x86_spec_ctrl_mask = ~SPEC_CTRL_IBRS;
 
+/*
+ * AMD specific MSR info for Speculative Store Bypass control.
+ * x86_amd_ls_cfg_rds_mask is initialized in identify_boot_cpu().
+ */
+u64 __ro_after_init x86_amd_ls_cfg_base;
+u64 __ro_after_init x86_amd_ls_cfg_rds_mask;
+
 void __init check_bugs(void)
 {
 	identify_boot_cpu();
@@ -52,7 +59,8 @@ void __init check_bugs(void)
 
 	/*
 	 * Read the SPEC_CTRL MSR to account for reserved bits which may
-	 * have unknown values.
+	 * have unknown values. AMD64_LS_CFG MSR is cached in the early AMD
+	 * init code as it is not enumerated and depends on the family.
 	 */
 	if (boot_cpu_has(X86_FEATURE_IBRS))
 		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
@@ -154,6 +162,14 @@ void x86_spec_ctrl_restore_host(u64 gues
 }
 EXPORT_SYMBOL_GPL(x86_spec_ctrl_restore_host);
 
+static void x86_amd_rds_enable(void)
+{
+	u64 msrval = x86_amd_ls_cfg_base | x86_amd_ls_cfg_rds_mask;
+
+	if (boot_cpu_has(X86_FEATURE_AMD_RDS))
+		wrmsrl(MSR_AMD64_LS_CFG, msrval);
+}
+
 #ifdef RETPOLINE
 static bool spectre_v2_bad_module;
 
@@ -443,6 +459,11 @@ static enum ssb_mitigation_cmd __init __
 
 	switch (cmd) {
 	case SPEC_STORE_BYPASS_CMD_AUTO:
+		/*
+		 * AMD platforms by default don't need SSB mitigation.
+		 */
+		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+			break;
 	case SPEC_STORE_BYPASS_CMD_ON:
 		mode = SPEC_STORE_BYPASS_DISABLE;
 		break;
@@ -469,6 +490,7 @@ static enum ssb_mitigation_cmd __init __
 			x86_spec_ctrl_set(SPEC_CTRL_RDS);
 			break;
 		case X86_VENDOR_AMD:
+			x86_amd_rds_enable();
 			break;
 		}
 	}
@@ -490,6 +512,9 @@ void x86_spec_ctrl_setup_ap(void)
 {
 	if (boot_cpu_has(X86_FEATURE_IBRS))
 		x86_spec_ctrl_set(x86_spec_ctrl_base & ~x86_spec_ctrl_mask);
+
+	if (ssb_mode == SPEC_STORE_BYPASS_DISABLE)
+		x86_amd_rds_enable();
 }
 
 #ifdef CONFIG_SYSFS
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -910,6 +910,10 @@ static const __initconst struct x86_cpu_
 	{ X86_VENDOR_CENTAUR,	5,					},
 	{ X86_VENDOR_INTEL,	5,					},
 	{ X86_VENDOR_NSC,	5,					},
+	{ X86_VENDOR_AMD,	0x12,					},
+	{ X86_VENDOR_AMD,	0x11,					},
+	{ X86_VENDOR_AMD,	0x10,					},
+	{ X86_VENDOR_AMD,	0xf,					},
 	{ X86_VENDOR_ANY,	4,					},
 	{}
 };
