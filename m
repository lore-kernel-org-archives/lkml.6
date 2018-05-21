Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo40L52dv8cYWWHEq4N/Dj2avAuj5HiaURD2SntVAK/lpWusRdaTdHn0KFHsMU1HKSJgMQk
ARC-Seal: i=1; a=rsa-sha256; t=1526937415; cv=none;
        d=google.com; s=arc-20160816;
        b=tzP4DsVKuUqGWKxLn2ph8TAGnDLsdXG9550/LCs0nRhTrrCTterBCYTwv1M+Y9d2gs
         eMyD3+dq+Qr45vvFhf8fpKi1Sezb7zakNZe6K46BTNi2IxnrZzwAP/oicwnf4WrSe9lw
         hjxofhUH8ZtgMpTwnA2Ieu8vD0THyEtteblYHaPVbwscyLy+DmM7XwNGwEMqpY5f2Kbz
         gHwM9jjwZTdJDRdDFlasL+fUXXuUqJH/1MrFMq/yS3IBGEHl0xBRTXWaY/9nUgdAqmtI
         C8hNNfZ/SxFogw7JzGjf8YcONXi+FmzNjQPk/zeUJZbhgU7Fzv7ZqLZgLsXSgDKk403Z
         Nz9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=xGRFKICbWn/mU8MgIPRo2AxTwTVH2FTLTkgoB3pB++I=;
        b=jz+CMxeznF1TXO0SznWe0SdO9y31eHRIj+fRLwP5NMR9muAB29q8hpApqLJwu7pVLL
         oboggR1lCa/b1JbLoGc5rlbooSwGxUoyH7smz0sSght1vJZEpKYc249+/iGC6bxONDeA
         dAowbiBvI+q9mzxBQWqGqjI2bdj3Mte53OzK4fv/pQttgBVj1qnIvpWaOrFQ/UOC4dey
         jbKAUSXphhhoz0AmRwLwCcq4T8beuoQyNVzwjjNruxuntJSa2uIlchYCBHcwGUeUWR+/
         fywFp/e7ZUsMNjGr5xUmGsLUBbaNd+dcOtTbOb9yAXkmbIhe+V+dF8XAKIrLD34V5e9u
         byKA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=tV7aqG0L;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=tV7aqG0L;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 73/87] x86/cpufeatures: Disentangle MSR_SPEC_CTRL enumeration from IBRS
Date: Mon, 21 May 2018 23:11:49 +0200
Message-Id: <20180521210426.391468460@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109927546153517?=
X-GMAIL-MSGID: =?utf-8?q?1601109927546153517?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 7eb8956a7fec3c1f0abc2a5517dada99ccc8a961 upstream

The availability of the SPEC_CTRL MSR is enumerated by a CPUID bit on
Intel and implied by IBRS or STIBP support on AMD. That's just confusing
and in case an AMD CPU has IBRS not supported because the underlying
problem has been fixed but has another bit valid in the SPEC_CTRL MSR,
the thing falls apart.

Add a synthetic feature bit X86_FEATURE_MSR_SPEC_CTRL to denote the
availability on both Intel and AMD.

While at it replace the boot_cpu_has() checks with static_cpu_has() where
possible. This prevents late microcode loading from exposing SPEC_CTRL, but
late loading is already very limited as it does not reevaluate the
mitigation options and other bits and pieces. Having static_cpu_has() is
the simplest and least fragile solution.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/cpufeatures.h |    2 ++
 arch/x86/kernel/cpu/bugs.c         |   18 +++++++++++-------
 arch/x86/kernel/cpu/common.c       |    9 +++++++--
 arch/x86/kernel/cpu/intel.c        |    1 +
 4 files changed, 21 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -197,6 +197,8 @@
 #define X86_FEATURE_RETPOLINE	( 7*32+12) /* "" Generic Retpoline mitigation for Spectre variant 2 */
 #define X86_FEATURE_RETPOLINE_AMD ( 7*32+13) /* "" AMD Retpoline mitigation for Spectre variant 2 */
 
