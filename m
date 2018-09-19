Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B07FECE566
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04EE2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5KLqw0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B04EE2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387497AbeITEar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:30:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34315 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeITEaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:30:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id j25-v6so10623250wmc.1;
        Wed, 19 Sep 2018 15:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+b3p5faRXal795o3hk9VS/xC2byqtUWi4N9Q2yiqEn4=;
        b=I5KLqw0uJwRKa05uptwmOZodolx0LZpGgiUVVuMz8yybKisKYHjci7LFKPiNzfvuFi
         maQwxgtU7xIqYQRISsM6rm3QTxgyARjLqQUJLgpsyRAUKp0PGhx27oB29oKFtdpwUFUp
         r6qQKM0D3c83wzw1BwhG/7fga+7bd0bOGy5uBr/iZ2P2+6cbTCwHurA18muwWLJCF9To
         Lb+4WlA8+cHjWX71+aKglZZKdCFFZztvb/e5aJFVYhbZkdkIIO52s/Thqroux3cnoj8Z
         eglYyTkOONNpQFp40vExjHT51/I6VR+/WEyQz9vO9OpqYhy0K2qBEY/zWPj6jbpUX5z4
         Os8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=+b3p5faRXal795o3hk9VS/xC2byqtUWi4N9Q2yiqEn4=;
        b=MDCyfgH3rs8RYalcbNkURcBGAagxbdGbFtPxNOwvVW69iIcCBefI9lFpx0d18w+zbn
         RJwheinZBCAFSt9Pl0u3A/eamf/Rzn3Rz63YZHXiR1fd9g0LXotsZOYtHyj8U0pTQFZw
         k5ytsn4NTtZIPlsfuiY2Hk8tUPK+jT5LmsDNxKLz8GUPlJ0oeXjIRQBdC7fxr3JZOcNF
         ThsfKc5zwDf2DAWtCmrKrsG7i8dzwZNJ8fUWin50tqzrvYizd4mFOoR/TUB4RoThY6yD
         AgOWmNE4LRw2N+FqrX0AVJll29GEV2Rg6NpRyO763p2PI/jnCExhg/J3kjlKNT0JoFGM
         gPZQ==
X-Gm-Message-State: APzg51CktZqMo9Sx3odgQ/QwkWouwPH2ftgnsfOgBAvYb5afvIsfOwmO
        2Xtwvv7/VpKYYyqQgGJ6cY/bTZs8
X-Google-Smtp-Source: ANB0VdbpOUiYAnubMom0JOp2+x8VzjH/Dqd3NhNhtokjyRx9Rvu23oayTFYq+/ckkKJbQe7xWsLvqg==
X-Received: by 2002:a1c:ce0b:: with SMTP id e11-v6mr66258wmg.47.1537397434912;
        Wed, 19 Sep 2018 15:50:34 -0700 (PDT)
Received: from 640k.lan (94-36-187-248.adsl-ull.clienti.tiscali.it. [94.36.187.248])
        by smtp.gmail.com with ESMTPSA id l10-v6sm46721117wre.0.2018.09.19.15.50.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 15:50:34 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH 3/3] KVM: VMX: use preemption timer to force immediate VMExit
Date:   Thu, 20 Sep 2018 00:50:29 +0200
Message-Id: <1537397429-38588-4-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1537397429-38588-1-git-send-email-pbonzini@redhat.com>
References: <1537397429-38588-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

