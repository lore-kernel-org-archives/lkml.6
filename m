Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20CBC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6576821486
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789172;
	bh=CNc93kexL0wvXYlx1b4oHvkLU56jpPfC+KwzFsAJIfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EPoptM2ab/F9N0DsIR4VVckbQwfcRkk4csubrQonpLnreSYgHCaW0ebEGVPoBOgNO
	 VQWtXE+pAczxBrNsHrf6wJTw3qP42cfjTO0tdqakHUI5B0OkM/lcTdARJUYs8a2RFq
	 sVRuWNBfSsEF1fqf83R7FATAcxJCl6H4A772NZfc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6576821486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbeLNMGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:06:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:51082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730055AbeLNMGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:06:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EDA02148E;
        Fri, 14 Dec 2018 12:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789166;
        bh=CNc93kexL0wvXYlx1b4oHvkLU56jpPfC+KwzFsAJIfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xOCfHGqhHYN71l0XNsbUzFYgWE5jrVr97eZGG9Wy35yJlG5ICMz4DgnyBK73Z4zLb
         mLAo/P7Qnnn6x3h/jQQ1QNjHS323wcPZvFcPQ5kgx5Q3huQXKFcunxd0/kIVG0h3sd
         D1ZDpkXs7qhf96GifAz1eiLrreP9zikIyq14mk6U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eyal Moscovici <eyal.moscovici@oracle.com>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 097/142] KVM: VMX: Update shared MSRs to be saved/restored on MSR_EFER.LMA changes
Date:   Fri, 14 Dec 2018 12:59:42 +0100
Message-Id: <20181214115750.936421427@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index e55f7a90d4b2..b1aef90aab91 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -962,6 +962,7 @@ struct vcpu_vmx {
 	struct shared_msr_entry *guest_msrs;
 	int                   nmsrs;
 	int                   save_nmsrs;
+	bool                  guest_msrs_dirty;
 	unsigned long	      host_idt_base;
 #ifdef CONFIG_X86_64
 	u64 		      msr_host_kernel_gs_base;
@@ -2874,6 +2875,20 @@ static void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 
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
 
@@ -2934,11 +2949,6 @@ static void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
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
@@ -3418,6 +3428,7 @@ static void setup_msrs(struct vcpu_vmx *vmx)
 		move_msr_up(vmx, index, save_nmsrs++);
 
 	vmx->save_nmsrs = save_nmsrs;
+	vmx->guest_msrs_dirty = true;
 
 	if (cpu_has_vmx_msr_bitmap())
 		vmx_update_msr_bitmap(&vmx->vcpu);
-- 
2.19.1



