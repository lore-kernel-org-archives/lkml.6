Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoR3wRDUlB7YAMnkw4DxHT4/nll2RtuZj+FoXbDKf8PlLl4CDT5et537PiwJsfo8QT5/iiQ
ARC-Seal: i=1; a=rsa-sha256; t=1526938024; cv=none;
        d=google.com; s=arc-20160816;
        b=zPeP2JXrqiL4Rxz5vMUL9LHp6kObzFNzX3LjkkJT99EceAAXfFpf2re9A2Ek8yzXc9
         1H4l+tyULWYooAvUlECh82QwxLA+plMg4t4u8MBnewoW9htBx9Ekh9aB2gMzyFgyxmhc
         ibfXBKmfS+Sly0qP8+4RtGjXzz3eqZBjQf0qJkGVu5zdfeyrIaONm9KzAClmTHOGBLUy
         V+ylD2Oskw4sUTLrrEJ52iu/CnpHxPqSMO5tG9U2Am9T7HQ89hBLutvp/8HRhSOwMd0j
         Bea6FsnUA/Pbl9rOEq/cASMHBOB+UqujgkYXvFIt6vM3KgR7zE10bc/wElKjkxHq4yUi
         WcMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=FtADI9RsjA2TFpUlxTGPes9BgfW+reTVrKmohV88Qtc=;
        b=LOX57Keb2xt+AjDEBjUlklSPnfmDlQQdpW54drljxO8tbYhHQqMTLVTLeHIZoSZChq
         sS1FCSTfC/obrcE8UZJ1UR9LQ0KlfwseM+F0TZQO3JnrbnhrBx0X6LS5CbqxdLoKPhj1
         CcLXiEn4t5qTrtDwEJZayMYL277l5E3IopGdF1ZUPTm7MesYCjWGce/7B9gC0U9J6MHU
         T0md5fmgIzs7gdmR9I2ahwXbvayK4xyQcL6FSASKTpOQdGQSel9k1cZbpNcKwx+bRxYy
         ADlBbBZyv/6l1MApz7Vq3OkAuqVNgSL7kRrzoF7/1HYMXmbAVPL0qLpPOX0yHJtZsOep
         Vcxg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=2GudnV59;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=2GudnV59;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>
Subject: [PATCH 4.16 101/110] x86/speculation: Add virtualized speculative store bypass disable support
Date: Mon, 21 May 2018 23:12:38 +0200
Message-Id: <20180521210514.610099742@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109944454534636?=
X-GMAIL-MSGID: =?utf-8?q?1601110566198394471?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/cpufeatures.h |    1 +
 arch/x86/include/asm/msr-index.h   |    2 ++
 arch/x86/kernel/cpu/bugs.c         |    4 +++-
 arch/x86/kernel/process.c          |   13 ++++++++++++-
 4 files changed, 18 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -282,6 +282,7 @@
 #define X86_FEATURE_AMD_IBPB		(13*32+12) /* "" Indirect Branch Prediction Barrier */
 #define X86_FEATURE_AMD_IBRS		(13*32+14) /* "" Indirect Branch Restricted Speculation */
 #define X86_FEATURE_AMD_STIBP		(13*32+15) /* "" Single Thread Indirect Branch Predictors */
+#define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
 #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -347,6 +347,8 @@
 #define MSR_AMD64_SEV_ENABLED_BIT	0
 #define MSR_AMD64_SEV_ENABLED		BIT_ULL(MSR_AMD64_SEV_ENABLED_BIT)
 
+#define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
+
 /* Fam 17h MSRs */
 #define MSR_F17H_IRPERF			0xc00000e9
 
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -205,7 +205,9 @@ static void x86_amd_ssb_disable(void)
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
@@ -388,6 +388,15 @@ static __always_inline void amd_set_core
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
@@ -397,7 +406,9 @@ static __always_inline void intel_set_ss
 
 static __always_inline void __speculative_store_bypass_update(unsigned long tifn)
 {
-	if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD))
+	if (static_cpu_has(X86_FEATURE_VIRT_SSBD))
+		amd_set_ssb_virt_state(tifn);
+	else if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD))
 		amd_set_core_ssb_state(tifn);
 	else
 		intel_set_ssb_state(tifn);
