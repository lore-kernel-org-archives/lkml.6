Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3102895-1519914329-2-1231522670664908465
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: from='UTF-8', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519914329; b=rwV/CS3DnzVs1dgI5t1jPclGqYD4qvk+E74bAbNo00VVri1
    b2qZDAt+u1Tqn+o8DzMAQSC2wUI9Fjv2otr8McA0gZ2pQjxzSZ639tlbnX/es1xw
    CeFaT8NxnUna2hhCutoxIwkTeEvm1EzYSBdr7tDG8apHGesGoPkzKw+FGuc7DsX1
    KjYlFTeApm5eqPPNSeW+PY87OyvzXcOI9S/RINQA8/1BJvvKIdWr4f4b2AIvjVj2
    de9Gk5vS29Kt03iH9CTdm8KzRCZQnFOORY7FRTPxXo+ZiQzbqnTK6hSQocC6dNY8
    KC5vcwmnIAJbaSDGJqyuS5oTQQ0+r3YCh2aY4TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1519914329; bh=dgoZl/Dz769uuvVsD2p2/y19Rn
    lwsoxVkRanCkxfOIg=; b=Ik3Z7rU9bcL8Ctjs3dct2tTuD90mmLpH9N/ff05hsr
    SFc0BRsA84IKIQr/ug1QpJ3nlv9v5X1Nl/buFUx0lKMB1FXqN2bs63TChn+pLMmE
    iGddBVEC9V9BB6chXmamuXd5BdxPWlrZliJNx06ntFHjkGfT9xJQVrWnf6BBSw2V
    NvtkE//6ct+i+muEIMfSkX8u0DWtoUNNhkP6MuTua1FjOMv2BJ4opvb0ol6Jo4Ka
    +Xos+o69vjyJxTyG4GdZADWaVZ1cSD1EnGE4BddL4YO9y29OHBUTDiA4q1LlBJ52
    XkV/ptxjkd7hhwqgXeVx+iLJP3D/HciusT8OYKScH+9Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031469AbeCAOZJ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 09:25:09 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031397AbeCAOZJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 1 Mar 2018 09:25:09 -0500
From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>, stable@vger.kernel.org
Subject: [PATCH] KVM: x86: fix vcpu initialization with userspace lapic
Date: Thu,  1 Mar 2018 15:24:25 +0100
Message-Id: <20180301142425.18550-1-rkrcmar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Moving the code around broke this rare configuration.
Use this opportunity to finally call lapic reset from vcpu reset.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Fixes: 0b2e9904c159 ("KVM: x86: move LAPIC initialization after VMCS creation")
Cc: stable@vger.kernel.org
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
---
 arch/x86/kvm/lapic.c | 10 ++++------
 arch/x86/kvm/x86.c   |  3 ++-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index cc5fe7a50dde..391dda8d43b7 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2002,14 +2002,13 @@ void kvm_lapic_set_base(struct kvm_vcpu *vcpu, u64 value)
 
 void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
 {
-	struct kvm_lapic *apic;
+	struct kvm_lapic *apic = vcpu->arch.apic;
 	int i;
 
-	apic_debug("%s\n", __func__);
+	if (!apic)
+		return;
 
-	ASSERT(vcpu);
-	apic = vcpu->arch.apic;
-	ASSERT(apic != NULL);
+	apic_debug("%s\n", __func__);
 
 	/* Stop the timer in case it's a reset to an active apic */
 	hrtimer_cancel(&apic->lapic_timer.timer);
@@ -2568,7 +2567,6 @@ void kvm_apic_accept_events(struct kvm_vcpu *vcpu)
 
 	pe = xchg(&apic->pending_events, 0);
 	if (test_bit(KVM_APIC_INIT, &pe)) {
-		kvm_lapic_reset(vcpu, true);
 		kvm_vcpu_reset(vcpu, true);
 		if (kvm_vcpu_is_bsp(apic->vcpu))
 			vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1a3ed81031f1..3f96b51d0495 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8123,7 +8123,6 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	kvm_vcpu_mtrr_init(vcpu);
 	vcpu_load(vcpu);
 	kvm_vcpu_reset(vcpu, false);
-	kvm_lapic_reset(vcpu, false);
 	kvm_mmu_setup(vcpu);
 	vcpu_put(vcpu);
 	return 0;
@@ -8166,6 +8165,8 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 
 void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 {
+	kvm_lapic_reset(vcpu, init_event);
+
 	vcpu->arch.hflags = 0;
 
 	vcpu->arch.smi_pending = 0;
-- 
2.15.1
