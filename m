Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D944C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0032087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8Q2W7jP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB0032087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbeLDLFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:05:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:53204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728145AbeLDLF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:05:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54882214DB;
        Tue,  4 Dec 2018 11:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921526;
        bh=bULqB4Az77MCpTT1fuxkxVAQnbbiaQ0rtt46X8Q1xzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f8Q2W7jPOHFBHmTBj/ZVS+Xolji/AGI4i48Tw9i7egH5B+5bC+IAR3BsrYVD2ezWd
         3fyASvOH9PojP4kzbTErVigE95rylW9T9ytF2+XUgZ5Ag/hqtcd1oA/pQdbKM+ew7O
         4kyj93Wt8AOn6mTl5j8R3R69usUxzsqtRiFv2uNY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        kvm@vger.kernel.org, KarimAllah Ahmed <karahmed@amazon.de>,
        andrew.cooper3@citrix.com, Joerg Roedel <joro@8bytes.org>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 4.14 070/146] x86/bugs: Add AMDs SPEC_CTRL MSR usage
Date:   Tue,  4 Dec 2018 11:49:16 +0100
Message-Id: <20181204103729.655226778@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk konrad.wilk@oracle.com

commit 6ac2f49edb1ef5446089c7c660017732886d62d6 upstream

The AMD document outlining the SSBD handling
124441_AMD64_SpeculativeStoreBypassDisable_Whitepaper_final.pdf
mentions that if CPUID 8000_0008.EBX[24] is set we should be using
the SPEC_CTRL MSR (0x48) over the VIRT SPEC_CTRL MSR (0xC001_011f)
for speculative store bypass disable.

This in effect means we should clear the X86_FEATURE_VIRT_SSBD
flag so that we would prefer the SPEC_CTRL MSR.

See the document titled:
   124441_AMD64_SpeculativeStoreBypassDisable_Whitepaper_final.pdf

A copy of this document is available at
   https://bugzilla.kernel.org/show_bug.cgi?id=199889

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Cc: kvm@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Cc: andrew.cooper3@citrix.com
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20180601145921.9500-3-konrad.wilk@oracle.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/cpufeatures.h |    1 +
 arch/x86/kernel/cpu/bugs.c         |   12 +++++++-----
 arch/x86/kernel/cpu/common.c       |    6 ++++++
 arch/x86/kvm/cpuid.c               |   10 ++++++++--
 arch/x86/kvm/svm.c                 |    8 +++++---
 5 files changed, 27 insertions(+), 10 deletions(-)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -284,6 +284,7 @@
 #define X86_FEATURE_AMD_IBPB		(13*32+12) /* "" Indirect Branch Prediction Barrier */
 #define X86_FEATURE_AMD_IBRS		(13*32+14) /* "" Indirect Branch Restricted Speculation */
 #define X86_FEATURE_AMD_STIBP		(13*32+15) /* "" Single Thread Indirect Branch Predictors */
+#define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
 
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -532,18 +532,20 @@ static enum ssb_mitigation __init __ssb_
 	if (mode == SPEC_STORE_BYPASS_DISABLE) {
 		setup_force_cpu_cap(X86_FEATURE_SPEC_STORE_BYPASS_DISABLE);
 		/*
-		 * Intel uses the SPEC CTRL MSR Bit(2) for this, while AMD uses
-		 * a completely different MSR and bit dependent on family.
+		 * Intel uses the SPEC CTRL MSR Bit(2) for this, while AMD may
+		 * use a completely different MSR and bit dependent on family.
 		 */
 		switch (boot_cpu_data.x86_vendor) {
 		case X86_VENDOR_INTEL:
+		case X86_VENDOR_AMD:
+			if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL)) {
+				x86_amd_ssb_disable();
+				break;
+			}
 			x86_spec_ctrl_base |= SPEC_CTRL_SSBD;
 			x86_spec_ctrl_mask |= SPEC_CTRL_SSBD;
 			wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
 			break;
-		case X86_VENDOR_AMD:
-			x86_amd_ssb_disable();
-			break;
 		}
 	}
 
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -760,6 +760,12 @@ static void init_speculation_control(str
 		set_cpu_cap(c, X86_FEATURE_STIBP);
 		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
 	}
+
+	if (cpu_has(c, X86_FEATURE_AMD_SSBD)) {
+		set_cpu_cap(c, X86_FEATURE_SSBD);
+		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
+		clear_cpu_cap(c, X86_FEATURE_VIRT_SSBD);
+	}
 }
 
 void get_cpu_cap(struct cpuinfo_x86 *c)
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -367,7 +367,8 @@ static inline int __do_cpuid_ent(struct
 
 	/* cpuid 0x80000008.ebx */
 	const u32 kvm_cpuid_8000_0008_ebx_x86_features =
-		F(AMD_IBPB) | F(AMD_IBRS) | F(VIRT_SSBD) | F(AMD_SSB_NO);
+		F(AMD_IBPB) | F(AMD_IBRS) | F(AMD_SSBD) | F(VIRT_SSBD) |
+		F(AMD_SSB_NO);
 
 	/* cpuid 0xC0000001.edx */
 	const u32 kvm_cpuid_C000_0001_edx_x86_features =
@@ -649,7 +650,12 @@ static inline int __do_cpuid_ent(struct
 			entry->ebx |= F(VIRT_SSBD);
 		entry->ebx &= kvm_cpuid_8000_0008_ebx_x86_features;
 		cpuid_mask(&entry->ebx, CPUID_8000_0008_EBX);
-		if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD))
+		/*
+		 * The preference is to use SPEC CTRL MSR instead of the
+		 * VIRT_SPEC MSR.
+		 */
+		if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) &&
+		    !boot_cpu_has(X86_FEATURE_AMD_SSBD))
 			entry->ebx |= F(VIRT_SSBD);
 		break;
 	}
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3644,7 +3644,8 @@ static int svm_get_msr(struct kvm_vcpu *
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
-		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS))
+		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS) &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_SSBD))
 			return 1;
 
 		msr_info->data = svm->spec_ctrl;
@@ -3749,11 +3750,12 @@ static int svm_set_msr(struct kvm_vcpu *
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr->host_initiated &&
-		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS))
+		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS) &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_SSBD))
 			return 1;
 
 		/* The STIBP bit doesn't fault even if it's not advertised */
-		if (data & ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP))
+		if (data & ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP | SPEC_CTRL_SSBD))
 			return 1;
 
 		svm->spec_ctrl = data;


