Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE43C64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3237E206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3237E206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbeI3Eb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:31:27 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51539 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726537AbeI3ESU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:20 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N60-0000H4-L2; Sat, 29 Sep 2018 22:48:16 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5v-0006pn-FC; Sat, 29 Sep 2018 22:48:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.28498401@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 012/131] x86/KVM/VMX: Expose SPEC_CTRL Bit(2) to the
 guest
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit da39556f66f5cfe8f9c989206974f1cb16ca5d7c upstream.

Expose the CPUID.7.EDX[31] bit to the guest, and also guard against various
combinations of SPEC_CTRL MSR values.

The handling of the MSR (to take into account the host value of SPEC_CTRL
Bit(2)) is taken care of in patch:

  KVM/SVM/VMX/x86/spectre_v2: Support the combination of guest and host IBRS

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>

[dwmw2: Handle 4.9 guest CPUID differences, rename
        guest_cpu_has_ibrs() → guest_cpu_has_spec_ctrl()]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/cpuid.c | 2 +-
 arch/x86/kvm/cpuid.h | 4 ++--
 arch/x86/kvm/svm.c   | 4 ++--
 arch/x86/kvm/vmx.c   | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -318,7 +318,7 @@ static inline int __do_cpuid_ent(struct
 
 	/* cpuid 7.0.edx*/
 	const u32 kvm_cpuid_7_0_edx_x86_features =
-		F(SPEC_CTRL) | F(ARCH_CAPABILITIES);
+		F(SPEC_CTRL) | F(RDS) | F(ARCH_CAPABILITIES);
 
 	/* all calls to cpuid_count() should be made on the same cpu */
 	get_cpu();
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -115,7 +115,7 @@ static inline bool guest_cpuid_has_ibpb(
 	return best && (best->edx & bit(X86_FEATURE_SPEC_CTRL));
 }
 
-static inline bool guest_cpuid_has_ibrs(struct kvm_vcpu *vcpu)
+static inline bool guest_cpuid_has_spec_ctrl(struct kvm_vcpu *vcpu)
 {
 	struct kvm_cpuid_entry2 *best;
 
@@ -123,7 +123,7 @@ static inline bool guest_cpuid_has_ibrs(
 	if (best && (best->ebx & bit(X86_FEATURE_IBRS)))
 		return true;
 	best = kvm_find_cpuid_entry(vcpu, 7, 0);
-	return best && (best->edx & bit(X86_FEATURE_SPEC_CTRL));
+	return best && (best->edx & (bit(X86_FEATURE_SPEC_CTRL) | bit(X86_FEATURE_RDS)));
 }
 
 static inline bool guest_cpuid_has_arch_capabilities(struct kvm_vcpu *vcpu)
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3139,7 +3139,7 @@ static int svm_get_msr(struct kvm_vcpu *
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
-		    !guest_cpuid_has_ibrs(vcpu))
+		    !guest_cpuid_has_spec_ctrl(vcpu))
 			return 1;
 
 		msr_info->data = svm->spec_ctrl;
@@ -3218,7 +3218,7 @@ static int svm_set_msr(struct kvm_vcpu *
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr->host_initiated &&
-		    !guest_cpuid_has_ibrs(vcpu))
+		    !guest_cpuid_has_spec_ctrl(vcpu))
 			return 1;
 
 		/* The STIBP bit doesn't fault even if it's not advertised */
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2528,7 +2528,7 @@ static int vmx_get_msr(struct kvm_vcpu *
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
-		    !guest_cpuid_has_ibrs(vcpu))
+		    !guest_cpuid_has_spec_ctrl(vcpu))
 			return 1;
 
 		msr_info->data = to_vmx(vcpu)->spec_ctrl;
@@ -2633,11 +2633,11 @@ static int vmx_set_msr(struct kvm_vcpu *
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
-		    !guest_cpuid_has_ibrs(vcpu))
+		    !guest_cpuid_has_spec_ctrl(vcpu))
 			return 1;
 
 		/* The STIBP bit doesn't fault even if it's not advertised */
-		if (data & ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP))
+		if (data & ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP | SPEC_CTRL_RDS))
 			return 1;
 
 		vmx->spec_ctrl = data;

