Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE90DC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90BB62168D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90BB62168D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731138AbeHNUYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:24:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57500 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730771AbeHNUYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:24:45 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 52C88DE0;
        Tue, 14 Aug 2018 17:36:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 064/104] x86/KVM/VMX: Extend add_atomic_switch_msr() to allow VMENTER only MSRs
Date:   Tue, 14 Aug 2018 19:17:18 +0200
Message-Id: <20180814171519.457317432@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171515.270692185@linuxfoundation.org>
References: <20180814171515.270692185@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 989e3992d2eca32c3f1404f2bc91acda3aa122d8 upstream

The IA32_FLUSH_CMD MSR needs only to be written on VMENTER. Extend
add_atomic_switch_msr() with an entry_only parameter to allow storing the
MSR only in the guest (ENTRY) MSR array.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2085,9 +2085,9 @@ static void add_atomic_switch_msr_specia
 }
 
 static void add_atomic_switch_msr(struct vcpu_vmx *vmx, unsigned msr,
-				  u64 guest_val, u64 host_val)
+				  u64 guest_val, u64 host_val, bool entry_only)
 {
-	int i, j;
+	int i, j = 0;
 	struct msr_autoload *m = &vmx->msr_autoload;
 
 	switch (msr) {
@@ -2123,7 +2123,9 @@ static void add_atomic_switch_msr(struct
 	}
 
 	i = find_msr(&m->guest, msr);
-	j = find_msr(&m->host, msr);
+	if (!entry_only)
+		j = find_msr(&m->host, msr);
+
 	if (i == NR_AUTOLOAD_MSRS || j == NR_AUTOLOAD_MSRS) {
 		printk_once(KERN_WARNING "Not enough msr switch entries. "
 				"Can't add msr %x\n", msr);
@@ -2133,12 +2135,16 @@ static void add_atomic_switch_msr(struct
 		i = m->guest.nr++;
 		vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, m->guest.nr);
 	}
+	m->guest.val[i].index = msr;
+	m->guest.val[i].value = guest_val;
+
+	if (entry_only)
+		return;
+
 	if (j < 0) {
 		j = m->host.nr++;
 		vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, m->host.nr);
 	}
-	m->guest.val[i].index = msr;
-	m->guest.val[i].value = guest_val;
 	m->host.val[j].index = msr;
 	m->host.val[j].value = host_val;
 }
@@ -2184,7 +2190,7 @@ static bool update_transition_efer(struc
 			guest_efer &= ~EFER_LME;
 		if (guest_efer != host_efer)
 			add_atomic_switch_msr(vmx, MSR_EFER,
-					      guest_efer, host_efer);
+					      guest_efer, host_efer, false);
 		return false;
 	} else {
 		guest_efer &= ~ignore_bits;
@@ -3593,7 +3599,7 @@ static int vmx_set_msr(struct kvm_vcpu *
 		vcpu->arch.ia32_xss = data;
 		if (vcpu->arch.ia32_xss != host_xss)
 			add_atomic_switch_msr(vmx, MSR_IA32_XSS,
-				vcpu->arch.ia32_xss, host_xss);
+				vcpu->arch.ia32_xss, host_xss, false);
 		else
 			clear_atomic_switch_msr(vmx, MSR_IA32_XSS);
 		break;
@@ -9517,7 +9523,7 @@ static void atomic_switch_perf_msrs(stru
 			clear_atomic_switch_msr(vmx, msrs[i].msr);
 		else
 			add_atomic_switch_msr(vmx, msrs[i].msr, msrs[i].guest,
-					msrs[i].host);
+					msrs[i].host, false);
 }
 
 static void vmx_arm_hv_timer(struct kvm_vcpu *vcpu)


