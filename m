Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE6AC07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A2920879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiVKxLlq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A2920879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbeLEJkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:40:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:44834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728677AbeLEJkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:40:31 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6898E2084C;
        Wed,  5 Dec 2018 09:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002830;
        bh=2TQV0LggHimhLzBgkC++Ytj6lTiuG32OTzBqf4G2nS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OiVKxLlqJxCw/m9xoI+JpejEKieqyuM/DgHq7LZvOfVGFzD3ehq5leIm0s6Nc0vP8
         RItyWQ2PwU9psGlBxkAXVoeWcOhlG1pm6moQlYlNCPVdv7msiNDCIf3Tfh8bVXlcOU
         lWzpXpF73OyN7yIrKPyJZPHj2WF+1Btwzn8V80VU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Liran Alon <liran.alon@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 080/123] KVM: VMX: Update shared MSRs to be saved/restored on MSR_EFER.LMA changes
Date:   Wed,  5 Dec 2018 04:35:12 -0500
Message-Id: <20181205093555.5386-80-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liran Alon <liran.alon@oracle.com>

[ Upstream commit f48b4711dd6e1cf282f9dfd159c14a305909c97c ]

When guest transitions from/to long-mode by modifying MSR_EFER.LMA,
the list of shared MSRs to be saved/restored on guest<->host
transitions is updated (See vmx_set_efer() call to setup_msrs()).

On every entry to guest, vcpu_enter_guest() calls
vmx_prepare_switch_to_guest(). This function should also take care
of setting the shared MSRs to be saved/restored. However, the
function does nothing in case we are already running with loaded
guest state (vmx->loaded_cpu_state != NULL).

This means that even when guest modifies MSR_EFER.LMA which results
in updating the list of shared MSRs, it isn't being taken into account
by vmx_prepare_switch_to_guest() because it happens while we are
running with loaded guest state.

To fix above mentioned issue, add a flag to mark that the list of
shared MSRs has been updated and modify vmx_prepare_switch_to_guest()
to set shared MSRs when running with host state *OR* list of shared
MSRs has been updated.

Note that this issue was mistakenly introduced by commit
678e315e78a7 ("KVM: vmx: add dedicated utility to access guest's
kernel_gs_base") because previously vmx_set_efer() always called
vmx_load_host_state() which resulted in vmx_prepare_switch_to_guest() to
set shared MSRs.

Fixes: 678e315e78a7 ("KVM: vmx: add dedicated utility to access guest's kernel_gs_base")
Reported-by: Eyal Moscovici <eyal.moscovici@oracle.com>
Reviewed-by: Mihai Carabas <mihai.carabas@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 9f3def7baa6d..bdd46628c107 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -961,6 +961,7 @@ struct vcpu_vmx {
 	struct shared_msr_entry *guest_msrs;
 	int                   nmsrs;
 	int                   save_nmsrs;
+	bool                  guest_msrs_dirty;
 	unsigned long	      host_idt_base;
 #ifdef CONFIG_X86_64
 	u64 		      msr_host_kernel_gs_base;
@@ -2873,6 +2874,20 @@ static void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 
 	vmx->req_immediate_exit = false;
 
+	/*
+	 * Note that guest MSRs to be saved/restored can also be changed
+	 * when guest state is loaded. This happens when guest transitions
+	 * to/from long-mode by setting MSR_EFER.LMA.
+	 */
+	if (!vmx->loaded_cpu_state || vmx->guest_msrs_dirty) {
+		vmx->guest_msrs_dirty = false;
+		for (i = 0; i < vmx->save_nmsrs; ++i)
+			kvm_set_shared_msr(vmx->guest_msrs[i].index,
+					   vmx->guest_msrs[i].data,
+					   vmx->guest_msrs[i].mask);
+
+	}
+
 	if (vmx->loaded_cpu_state)
 		return;
 
@@ -2933,11 +2948,6 @@ static void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 		vmcs_writel(HOST_GS_BASE, gs_base);
 		host_state->gs_base = gs_base;
 	}
-
-	for (i = 0; i < vmx->save_nmsrs; ++i)
-		kvm_set_shared_msr(vmx->guest_msrs[i].index,
-				   vmx->guest_msrs[i].data,
-				   vmx->guest_msrs[i].mask);
 }
 
 static void vmx_prepare_switch_to_host(struct vcpu_vmx *vmx)
@@ -3417,6 +3427,7 @@ static void setup_msrs(struct vcpu_vmx *vmx)
 		move_msr_up(vmx, index, save_nmsrs++);
 
 	vmx->save_nmsrs = save_nmsrs;
+	vmx->guest_msrs_dirty = true;
 
 	if (cpu_has_vmx_msr_bitmap())
 		vmx_update_msr_bitmap(&vmx->vcpu);
-- 
2.17.1

