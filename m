Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtEEGMT/9qx2vdbl3A+5Yq8vGbeONoTFXS5SYeItQWhueShvgYOSCzw+Cf9bYv9ux8TyrDO
ARC-Seal: i=1; a=rsa-sha256; t=1520452080; cv=none;
        d=google.com; s=arc-20160816;
        b=g3SXj7db0lwSnIpqe7isb9kxW+Rm5ZS3FbKsBTr7XgG3G4b+ihb2qpR+0b4tGXLhtZ
         dOiYk3drVFC03rZQPWrXs6w8Rzr5U2Ul2+yYwk/EfGsAaBS4ti+7yj74CPlNQ6RPmXWg
         t5CBSDn3kACn25F4vm3EapNP2PK34SaDOpdtgv0bhRCxlEOmP/dSb+KMnuTIx6+gp4QV
         AmwonPRM+/g6sc6TTi0bPJAuE/lx7xNtS8rerjwo01Qsl+vQNa746e3399nJtIpmV3V4
         XZPD1m+cAk7du9bUPJRnb5PBll7Yb7KOAfaBMC3HgNQZ0xEyfi07XmU9E2At4JGUtBKj
         XsgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zqdejJBZZwelrko8gEXgXJjZVlvkXDxQ1CWqVtIe+tM=;
        b=Fk2jDNeYv84skNh/YN7botB8cNKkv85sSTbRf/86qvauUpGDNDrqM3v43AAqu+nyph
         NwKeybpdo8X374NcH/us/2wXFMgJ9yV3z5ZzkPUT4Ac/+2X4+yEQK6UDRpI1c1AZ2WC4
         Up6ZdBdD46adHWG+nc9Y9I2tTV/a2vI6tvJodUFV7gwuil0OgJ7bSpqhdwO6JhMzhkMh
         v2pCVIA+WbNJvJdZ+GEsm8yVr7yOlZr+upaL16zTOOomG1nfyhAe4Mo5mFG5qdMP3zRN
         wHStOM5N9OfaFZkWjQt72fhFZtaqd9j58/PdCTYMj5d3JoGESds8ihkT8E+FLQUXuylu
         fQAQ==
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
Subject: [PATCH 4.14 102/110] KVM: x86: fix vcpu initialization with userspace lapic
Date: Wed,  7 Mar 2018 11:39:25 -0800
Message-Id: <20180307191052.960331800@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309334216482775?=
X-GMAIL-MSGID: =?utf-8?q?1594309560505163064?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1944,14 +1944,13 @@ void kvm_lapic_set_base(struct kvm_vcpu
 
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
@@ -2510,7 +2509,6 @@ void kvm_apic_accept_events(struct kvm_v
 
 	pe = xchg(&apic->pending_events, 0);
 	if (test_bit(KVM_APIC_INIT, &pe)) {
-		kvm_lapic_reset(vcpu, true);
 		kvm_vcpu_reset(vcpu, true);
 		if (kvm_vcpu_is_bsp(apic->vcpu))
 			vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7779,7 +7779,6 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu
 	if (r)
 		return r;
 	kvm_vcpu_reset(vcpu, false);
-	kvm_lapic_reset(vcpu, false);
 	kvm_mmu_setup(vcpu);
 	vcpu_put(vcpu);
 	return r;
@@ -7822,6 +7821,8 @@ void kvm_arch_vcpu_destroy(struct kvm_vc
 
 void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 {
+	kvm_lapic_reset(vcpu, init_event);
+
 	vcpu->arch.hflags = 0;
 
 	vcpu->arch.smi_pending = 0;
