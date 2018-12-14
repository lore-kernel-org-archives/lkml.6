Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E834C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA13620879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790058;
	bh=JSEWZLW/of4QalpzTP6rrGq77919tcqUSplJ7mNnKHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K4wp7MENJ8TkjlkCqVfml4xCgjWP4OoeEy3zrJ3ktWnn+kaTzSspY8w4L8+jPeMcO
	 p/OoAJKjJnpKNFQHcblEaEylXD33TFitFCgVjJuvbjXnljTEWP9UTYmvygGMZ9IFfE
	 ERndAt3EDg9xOI/Okg6ei483pdNSOxPjOQUMbDPU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA13620879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732141AbeLNMU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:20:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:34878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731476AbeLNMPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:15:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6546214DE;
        Fri, 14 Dec 2018 12:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789702;
        bh=JSEWZLW/of4QalpzTP6rrGq77919tcqUSplJ7mNnKHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NF+x2WORZeyWxAiPPIefauCe1y0hrjExeB+vni9aI2TLMNNVLjT9v3ifzxD5SwSbF
         68qVp4nW+/f/cYUxe2ZdZnJvB3+lz5iB0hdmo7pkbb+LremfCs49HJOML5kIl8WTKN
         kpxTs40uoR9lhF+bITLaubWgexkXobelQaUa6Pls=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 44/88] KVM: VMX: introduce alloc_loaded_vmcs
Date:   Fri, 14 Dec 2018 13:00:18 +0100
Message-Id: <20181214115705.838516998@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

commit f21f165ef922c2146cc5bdc620f542953c41714b upstream.

Group together the calls to alloc_vmcs and loaded_vmcs_init.  Soon we'll also
allocate an MSR bitmap there.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 4.4:
 - No loaded_vmcs::shadow_vmcs field to initialise
 - Adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |   35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -3345,11 +3345,6 @@ static struct vmcs *alloc_vmcs_cpu(int c
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
@@ -3367,6 +3362,21 @@ static void free_loaded_vmcs(struct load
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
@@ -6699,6 +6709,7 @@ static int handle_vmon(struct kvm_vcpu *
 	struct vmcs *shadow_vmcs;
 	const u64 VMXON_NEEDED_FEATURES = FEATURE_CONTROL_LOCKED
 		| FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
+	int r;
 
 	/* The Intel VMX Instruction Reference lists a bunch of bits that
 	 * are prerequisite to running VMXON, most notably cr4.VMXE must be
@@ -6738,10 +6749,9 @@ static int handle_vmon(struct kvm_vcpu *
 		return 1;
 	}
 
-	vmx->nested.vmcs02.vmcs = alloc_vmcs();
-	if (!vmx->nested.vmcs02.vmcs)
+	r = alloc_loaded_vmcs(&vmx->nested.vmcs02);
+	if (r < 0)
 		goto out_vmcs02;
-	loaded_vmcs_init(&vmx->nested.vmcs02);
 
 	if (cpu_has_vmx_msr_bitmap()) {
 		vmx->nested.msr_bitmap =
@@ -8802,16 +8812,15 @@ static struct kvm_vcpu *vmx_create_vcpu(
 	if (!vmx->guest_msrs)
 		goto free_pml;
 
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


