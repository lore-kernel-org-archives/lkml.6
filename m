Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225/+ImSBUgFIRr40Yuj7sW59eL+0TLMsAqxdje0bAukUccmwNEcHSebGFtXFA0Hipv9K4vO
ARC-Seal: i=1; a=rsa-sha256; t=1518709582; cv=none;
        d=google.com; s=arc-20160816;
        b=BzVBqR8LiAboLsp/YVdCFCvX43+L9Hb+oLh4XhWvnydQk8x82juDL2cuYsbqFzPl9t
         tfvgST0vc1jISLEQZZ6JAqbdNymuFBRqGQXyMghS6pLQJ46Z5NgTwGw81SnsGTQRsUi6
         FAfIuc5IsWkMrv7JxmORh2DSpsPQhrJmcMhw6gcaTHJG2A4sX75EhtsTbD1oRiqNulrq
         55R1wM9SOMO0FXUupkiVjl4yfKC+623tjUWD5rhBOYjoDYnJvWIEUez6CYIDVUwY9W9G
         KuLI8YjOAYEvACFeQHDbz3h4iS1Qme5Omj8Y5vAxqUxuPgxPayoRqjwmGRkoIg8QMf1Q
         /Q7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rKIY/eTvEaNJVUyBZ2Wci66kW7w57itZs4pyvHZgv8A=;
        b=YGiWIHozV4gB3X1Tvefh/0346G1HoZ4jbM1YXzsy5NkXTAfszrc5Qx2j5zItj3Cm9M
         tmUZaZQjBXh08soGpz4Lomh6sq3M5jNdLQE2d7hucRnJ4/3MuA4urdbokN5NhaxUjQnf
         qoPMQjHDFPqWA0HcLLvfnUxgKifYhNTl/xuQRzs3vqTmnNWE3Pi4Jt8IcnxzrobvoQJ9
         4vrrSbx5v5fZ1tz8KJGFZvJSnouafXQCinLBnv49OtUsJd3GJqncW/7ZyTpHFlV2rlws
         k7l6jGeyPpJbWH/iqnDQSWqt0EBq0AO2ZNpQltI8a5PX/ZuMCwfPh5mP2+S0zY7DdvOv
         diQQ==
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
Subject: [PATCH 4.15 132/202] KVM: nVMX: Fix bug of injecting L2 exception into L1
Date: Thu, 15 Feb 2018 16:17:12 +0100
Message-Id: <20180215151720.080557703@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481754467882981?=
X-GMAIL-MSGID: =?utf-8?q?1592482419421147373?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -11255,7 +11255,6 @@ static int vmx_check_nested_events(struc
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
 
