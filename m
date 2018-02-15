Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225AyiG5NQ/BcBiX/JgCUG15SkzSeTg3uzGG/LUiDw64FP53w/qIc+kh+xmxW3rwKpgx+hBV
ARC-Seal: i=1; a=rsa-sha256; t=1518709579; cv=none;
        d=google.com; s=arc-20160816;
        b=sh0jQjBYOGKggsYlw4rr5xbtoZm5OfN41EpNwLVgM6eLOCyiFiGUa/C04DRiSdnuZI
         L7UqHtj7z+B88Mb7Q9/mFAO2kzOwnpzMrckgPhvOUfJb6GVj1hPnW7L5OMPQqFKyGfj7
         mlmDM2u3flzXs1KR0pzTjIUpkM0XQYxt6EEwNYIvyPygvNmPX4xiMiJGqw/7eLaXIxFu
         /axOj/8wfiAWqUoXMc5lchHn3nGQlf53Q2BGj2kRWeZ/Ia3YtkqnbpaKUtOW/hXLVtVb
         cfASNqDLuXvO5JsIwcN0mLFjST2F7bWQRfi8NyIO4qju7dGG9I1F0q2mPKFWuZJYjIcC
         2Omg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=z6eG1OVb0l1TPHCAN5Wf0z5D76gxzVYHXHCZDGPmd90=;
        b=CREqi++H9ayUl6ut/ZCzTuiK0JlUOKYFRuBrXjUEjdQ1lYBnzQv4mGlwTAydIYJjAm
         BK+xDN9CzHKkQlfXT/dMVreuffUgWGILbilOwQ60Si44iXY2nNKKCwUIjlMvfBmnIjn2
         SyDrbA0KPstz7DNPyNKpLPXUED/8sFSJ+3yMHp4Fqy0lgdcMj3Yl01fVUkh3/kCKQYn5
         +daZ1URbADW6JUarngzVfQaGZZ56H8jZmV1RFOqG3I3T33ZNfuxEgPCqXkex4KDqmtxM
         sjAWNSpnaj/xBxNej2WNYY/OBiDX0SL8bNZoQfusaCNNdipet2b2VX3qrSRx7uYeaRlC
         b2DQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Liran Alon <liran.alon@oracle.com>,
	Nikita Leshenko <nikita.leshchenko@oracle.com>,
	Krish Sadhukhan <krish.sadhukhan@oracle.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 4.15 131/202] KVM: nVMX: Fix races when sending nested PI while dest enters/leaves L2
Date: Thu, 15 Feb 2018 16:17:11 +0100
Message-Id: <20180215151720.035485543@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481037885961253?=
X-GMAIL-MSGID: =?utf-8?q?1592482416517046945?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liran Alon <liran.alon@oracle.com>

commit 6b6977117f50d60455ace86b2d256f6fb4f3de05 upstream.

Consider the following scenario:
1. CPU A calls vmx_deliver_nested_posted_interrupt() to send an IPI
to CPU B via virtual posted-interrupt mechanism.
2. CPU B is currently executing L2 guest.
3. vmx_deliver_nested_posted_interrupt() calls
kvm_vcpu_trigger_posted_interrupt() which will note that
vcpu->mode == IN_GUEST_MODE.
4. Assume that before CPU A sends the physical POSTED_INTR_NESTED_VECTOR
IPI, CPU B exits from L2 to L0 during event-delivery
(valid IDT-vectoring-info).
5. CPU A now sends the physical IPI. The IPI is received in host and
it's handler (smp_kvm_posted_intr_nested_ipi()) does nothing.
6. Assume that before CPU A sets pi_pending=true and KVM_REQ_EVENT,
CPU B continues to run in L0 and reach vcpu_enter_guest(). As
KVM_REQ_EVENT is not set yet, vcpu_enter_guest() will continue and resume
L2 guest.
7. At this point, CPU A sets pi_pending=true and KVM_REQ_EVENT but
it's too late! CPU B already entered L2 and KVM_REQ_EVENT will only be
consumed at next L2 entry!

Another scenario to consider:
1. CPU A calls vmx_deliver_nested_posted_interrupt() to send an IPI
to CPU B via virtual posted-interrupt mechanism.
2. Assume that before CPU A calls kvm_vcpu_trigger_posted_interrupt(),
CPU B is at L0 and is about to resume into L2. Further assume that it is
in vcpu_enter_guest() after check for KVM_REQ_EVENT.
3. At this point, CPU A calls kvm_vcpu_trigger_posted_interrupt() which
will note that vcpu->mode != IN_GUEST_MODE. Therefore, do nothing and
return false. Then, will set pi_pending=true and KVM_REQ_EVENT.
4. Now CPU B continue and resumes into L2 guest without processing
the posted-interrupt until next L2 entry!

To fix both issues, we just need to change
vmx_deliver_nested_posted_interrupt() to set pi_pending=true and
KVM_REQ_EVENT before calling kvm_vcpu_trigger_posted_interrupt().

It will fix the first scenario by chaging step (6) to note that
KVM_REQ_EVENT and pi_pending=true and therefore process
nested posted-interrupt.

It will fix the second scenario by two possible ways:
1. If kvm_vcpu_trigger_posted_interrupt() is called while CPU B has changed
vcpu->mode to IN_GUEST_MODE, physical IPI will be sent and will be received
when CPU resumes into L2.
2. If kvm_vcpu_trigger_posted_interrupt() is called while CPU B hasn't yet
changed vcpu->mode to IN_GUEST_MODE, then after CPU B will change
vcpu->mode it will call kvm_request_pending() which will return true and
therefore force another round of vcpu_enter_guest() which will note that
KVM_REQ_EVENT and pi_pending=true and therefore process nested
posted-interrupt.

Fixes: 705699a13994 ("KVM: nVMX: Enable nested posted interrupt processing")
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
[Add kvm_vcpu_kick to also handle the case where L1 doesn't intercept L2 HLT
 and L2 executes HLT instruction. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -5323,14 +5323,15 @@ static int vmx_deliver_nested_posted_int
 
 	if (is_guest_mode(vcpu) &&
 	    vector == vmx->nested.posted_intr_nv) {
-		/* the PIR and ON have been set by L1. */
-		kvm_vcpu_trigger_posted_interrupt(vcpu, true);
 		/*
 		 * If a posted intr is not recognized by hardware,
 		 * we will accomplish it in the next vmentry.
 		 */
 		vmx->nested.pi_pending = true;
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
+		/* the PIR and ON have been set by L1. */
+		if (!kvm_vcpu_trigger_posted_interrupt(vcpu, true))
+			kvm_vcpu_kick(vcpu);
 		return 0;
 	}
 	return -1;
