Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2744FECE566
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6DC20880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUVdUYOA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6DC20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387461AbeITEao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:30:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37572 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725755AbeITEan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:30:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id u12-v6so7393219wrr.4;
        Wed, 19 Sep 2018 15:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hdueyEZvEHo+lwThNfLaGX/VBGTkBQPdDUJFzmDttVE=;
        b=hUVdUYOAUXZM1qs+INNhfzU2GcfTAQO4VDXpjUUtsn2Q2wgSWl90h16G15OpolXuOQ
         7eEKX537bQ0dMTS+NElwOMOy54hrv+uU7MR9B7Id/qsU2xb1oJPWLyOUi7JNPOAPeYzN
         XmamiQNedtTYVb+KHr3+qEFkU1Ou3AyAXTM+zbtGFotmqO0e+wgrIFtjnvJTBzYx1fyT
         rpA4s03kCvQbWWKDnUqzn8fPjAnpFBMYhCRYYfLCNhqxWqOOj0lGh+lsWm/bJdghENBW
         eciVJbDq2IGKEAI5BBeEz4nS9r5sK+JHzqVzpQcovJp1DNPWi0eKPTXWBm7RvgfhC6HS
         ka1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=hdueyEZvEHo+lwThNfLaGX/VBGTkBQPdDUJFzmDttVE=;
        b=d0R2SLthLksrQp1d0X/Lhg7FUyK+9/KExHgqWfVhQ6cFG6JthsA+M4a/W3AmRgeA/y
         VLgFPC49ill9ZjY6qvDBz64eWVD2S8f4YOBXpop1RUrBnNq75YIn9uGrjt++IfCCpL+I
         NY8xzwZy/BTGr8WKg/rLFRjMWLTgt/VZavsCTrmqO7pwjWFnAtBTpmpHlmmwh+9JadIP
         s4zBZzuhy45blvevRCw6Sj1Dj/4f8p8W8MPKHDXHb/DybU1xpFSaXQzDtGVM7FntYCbc
         ajK3/khA42UPPa+Dc5bwD/sbhWBv7d219CRJmD7llYzkoZutyUk2mhUQursky1dljk7H
         ithg==
X-Gm-Message-State: APzg51DIx+3u9reWpxDm7ygTqSIPdS3vrI+5xDuxBCjBrKYOoDvU4jte
        A6AqvSb4mPVvHgfzUUUr2ZuvOxgV
X-Google-Smtp-Source: ANB0Vdbshv9FmN2rA/zD+F3LD9BsbcduiDvKrnuzyL/UNVpGDLhG85wZO7TqjUCvyzoGdOJR2kNRZw==
X-Received: by 2002:adf:d1c1:: with SMTP id m1-v6mr31896486wri.138.1537397433767;
        Wed, 19 Sep 2018 15:50:33 -0700 (PDT)
Received: from 640k.lan (94-36-187-248.adsl-ull.clienti.tiscali.it. [94.36.187.248])
        by smtp.gmail.com with ESMTPSA id l10-v6sm46721117wre.0.2018.09.19.15.50.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 15:50:33 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH 2/3] KVM: VMX: modify preemption timer bit only when arming timer
Date:   Thu, 20 Sep 2018 00:50:28 +0200
Message-Id: <1537397429-38588-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1537397429-38588-1-git-send-email-pbonzini@redhat.com>
References: <1537397429-38588-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Provide a singular location where the VMX preemption timer bit is
set/cleared so that future usages of the preemption timer can ensure
the VMCS bit is up-to-date without having to modify unrelated code
paths.  For example, the preemption timer can be used to force an
immediate VMExit.  Cache the status of the timer to avoid redundant
VMREAD and VMWRITE, e.g. if the timer stays armed across multiple
VMEnters/VMExits.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx.c | 61 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 4655d6dd6759..ed80673572d2 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -397,6 +397,7 @@ struct loaded_vmcs {
 	int cpu;
 	bool launched;
 	bool nmi_known_unmasked;
+	bool hv_timer_armed;
 	/* Support for vnmi-less CPUs */
 	int soft_vnmi_blocked;
 	ktime_t entry_time;
@@ -10595,24 +10596,38 @@ static void atomic_switch_perf_msrs(struct vcpu_vmx *vmx)
 					msrs[i].host, false);
 }
 
