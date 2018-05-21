Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq0ZfiRxDKlfdRl9CnOpgLzzfzAyrzKuV930Exrs0E2e91mS/OM/uGEcEDmmAcGVVY0Oxxl
ARC-Seal: i=1; a=rsa-sha256; t=1526937418; cv=none;
        d=google.com; s=arc-20160816;
        b=h3LZUIspIUOiNABfSSm2+qoL244X/Y1N/OWRAjy4DzQdVFDqFkKGK+MDpwNxcWW7oi
         XLgPkORrirq9iF/XVyANn/EGcTivIs0MhsqJi4HexySce8ApdjYpQS/TnThwBNmtflaz
         eZVA4JtHrQP0KS7v476RVy+eDCP61W3tgAr2+kO8t2wzk0AFRPWtVyTgOInyML9dyW5t
         aIHyc6M0Y+vYHS8jCYCQjU7FRytI93z1US3+cbvpWE3XTlwVWGsTFXXxYQAquN5BKRrc
         JEBE6Rr3laWWMWVRTCDGzql92iQySxvqUs4W/goTqwsWjVC/2FDTS11FiHlyLNiaRZLn
         cS+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=f4/ysB5Xh1WjgI4GIeYfGBhgRoX/f2hnT9+U9HBumD4=;
        b=tFVBdA/oLmXsAQ8mgaYZ6QRUbn6OK9EVeUwhr1PBBJYoY4NAn+ZpClYg2/ugtfQMBQ
         B67G5B6QHt9ql6/FKkwgtk/zwF7s5BY0pWYsAVr6yDjnZ6iHScSxeZmCLbJhjnWJyAHH
         qa0nvIM6cyyfsBkAnfPrUzucHucIAaLAISb/Xsu7fx2u3L2e84mjjGO2jCxZvYXvinUF
         9ckX44AzB81YFACErDyvVCyTJwJMPkTIFbrmLSdjTRjrfFUHZss2fVRTFCQY/vCpScBZ
         EpgbPBHtky3W6vDfwAOgp28fb0k+Gkd0lXjbLuP1CaD2avYsaxEYRoUwsbu3RU67RkFk
         wVjA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=08+Uq8JR;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=08+Uq8JR;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 74/87] x86/cpufeatures: Disentangle SSBD enumeration
Date: Mon, 21 May 2018 23:11:50 +0200
Message-Id: <20180521210426.465972454@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109930629084365?=
X-GMAIL-MSGID: =?utf-8?q?1601109930629084365?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/cpufeatures.h |    5 +++--
 arch/x86/kernel/cpu/amd.c          |    7 +------
 arch/x86/kernel/cpu/bugs.c         |   10 +++++-----
 arch/x86/kernel/cpu/common.c       |    3 +++
 arch/x86/kernel/cpu/intel.c        |    1 +
 arch/x86/kernel/process.c          |    2 +-
 6 files changed, 14 insertions(+), 14 deletions(-)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -198,6 +198,7 @@
 #define X86_FEATURE_RETPOLINE_AMD ( 7*32+13) /* "" AMD Retpoline mitigation for Spectre variant 2 */
 
 #define X86_FEATURE_MSR_SPEC_CTRL ( 7*32+16) /* "" MSR SPEC_CTRL is implemented */
+#define X86_FEATURE_SSBD	( 7*32+17) /* Speculative Store Bypass Disable */
 
 #define X86_FEATURE_RSB_CTXSW	( 7*32+19) /* "" Fill RSB on context switches */
 
@@ -207,7 +208,7 @@
 #define X86_FEATURE_USE_IBPB	( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled */
 #define X86_FEATURE_USE_IBRS_FW	( 7*32+22) /* "" Use IBRS during runtime firmware calls */
 #define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE ( 7*32+23) /* "" Disable Speculative Store Bypass. */
