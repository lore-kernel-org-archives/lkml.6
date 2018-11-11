Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E68C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7B820871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7B820871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbeKLFtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:49:33 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51298 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730810AbeKLFse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:34 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvst-0000oG-KS; Sun, 11 Nov 2018 19:59:03 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsV-0001fO-Au; Sun, 11 Nov 2018 19:58:39 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "KarimAllah Ahmed" <karahmed@amazon.de>,
        kvm@vger.kernel.org,
        "Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Janakarajan Natarajan" <Janakarajan.Natarajan@amd.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Joerg Roedel" <joro@8bytes.org>, "Borislav Petkov" <bp@suse.de>,
        "Kees Cook" <keescook@chromium.org>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "H. Peter Anvin" <hpa@zytor.com>, andrew.cooper3@citrix.com,
        "Andy Lutomirski" <luto@kernel.org>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.865445815@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 221/366] x86/bugs: Add AMD's SPEC_CTRL MSR usage
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 6ac2f49edb1ef5446089c7c660017732886d62d6 upstream.

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
[bwh: Backported to 3.16:
 - The feature bit is in feature word 11
 - Update feature test in guest_cpuid_has_spec_ctrl() instead of
   svm_{get,set}_msr()
 - Adjust filenames, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -256,6 +256,7 @@
 #define X86_FEATURE_AMD_IBPB		(11*32+12) /* "" Indirect Branch Prediction Barrier */
 #define X86_FEATURE_AMD_IBRS		(11*32+14) /* "" Indirect Branch Restricted Speculation */
 #define X86_FEATURE_AMD_STIBP		(11*32+15) /* "" Single Thread Indirect Branch Predictors */
+#define X86_FEATURE_AMD_SSBD		(11*32+24) /* "" Speculative Store Bypass Disable */
 #define X86_FEATURE_VIRT_SSBD		(11*32+25) /* Virtualized Speculative Store Bypass Disable */
 #define X86_FEATURE_AMD_SSB_NO		(11*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
 
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -570,18 +570,20 @@ static enum ssb_mitigation __init __ssb_
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
@@ -716,6 +716,12 @@ static void init_speculation_control(str
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
@@ -302,7 +302,8 @@ static inline int __do_cpuid_ent(struct
 
 	/* cpuid 0x80000008.ebx */
 	const u32 kvm_cpuid_8000_0008_ebx_x86_features =
-		F(AMD_IBPB) | F(AMD_IBRS) | F(VIRT_SSBD) | F(AMD_SSB_NO);
+		F(AMD_IBPB) | F(AMD_IBRS) | F(AMD_SSBD) | F(VIRT_SSBD) |
+		F(AMD_SSB_NO);
 
 	/* cpuid 0xC0000001.edx */
 	const u32 kvm_supported_word5_x86_features =
@@ -536,7 +537,12 @@ static inline int __do_cpuid_ent(struct
 			entry->ebx |= F(VIRT_SSBD);
 		entry->ebx &= kvm_cpuid_8000_0008_ebx_x86_features;
 		cpuid_mask(&entry->ebx, 11);
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
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -120,7 +120,7 @@ static inline bool guest_cpuid_has_spec_
 	struct kvm_cpuid_entry2 *best;
 
 	best = kvm_find_cpuid_entry(vcpu, 0x80000008, 0);
-	if (best && (best->ebx & bit(X86_FEATURE_AMD_IBRS)))
+	if (best && (best->ebx & (bit(X86_FEATURE_AMD_IBRS | bit(X86_FEATURE_AMD_SSBD)))))
 		return true;
 	best = kvm_find_cpuid_entry(vcpu, 7, 0);
 	return best && (best->edx & (bit(X86_FEATURE_SPEC_CTRL) | bit(X86_FEATURE_SPEC_CTRL_SSBD)));
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3236,7 +3236,7 @@ static int svm_set_msr(struct kvm_vcpu *
 			return 1;
 
 		/* The STIBP bit doesn't fault even if it's not advertised */
-		if (data & ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP))
+		if (data & ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP | SPEC_CTRL_SSBD))
 			return 1;
 
 		svm->spec_ctrl = data;

