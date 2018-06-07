Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id O77JFBpVGVtGcQAAmS7hNA
	; Thu, 07 Jun 2018 15:54:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 44E5E607E7; Thu,  7 Jun 2018 15:54:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9CD54601D2;
	Thu,  7 Jun 2018 15:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9CD54601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934351AbeFGPx7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:53:59 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40356 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753549AbeFGOel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:34:41 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbx-0005dI-20; Thu, 07 Jun 2018 15:09:57 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvaz-0002kN-5D; Thu, 07 Jun 2018 15:08:57 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David Woodhouse" <dwmw@amazon.co.uk>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Paolo Bonzini" <pbonzini@redhat.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.320516216@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 053/410] KVM: VMX: introduce alloc_loaded_vmcs
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

From: Paolo Bonzini <pbonzini@redhat.com>

commit f21f165ef922c2146cc5bdc620f542953c41714b upstream.

Group together the calls to alloc_vmcs and loaded_vmcs_init.  Soon we'll also
allocate an MSR bitmap there.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16:
 - No loaded_vmcs::shadow_vmcs field to initialise
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2999,11 +2999,6 @@ static struct vmcs *alloc_vmcs_cpu(int c
 	return vmcs;
 }
 
-static struct vmcs *alloc_vmcs(void)
-{
-	return alloc_vmcs_cpu(raw_smp_processor_id());
-}
-
 static void free_vmcs(struct vmcs *vmcs)
 {
 	free_pages((unsigned long)vmcs, vmcs_config.order);
@@ -3021,6 +3016,21 @@ static void free_loaded_vmcs(struct load
 	loaded_vmcs->vmcs = NULL;
 }
 
+static struct vmcs *alloc_vmcs(void)
+{
+	return alloc_vmcs_cpu(raw_smp_processor_id());
+}
+
+static int alloc_loaded_vmcs(struct loaded_vmcs *loaded_vmcs)
+{
+	loaded_vmcs->vmcs = alloc_vmcs();
+	if (!loaded_vmcs->vmcs)
+		return -ENOMEM;
+
+	loaded_vmcs_init(loaded_vmcs);
+	return 0;
+}
+
 static void free_kvm_area(void)
 {
 	int cpu;
@@ -5965,6 +5975,7 @@ static int handle_vmon(struct kvm_vcpu *
 	struct vmcs *shadow_vmcs;
 	const u64 VMXON_NEEDED_FEATURES = FEATURE_CONTROL_LOCKED
 		| FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
+	int r;
 
 	/* The Intel VMX Instruction Reference lists a bunch of bits that
 	 * are prerequisite to running VMXON, most notably cr4.VMXE must be
@@ -6004,10 +6015,9 @@ static int handle_vmon(struct kvm_vcpu *
 		return 1;
 	}
 
-	vmx->nested.vmcs02.vmcs = alloc_vmcs();
-	if (!vmx->nested.vmcs02.vmcs)
+	r = alloc_loaded_vmcs(&vmx->nested.vmcs02);
+	if (r < 0)
 		return -ENOMEM;
-	loaded_vmcs_init(&vmx->nested.vmcs02);
 
 	if (enable_shadow_vmcs) {
 		shadow_vmcs = alloc_vmcs();
@@ -7612,16 +7622,15 @@ static struct kvm_vcpu *vmx_create_vcpu(
 		goto uninit_vcpu;
 	}
 
-	vmx->loaded_vmcs = &vmx->vmcs01;
-	vmx->loaded_vmcs->vmcs = alloc_vmcs();
-	if (!vmx->loaded_vmcs->vmcs)
-		goto free_msrs;
 	if (!vmm_exclusive)
 		kvm_cpu_vmxon(__pa(per_cpu(vmxarea, raw_smp_processor_id())));
-	loaded_vmcs_init(vmx->loaded_vmcs);
+	err = alloc_loaded_vmcs(&vmx->vmcs01);
 	if (!vmm_exclusive)
 		kvm_cpu_vmxoff();
+	if (err < 0)
+		goto free_msrs;
 
+	vmx->loaded_vmcs = &vmx->vmcs01;
 	cpu = get_cpu();
 	vmx_vcpu_load(&vmx->vcpu, cpu);
 	vmx->vcpu.cpu = cpu;
