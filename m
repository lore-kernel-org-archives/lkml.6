Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227eQi9P7i0dc46EhNwf9U9/QFtNCgaYWPKseUl27ZxppWgs7MU58lnpo8FPDMw34n8LrnQx
ARC-Seal: i=1; a=rsa-sha256; t=1517591337; cv=none;
        d=google.com; s=arc-20160816;
        b=Y9skgBWLRb9u7AoL/CmSC2h8XrS5yuUKMME038m8DOQ5Hd74q6mPcFwM2xHqrGlaZk
         0/FpFdhI+7JSyBM2rKxfbNn1uXUnueH0sK7VSQe5tEwz2epWbTctPo4Hhl5SRO8M0ZFl
         tYaGrcATtXsGgQh+paV+BuvjAnjbfjC+2+nU3kSbWc5QsgsZQnLeGX7XGFqlt02MRP5C
         5VlVRB450FcoftIh5aUvJ4R/GTlu/tb0j2pd3blKMC1y+Rfg/zJSlyQ5r5npenoIgjfD
         mCFvHngFZ9W0/u2xGTObsL6j3tvcTyJEtY6nlNWk9kSsS4LjIYho3XF4IOUnK2hjXpjk
         MfSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WtZprEMj/f57cEZcprQO4WoD5VvJAiIpEWT1bGXlfPk=;
        b=d+7LQVDM8A53OwAwuJLu1YdlktL7X+4PsrSL2csIPx0tF2XHAN0F8tHNdQK73r1XWz
         8aWRQ+Td9OWglevA9qlf5XJAZ6oClrpwM0aR6k1ldceQ4ZQ8G0+jyPELY9dnkGlYcmDx
         fREiuz319cXJ1WtIyVJjKE4Q6N7N3+mYlYwrF9dhoXSdCFBl6f64SFFUk52SKgGxTD8B
         3RB8t9TgVRsNiHYbhajFY/sRMQPqMj2mg86hxXUTlwpHuV8Fewca4RQPSayfrrhSaSlR
         VbRCx6EAPdTqYAotR3qlB4Ihl/TGljmUe8cJ+Ou/1t455fNdYelQjCJEIGZA8s7GijLv
         uEiA==
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
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 045/156] KVM: nVMX: Fix vmx_check_nested_events() return value in case an event was reinjected to L2
Date: Fri,  2 Feb 2018 17:57:06 +0100
Message-Id: <20180202140842.322762383@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309854257962058?=
X-GMAIL-MSGID: =?utf-8?q?1591309854257962058?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liran Alon <liran.alon@oracle.com>


[ Upstream commit 917dc6068bc12a2dafffcf0e9d405ddb1b8780cb ]

vmx_check_nested_events() should return -EBUSY only in case there is a
pending L1 event which requires a VMExit from L2 to L1 but such a
VMExit is currently blocked. Such VMExits are blocked either
because nested_run_pending=1 or an event was reinjected to L2.
vmx_check_nested_events() should return 0 in case there are no
pending L1 events which requires a VMExit from L2 to L1 or if
a VMExit from L2 to L1 was done internally.

However, upstream commit which introduced blocking in case an event was
reinjected to L2 (commit acc9ab601327 ("KVM: nVMX: Fix pending events
injection")) contains a bug: It returns -EBUSY even if there are no
pending L1 events which requires VMExit from L2 to L1.

This commit fix this issue.

Fixes: acc9ab601327 ("KVM: nVMX: Fix pending events injection")

Signed-off-by: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11114,13 +11114,12 @@ static int vmx_check_nested_events(struc
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	unsigned long exit_qual;
-
-	if (kvm_event_needs_reinjection(vcpu))
-		return -EBUSY;
+	bool block_nested_events =
+	    vmx->nested.nested_run_pending || kvm_event_needs_reinjection(vcpu);
 
 	if (vcpu->arch.exception.pending &&
 		nested_vmx_check_exception(vcpu, &exit_qual)) {
-		if (vmx->nested.nested_run_pending)
+		if (block_nested_events)
 			return -EBUSY;
 		nested_vmx_inject_exception_vmexit(vcpu, exit_qual);
 		vcpu->arch.exception.pending = false;
@@ -11129,14 +11128,14 @@ static int vmx_check_nested_events(struc
 
 	if (nested_cpu_has_preemption_timer(get_vmcs12(vcpu)) &&
 	    vmx->nested.preemption_timer_expired) {
-		if (vmx->nested.nested_run_pending)
+		if (block_nested_events)
 			return -EBUSY;
 		nested_vmx_vmexit(vcpu, EXIT_REASON_PREEMPTION_TIMER, 0, 0);
 		return 0;
 	}
 
 	if (vcpu->arch.nmi_pending && nested_exit_on_nmi(vcpu)) {
-		if (vmx->nested.nested_run_pending)
+		if (block_nested_events)
 			return -EBUSY;
 		nested_vmx_vmexit(vcpu, EXIT_REASON_EXCEPTION_NMI,
 				  NMI_VECTOR | INTR_TYPE_NMI_INTR |
@@ -11152,7 +11151,7 @@ static int vmx_check_nested_events(struc
 
 	if ((kvm_cpu_has_interrupt(vcpu) || external_intr) &&
 	    nested_exit_on_intr(vcpu)) {
-		if (vmx->nested.nested_run_pending)
+		if (block_nested_events)
 			return -EBUSY;
 		nested_vmx_vmexit(vcpu, EXIT_REASON_EXTERNAL_INTERRUPT, 0, 0);
 		return 0;
