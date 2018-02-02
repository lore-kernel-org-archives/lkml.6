Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225arm1Ov7t33MuY19tatVA3CA4I0W8K5yGJQsCwcw8TdSDfpOSxJ+q1sE6RWmbpK82RQeux
ARC-Seal: i=1; a=rsa-sha256; t=1517591580; cv=none;
        d=google.com; s=arc-20160816;
        b=ci5FRCAyqeHiYmY51U8+qMtZBTSnq5fZhT/cw2i8Es7mXjmsK9XZYjbDGr8WgsLy2x
         Rv1PWQP0fJkdh3VRsvTCP4+ZX7bJ3vAaNS8Ogbsn4C57gUt6JtsjeSXpR+TGDziDBHHe
         f/24VOaRwcgD5THZ3xy1+gFnsKmbsWlD+FL1VyQQyUj22zXT1sJ3ZL364uBO7XZ8bNaA
         xhPu/IB8DjfL07jNTzRFOFmoCqcX42jfBU3lC/q6GhQdP9dlMko3+U6AZtAPsGw0WP4C
         Y+Eml/K1uSCctyJ8xvyNYv6cDy6z+IVB8c7F44m6ES0qDJrrws2U2bWhpG/GiyYWZyID
         qSkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gKJrYxE7dX+TQthzbQnbxApgMoxyVjuxuKUZzQg46jE=;
        b=Gc5FE8p5Z6fjvsJczLzBg2fc6z8+MDEB5bK8ZnjgKumxJFMqiIL0MM0IUK005q6xnv
         2pkcEBryXiRttffRZn3yYfXEA9QYmo0RfYJvu/RABWnrpAsPdgrF5rHzQEy/S2yywqb8
         StGcdVbzswG0QASN3OP/3QB1MuUfRZAozMKXRsZXIGtvHRGq7JeFJFaf23ZqN3MBki+f
         5yK4UVpcDg5FMWvHfkidKYCueoUCQ40ArVFBOfp3ksyz7FtanIqZvpmrS1gwmaUndLxU
         bCZZjvfNm6j3fF4sWnnAFR0qFzZKsgGZqyGbmXZlRUYEYZ/XhkRN502HHFbpgkYNVhHQ
         Ibzw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jim Mattson <jmattson@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 128/156] KVM: x86: emulate #UD while in guest mode
Date: Fri,  2 Feb 2018 17:58:29 +0100
Message-Id: <20180202140846.162276178@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591310109198616337?=
X-GMAIL-MSGID: =?utf-8?q?1591310109198616337?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>


[ Upstream commit bd89525a823ce6edddcedbe9aed79faa1b9cf544 ]

This reverts commits ae1f57670703656cc9f293722c3b8b6782f8ab3f
and ac9b305caa0df6f5b75d294e4b86c1027648991e.

If the hardware doesn't support MOVBE, but L0 sets CPUID.01H:ECX.MOVBE
in L1's emulated CPUID information, then L1 is likely to pass that
CPUID bit through to L2. L2 will expect MOVBE to work, but if L1
doesn't intercept #UD, then any MOVBE instruction executed in L2 will
raise #UD, and the exception will be delivered in L2.

Commit ac9b305caa0df6f5b75d294e4b86c1027648991e is a better and more
complete version of ae1f57670703 ("KVM: nVMX: Do not emulate #UD while
in guest mode"); however, neither considers the above case.

Suggested-by: Jim Mattson <jmattson@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm.c |    9 +--------
 arch/x86/kvm/vmx.c |    5 +----
 2 files changed, 2 insertions(+), 12 deletions(-)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -362,7 +362,6 @@ static void recalc_intercepts(struct vcp
 {
 	struct vmcb_control_area *c, *h;
 	struct nested_state *g;
-	u32 h_intercept_exceptions;
 
 	mark_dirty(svm->vmcb, VMCB_INTERCEPTS);
 
@@ -373,14 +372,9 @@ static void recalc_intercepts(struct vcp
 	h = &svm->nested.hsave->control;
 	g = &svm->nested;
 
-	/* No need to intercept #UD if L1 doesn't intercept it */
-	h_intercept_exceptions =
-		h->intercept_exceptions & ~(1U << UD_VECTOR);
-
 	c->intercept_cr = h->intercept_cr | g->intercept_cr;
 	c->intercept_dr = h->intercept_dr | g->intercept_dr;
-	c->intercept_exceptions =
-		h_intercept_exceptions | g->intercept_exceptions;
+	c->intercept_exceptions = h->intercept_exceptions | g->intercept_exceptions;
 	c->intercept = h->intercept | g->intercept;
 }
 
@@ -2195,7 +2189,6 @@ static int ud_interception(struct vcpu_s
 {
 	int er;
 
-	WARN_ON_ONCE(is_guest_mode(&svm->vcpu));
 	er = emulate_instruction(&svm->vcpu, EMULTYPE_TRAP_UD);
 	if (er == EMULATE_USER_EXIT)
 		return 0;
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1891,7 +1891,7 @@ static void update_exception_bitmap(stru
 {
 	u32 eb;
 
-	eb = (1u << PF_VECTOR) | (1u << MC_VECTOR) |
+	eb = (1u << PF_VECTOR) | (1u << UD_VECTOR) | (1u << MC_VECTOR) |
 	     (1u << DB_VECTOR) | (1u << AC_VECTOR);
 	if ((vcpu->guest_debug &
 	     (KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP)) ==
@@ -1909,8 +1909,6 @@ static void update_exception_bitmap(stru
 	 */
 	if (is_guest_mode(vcpu))
 		eb |= get_vmcs12(vcpu)->exception_bitmap;
-	else
-		eb |= 1u << UD_VECTOR;
 
 	vmcs_write32(EXCEPTION_BITMAP, eb);
 }
@@ -5921,7 +5919,6 @@ static int handle_exception(struct kvm_v
 		return 1;  /* already handled by vmx_vcpu_run() */
 
 	if (is_invalid_opcode(intr_info)) {
-		WARN_ON_ONCE(is_guest_mode(vcpu));
 		er = emulate_instruction(vcpu, EMULTYPE_TRAP_UD);
 		if (er == EMULATE_USER_EXIT)
 			return 0;
