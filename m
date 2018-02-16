Return-Path: <dave.hansen@linux.intel.com>
X-Google-Smtp-Source: AH8x227lUcKAPwQSaHTH4liyqlNOIreXHsNerq9OzGD6jamk08F0VQLavXbTjGaG22M4YI+C0llF
ARC-Seal: i=1; a=rsa-sha256; t=1518808945; cv=none;
        d=google.com; s=arc-20160816;
        b=y0T7vk2VQ3oPBCAaeRIurVCa3bJ993DUNw6hFbqpoEKMVI75jKwFpxsnYCIoHfPm8u
         D+AaUqjPIm2szkpt4XG0e9cBOx4UYazXYrBDHe1Q9AFzWy01CMt1rncel9ie77qKTjKr
         GDPfKHqOXmgdIK/qRdWQDkFqPVZ+NaDfTG2uQFu1DiF1YyTX6AmCWRMy6BKJSRJAfnjV
         ZlH1G2p2+RrzJSl44V/k9FEAS0CnR8E19ppLAVjrlLy2HVii4XM52YQUkDfl1vUOezFl
         NQMzepgh6YCXmyos3awMMu9fu6gXhUZDq4eLOHsMdJhYohjPEDjlj1FLVl6eqe4oxCHO
         Rrrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:from:cc:to:subject:arc-authentication-results;
        bh=ozjfbPJ1P+Eelr66hGEPmaO9BZfdZBHI5YAP+FK/FYM=;
        b=kiXTZfTO9vDhB/Ro7XNXDLKA5A9eDylygj1HZdjN1WEYTFRkGZLxf17iuFftAU3qGD
         pq2/yq76JJH7HwV41erXPJVpYfCDk0j7zSlo8gZAVB2rSsGM9bHSkXgkf56MbAzizA8i
         ZkcJc0zVFxp5gaRhOed5sUyTwLn/5cKb7NFX/5UlDefjjriYRDcTpy5rKzdDGiCAoGIH
         3B0MwxCfl5dhUgHMXlsBXQEBcnBcKSNV4XNfuAzUV8ump+/0a2uizmb8DjDbOgjc6+oB
         jXfbmkw/NAZ0iY0qBcX7eAof3u9JlgnUZxE9HPlBg1dAAExj+8A0OD5nN6auZV7J3SOo
         JE2w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,520,1511856000";
   d="scan'208";a="18470001"
Subject: [RFC][PATCH] x86: proposed new ARCH_CAPABILITIES MSR bit for RSB-underflow
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,torvalds@linux-foundation.org,tglx@linutronix.de,gnomes@lxorguk.ukuu.org.uk,riel@redhat.com,jpoimboe@redhat.com,thomas.lendacky@amd.com,peterz@infradead.org,jikos@kernel.org,luto@amacapital.net,keescook@google.com,gregkh@linux-foundation.org,pjt@google.com,dwmw@amazon.co.uk,x86@kernel.org,ak@linux.intel.com,tim.c.chen@linux.intel.com,arjan@linux.intel.com,dan.j.williams@intel.com,asit.k.mallick@intel.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 16 Feb 2018 11:17:55 -0800
Message-Id: <20180216191755.6F62DDEA@viggo.jf.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592586608850569551?=
X-GMAIL-MSGID: =?utf-8?q?1592586608850569551?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Intel is considering adding a new bit to the IA32_ARCH_CAPABILITIES
MSR to tell when RSB underflow might be happen.  Feedback on this
would be greatly appreciated before the specification is finalized.

---

Background:

The RSB is a microarchitectural structure that attempts to help
predict the branch target of RET instructions.  It is implemented as a
stack that is pushed on CALL and popped on RET.  Being a stack, it can
become empty.  On some processors, an empty condition leads to use of
the other indirect branch predictors which have been targeted by
Spectre variant 2 (branch target injection) exploits.

Processors based on Skylake and its close derivatives have this
fallback behavior and need additional mitigation to avoid RSB-empty
conditions.  Right now, the only place we do this "RSB stuffing"
operation is at context switch.  We currently have a model/family list
to decide where to deploy this.

Problem:

However, that causes a problem in virtualization environments.  They
routinely expose a different model/family to guests than what the
bare-metal hardware has.  This, among other things, makes it easy to
migrate guests between different bare-metal systems with different
capabilities.  However, this defeats the Skylake-generation
model/family detection.

Solution:

To help address this issue, Intel is proposing a new bit in the
IA32_ARCH_CAPABILITIES MSR.  This bit, "RSB Override" (RSBO) would
indicate:

	The CPU may predict the target of RET instructions with a
	predictor other than the RSB when the RSB is 'empty'.