A VMX preemption timer value of '0' is guaranteed to cause a VMExit
prior to the CPU executing any instructions in the guest.  Use the
preemption timer (if it's supported) to trigger immediate VMExit
in place of the current method of sending a self-IPI.  This ensures
that pending VMExit injection to L1 occurs prior to executing any
instructions in the guest (regardless of nesting level).

When deferring VMExit injection, KVM generates an immediate VMExit
from the (possibly nested) guest by sending itself an IPI.  Because
hardware interrupts are blocked prior to VMEnter and are unblocked
(in hardware) after VMEnter, this results in taking a VMExit(INTR)
before any guest instruction is executed.  But, as this approach
relies on the IPI being received before VMEnter executes, it only
works as intended when KVM is running as L0.  Because there are no
architectural guarantees regarding when IPIs are delivered, when
running nested the INTR may "arrive" long after L2 is running e.g.
L0 KVM doesn't force an immediate switch to L1 to deliver an INTR.

For the most part, this unintended delay is not an issue since the
events being injected to L1 also do not have architectural guarantees
regarding their timing.  The notable exception is the VMX preemption
timer[1], which is architecturally guaranteed to cause a VMExit prior
to executing any instructions in the guest if the timer value is '0'
at VMEnter.  Specifically, the delay in injecting the VMExit causes
the preemption timer KVM unit test to fail when run in a nested guest.

Note: this approach is viable even on CPUs with a broken preemption
timer, as broken in this context only means the timer counts at the
wrong rate.  There are no known errata affecting timer value of '0'.

[1] I/O SMIs also have guarantees on when they arrive, but I have
    no idea if/how those are emulated in KVM.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
[Use a hook for SVM instead of leaving the default in x86.c - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/svm.c              |  2 ++
 arch/x86/kvm/vmx.c              | 21 ++++++++++++++++++++-
 arch/x86/kvm/x86.c              |  8 +++++++-
 4 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 8e90488c3d56..bffb25b50425 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1055,6 +1055,7 @@ struct kvm_x86_ops {
 	bool (*umip_emulated)(void);
 
 	int (*check_nested_events)(struct kvm_vcpu *vcpu, bool external_intr);
+	void (*request_immediate_exit)(struct kvm_vcpu *vcpu);
 
 	void (*sched_in)(struct kvm_vcpu *kvm, int cpu);
 
@@ -1482,6 +1483,7 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu,
 
 int kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu);
 int kvm_complete_insn_gp(struct kvm_vcpu *vcpu, int err);
+void __kvm_request_immediate_exit(struct kvm_vcpu *vcpu);
 
 int kvm_is_in_guest(void);
 
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index c7f1c3fd782d..d96092b35936 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -7148,6 +7148,8 @@ static int svm_unregister_enc_region(struct kvm *kvm,
 	.check_intercept = svm_check_intercept,
 	.handle_external_intr = svm_handle_external_intr,
 
+	.request_immediate_exit = __kvm_request_immediate_exit,
+
 	.sched_in = svm_sched_in,
 
 	.pmu_ops = &amd_pmu_ops,
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index ed80673572d2..c9a57e2a5999 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1020,6 +1020,8 @@ struct vcpu_vmx {
 	int ple_window;
 	bool ple_window_dirty;
 
+	bool req_immediate_exit;
+
 	/* Support for PML */
 #define PML_ENTITY_NUM		512
 	struct page *pml_pg;
@@ -2865,6 +2867,8 @@ static void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 	u16 fs_sel, gs_sel;
 	int i;
 
+	vmx->req_immediate_exit = false;
+
 	if (vmx->loaded_cpu_state)
 		return;
 
@@ -7967,6 +7971,9 @@ static __init int hardware_setup(void)
 		kvm_x86_ops->enable_log_dirty_pt_masked = NULL;
 	}
 
+	if (!cpu_has_vmx_preemption_timer())
+		kvm_x86_ops->request_immediate_exit = __kvm_request_immediate_exit;
+
 	if (cpu_has_vmx_preemption_timer() && enable_preemption_timer) {
 		u64 vmx_msr;
 
@@ -9209,7 +9216,8 @@ static int handle_pml_full(struct kvm_vcpu *vcpu)
 
 static int handle_preemption_timer(struct kvm_vcpu *vcpu)
 {
-	kvm_lapic_expired_hv_timer(vcpu);
+	if (!to_vmx(vcpu)->req_immediate_exit)
+		kvm_lapic_expired_hv_timer(vcpu);
 	return 1;
 }
 
@@ -10611,6 +10619,11 @@ static void vmx_update_hv_timer(struct kvm_vcpu *vcpu)
 	u64 tscl;
 	u32 delta_tsc;
 
+	if (vmx->req_immediate_exit) {
+		vmx_arm_hv_timer(vmx, 0);
+		return;
+	}
+
 	if (vmx->hv_deadline_tsc != -1) {
 		tscl = rdtsc();
 		if (vmx->hv_deadline_tsc > tscl)
@@ -12879,6 +12892,11 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu, bool external_intr)
 	return 0;
 }
 
+static void vmx_request_immediate_exit(struct kvm_vcpu *vcpu)
+{
+	to_vmx(vcpu)->req_immediate_exit = true;
+}
+
 static u32 vmx_get_preemption_timer_value(struct kvm_vcpu *vcpu)
 {
 	ktime_t remaining =
@@ -14135,6 +14153,7 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 	.umip_emulated = vmx_umip_emulated,
 
 	.check_nested_events = vmx_check_nested_events,
+	.request_immediate_exit = vmx_request_immediate_exit,
 
 	.sched_in = vmx_sched_in,
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5c870203737f..9d0fda9056de 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7361,6 +7361,12 @@ void kvm_vcpu_reload_apic_access_page(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_reload_apic_access_page);
 
+void __kvm_request_immediate_exit(struct kvm_vcpu *vcpu)
+{
+	smp_send_reschedule(vcpu->cpu);
+}
+EXPORT_SYMBOL_GPL(__kvm_request_immediate_exit);
+
 /*
  * Returns 1 to let vcpu_run() continue the guest execution loop without
  * exiting to the userspace.  Otherwise, the value will be returned to the
@@ -7565,7 +7571,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 	if (req_immediate_exit) {
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
-		smp_send_reschedule(vcpu->cpu);
+		kvm_x86_ops->request_immediate_exit(vcpu);
 	}
 
 	trace_kvm_entry(vcpu->vcpu_id);
-- 
1.8.3.1

