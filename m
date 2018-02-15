Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224i022ESGd8U4p3AvAUZPPYDADqHj3im5zdeu5MZCjSSSKl7SzWH9/SKdpaD7l3BZUxTTSH
ARC-Seal: i=1; a=rsa-sha256; t=1518708948; cv=none;
        d=google.com; s=arc-20160816;
        b=BUBW7sF3e5+6ERndNA875akkd8ESbInl7f9PKZlVF8p+EBr+rJxCuzDfHz/21jLyrw
         1KvtAAMr6zJ5jL/fzijF8ypO6ToYNT6SBG3pmL4jYby0Rr+Db0Y7H7iB2i1VPksd40QH
         L1Y1K0T5PEb70ANl9qkke0Lh7Ckf4a4eVetdLO44oaZYgafwF7JxRsPyVxYyaXXYbIzk
         TaeyzOhGgxa92oBFcWKuE17BrlD1EFN06DnAQJI/rTXj8GC3Zm+8WpMeQd3Zo06afeDJ
         oR1Hgwq18AojPodkm8QUltNfw2GgHpC1Ppysjn7MX5uZIvDN/dCVr1VY3P6IW9Ti+Hgz
         QHhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BRc51G70HrZKySHryr/mWGu5IdNqh/KZGLd9+HFEHqk=;
        b=uiE53Ob+ejk49wQlLwHPX9xVrG6zhckuyMvzUyCleZ/NcDUlg9Y10y2iSwqDNlXyQG
         xA/TOFbeFIyPOEEdcEfffpRtb37crsyf1lEKH7GTM2z0AdR/7LS8kRlWy+/+mPzlq+iD
         D4Kwwr82UFZ/Hw9mHipN1BTjcEV/hNutFJD1t6IKm5bJ9piJiEndBrKGqsHmh3cOdTZd
         OjyQG87DqDqlQan0vxsv2FMqnLEfpBqT8o/b6IWRujH8y4rK4B4SN7KurDV6jURiBiwM
         GJMRxcUT7Z9Rf/XRvn6u11SKOujWUvoOiEew/z/DRCZ3wZKHITv5mM3tFaBlDibooocu
         OQpg==
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
Subject: [PATCH 4.14 138/195] KVM: nVMX: Fix bug of injecting L2 exception into L1
Date: Thu, 15 Feb 2018 16:17:09 +0100
Message-Id: <20180215151712.690147137@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481754467882981?=
X-GMAIL-MSGID: =?utf-8?q?1592481754467882981?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liran Alon <liran.alon@oracle.com>

commit 5c7d4f9ad39d980728b39752304ce10bb2960cbf upstream.

kvm_clear_exception_queue() should clear pending exception.
This also includes exceptions which were only marked pending but not
yet injected. This is because exception.pending is used for both L1
and L2 to determine if an exception should be raised to guest.
Note that an exception which is pending but not yet injected will
be raised again once the guest will be resumed.

Consider the following scenario:
1) L0 KVM with ignore_msrs=false.
2) L1 prepare vmcs12 with the following:
    a) No intercepts on MSR (MSR_BITMAP exist and is filled with 0).
    b) No intercept for #GP.
    c) vmx-preemption-timer is configured.
3) L1 enters into L2.
4) L2 reads an unhandled MSR that exists in MSR_BITMAP
(such as 0x1fff).

L2 RDMSR could be handled as described below:
1) L2 exits to L0 on RDMSR and calls handle_rdmsr().
2) handle_rdmsr() calls kvm_inject_gp() which sets
KVM_REQ_EVENT, exception.pending=true and exception.injected=false.
3) vcpu_enter_guest() consumes KVM_REQ_EVENT and calls
inject_pending_event() which calls vmx_check_nested_events()
which sees that exception.pending=true but
nested_vmx_check_exception() returns 0 and therefore does nothing at
this point. However let's assume it later sees vmx-preemption-timer
expired and therefore exits from L2 to L1 by calling
nested_vmx_vmexit().
4) nested_vmx_vmexit() calls prepare_vmcs12()
which calls vmcs12_save_pending_event() but it does nothing as
exception.injected is false. Also prepare_vmcs12() calls
kvm_clear_exception_queue() which does nothing as
exception.injected is already false.
5) We now return from vmx_check_nested_events() with 0 while still
having exception.pending=true!
6) Therefore inject_pending_event() continues
and we inject L2 exception to L1!...

This commit will fix above issue by changing step (4) to
clear exception.pending in kvm_clear_exception_queue().

Fixes: 664f8e26b00c ("KVM: X86: Fix loss of exception which has not yet been injected")
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Signed-off-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |    1 -
 arch/x86/kvm/x86.h |    1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11246,7 +11246,6 @@ static int vmx_check_nested_events(struc
 		if (block_nested_events)
 			return -EBUSY;
 		nested_vmx_inject_exception_vmexit(vcpu, exit_qual);
-		vcpu->arch.exception.pending = false;
 		return 0;
 	}
 
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -12,6 +12,7 @@
 
 static inline void kvm_clear_exception_queue(struct kvm_vcpu *vcpu)
 {
+	vcpu->arch.exception.pending = false;
 	vcpu->arch.exception.injected = false;
 }
 
