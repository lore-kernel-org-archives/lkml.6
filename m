Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F660C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4248D2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789895;
	bh=s5cxMasOIF5PI+mbRmOUN1g2ToIzjJgsG3OM2PKLpXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QrL6KKEtMlo/JJ9E0jTWYAW34+oFlBGtk1LJaIkBSOQtUPTJ/YIn3pdim4zimvwx4
	 JvFlGDvADSyeoOBSnXiejnyAaiFpH7tiSnSHLwhjHUoSVYptBmEEHlkn3VlzUTC+dH
	 5ZBZcbTejGTqyPbn7cyV+4eJxmmO1M7ic/meCfNQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4248D2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732796AbeLNMQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:16:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:36740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732139AbeLNMQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:16:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC1D721486;
        Fri, 14 Dec 2018 12:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789791;
        bh=s5cxMasOIF5PI+mbRmOUN1g2ToIzjJgsG3OM2PKLpXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FmdNbi8W3a/UdHcwSyqXLqg9/qUb8VV1nbI762nYAkugL/PJErCiri6NZGmxihHTb
         jmxBVeApzPUp0RfXXESKjEsSWEQxfRXaO+8WlqoySN15THogEMwJwMfngmpK8vT891
         2aPI8/ZGfXzmYHyzTcpc3YF1yMDByXard8+lLUHg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 57/88] x86/KVM/VMX: Expose SPEC_CTRL Bit(2) to the guest
Date:   Fri, 14 Dec 2018 13:00:31 +0100
Message-Id: <20181214115707.221373346@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 4.4: Update feature bit name]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/cpuid.c |    2 +-
 arch/x86/kvm/cpuid.h |    4 ++--
 arch/x86/kvm/svm.c   |    4 ++--
 arch/x86/kvm/vmx.c   |    6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -364,7 +364,7 @@ static inline int __do_cpuid_ent(struct
 
 	/* cpuid 7.0.edx*/
 	const u32 kvm_cpuid_7_0_edx_x86_features =
-		F(SPEC_CTRL) | F(ARCH_CAPABILITIES);
+		F(SPEC_CTRL) | F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES);
 
 	/* all calls to cpuid_count() should be made on the same cpu */
 	get_cpu();
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -170,7 +170,7 @@ static inline bool guest_cpuid_has_ibpb(
 	return best && (best->edx & bit(X86_FEATURE_SPEC_CTRL));
 }
 
-static inline bool guest_cpuid_has_ibrs(struct kvm_vcpu *vcpu)
+static inline bool guest_cpuid_has_spec_ctrl(struct kvm_vcpu *vcpu)
 {
 	struct kvm_cpuid_entry2 *best;
 
@@ -178,7 +178,7 @@ static inline bool guest_cpuid_has_ibrs(
 	if (best && (best->ebx & bit(X86_FEATURE_IBRS)))
 		return true;
 	best = kvm_find_cpuid_entry(vcpu, 7, 0);
-	return best && (best->edx & bit(X86_FEATURE_SPEC_CTRL));
+	return best && (best->edx & (bit(X86_FEATURE_SPEC_CTRL) | bit(X86_FEATURE_SPEC_CTRL_SSBD)));
 }
 
 static inline bool guest_cpuid_has_arch_capabilities(struct kvm_vcpu *vcpu)
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3090,7 +3090,7 @@ static int svm_get_msr(struct kvm_vcpu *
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
-		    !guest_cpuid_has_ibrs(vcpu))
+		    !guest_cpuid_has_spec_ctrl(vcpu))
 			return 1;
 
 		msr_info->data = svm->spec_ctrl;
@@ -3171,7 +3171,7 @@ static int svm_set_msr(struct kvm_vcpu *
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr->host_initiated &&
-		    !guest_cpuid_has_ibrs(vcpu))
+		    !guest_cpuid_has_spec_ctrl(vcpu))
 			return 1;
 
 		/* The STIBP bit doesn't fault even if it's not advertised */
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2861,7 +2861,7 @@ static int vmx_get_msr(struct kvm_vcpu *
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
-		    !guest_cpuid_has_ibrs(vcpu))
+		    !guest_cpuid_has_spec_ctrl(vcpu))
 			return 1;
 
 		msr_info->data = to_vmx(vcpu)->spec_ctrl;
@@ -2973,11 +2973,11 @@ static int vmx_set_msr(struct kvm_vcpu *
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
-		    !guest_cpuid_has_ibrs(vcpu))
+		    !guest_cpuid_has_spec_ctrl(vcpu))
 			return 1;
 
 		/* The STIBP bit doesn't fault even if it's not advertised */
-		if (data & ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP))
+		if (data & ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP | SPEC_CTRL_SSBD))
 			return 1;
 
 		vmx->spec_ctrl = data;


