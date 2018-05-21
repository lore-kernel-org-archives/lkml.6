Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpICSF2+xxaDITtIqIk525nPjN/9I0W+B4hhrx5WwrlxLIXotm8SvJN7L8BHclOdwc44ROm
ARC-Seal: i=1; a=rsa-sha256; t=1526937694; cv=none;
        d=google.com; s=arc-20160816;
        b=WrgbEgtRBChG6DXLUkpDnnxwTrYiJRZ6H/OWP8yjPFmmBT93OIbpwfMX74Is9N0uKx
         60qtmKwTF+NlU7mZytEQNjj7NeGohQtJZI49HDNub3+2m1lTHs8ZNcUTs4g+hbQt9nAO
         +JtWg/4iTBYKVGZ7m5glIKhz0JeTkyD8FUFR3juGq2oaYilf7KeLBggdQS7AFF6Z3kD1
         hzl5FZg3XGMW5+NP7VQNieCpoY1+1d6VA3hTOeZxokMC6+jtiHYfoiTQhY5I00JQsRyv
         iWGsLEw9K6/V3mNbLjWzbSQHc7p9d8hE7hBKQLIfk5cwOirxfkApFemDmVtBOiQTsjA5
         0HPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=8p5aoNEJv+15jfR2ompBI/ySZWfUZoi0PJ4skXYG1xE=;
        b=db3YYj+VZ3gKFTsvns37OCRensCMZs00JnnxJaYFPnvxvwB3B/dIGB6SFaKyZJ1ssr
         HKC8OwPkTdqK9HZZyp3pLFvliONazMM/WNgXPN+2ijOWi0qvWWRPYeGSzcAWGpdRIGaX
         cL1hNSV50cE0RqzfyDedLXVoscfRnxu4UqO0N3Z/p5UjjsaqqoAzKalrjLy4TuOZKCkk
         cKFXxLfd7OoB6gTarp7pKHrHAodRsjOHcpwr9DvShSp3W+CObhYLPkS9OtsFykIA1Z1z
         AFxz9tY8Ws9QnkbXzgBsB1vrxacWlAfvL647OK3N0ZdCfjzywmn7PeOltVqpvTiLcvuw
         4qow==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Nd+KbGI6;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Nd+KbGI6;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>
Subject: [PATCH 4.14 87/95] x86/speculation: Add virtualized speculative store bypass disable support
Date: Mon, 21 May 2018 23:12:17 +0200
Message-Id: <20180521210502.839608259@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109944454534636?=
X-GMAIL-MSGID: =?utf-8?q?1601110219660633116?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -344,6 +344,8 @@
 #define MSR_AMD64_IBSOPDATA4		0xc001103d
 #define MSR_AMD64_IBS_REG_COUNT_MAX	8 /* includes MSR_AMD64_IBSBRTARGET */
 
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
@@ -389,6 +389,15 @@ static __always_inline void amd_set_core
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
@@ -398,7 +407,9 @@ static __always_inline void intel_set_ss
 
 static __always_inline void __speculative_store_bypass_update(unsigned long tifn)
 {
-	if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD))
+	if (static_cpu_has(X86_FEATURE_VIRT_SSBD))
+		amd_set_ssb_virt_state(tifn);
+	else if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD))
 		amd_set_core_ssb_state(tifn);
 	else
 		intel_set_ssb_state(tifn);