-static void vmx_arm_hv_timer(struct kvm_vcpu *vcpu)
+static void vmx_arm_hv_timer(struct vcpu_vmx *vmx, u64 val)
+{
+	vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, val);
+	if (!vmx->loaded_vmcs->hv_timer_armed)
+		vmcs_set_bits(PIN_BASED_VM_EXEC_CONTROL,
+			      PIN_BASED_VMX_PREEMPTION_TIMER);
+	vmx->loaded_vmcs->hv_timer_armed = true;
+}
+
+static void vmx_update_hv_timer(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	u64 tscl;
 	u32 delta_tsc;
 
-	if (vmx->hv_deadline_tsc == -1)
-		return;
+	if (vmx->hv_deadline_tsc != -1) {
+		tscl = rdtsc();
+		if (vmx->hv_deadline_tsc > tscl)
+			/* set_hv_timer ensures the delta fits in 32-bits */
+			delta_tsc = (u32)((vmx->hv_deadline_tsc - tscl) >>
+				cpu_preemption_timer_multi);
+		else
+			delta_tsc = 0;
 
-	tscl = rdtsc();
-	if (vmx->hv_deadline_tsc > tscl)
-		/* sure to be 32 bit only because checked on set_hv_timer */
-		delta_tsc = (u32)((vmx->hv_deadline_tsc - tscl) >>
-			cpu_preemption_timer_multi);
-	else
-		delta_tsc = 0;
+		vmx_arm_hv_timer(vmx, delta_tsc);
+		return;
+	}
 
-	vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, delta_tsc);
+	if (vmx->loaded_vmcs->hv_timer_armed)
+		vmcs_clear_bits(PIN_BASED_VM_EXEC_CONTROL,
+				PIN_BASED_VMX_PREEMPTION_TIMER);
+	vmx->loaded_vmcs->hv_timer_armed = false;
 }
 
 static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
@@ -10672,7 +10687,7 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 
 	atomic_switch_perf_msrs(vmx);
 
-	vmx_arm_hv_timer(vcpu);
+	vmx_update_hv_timer(vcpu);
 
 	/*
 	 * If this vCPU has touched SPEC_CTRL, restore the guest's value if
@@ -12078,11 +12093,10 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 
 	exec_control = vmcs12->pin_based_vm_exec_control;
 
-	/* Preemption timer setting is only taken from vmcs01.  */
-	exec_control &= ~PIN_BASED_VMX_PREEMPTION_TIMER;
+	/* Preemption timer setting is computed directly in vmx_vcpu_run.  */
 	exec_control |= vmcs_config.pin_based_exec_ctrl;
-	if (vmx->hv_deadline_tsc == -1)
-		exec_control &= ~PIN_BASED_VMX_PREEMPTION_TIMER;
+	exec_control &= ~PIN_BASED_VMX_PREEMPTION_TIMER;
+	vmx->loaded_vmcs->hv_timer_armed = false;
 
 	/* Posted interrupts setting is only taken from vmcs12.  */
 	if (nested_cpu_has_posted_intr(vmcs12)) {
@@ -13255,12 +13269,7 @@ static void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
 	vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, vmx->msr_autoload.host.nr);
 	vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, vmx->msr_autoload.guest.nr);
 	vmcs_write64(TSC_OFFSET, vcpu->arch.tsc_offset);
-	if (vmx->hv_deadline_tsc == -1)
-		vmcs_clear_bits(PIN_BASED_VM_EXEC_CONTROL,
-				PIN_BASED_VMX_PREEMPTION_TIMER);
-	else
-		vmcs_set_bits(PIN_BASED_VM_EXEC_CONTROL,
-			      PIN_BASED_VMX_PREEMPTION_TIMER);
+
 	if (kvm_has_tsc_control)
 		decache_tsc_multiplier(vmx);
 
@@ -13464,18 +13473,12 @@ static int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc)
 		return -ERANGE;
 
 	vmx->hv_deadline_tsc = tscl + delta_tsc;
-	vmcs_set_bits(PIN_BASED_VM_EXEC_CONTROL,
-			PIN_BASED_VMX_PREEMPTION_TIMER);
-
 	return delta_tsc == 0;
 }
 
 static void vmx_cancel_hv_timer(struct kvm_vcpu *vcpu)
 {
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	vmx->hv_deadline_tsc = -1;
-	vmcs_clear_bits(PIN_BASED_VM_EXEC_CONTROL,
-			PIN_BASED_VMX_PREEMPTION_TIMER);
+	to_vmx(vcpu)->hv_deadline_tsc = -1;
 }
 #endif
 
-- 
1.8.3.1


