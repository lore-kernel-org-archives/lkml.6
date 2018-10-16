Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70618C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E1D20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnZn/K4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E1D20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbeJPMUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728409AbeJPMBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3357C21471;
        Tue, 16 Oct 2018 04:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663195;
        bh=VOk32B2Ang7eBz1Zr3HzwXCW8RGBtdXBRNQiaZX4q4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mnZn/K4/vsocS1i21pDwu1J2dkCDhuRtrtOSto03hfS2mC37nEeJXPQtfOCBVn9Ku
         hMcrQTKPpV5jwkx4oGRuA7oYeuVUl3ifa3Q62gQLQwD1qVWBfSDiDpOPEjyuShOIrf
         15li2SQqJdNKk9uhFvevFXjKY3tHA1XPD0hwQY38=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Liran Alon <liran.alon@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 059/100] KVM: nVMX: Fix emulation of VM_ENTRY_LOAD_BNDCFGS
Date:   Tue, 16 Oct 2018 00:11:40 -0400
Message-Id: <20181016041221.135528-59-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liran Alon <liran.alon@oracle.com>

[ Upstream commit 62cf9bd8118c4009f02c477ef78c723f49e53e16 ]

L2 IA32_BNDCFGS should be updated with vmcs12->guest_bndcfgs only
when VM_ENTRY_LOAD_BNDCFGS is specified in vmcs12->vm_entry_controls.

Otherwise, L2 IA32_BNDCFGS should be set to vmcs01->guest_bndcfgs which
is L1 IA32_BNDCFGS.

Reviewed-by: Nikita Leshchenko <nikita.leshchenko@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 2e23fce5eb1f..9efe130ea2e6 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -819,6 +819,7 @@ struct nested_vmx {
 
 	/* to migrate it to L2 if VM_ENTRY_LOAD_DEBUG_CONTROLS is off */
 	u64 vmcs01_debugctl;
+	u64 vmcs01_guest_bndcfgs;
 
 	u16 vpid02;
 	u16 last_vpid;
@@ -11567,8 +11568,13 @@ static void prepare_vmcs02_full(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12)
 
 	set_cr4_guest_host_mask(vmx);
 
-	if (kvm_mpx_supported())
-		vmcs_write64(GUEST_BNDCFGS, vmcs12->guest_bndcfgs);
+	if (kvm_mpx_supported()) {
+		if (vmx->nested.nested_run_pending &&
+			(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS))
+			vmcs_write64(GUEST_BNDCFGS, vmcs12->guest_bndcfgs);
+		else
+			vmcs_write64(GUEST_BNDCFGS, vmx->nested.vmcs01_guest_bndcfgs);
+	}
 
 	if (enable_vpid) {
 		if (nested_cpu_has_vpid(vmcs12) && vmx->nested.vpid02)
@@ -12082,6 +12088,9 @@ static int enter_vmx_non_root_mode(struct kvm_vcpu *vcpu)
 
 	if (!(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS))
 		vmx->nested.vmcs01_debugctl = vmcs_read64(GUEST_IA32_DEBUGCTL);
+	if (kvm_mpx_supported() &&
+		!(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS))
+		vmx->nested.vmcs01_guest_bndcfgs = vmcs_read64(GUEST_BNDCFGS);
 
 	vmx_switch_vmcs(vcpu, &vmx->nested.vmcs02);
 	vmx_segment_cache_clear(vmx);
-- 
2.17.1