Hardware implementations may choose to set this, but it can also be
set by a hypervisor that traps RDMSR and simply wants to indicate to a
guest that it should deploy RSB-underflow mitigations.

An OS should assume that RSB-underflow mitigations are needed both
when RSBO=1 or when running on Skylake-generation processors with
RSBO=0.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: Rik van Riel <riel@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: thomas.lendacky@amd.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Kees Cook <keescook@google.com>
Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
Cc: Paul Turner <pjt@google.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: x86@kernel.org
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Asit Mallick <asit.k.mallick@intel.com>

---

 b/arch/x86/include/asm/msr-index.h |    1 
 b/arch/x86/kernel/cpu/bugs.c       |   47 +++++++++++++++++++++++++++++++++----
 2 files changed, 43 insertions(+), 5 deletions(-)

diff -puN arch/x86/kernel/cpu/bugs.c~need-rsb-stuffing arch/x86/kernel/cpu/bugs.c
--- a/arch/x86/kernel/cpu/bugs.c~need-rsb-stuffing	2018-02-16 10:06:56.807610157 -0800
+++ b/arch/x86/kernel/cpu/bugs.c	2018-02-16 10:43:24.281604702 -0800
@@ -218,6 +218,43 @@ static bool __init is_skylake_era(void)
 	return false;
 }
 
+/*
+ * This MSR has a bit to indicate whether the processor might fall back to
+ * the BTB.  Hypervisors might lie about the model/family, breaking the
+ * is_skylake_era() check.  They might also want the OS to deploy
+ * mitigations because it *might* get migrated to other hardware that has
+ * this behavior, even if current bare-metal hardware is not exposed.
+ */
+static bool cpu_has_rsb_override(void)
+{
+	u64 ia32_cap = 0;
+
+        if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
+		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
+
+        /* RSBO == RSB Override */
+        if (ia32_cap & ARCH_CAP_RSBO)
+		return true;
+
+	return false;
+}
+
+/*
+ * Can a RET instruction on this CPU fall back to the BTB?
+ */
+static bool __init cpu_ret_uses_btb(void)
+{
+	/* All Skylake-era processors fall back to BTB */
+	if (is_skylake_era())
+		return true;
+
+	/* Does the ARCH_CAPABILITIES override the model/family we see? */
+	if (cpu_has_rsb_override())
+		return true;
+
+	return false;
+}
+
 static void __init spectre_v2_select_mitigation(void)
 {
 	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
@@ -283,14 +320,14 @@ retpoline_auto:
 	 * from a shallow call stack to a deeper one. To prevent this fill
 	 * the entire RSB, even when using IBRS.
 	 *
-	 * Skylake era CPUs have a separate issue with *underflow* of the
-	 * RSB, when they will predict 'ret' targets from the generic BTB.
-	 * The proper mitigation for this is IBRS. If IBRS is not supported
-	 * or deactivated in favour of retpolines the RSB fill on context
+	 * Some CPUs have a separate issue with *underflow* of the RSB,
+	 * when they will predict 'ret' targets from the generic BTB.  The
+	 * proper mitigation for this is IBRS. If IBRS is not supported or
+	 * deactivated in favour of retpolines the RSB fill on context
 	 * switch is required.
 	 */
 	if ((!boot_cpu_has(X86_FEATURE_PTI) &&
-	     !boot_cpu_has(X86_FEATURE_SMEP)) || is_skylake_era()) {
+	     !boot_cpu_has(X86_FEATURE_SMEP)) || cpu_ret_uses_btb()) {
 		setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
 		pr_info("Spectre v2 mitigation: Filling RSB on context switch\n");
 	}
diff -puN arch/x86/include/asm/msr-index.h~need-rsb-stuffing arch/x86/include/asm/msr-index.h
--- a/arch/x86/include/asm/msr-index.h~need-rsb-stuffing	2018-02-16 10:10:25.738609636 -0800
+++ b/arch/x86/include/asm/msr-index.h	2018-02-16 10:12:22.880609344 -0800
@@ -68,6 +68,7 @@
 #define MSR_IA32_ARCH_CAPABILITIES	0x0000010a
 #define ARCH_CAP_RDCL_NO		(1 << 0)   /* Not susceptible to Meltdown */
 #define ARCH_CAP_IBRS_ALL		(1 << 1)   /* Enhanced IBRS support */
+#define ARCH_CAP_RSBO			(1 << 2)   /* Needs RSB Stuffing */
 
 #define MSR_IA32_BBL_CR_CTL		0x00000119
 #define MSR_IA32_BBL_CR_CTL3		0x0000011e
_
