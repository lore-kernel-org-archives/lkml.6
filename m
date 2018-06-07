Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 656QDwdJGVvaSwAAmS7hNA
	; Thu, 07 Jun 2018 15:19:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 23CE1607E7; Thu,  7 Jun 2018 15:19:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7C1C8606DD;
	Thu,  7 Jun 2018 15:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7C1C8606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935433AbeFGPTx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:19:53 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41275 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935647AbeFGO71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:59:27 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvby-0005Zs-3E; Thu, 07 Jun 2018 15:09:58 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvaz-0002kB-37; Thu, 07 Jun 2018 15:08:57 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>,
        "David Matlack" <dmatlack@google.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Paolo Bonzini" <pbonzini@redhat.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.775362726@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 051/410] KVM: nVMX: mark vmcs12 pages dirty on L2 exit
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Matlack <dmatlack@google.com>

commit c9f04407f2e0b3fc9ff7913c65fcfcb0a4b61570 upstream.

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
[bwh: Backported to 3.16:
 - No nested posted interrupt support
 - No SMM support, so use mark_page_dirty() instead of
   kvm_vcpu_mark_page_dirty()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/vmx.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -4197,6 +4197,23 @@ static int vmx_vm_has_apicv(struct kvm *
 	return enable_apicv && irqchip_in_kernel(kvm);
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
+		mark_page_dirty(vcpu->kvm, gfn);
+	}
+}
+
+
 /*
  * Send interrupt to vcpu via posted interrupt way.
  * 1. If target vcpu is running(non-root mode), send posted interrupt
@@ -6902,6 +6919,18 @@ static bool nested_vmx_exit_handled(stru
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
 		return 0;
 