+#define X86_FEATURE_MSR_SPEC_CTRL ( 7*32+16) /* "" MSR SPEC_CTRL is implemented */
+
 #define X86_FEATURE_RSB_CTXSW	( 7*32+19) /* "" Fill RSB on context switches */
 
 /* Because the ALTERNATIVE scheme is for members of the X86_FEATURE club... */
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -63,7 +63,7 @@ void __init check_bugs(void)
 	 * have unknown values. AMD64_LS_CFG MSR is cached in the early AMD
 	 * init code as it is not enumerated and depends on the family.
 	 */
-	if (boot_cpu_has(X86_FEATURE_IBRS))
+	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
 		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
 
 	/* Select the proper spectre mitigation before patching alternatives */
@@ -144,7 +144,7 @@ u64 x86_spec_ctrl_get_default(void)
 {
 	u64 msrval = x86_spec_ctrl_base;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+	if (static_cpu_has(X86_FEATURE_SPEC_CTRL))
 		msrval |= ssbd_tif_to_spec_ctrl(current_thread_info()->flags);
 	return msrval;
 }
@@ -154,10 +154,12 @@ void x86_spec_ctrl_set_guest(u64 guest_s
 {
 	u64 host = x86_spec_ctrl_base;
 
-	if (!boot_cpu_has(X86_FEATURE_IBRS))
+	/* Is MSR_SPEC_CTRL implemented ? */
+	if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
 		return;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+	/* Intel controls SSB in MSR_SPEC_CTRL */
+	if (static_cpu_has(X86_FEATURE_SPEC_CTRL))
 		host |= ssbd_tif_to_spec_ctrl(current_thread_info()->flags);
 
 	if (host != guest_spec_ctrl)
@@ -169,10 +171,12 @@ void x86_spec_ctrl_restore_host(u64 gues
 {
 	u64 host = x86_spec_ctrl_base;
 
-	if (!boot_cpu_has(X86_FEATURE_IBRS))
+	/* Is MSR_SPEC_CTRL implemented ? */
+	if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
 		return;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+	/* Intel controls SSB in MSR_SPEC_CTRL */
+	if (static_cpu_has(X86_FEATURE_SPEC_CTRL))
 		host |= ssbd_tif_to_spec_ctrl(current_thread_info()->flags);
 
 	if (host != guest_spec_ctrl)
@@ -630,7 +634,7 @@ int arch_prctl_spec_ctrl_get(struct task
 
 void x86_spec_ctrl_setup_ap(void)
 {
-	if (boot_cpu_has(X86_FEATURE_IBRS))
+	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
 		x86_spec_ctrl_set(x86_spec_ctrl_base & ~x86_spec_ctrl_mask);
 
 	if (ssb_mode == SPEC_STORE_BYPASS_DISABLE)
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -729,19 +729,24 @@ static void init_speculation_control(str
 	if (cpu_has(c, X86_FEATURE_SPEC_CTRL)) {
 		set_cpu_cap(c, X86_FEATURE_IBRS);
 		set_cpu_cap(c, X86_FEATURE_IBPB);
+		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
 	}
 
 	if (cpu_has(c, X86_FEATURE_INTEL_STIBP))
 		set_cpu_cap(c, X86_FEATURE_STIBP);
 
-	if (cpu_has(c, X86_FEATURE_AMD_IBRS))
+	if (cpu_has(c, X86_FEATURE_AMD_IBRS)) {
 		set_cpu_cap(c, X86_FEATURE_IBRS);
+		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
+	}
 
 	if (cpu_has(c, X86_FEATURE_AMD_IBPB))
 		set_cpu_cap(c, X86_FEATURE_IBPB);
 
-	if (cpu_has(c, X86_FEATURE_AMD_STIBP))
+	if (cpu_has(c, X86_FEATURE_AMD_STIBP)) {
 		set_cpu_cap(c, X86_FEATURE_STIBP);
+		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
+	}
 }
 
 void get_cpu_cap(struct cpuinfo_x86 *c)
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -153,6 +153,7 @@ static void early_init_intel(struct cpui
 		setup_clear_cpu_cap(X86_FEATURE_IBPB);
 		setup_clear_cpu_cap(X86_FEATURE_STIBP);
 		setup_clear_cpu_cap(X86_FEATURE_SPEC_CTRL);
+		setup_clear_cpu_cap(X86_FEATURE_MSR_SPEC_CTRL);
 		setup_clear_cpu_cap(X86_FEATURE_INTEL_STIBP);
 		setup_clear_cpu_cap(X86_FEATURE_SSBD);
 	}
