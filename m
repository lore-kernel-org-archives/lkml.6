Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8DCC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1C320878
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wsbr1rW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1C320878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeLDK5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:57:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:41770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbeLDK5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:57:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7A612146D;
        Tue,  4 Dec 2018 10:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921062;
        bh=fXYE8XQrIAC4oTNobHDjADFumnA0SneZFbu/wgQLY38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wsbr1rW1kNdto1vQksH4YDwVuY7Q2aYvWtl7wlolPQIdPjitP2+888CxWhn+JQSGx
         CHAA9g2KU/h6BlA1QshrSAckDc4Njc2jkkmWPn4XGhAEbSufoOpq0UsU0gB3l1VOSI
         cetYvdHzo+BKoIpsERHvxdyZd9uMghEozAYRCARg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liran Alon <liran.alon@oracle.com>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Leonid Shatz <leonid.shatz@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 065/139] KVM: nVMX/nSVM: Fix bug which sets vcpu->arch.tsc_offset to L1 tsc_offset
Date:   Tue,  4 Dec 2018 11:49:06 +0100
Message-Id: <20181204103652.702958456@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leonid Shatz <leonid.shatz@oracle.com>

commit 326e742533bf0a23f0127d8ea62fb558ba665f08 upstream.

Since commit e79f245ddec1 ("X86/KVM: Properly update 'tsc_offset' to
represent the running guest"), vcpu->arch.tsc_offset meaning was
changed to always reflect the tsc_offset value set on active VMCS.
Regardless if vCPU is currently running L1 or L2.

However, above mentioned commit failed to also change
kvm_vcpu_write_tsc_offset() to set vcpu->arch.tsc_offset correctly.
This is because vmx_write_tsc_offset() could set the tsc_offset value
in active VMCS to given offset parameter *plus vmcs12->tsc_offset*.
However, kvm_vcpu_write_tsc_offset() just sets vcpu->arch.tsc_offset
to given offset parameter. Without taking into account the possible
addition of vmcs12->tsc_offset. (Same is true for SVM case).

Fix this issue by changing kvm_x86_ops->write_tsc_offset() to return
actually set tsc_offset in active VMCS and modify
kvm_vcpu_write_tsc_offset() to set returned value in
vcpu->arch.tsc_offset.
In addition, rename write_tsc_offset() callback to write_l1_tsc_offset()
to make it clear that it is meant to set L1 TSC offset.

Fixes: e79f245ddec1 ("X86/KVM: Properly update 'tsc_offset' to represent the running guest")
Reviewed-by: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Mihai Carabas <mihai.carabas@oracle.com>
Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Signed-off-by: Leonid Shatz <leonid.shatz@oracle.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/kvm_host.h |    3 ++-
 arch/x86/kvm/svm.c              |    5 +++--
 arch/x86/kvm/vmx.c              |   21 +++++++++------------
 arch/x86/kvm/x86.c              |    6 +++---
 4 files changed, 17 insertions(+), 18 deletions(-)

--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1046,7 +1046,8 @@ struct kvm_x86_ops {
 	bool (*has_wbinvd_exit)(void);
 
 	u64 (*read_l1_tsc_offset)(struct kvm_vcpu *vcpu);
-	void (*write_tsc_offset)(struct kvm_vcpu *vcpu, u64 offset);
+	/* Returns actual tsc_offset set in active VMCS */
+	u64 (*write_l1_tsc_offset)(struct kvm_vcpu *vcpu, u64 offset);
 
 	void (*get_exit_info)(struct kvm_vcpu *vcpu, u64 *info1, u64 *info2);
 
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1444,7 +1444,7 @@ static u64 svm_read_l1_tsc_offset(struct
 	return vcpu->arch.tsc_offset;
 }
 
-static void svm_write_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
+static u64 svm_write_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	u64 g_tsc_offset = 0;
@@ -1462,6 +1462,7 @@ static void svm_write_tsc_offset(struct
 	svm->vmcb->control.tsc_offset = offset + g_tsc_offset;
 
 	mark_dirty(svm->vmcb, VMCB_INTERCEPTS);
+	return svm->vmcb->control.tsc_offset;
 }
 
 static void avic_init_vmcb(struct vcpu_svm *svm)
@@ -7155,7 +7156,7 @@ static struct kvm_x86_ops svm_x86_ops __
 	.has_wbinvd_exit = svm_has_wbinvd_exit,
 
 	.read_l1_tsc_offset = svm_read_l1_tsc_offset,
-	.write_tsc_offset = svm_write_tsc_offset,
+	.write_l1_tsc_offset = svm_write_l1_tsc_offset,
 
 	.set_tdp_cr3 = set_tdp_cr3,
 
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -3433,11 +3433,9 @@ static u64 vmx_read_l1_tsc_offset(struct
 	return vcpu->arch.tsc_offset;
 }
 
-/*
- * writes 'offset' into guest's timestamp counter offset register
- */
-static void vmx_write_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
+static u64 vmx_write_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
 {
+	u64 active_offset = offset;
 	if (is_guest_mode(vcpu)) {
 		/*
 		 * We're here if L1 chose not to trap WRMSR to TSC. According
@@ -3445,17 +3443,16 @@ static void vmx_write_tsc_offset(struct
 		 * set for L2 remains unchanged, and still needs to be added
 		 * to the newly set TSC to get L2's TSC.
 		 */
-		struct vmcs12 *vmcs12;
-		/* recalculate vmcs02.TSC_OFFSET: */
-		vmcs12 = get_vmcs12(vcpu);
-		vmcs_write64(TSC_OFFSET, offset +
-			(nested_cpu_has(vmcs12, CPU_BASED_USE_TSC_OFFSETING) ?
-			 vmcs12->tsc_offset : 0));
+		struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
+		if (nested_cpu_has(vmcs12, CPU_BASED_USE_TSC_OFFSETING))
+			active_offset += vmcs12->tsc_offset;
 	} else {
 		trace_kvm_write_tsc_offset(vcpu->vcpu_id,
 					   vmcs_read64(TSC_OFFSET), offset);
-		vmcs_write64(TSC_OFFSET, offset);
 	}
+
+	vmcs_write64(TSC_OFFSET, active_offset);
+	return active_offset;
 }
 
 /*
@@ -14203,7 +14200,7 @@ static struct kvm_x86_ops vmx_x86_ops __
 	.has_wbinvd_exit = cpu_has_vmx_wbinvd_exit,
 
 	.read_l1_tsc_offset = vmx_read_l1_tsc_offset,
-	.write_tsc_offset = vmx_write_tsc_offset,
+	.write_l1_tsc_offset = vmx_write_l1_tsc_offset,
 
 	.set_tdp_cr3 = vmx_set_cr3,
 
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1582,8 +1582,7 @@ EXPORT_SYMBOL_GPL(kvm_read_l1_tsc);
 
 static void kvm_vcpu_write_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
 {
-	kvm_x86_ops->write_tsc_offset(vcpu, offset);
-	vcpu->arch.tsc_offset = offset;
+	vcpu->arch.tsc_offset = kvm_x86_ops->write_l1_tsc_offset(vcpu, offset);
 }
 
 static inline bool kvm_check_tsc_unstable(void)
@@ -1711,7 +1710,8 @@ EXPORT_SYMBOL_GPL(kvm_write_tsc);
 static inline void adjust_tsc_offset_guest(struct kvm_vcpu *vcpu,
 					   s64 adjustment)
 {
-	kvm_vcpu_write_tsc_offset(vcpu, vcpu->arch.tsc_offset + adjustment);
+	u64 tsc_offset = kvm_x86_ops->read_l1_tsc_offset(vcpu);
+	kvm_vcpu_write_tsc_offset(vcpu, tsc_offset + adjustment);
 }
 
 static inline void adjust_tsc_offset_host(struct kvm_vcpu *vcpu, s64 adjustment)


