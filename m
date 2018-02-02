Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224onnmIjabCKEMupf8EFqgxpIJe1mIiZPHUasd4vDxHH1Y6L3QEsOvoWmbdX3QkEQ1axees
ARC-Seal: i=1; a=rsa-sha256; t=1517591412; cv=none;
        d=google.com; s=arc-20160816;
        b=XKGx2x84fJ1/6ZkmV+uaIZnZ0H6KHA+CI2+9wFsG9THfd9swEJHiJfPs/FaTQRZO49
         WUXEXjT5/rUaaiBFdUE5DDrtAiq9LB3xlEwdTW679G0bVwMnOxISf0YbaCZj/2nWP1J5
         KSkyeYVB4VHzXiCG40NHupNpUwr01kffnfoNkdx3Jv6CJ5sAAaBDyX9JpjDGKA9gfy2v
         mDbSAwUGhqj1kFWaXK3hDXm9X516GBvy/rwSByQilZMeDNl933Bl7FN3qT6SeS1WOeZ6
         KbeBcP/OBND4/0zZNCocKsRFBVA8K/3sJ38SJ5SoLdBlhMSNHs2MbQH51cQJBcJBbE4L
         11qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZxqOvjEEN5x5S5ppgGSqLaNjETdqAp71JM2rj7ppSNc=;
        b=qCo6F9mcWTcuKX8qy0UHNDuc/7z/0WbXq8wQcD6L/2U0dyTv4pt3/k9Z7EnQOftWOX
         5zyjnqjMyWunMISu+1M0MPjNhdCkazVgmBTu2QKA6cfRtjhF8JL2zHgiwihO2hJfLE5p
         COMLjkUfKvV9rdPEIZKw3bda6aP+Vlmh8ZGslfS+3XCPrmD1e+FsEydj9h2qfLPNMVW/
         sKHDPzlb5803lbBcFtCcxndu1NjEwZeVSZw18hX8l8440nbwVHOJCPoqsILroqSgYoL0
         cBXNsqXWL8kvzcPu20iBSbXgLjSr/UpABLNwIDSHZCCzcP2w0JZmpma92lmp+SNim0DX
         OrUA==
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
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wanpeng Li <wanpeng.li@hotmail.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 036/156] KVM: nVMX/nSVM: Dont intercept #UD when running L2
Date: Fri,  2 Feb 2018 17:56:57 +0100
Message-Id: <20180202140841.939284771@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309933569328457?=
X-GMAIL-MSGID: =?utf-8?q?1591309933569328457?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liran Alon <liran.alon@oracle.com>


[ Upstream commit ac9b305caa0df6f5b75d294e4b86c1027648991e ]

When running L2, #UD should be intercepted by L1 or just forwarded
directly to L2. It should not reach L0 x86 emulator.
Therefore, set intercept for #UD only based on L1 exception-bitmap.

Also add WARN_ON_ONCE() on L0 #UD intercept handlers to make sure
it is never reached while running L2.

This improves commit ae1f57670703 ("KVM: nVMX: Do not emulate #UD while
in guest mode") by removing an unnecessary exit from L2 to L0 on #UD
when L1 doesn't intercept it.

In addition, SVM L0 #UD intercept handler doesn't handle correctly the
case it is raised from L2. In this case, it should forward the #UD to
guest instead of x86 emulator. As done in VMX #UD intercept handler.
This commit fixes this issue as-well.

Signed-off-by: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Wanpeng Li <wanpeng.li@hotmail.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm.c |    9 ++++++++-
 arch/x86/kvm/vmx.c |    9 ++++-----
 2 files changed, 12 insertions(+), 6 deletions(-)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -362,6 +362,7 @@ static void recalc_intercepts(struct vcp
 {
 	struct vmcb_control_area *c, *h;
 	struct nested_state *g;
+	u32 h_intercept_exceptions;
 
 	mark_dirty(svm->vmcb, VMCB_INTERCEPTS);
 
@@ -372,9 +373,14 @@ static void recalc_intercepts(struct vcp
 	h = &svm->nested.hsave->control;
 	g = &svm->nested;
 
+	/* No need to intercept #UD if L1 doesn't intercept it */
+	h_intercept_exceptions =
+		h->intercept_exceptions & ~(1U << UD_VECTOR);
+
 	c->intercept_cr = h->intercept_cr | g->intercept_cr;
 	c->intercept_dr = h->intercept_dr | g->intercept_dr;
-	c->intercept_exceptions = h->intercept_exceptions | g->intercept_exceptions;
+	c->intercept_exceptions =
+		h_intercept_exceptions | g->intercept_exceptions;
 	c->intercept = h->intercept | g->intercept;
 }
 
@@ -2189,6 +2195,7 @@ static int ud_interception(struct vcpu_s
 {
 	int er;
 
+	WARN_ON_ONCE(is_guest_mode(&svm->vcpu));
 	er = emulate_instruction(&svm->vcpu, EMULTYPE_TRAP_UD);
 	if (er == EMULATE_USER_EXIT)
 		return 0;
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1891,7 +1891,7 @@ static void update_exception_bitmap(stru
 {
 	u32 eb;
 
-	eb = (1u << PF_VECTOR) | (1u << UD_VECTOR) | (1u << MC_VECTOR) |
+	eb = (1u << PF_VECTOR) | (1u << MC_VECTOR) |
 	     (1u << DB_VECTOR) | (1u << AC_VECTOR);
 	if ((vcpu->guest_debug &
 	     (KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP)) ==
@@ -1909,6 +1909,8 @@ static void update_exception_bitmap(stru
 	 */
 	if (is_guest_mode(vcpu))
 		eb |= get_vmcs12(vcpu)->exception_bitmap;
+	else
+		eb |= 1u << UD_VECTOR;
 
 	vmcs_write32(EXCEPTION_BITMAP, eb);
 }
@@ -5919,10 +5921,7 @@ static int handle_exception(struct kvm_v
 		return 1;  /* already handled by vmx_vcpu_run() */
 
 	if (is_invalid_opcode(intr_info)) {
-		if (is_guest_mode(vcpu)) {
-			kvm_queue_exception(vcpu, UD_VECTOR);
-			return 1;
-		}
+		WARN_ON_ONCE(is_guest_mode(vcpu));
 		er = emulate_instruction(vcpu, EMULTYPE_TRAP_UD);
 		if (er == EMULATE_USER_EXIT)
 			return 0;
