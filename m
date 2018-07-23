Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188D3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D431620854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D431620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388322AbeGWN1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:27:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45194 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387882AbeGWN1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:27:12 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 859A0BD4;
        Mon, 23 Jul 2018 12:26:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Liran Alon <liran.alon@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.17 07/63] KVM: VMX: Mark VMXArea with revision_id of physical CPU even when eVMCS enabled
Date:   Mon, 23 Jul 2018 14:24:13 +0200
Message-Id: <20180723122446.654794759@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122446.351334162@linuxfoundation.org>
References: <20180723122446.351334162@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liran Alon <liran.alon@oracle.com>

commit 2307af1c4b2e0ad886f30e31739845322cbd328b upstream.

When eVMCS is enabled, all VMCS allocated to be used by KVM are marked
with revision_id of KVM_EVMCS_VERSION instead of revision_id reported
by MSR_IA32_VMX_BASIC.

However, even though not explictly documented by TLFS, VMXArea passed
as VMXON argument should still be marked with revision_id reported by
physical CPU.

This issue was found by the following setup:
* L0 = KVM which expose eVMCS to it's L1 guest.
* L1 = KVM which consume eVMCS reported by L0.
This setup caused the following to occur:
1) L1 execute hardware_enable().
2) hardware_enable() calls kvm_cpu_vmxon() to execute VMXON.
3) L0 intercept L1 VMXON and execute handle_vmon() which notes
vmxarea->revision_id != VMCS12_REVISION and therefore fails with
nested_vmx_failInvalid() which sets RFLAGS.CF.
4) L1 kvm_cpu_vmxon() don't check RFLAGS.CF for failure and therefore
hardware_enable() continues as usual.
5) L1 hardware_enable() then calls ept_sync_global() which executes
INVEPT.
6) L0 intercept INVEPT and execute handle_invept() which notes
!vmx->nested.vmxon and thus raise a #UD to L1.
7) Raised #UD caused L1 to panic.

Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Cc: stable@vger.kernel.org
Fixes: 773e8a0425c923bc02668a2d6534a5ef5a43cc69
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |   27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -4110,11 +4110,7 @@ static __init int setup_vmcs_config(stru
 	vmcs_conf->order = get_order(vmcs_conf->size);
 	vmcs_conf->basic_cap = vmx_msr_high & ~0x1fff;
 
-	/* KVM supports Enlightened VMCS v1 only */
-	if (static_branch_unlikely(&enable_evmcs))
-		vmcs_conf->revision_id = KVM_EVMCS_VERSION;
-	else
-		vmcs_conf->revision_id = vmx_msr_low;
+	vmcs_conf->revision_id = vmx_msr_low;
 
 	vmcs_conf->pin_based_exec_ctrl = _pin_based_exec_control;
 	vmcs_conf->cpu_based_exec_ctrl = _cpu_based_exec_control;
@@ -4184,7 +4180,13 @@ static struct vmcs *alloc_vmcs_cpu(int c
 		return NULL;
 	vmcs = page_address(pages);
 	memset(vmcs, 0, vmcs_config.size);
-	vmcs->revision_id = vmcs_config.revision_id; /* vmcs revision id */
+
+	/* KVM supports Enlightened VMCS v1 only */
+	if (static_branch_unlikely(&enable_evmcs))
+		vmcs->revision_id = KVM_EVMCS_VERSION;
+	else
+		vmcs->revision_id = vmcs_config.revision_id;
+
 	return vmcs;
 }
 
@@ -4343,6 +4345,19 @@ static __init int alloc_kvm_area(void)
 			return -ENOMEM;
 		}
 
+		/*
+		 * When eVMCS is enabled, alloc_vmcs_cpu() sets
+		 * vmcs->revision_id to KVM_EVMCS_VERSION instead of
+		 * revision_id reported by MSR_IA32_VMX_BASIC.
+		 *
+		 * However, even though not explictly documented by
+		 * TLFS, VMXArea passed as VMXON argument should
+		 * still be marked with revision_id reported by
+		 * physical CPU.
+		 */
+		if (static_branch_unlikely(&enable_evmcs))
+			vmcs->revision_id = vmcs_config.revision_id;
+
 		per_cpu(vmxarea, cpu) = vmcs;
 	}
 	return 0;


