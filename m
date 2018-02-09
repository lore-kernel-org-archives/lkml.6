Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227eMnJXMG9hsPMDVOpeb2oe90Rl8ehtAzBp73L5dEkR+BTFKUTk4HUXLOdAE/2apxN9Yjqg
ARC-Seal: i=1; a=rsa-sha256; t=1518183836; cv=none;
        d=google.com; s=arc-20160816;
        b=bcQ6ESwpIszBuqwIDBIgPs5EWbsnoL+DH3JVHX0mCDUX7Fom/cesLTvFUnvsADSThy
         +yRZrL8TXFoFnjZzjVzw7HevURCeXWxnIKOt0IzS+V8Lc7zuc/twGO7HcH4M3SJVIXF7
         FSNMI7D52QF62sSp9Y73eCMVe2xY6XJUfGE9gCunt0MC83+TUOW02kUZl8uh+crUy4Ai
         zLlbvMY8Oj7UPYjGtO5VvRPNiH9y4Yilubp1nRsM0MRYPQ/3PsJ92Kg3gUm5iBybXIAm
         cZAUNebgf9UaEja0LILCPYBW+vmTwR9OdTWQfP+g2uqR+BJkmfhl+q3muntbA3f5KBJg
         J4Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=te5TFzDHaj8Gm/NjD+rgWgMB7ZpBcpkihyzRJRktL5M=;
        b=rqW/6ps7zCdLjb6caCRTXWTJjCv/Wv3EtveoS2CJDMAvPwlShSxcNwBf/F92BuHJUI
         BeSN2+aLE7lVfMGYp+zvmBvxJwoabhv2JOh5E6RzTdnik0OjCwjdq+aEb+XDIarHCr5Y
         jvcDyD73daOJaQc2YsgpTqHn4WsfOaMY80vgdJIEZGoyB6OiMCJuHiOTsNK9X+MWF8Gh
         TDPUpRAxMGU7grAeAlSNEJw+aKhLxsJsgN9Wyc9O+oFD9jq553y/sRaGcY5bBV5uSalg
         1cVkV+1kPczo22DybDf4wa+u3PdBrLHuZeQU+x50Dsw0Mvth5wQv1X0IdPYjgVHkGcy0
         dMUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Matlack <dmatlack@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 78/92] KVM: nVMX: mark vmcs12 pages dirty on L2 exit
Date: Fri,  9 Feb 2018 14:39:47 +0100
Message-Id: <20180209133936.840471945@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591931135242307815?=
X-GMAIL-MSGID: =?utf-8?q?1591931135242307815?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Matlack <dmatlack@google.com>


(cherry picked from commit c9f04407f2e0b3fc9ff7913c65fcfcb0a4b61570)

The host physical addresses of L1's Virtual APIC Page and Posted
Interrupt descriptor are loaded into the VMCS02. The CPU may write
to these pages via their host physical address while L2 is running,
bypassing address-translation-based dirty tracking (e.g. EPT write
protection). Mark them dirty on every exit from L2 to prevent them
from getting out of sync with dirty tracking.

Also mark the virtual APIC page and the posted interrupt descriptor
dirty when KVM is virtualizing posted interrupt processing.

Signed-off-by: David Matlack <dmatlack@google.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |   53 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 10 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -4736,6 +4736,28 @@ static bool vmx_get_enable_apicv(void)
 	return enable_apicv;
 }
 
+static void nested_mark_vmcs12_pages_dirty(struct kvm_vcpu *vcpu)
+{
+	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
+	gfn_t gfn;
+
+	/*
+	 * Don't need to mark the APIC access page dirty; it is never
+	 * written to by the CPU during APIC virtualization.
+	 */
+
+	if (nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW)) {
+		gfn = vmcs12->virtual_apic_page_addr >> PAGE_SHIFT;
+		kvm_vcpu_mark_page_dirty(vcpu, gfn);
+	}
+
+	if (nested_cpu_has_posted_intr(vmcs12)) {
+		gfn = vmcs12->posted_intr_desc_addr >> PAGE_SHIFT;
+		kvm_vcpu_mark_page_dirty(vcpu, gfn);
+	}
+}
+
+
 static void vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -4743,18 +4765,15 @@ static void vmx_complete_nested_posted_i
 	void *vapic_page;
 	u16 status;
 
-	if (vmx->nested.pi_desc &&
-	    vmx->nested.pi_pending) {
-		vmx->nested.pi_pending = false;
-		if (!pi_test_and_clear_on(vmx->nested.pi_desc))
-			return;
-
-		max_irr = find_last_bit(
-			(unsigned long *)vmx->nested.pi_desc->pir, 256);
+	if (!vmx->nested.pi_desc || !vmx->nested.pi_pending)
+		return;
 
-		if (max_irr == 256)
-			return;
+	vmx->nested.pi_pending = false;
+	if (!pi_test_and_clear_on(vmx->nested.pi_desc))
+		return;
 
+	max_irr = find_last_bit((unsigned long *)vmx->nested.pi_desc->pir, 256);
+	if (max_irr != 256) {
 		vapic_page = kmap(vmx->nested.virtual_apic_page);
 		__kvm_apic_update_irr(vmx->nested.pi_desc->pir, vapic_page);
 		kunmap(vmx->nested.virtual_apic_page);
@@ -4766,6 +4785,8 @@ static void vmx_complete_nested_posted_i
 			vmcs_write16(GUEST_INTR_STATUS, status);
 		}
 	}
+
+	nested_mark_vmcs12_pages_dirty(vcpu);
 }
 
 static inline bool kvm_vcpu_trigger_posted_interrupt(struct kvm_vcpu *vcpu)
@@ -8022,6 +8043,18 @@ static bool nested_vmx_exit_handled(stru
 				vmcs_read32(VM_EXIT_INTR_ERROR_CODE),
 				KVM_ISA_VMX);
 
+	/*
+	 * The host physical addresses of some pages of guest memory
+	 * are loaded into VMCS02 (e.g. L1's Virtual APIC Page). The CPU
+	 * may write to these pages via their host physical address while
+	 * L2 is running, bypassing any address-translation-based dirty
+	 * tracking (e.g. EPT write protection).
+	 *
+	 * Mark them dirty on every exit from L2 to prevent them from
+	 * getting out of sync with dirty tracking.
+	 */
+	nested_mark_vmcs12_pages_dirty(vcpu);
+
 	if (vmx->nested.nested_run_pending)
 		return false;
 
