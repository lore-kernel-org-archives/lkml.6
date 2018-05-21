Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZro9EnssLQqKjRY5e1S75ke8Fy9/vfSrF8XyJVITXNaPmCXnTR+OdBgOjqJJ0s8k/zd3iJB
ARC-Seal: i=1; a=rsa-sha256; t=1526937681; cv=none;
        d=google.com; s=arc-20160816;
        b=LEB4SP8JEx/jwKL6Ve0xw4URUXJiLkZR8FOU+zVTCELLCupNT6CFvDQkLpZz7xszQM
         I8AtgBnJNhSIChb1woUAn1OLJv3dQiiDG/4p7OKyV5HNJZWUYqRURHCzIVMUzm57uWNq
         ZMoNio802l3DVrY2ivzheCN1MPUd1KMaFFjK6zm6h1hjqp+lOo2OGXvT5oP87XpJuapk
         0ReLZ+C/I5NxzJrs7PBZf66MdUkcMtn/PY7lO4QkoWjDcleQsZMaf+M87mhh6E66pue0
         d/H1oJ/i4Or3HRiboxZJJe6XSyjeNfGg/uq8dD93uRtHgm6W79rW5er/wKYlaxmWD2TW
         d4OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=VhcbFopAw36oczaPnH2aWACBW8dZT9KCkoixhpaKbB0=;
        b=QNfllpLbuRhLWJMWLOEi1jlg8V1vpFkrdBidMk6+BzhwEJavbbxaOLyJ6PHedr9k5q
         jgqK+DJ3wUsJUZ1DslL1kWrhMYMBN4NvhtJJR1kbWaLVDbWNJMllmN/RtFtSIloKHnHf
         XcMPl72r6swKHzesRBMK8/FCdrO+cl1doPuqD+yeMgfDgcFyw7tBnKKPpKMinLCYMDqC
         tyCftSrME2YcNkEycZLfgZHMBbfOl1Rz+fvZNVHiUytHt/k9bE6IR7Ppi5VVFgvOkxYR
         0YcK2x5OuVjw7X0o/ZB2Np2ZlciX26pYxFxZaSe0S8UUAiOKg8rRzVujiyzynKGovbIX
         mqpg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=O73IiFXS;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=O73IiFXS;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 4.14 83/95] x86/cpufeatures: Disentangle SSBD enumeration
Date: Mon, 21 May 2018 23:12:13 +0200
Message-Id: <20180521210502.419381317@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109930629084365?=
X-GMAIL-MSGID: =?utf-8?q?1601110205991106733?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 52817587e706686fcdb27f14c1b000c92f266c96 upstream

The SSBD enumeration is similarly to the other bits magically shared
between Intel and AMD though the mechanisms are different.

Make X86_FEATURE_SSBD synthetic and set it depending on the vendor specific
features or family dependent setup.

Change the Intel bit to X86_FEATURE_SPEC_CTRL_SSBD to denote that SSBD is
controlled via MSR_SPEC_CTRL and fix up the usage sites.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/cpufeatures.h |    6 +++---
 arch/x86/kernel/cpu/amd.c          |    7 +------
 arch/x86/kernel/cpu/bugs.c         |   10 +++++-----
 arch/x86/kernel/cpu/common.c       |    3 +++
 arch/x86/kernel/cpu/intel.c        |    1 +
 arch/x86/kernel/process.c          |    2 +-
 6 files changed, 14 insertions(+), 15 deletions(-)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -207,14 +207,14 @@
 #define X86_FEATURE_INTEL_PPIN		( 7*32+14) /* Intel Processor Inventory Number */
 
 #define X86_FEATURE_MSR_SPEC_CTRL	( 7*32+16) /* "" MSR SPEC_CTRL is implemented */
-
+#define X86_FEATURE_SSBD		( 7*32+17) /* Speculative Store Bypass Disable */
 #define X86_FEATURE_MBA			( 7*32+18) /* Memory Bandwidth Allocation */
 #define X86_FEATURE_RSB_CTXSW		( 7*32+19) /* "" Fill RSB on context switches */
 
 #define X86_FEATURE_USE_IBPB		( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled */
 #define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* "" Use IBRS during runtime firmware calls */
 #define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /* "" Disable Speculative Store Bypass. */
-#define X86_FEATURE_AMD_SSBD		( 7*32+24)  /* "" AMD SSBD implementation */
+#define X86_FEATURE_LS_CFG_SSBD		( 7*32+24)  /* "" AMD SSBD implementation via LS_CFG MSR */
 #define X86_FEATURE_IBRS		( 7*32+25) /* Indirect Branch Restricted Speculation */
 #define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch Prediction Barrier */
 #define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch Predictors */
