Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuEn/Enr2gj7bflYF7IPS8iaygpHlvU4unlO3PnRDlJe1QLYKRXirRAC3oYHLETPBsM/xVk
ARC-Seal: i=1; a=rsa-sha256; t=1520451864; cv=none;
        d=google.com; s=arc-20160816;
        b=UJy3SWTaXeCHqWTCxrppo5ShEy8Up5wVUAAlfTvxXJ8oEvfErJYvNLISWwOdRbFRMa
         ldG7aDbw/qyzgZD/DmAGPjsaA5UWNVxqMx0hXYNhTailaCnzPMqlpls1Ko4cSnDM/EBz
         xKi2gU17D/hiGXxmbLGUEqEEqHfbiSIoaeZq7sS6bKpk/XORe1v0AIkxFYhGYfpNX69J
         tl/hB6ISYkF9AjbBPpVwryGSzlgewvLEiDVdm7aBD4WUxIEHyv7YRhBHuE2lbQQLkKRJ
         xz1quNPFRO4FqRRmIMuX3cufeT4mfN8bB+Sddi4uZwxApXzED3khlhsaZwvKPoUDi//T
         KNmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sltXO0vY2HS4gPEkkIrQj+xgTWHTf52XFXZw2uEoteI=;
        b=dA6SMaztRXAaYxOty+NxayU6V109TcTphrJkInwHFcMbbYrj0Qz53qgTSYqVkuX56q
         UXfr6d4uY09L8DG3IYAcZuM9ZNswj2u0gFGizVmHnJczi3RG+KlHzp8m8Imfdz7En5QA
         cNqfAsfM6PK242g2geufW+HHOvSjc5Q2a+pfevwu2oWFK4pyxp+oyqdOF7vtzVgBZYCs
         LMNRfcPWAkTabP76tR4tV0gVHsjI5R16A9CB8RE3Pt0j/IYQ6yVmImIM9292+XcMeVcS
         wRoZTt+BYKQ3MbPmPtR86BwTsLSiqMFVqzv2coqVQ5eX/3AVRUgI+/JFRO0gqGqskKnc
         V8Rg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+fb7a33a4b6c35007a72b@syzkaller.appspotmail.com,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 4.15 116/122] KVM: x86: fix vcpu initialization with userspace lapic
Date: Wed,  7 Mar 2018 11:38:48 -0800
Message-Id: <20180307191746.478423398@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309334216482775?=
X-GMAIL-MSGID: =?utf-8?q?1594309334216482775?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Radim Krčmář <rkrcmar@redhat.com>

commit b7e31be385584afe7f073130e8e570d53c95f7fe upstream.

Moving the code around broke this rare configuration.
Use this opportunity to finally call lapic reset from vcpu reset.

Reported-by: syzbot+fb7a33a4b6c35007a72b@syzkaller.appspotmail.com
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Fixes: 0b2e9904c159 ("KVM: x86: move LAPIC initialization after VMCS creation")
Cc: stable@vger.kernel.org
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/lapic.c |   10 ++++------
 arch/x86/kvm/x86.c   |    3 ++-
 2 files changed, 6 insertions(+), 7 deletions(-)

--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1993,14 +1993,13 @@ void kvm_lapic_set_base(struct kvm_vcpu
 
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
@@ -2559,7 +2558,6 @@ void kvm_apic_accept_events(struct kvm_v
 
 	pe = xchg(&apic->pending_events, 0);
 	if (test_bit(KVM_APIC_INIT, &pe)) {
-		kvm_lapic_reset(vcpu, true);
 		kvm_vcpu_reset(vcpu, true);
 		if (kvm_vcpu_is_bsp(apic->vcpu))
 			vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7793,7 +7793,6 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu
 	if (r)
 		return r;
 	kvm_vcpu_reset(vcpu, false);
-	kvm_lapic_reset(vcpu, false);
 	kvm_mmu_setup(vcpu);
 	vcpu_put(vcpu);
 	return r;
@@ -7836,6 +7835,8 @@ void kvm_arch_vcpu_destroy(struct kvm_vc
 
 void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 {
+	kvm_lapic_reset(vcpu, init_event);
+
 	vcpu->arch.hflags = 0;
 
 	vcpu->arch.smi_pending = 0;
