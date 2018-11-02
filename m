Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9F8C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7E72082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFODRnJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7E72082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbeKCDsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:48:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbeKCDsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:48:32 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6476120837;
        Fri,  2 Nov 2018 18:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184021;
        bh=tE2YGbronOQbwIg/b2wu5kw65zwW2SZigPSBj7O1I5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IFODRnJNyJe39jkSplPbPytnlfnPK8FpLCiuWnjj6OsRGhSuP3AYpxkdsqLLkbNXH
         vMJ/yUgTskExqjrPxeHnWaidsCO7UlfxRlfB1deX0tU+TO7tf+jj/tyV1yaPgvorUt
         JCFVfddzid4ZQqE6Qoy7y7gj2VfKh86yPEcU0Z7I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nikita Leshchenko <nikita.leshchenko@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Liran Alon <liran.alon@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 052/150] KVM: nVMX: Fix emulation of VM_ENTRY_LOAD_BNDCFGS
Date:   Fri,  2 Nov 2018 19:33:34 +0100
Message-Id: <20181102182907.122700122@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