-#define X86_FEATURE_AMD_SSBD	( 7*32+24) /* "" AMD SSBD implementation */
+#define X86_FEATURE_LS_CFG_SSBD	( 7*32+24) /* "" AMD SSBD implementation */
 #define X86_FEATURE_IBRS	( 7*32+25) /* Indirect Branch Restricted Speculation */
 #define X86_FEATURE_IBPB	( 7*32+26) /* Indirect Branch Prediction Barrier */
 #define X86_FEATURE_STIBP	( 7*32+27) /* Single Thread Indirect Branch Predictors */
@@ -314,7 +315,7 @@
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_ARCH_CAPABILITIES	(18*32+29) /* IA32_ARCH_CAPABILITIES MSR (Intel) */
-#define X86_FEATURE_SSBD		(18*32+31) /* Speculative Store Bypass Disable */
+#define X86_FEATURE_SPEC_CTRL_SSBD	(18*32+31) /* "" Speculative Store Bypass Disable */
 
 /*
  * BUG word(s)
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -558,8 +558,8 @@ static void bsp_init_amd(struct cpuinfo_
 		 * avoid RMW. If that faults, do not enable SSBD.
 		 */
 		if (!rdmsrl_safe(MSR_AMD64_LS_CFG, &x86_amd_ls_cfg_base)) {
+			setup_force_cpu_cap(X86_FEATURE_LS_CFG_SSBD);
 			setup_force_cpu_cap(X86_FEATURE_SSBD);
-			setup_force_cpu_cap(X86_FEATURE_AMD_SSBD);
 			x86_amd_ls_cfg_ssbd_mask = 1ULL << bit;
 		}
 	}
@@ -848,11 +848,6 @@ static void init_amd(struct cpuinfo_x86
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
@@ -158,8 +158,8 @@ void x86_spec_ctrl_set_guest(u64 guest_s
 	if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
 		return;
 
-	/* Intel controls SSB in MSR_SPEC_CTRL */
-	if (static_cpu_has(X86_FEATURE_SPEC_CTRL))
+	/* SSBD controlled in MSR_SPEC_CTRL */
+	if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD))
 		host |= ssbd_tif_to_spec_ctrl(current_thread_info()->flags);
 
 	if (host != guest_spec_ctrl)
@@ -175,8 +175,8 @@ void x86_spec_ctrl_restore_host(u64 gues
 	if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
 		return;
 
-	/* Intel controls SSB in MSR_SPEC_CTRL */
-	if (static_cpu_has(X86_FEATURE_SPEC_CTRL))
+	/* SSBD controlled in MSR_SPEC_CTRL */
+	if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD))
 		host |= ssbd_tif_to_spec_ctrl(current_thread_info()->flags);
 
 	if (host != guest_spec_ctrl)
@@ -188,7 +188,7 @@ static void x86_amd_ssb_disable(void)
 {
 	u64 msrval = x86_amd_ls_cfg_base | x86_amd_ls_cfg_ssbd_mask;
 
-	if (boot_cpu_has(X86_FEATURE_AMD_SSBD))
+	if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD))
 		wrmsrl(MSR_AMD64_LS_CFG, msrval);
 }
 
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -735,6 +735,9 @@ static void init_speculation_control(str
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
@@ -156,6 +156,7 @@ static void early_init_intel(struct cpui
 		setup_clear_cpu_cap(X86_FEATURE_MSR_SPEC_CTRL);
 		setup_clear_cpu_cap(X86_FEATURE_INTEL_STIBP);
 		setup_clear_cpu_cap(X86_FEATURE_SSBD);
+		setup_clear_cpu_cap(X86_FEATURE_SPEC_CTRL_SSBD);
 	}
 
 	/*
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -207,7 +207,7 @@ static __always_inline void __speculativ
 {
 	u64 msr;
 
-	if (static_cpu_has(X86_FEATURE_AMD_SSBD)) {
+	if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD)) {
 		msr = x86_amd_ls_cfg_base | ssbd_tif_to_amd_ls_cfg(tifn);
 		wrmsrl(MSR_AMD64_LS_CFG, msr);
 	} else {
