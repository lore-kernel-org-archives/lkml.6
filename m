Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1FBC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F56208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F56208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966782AbeFRJMd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:12:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33482 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966838AbeFRI3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:29:42 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5C7D7BBE;
        Mon, 18 Jun 2018 08:29:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mihai Carabas <mihai.carabas@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 004/189] x86: Add check for APIC access address for vmentry of L2 guests
Date:   Mon, 18 Jun 2018 10:11:40 +0200
Message-Id: <20180618081209.425381814@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krish Sadhukhan <krish.sadhukhan@oracle.com>

[ Upstream commit f0f4cf5b306620282db0c59ff963012e1973e025 ]

According to the sub-section titled 'VM-Execution Control Fields' in the
section titled 'Basic VM-Entry Checks' in Intel SDM vol. 3C, the following
vmentry check must be enforced:

    If the 'virtualize APIC-accesses' VM-execution control is 1, the
    APIC-access address must satisfy the following checks:

	- Bits 11:0 of the address must be 0.
	- The address should not set any bits beyond the processor's
	  physical-address width.

This patch adds the necessary check to conform to this rule. If the check
fails, we cause the L2 VMENTRY to fail which is what the associated unit
test (following patch) expects.

Reviewed-by: Mihai Carabas <mihai.carabas@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Wanpeng Li <wanpengli@tencent.com>
Signed-off-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -10318,6 +10318,16 @@ static inline bool nested_vmx_merge_msr_
 	return true;
 }
 
+static int nested_vmx_check_apic_access_controls(struct kvm_vcpu *vcpu,
+					  struct vmcs12 *vmcs12)
+{
+	if (nested_cpu_has2(vmcs12, SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES) &&
+	    !page_address_valid(vcpu, vmcs12->apic_access_addr))
+		return -EINVAL;
+	else
+		return 0;
+}
+
 static int nested_vmx_check_apicv_controls(struct kvm_vcpu *vcpu,
 					   struct vmcs12 *vmcs12)
 {
@@ -10961,6 +10971,9 @@ static int check_vmentry_prereqs(struct
 	if (nested_vmx_check_msr_bitmap_controls(vcpu, vmcs12))
 		return VMXERR_ENTRY_INVALID_CONTROL_FIELD;
 
+	if (nested_vmx_check_apic_access_controls(vcpu, vmcs12))
+		return VMXERR_ENTRY_INVALID_CONTROL_FIELD;
+
 	if (nested_vmx_check_tpr_shadow_controls(vcpu, vmcs12))
 		return VMXERR_ENTRY_INVALID_CONTROL_FIELD;
 


