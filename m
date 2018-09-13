Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447C6C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C92020854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C92020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbeIMSz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:55:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60860 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbeIMSz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:55:56 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 87747D1A;
        Thu, 13 Sep 2018 13:46:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 078/115] KVM: vmx: track host_state.loaded using a loaded_vmcs pointer
Date:   Thu, 13 Sep 2018 15:31:38 +0200
Message-Id: <20180913131828.417493999@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131823.327472833@linuxfoundation.org>
References: <20180913131823.327472833@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <sean.j.christopherson@intel.com>

[ Upstream commit bd9966de4e14fb559e89a06f7f5c9aab2cc028b9 ]

Using 'struct loaded_vmcs*' to track whether the CPU registers
contain host or guest state kills two birds with one stone.

  1. The (effective) boolean host_state.loaded is poorly named.
     It does not track whether or not host state is loaded into
     the CPU registers (which most readers would expect), but
     rather tracks if host state has been saved AND guest state
     is loaded.

  2. Using a loaded_vmcs pointer provides a more robust framework
     for the optimized guest/host state switching, especially when
     consideration per-VMCS enhancements.  To that end, WARN_ONCE
     if we try to switch to host state with a different VMCS than
     was last used to save host state.

Resolve an occurrence of the new WARN by setting loaded_vmcs after
the call to vmx_vcpu_put() in vmx_switch_vmcs().

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -749,17 +749,21 @@ struct vcpu_vmx {
 	/*
 	 * loaded_vmcs points to the VMCS currently used in this vcpu. For a
 	 * non-nested (L1) guest, it always points to vmcs01. For a nested
-	 * guest (L2), it points to a different VMCS.
+	 * guest (L2), it points to a different VMCS.  loaded_cpu_state points
+	 * to the VMCS whose state is loaded into the CPU registers that only
+	 * need to be switched when transitioning to/from the kernel; a NULL
+	 * value indicates that host state is loaded.
 	 */
 	struct loaded_vmcs    vmcs01;
 	struct loaded_vmcs   *loaded_vmcs;
+	struct loaded_vmcs   *loaded_cpu_state;
 	bool                  __launched; /* temporary, used in vmx_vcpu_run */
 	struct msr_autoload {
 		struct vmx_msrs guest;
 		struct vmx_msrs host;
 	} msr_autoload;
+
 	struct {
-		int           loaded;
 		u16           fs_sel, gs_sel, ldt_sel;
 #ifdef CONFIG_X86_64
 		u16           ds_sel, es_sel;
@@ -2336,10 +2340,11 @@ static void vmx_save_host_state(struct k
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	int i;
 
-	if (vmx->host_state.loaded)
+	if (vmx->loaded_cpu_state)
 		return;
 
-	vmx->host_state.loaded = 1;
+	vmx->loaded_cpu_state = vmx->loaded_vmcs;
+
 	/*
 	 * Set host fs and gs selectors.  Unfortunately, 22.2.3 does not
 	 * allow segment selectors with cpl > 0 or ti == 1.
@@ -2390,11 +2395,14 @@ static void vmx_save_host_state(struct k
 
 static void __vmx_load_host_state(struct vcpu_vmx *vmx)
 {
-	if (!vmx->host_state.loaded)
+	if (!vmx->loaded_cpu_state)
 		return;
 
+	WARN_ON_ONCE(vmx->loaded_cpu_state != vmx->loaded_vmcs);
+
 	++vmx->vcpu.stat.host_state_reload;
-	vmx->host_state.loaded = 0;
+	vmx->loaded_cpu_state = NULL;
+
 #ifdef CONFIG_X86_64
 	if (is_long_mode(&vmx->vcpu))
 		rdmsrl(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
@@ -9944,8 +9952,8 @@ static void vmx_switch_vmcs(struct kvm_v
 		return;
 
 	cpu = get_cpu();
-	vmx->loaded_vmcs = vmcs;
 	vmx_vcpu_put(vcpu);
+	vmx->loaded_vmcs = vmcs;
 	vmx_vcpu_load(vcpu, cpu);
 	vcpu->cpu = cpu;
 	put_cpu();


