Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEA9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6466C20854
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6466C20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388267AbeGTNSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:18:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38410 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbeGTNSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:18:35 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 602F8C18;
        Fri, 20 Jul 2018 12:30:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>,
        Christoffer Dall <cdall@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.9 45/66] KVM: arm/arm64: Convert kvm_host_cpu_state to a static per-cpu allocation
Date:   Fri, 20 Jul 2018 14:14:02 +0200
Message-Id: <20180720121409.830853381@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121407.228772286@linuxfoundation.org>
References: <20180720121407.228772286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Morse <james.morse@arm.com>

Commit 36989e7fd386a9a5822c48691473863f8fbb404d upstream.

kvm_host_cpu_state is a per-cpu allocation made from kvm_arch_init()
used to store the host EL1 registers when KVM switches to a guest.

Make it easier for ASM to generate pointers into this per-cpu memory
by making it a static allocation.

Signed-off-by: James Morse <james.morse@arm.com>
Acked-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/kvm/arm.c |   18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -51,8 +51,8 @@
 __asm__(".arch_extension	virt");
 #endif
 
+DEFINE_PER_CPU(kvm_cpu_context_t, kvm_host_cpu_state);
 static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
-static kvm_cpu_context_t __percpu *kvm_host_cpu_state;
 static unsigned long hyp_default_vectors;
 
 /* Per-CPU variable containing the currently running vcpu. */
@@ -338,7 +338,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu
 	}
 
 	vcpu->cpu = cpu;
-	vcpu->arch.host_cpu_context = this_cpu_ptr(kvm_host_cpu_state);
+	vcpu->arch.host_cpu_context = this_cpu_ptr(&kvm_host_cpu_state);
 
 	kvm_arm_set_running_vcpu(vcpu);
 }
@@ -1199,19 +1199,8 @@ static inline void hyp_cpu_pm_exit(void)
 }
 #endif
 
-static void teardown_common_resources(void)
-{
-	free_percpu(kvm_host_cpu_state);
-}
-
 static int init_common_resources(void)
 {
-	kvm_host_cpu_state = alloc_percpu(kvm_cpu_context_t);
-	if (!kvm_host_cpu_state) {
-		kvm_err("Cannot allocate host CPU state\n");
-		return -ENOMEM;
-	}
-
 	/* set size of VMID supported by CPU */
 	kvm_vmid_bits = kvm_get_vmid_bits();
 	kvm_info("%d-bit VMID\n", kvm_vmid_bits);
@@ -1369,7 +1358,7 @@ static int init_hyp_mode(void)
 	for_each_possible_cpu(cpu) {
 		kvm_cpu_context_t *cpu_ctxt;
 
-		cpu_ctxt = per_cpu_ptr(kvm_host_cpu_state, cpu);
+		cpu_ctxt = per_cpu_ptr(&kvm_host_cpu_state, cpu);
 		err = create_hyp_mappings(cpu_ctxt, cpu_ctxt + 1, PAGE_HYP);
 
 		if (err) {
@@ -1447,7 +1436,6 @@ int kvm_arch_init(void *opaque)
 out_hyp:
 	teardown_hyp_mode();
 out_err:
-	teardown_common_resources();
 	return err;
 }
 


