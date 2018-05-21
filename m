Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpjFJak0tJh+wJeLTtkMtSkiDnatsYBrWQ6v1l6O283fLaeQpZVE+iUFGGYbFco9iHjWFUH
ARC-Seal: i=1; a=rsa-sha256; t=1526937431; cv=none;
        d=google.com; s=arc-20160816;
        b=qm2v8cqBYIQUrlCcKOa9EjzKeZXUsI69VU2XkmoLIlmmR91lSUzVRfH4xTgdGApVjO
         nJy1YPqJGGBERf023WnEdH2Pfj0SrtqwYHzNI7ZmKwVRMJPR/1CRuX0ZptSSCC++JQb8
         oHeqD4ZaghA4DOPCh91l9OV7xIDBP6Zr4Jfnl/BFoeHYJ98sxMKHof4gHGjDJ7YaJlEQ
         1HS30VqIKBKTRcI6P2o0dxVK8ytUIgEW0DzkKZgFGl4YZCZ2yvaLBbK57pmAkJk+mfg/
         ADJP9kvV9cLMdqPMVDOFwDkjRxF66qERcr3yQToanIA7x3dCtAAJTxZsDNsCRbFt8WdF
         BwIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=YNYO39Qp3uXtTAwltUMMys3teheN92uOAbqsVzYwU4I=;
        b=Cij3fSG0+p0W5ubpxWtxQh1SQtPY6Fa7BEESp+eVyLIfyLyVmU5ISj9ZV7bJdY4mjL
         lK/fjTBrUMB5NrLmqqwvjyT6dcqTvcSNId0frL+Uc92V75rlf0Jm+WeYRSlP88Xfv6/f
         C7pw3sFwFhqGFGaWvp8rpYGNKBwbnBEL4GYZ2D73/5RZk9wHM0bVTNrw8joqLjgqXpEK
         jVYvzijlDU7lk/okcgt+5KBaSINNPK3HPg/SWZUyvv1VdvtHirvmN57sffFC1E50mzHW
         GhzDziEV90JTejccmRRBevWCOqsOq3wwg6L5MSxYAnrvgjhJL5cC+qEZUee57qZ4DhPG
         mcZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=E8k/+/cn;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=E8k/+/cn;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 79/87] x86/speculation: Add virtualized speculative store bypass disable support
Date: Mon, 21 May 2018 23:11:55 +0200
Message-Id: <20180521210426.823679099@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109944454534636?=
X-GMAIL-MSGID: =?utf-8?q?1601109944454534636?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Lendacky <thomas.lendacky@amd.com>

commit 11fb0683493b2da112cd64c9dada221b52463bf7 upstream

Some AMD processors only support a non-architectural means of enabling
speculative store bypass disable (SSBD).  To allow a simplified view of
this to a guest, an architectural definition has been created through a new
CPUID bit, 0x80000008_EBX[25], and a new MSR, 0xc001011f.  With this, a
hypervisor can virtualize the existence of this definition and provide an
architectural method for using SSBD to a guest.

Add the new CPUID feature, the new MSR and update the existing SSBD
support to use this MSR when present.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/cpufeatures.h |    1 +
 arch/x86/include/asm/msr-index.h   |    2 ++
 arch/x86/kernel/cpu/bugs.c         |    4 +++-
 arch/x86/kernel/process.c          |   13 ++++++++++++-
 4 files changed, 18 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -274,6 +274,7 @@
 #define X86_FEATURE_AMD_IBPB	(13*32+12) /* Indirect Branch Prediction Barrier */
 #define X86_FEATURE_AMD_IBRS	(13*32+14) /* Indirect Branch Restricted Speculation */
 #define X86_FEATURE_AMD_STIBP	(13*32+15) /* Single Thread Indirect Branch Predictors */
+#define X86_FEATURE_VIRT_SSBD	(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (eax), word 14 */
 #define X86_FEATURE_DTHERM	(14*32+ 0) /* Digital Thermal Sensor */
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -323,6 +323,8 @@
 #define MSR_AMD64_IBSOPDATA4		0xc001103d
 #define MSR_AMD64_IBS_REG_COUNT_MAX	8 /* includes MSR_AMD64_IBSBRTARGET */
 
+#define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
+
 /* Fam 17h MSRs */
 #define MSR_F17H_IRPERF			0xc00000e9
 
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -204,7 +204,9 @@ static void x86_amd_ssb_disable(void)
 {
 	u64 msrval = x86_amd_ls_cfg_base | x86_amd_ls_cfg_ssbd_mask;
 
-	if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD))
+	if (boot_cpu_has(X86_FEATURE_VIRT_SSBD))
+		wrmsrl(MSR_AMD64_VIRT_SPEC_CTRL, SPEC_CTRL_SSBD);
+	else if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD))
 		wrmsrl(MSR_AMD64_LS_CFG, msrval);
 }
 
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -312,6 +312,15 @@ static __always_inline void amd_set_core
 }
 #endif
 
+static __always_inline void amd_set_ssb_virt_state(unsigned long tifn)
+{
+	/*
+	 * SSBD has the same definition in SPEC_CTRL and VIRT_SPEC_CTRL,
+	 * so ssbd_tif_to_spec_ctrl() just works.
+	 */
+	wrmsrl(MSR_AMD64_VIRT_SPEC_CTRL, ssbd_tif_to_spec_ctrl(tifn));
+}
+
 static __always_inline void intel_set_ssb_state(unsigned long tifn)
 {
 	u64 msr = x86_spec_ctrl_base | ssbd_tif_to_spec_ctrl(tifn);
@@ -321,7 +330,9 @@ static __always_inline void intel_set_ss
 
 static __always_inline void __speculative_store_bypass_update(unsigned long tifn)
 {
-	if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD))
+	if (static_cpu_has(X86_FEATURE_VIRT_SSBD))
+		amd_set_ssb_virt_state(tifn);
+	else if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD))
 		amd_set_core_ssb_state(tifn);
 	else
 		intel_set_ssb_state(tifn);