@@ -337,7 +337,7 @@
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_ARCH_CAPABILITIES	(18*32+29) /* IA32_ARCH_CAPABILITIES MSR (Intel) */
-#define X86_FEATURE_SSBD		(18*32+31) /* Speculative Store Bypass Disable */
+#define X86_FEATURE_SPEC_CTRL_SSBD	(18*32+31) /* "" Speculative Store Bypass Disable */
 
 /*
  * BUG word(s)
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -570,8 +570,8 @@ static void bsp_init_amd(struct cpuinfo_
 		 * avoid RMW. If that faults, do not enable SSBD.
 		 */
 		if (!rdmsrl_safe(MSR_AMD64_LS_CFG, &x86_amd_ls_cfg_base)) {
+			setup_force_cpu_cap(X86_FEATURE_LS_CFG_SSBD);
 			setup_force_cpu_cap(X86_FEATURE_SSBD);
-			setup_force_cpu_cap(X86_FEATURE_AMD_SSBD);
 			x86_amd_ls_cfg_ssbd_mask = 1ULL << bit;
 		}
 	}
@@ -893,11 +893,6 @@ static void init_amd(struct cpuinfo_x86
 	/* AMD CPUs don't reset SS attributes on SYSRET, Xen does. */
 	if (!cpu_has(c, X86_FEATURE_XENPV))
 		set_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
-
-	if (boot_cpu_has(X86_FEATURE_AMD_SSBD)) {
-		set_cpu_cap(c, X86_FEATURE_SSBD);
-		set_cpu_cap(c, X86_FEATURE_AMD_SSBD);
-	}
 }
 
 #ifdef CONFIG_X86_32
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -159,8 +159,8 @@ void x86_spec_ctrl_set_guest(u64 guest_s
 	if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
 		return;
 
-	/* Intel controls SSB in MSR_SPEC_CTRL */
-	if (static_cpu_has(X86_FEATURE_SPEC_CTRL))
+	/* SSBD controlled in MSR_SPEC_CTRL */
+	if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD))
 		host |= ssbd_tif_to_spec_ctrl(current_thread_info()->flags);
 
 	if (host != guest_spec_ctrl)
@@ -176,8 +176,8 @@ void x86_spec_ctrl_restore_host(u64 gues
 	if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
 		return;
 
-	/* Intel controls SSB in MSR_SPEC_CTRL */
-	if (static_cpu_has(X86_FEATURE_SPEC_CTRL))
+	/* SSBD controlled in MSR_SPEC_CTRL */
+	if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD))
 		host |= ssbd_tif_to_spec_ctrl(current_thread_info()->flags);
 
 	if (host != guest_spec_ctrl)
@@ -189,7 +189,7 @@ static void x86_amd_ssb_disable(void)
 {
 	u64 msrval = x86_amd_ls_cfg_base | x86_amd_ls_cfg_ssbd_mask;
 
-	if (boot_cpu_has(X86_FEATURE_AMD_SSBD))
+	if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD))
 		wrmsrl(MSR_AMD64_LS_CFG, msrval);
 }
 
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -743,6 +743,9 @@ static void init_speculation_control(str
 	if (cpu_has(c, X86_FEATURE_INTEL_STIBP))
 		set_cpu_cap(c, X86_FEATURE_STIBP);
 
+	if (cpu_has(c, X86_FEATURE_SPEC_CTRL_SSBD))
+		set_cpu_cap(c, X86_FEATURE_SSBD);
+
 	if (cpu_has(c, X86_FEATURE_AMD_IBRS)) {
 		set_cpu_cap(c, X86_FEATURE_IBRS);
 		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -191,6 +191,7 @@ static void early_init_intel(struct cpui
 		setup_clear_cpu_cap(X86_FEATURE_MSR_SPEC_CTRL);
 		setup_clear_cpu_cap(X86_FEATURE_INTEL_STIBP);
 		setup_clear_cpu_cap(X86_FEATURE_SSBD);
+		setup_clear_cpu_cap(X86_FEATURE_SPEC_CTRL_SSBD);
 	}
 
 	/*
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -284,7 +284,7 @@ static __always_inline void __speculativ
 {
 	u64 msr;
 
-	if (static_cpu_has(X86_FEATURE_AMD_SSBD)) {
+	if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD)) {
 		msr = x86_amd_ls_cfg_base | ssbd_tif_to_amd_ls_cfg(tifn);
 		wrmsrl(MSR_AMD64_LS_CFG, msr);
 	} else {
