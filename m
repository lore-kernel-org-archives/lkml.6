Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D75C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9992077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9992077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbeICVho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:37:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42614 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbeICVhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:37:43 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 419FAD02;
        Mon,  3 Sep 2018 17:16:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 031/165] KVM: vmx: use local variable for current_vmptr when emulating VMPTRST
Date:   Mon,  3 Sep 2018 18:55:17 +0200
Message-Id: <20180903165656.655632955@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
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

From: Sean Christopherson <sean.j.christopherson@intel.com>

[ Upstream commit 0a06d4256674c4e041945b52044941995fee237d ]

Do not expose the address of vmx->nested.current_vmptr to
kvm_write_guest_virt_system() as the resulting __copy_to_user()
call will trigger a WARN when CONFIG_HARDENED_USERCOPY is
enabled.

Opportunistically clean up variable names in handle_vmptrst()
to improve readability, e.g. vmcs_gva is misleading as the
memory operand of VMPTRST is plain memory, not a VMCS.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Tested-by: Peter Shier <pshier@google.com>
Reviewed-by: Peter Shier <pshier@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8108,21 +8108,20 @@ static int handle_vmptrld(struct kvm_vcp
 /* Emulate the VMPTRST instruction */
 static int handle_vmptrst(struct kvm_vcpu *vcpu)
 {
-	unsigned long exit_qualification = vmcs_readl(EXIT_QUALIFICATION);
-	u32 vmx_instruction_info = vmcs_read32(VMX_INSTRUCTION_INFO);
-	gva_t vmcs_gva;
+	unsigned long exit_qual = vmcs_readl(EXIT_QUALIFICATION);
+	u32 instr_info = vmcs_read32(VMX_INSTRUCTION_INFO);
+	gpa_t current_vmptr = to_vmx(vcpu)->nested.current_vmptr;
 	struct x86_exception e;
+	gva_t gva;
 
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
-	if (get_vmx_mem_address(vcpu, exit_qualification,
-			vmx_instruction_info, true, &vmcs_gva))
+	if (get_vmx_mem_address(vcpu, exit_qual, instr_info, true, &gva))
 		return 1;
 	/* *_system ok, nested_vmx_check_permission has verified cpl=0 */
-	if (kvm_write_guest_virt_system(vcpu, vmcs_gva,
-					(void *)&to_vmx(vcpu)->nested.current_vmptr,
-					sizeof(u64), &e)) {
+	if (kvm_write_guest_virt_system(vcpu, gva, (void *)&current_vmptr,
+					sizeof(gpa_t), &e)) {
 		kvm_inject_page_fault(vcpu, &e);
 		return 1;
 	}


