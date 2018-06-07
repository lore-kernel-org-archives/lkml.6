Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id JvHuKkFKGVucVAAAmS7hNA
	; Thu, 07 Jun 2018 15:08:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CDE35608B8; Thu,  7 Jun 2018 15:08:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2F5ED6063F;
	Thu,  7 Jun 2018 15:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F5ED6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936044AbeFGPIJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:08:09 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41524 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935943AbeFGPDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:03:43 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbj-0005Zk-7W; Thu, 07 Jun 2018 15:09:43 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb5-0002yB-3O; Thu, 07 Jun 2018 15:09:03 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Simon Guo" <wei.guo.simon@gmail.com>,
        "Paul Mackerras" <paulus@ozlabs.org>,
        "Alexander Graf" <agraf@suse.de>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.619635479@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 184/410] KVM: PPC: Book3S PR: Fix svcpu copying with
 preemption enabled
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

From: Alexander Graf <agraf@suse.de>

commit 07ae5389e98c53bb9e9f308fce9c903bc3ee7720 upstream.

When copying between the vcpu and svcpu, we may get scheduled away onto
a different host CPU which in turn means our svcpu pointer may change.

That means we need to atomically copy to and from the svcpu with preemption
disabled, so that all code around it always sees a coherent state.

Reported-by: Simon Guo <wei.guo.simon@gmail.com>
Fixes: 3d3319b45eea ("KVM: PPC: Book3S: PR: Enable interrupts earlier")
Signed-off-by: Alexander Graf <agraf@suse.de>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/include/asm/kvm_book3s.h |  6 ++----
 arch/powerpc/kvm/book3s_interrupts.S  |  4 +---
 arch/powerpc/kvm/book3s_pr.c          | 20 +++++++++-----------
 3 files changed, 12 insertions(+), 18 deletions(-)

--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -190,10 +190,8 @@ extern void kvmppc_hv_entry_trampoline(v
 extern u32 kvmppc_alignment_dsisr(struct kvm_vcpu *vcpu, unsigned int inst);
 extern ulong kvmppc_alignment_dar(struct kvm_vcpu *vcpu, unsigned int inst);
 extern int kvmppc_h_pr(struct kvm_vcpu *vcpu, unsigned long cmd);
-extern void kvmppc_copy_to_svcpu(struct kvmppc_book3s_shadow_vcpu *svcpu,
-				 struct kvm_vcpu *vcpu);
-extern void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu,
-				   struct kvmppc_book3s_shadow_vcpu *svcpu);
+extern void kvmppc_copy_to_svcpu(struct kvm_vcpu *vcpu);
+extern void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu);
 
 static inline struct kvmppc_vcpu_book3s *to_book3s(struct kvm_vcpu *vcpu)
 {
--- a/arch/powerpc/kvm/book3s_interrupts.S
+++ b/arch/powerpc/kvm/book3s_interrupts.S
@@ -96,7 +96,7 @@ kvm_start_entry:
 
 kvm_start_lightweight:
 	/* Copy registers into shadow vcpu so we can access them in real mode */
-	GET_SHADOW_VCPU(r3)
+	mr	r3, r4
 	bl	FUNC(kvmppc_copy_to_svcpu)
 	nop
 	REST_GPR(4, r1)
@@ -165,9 +165,7 @@ after_sprg3_load:
 	stw	r12, VCPU_TRAP(r3)
 
 	/* Transfer reg values from shadow vcpu back to vcpu struct */
-	/* On 64-bit, interrupts are still off at this point */
 
-	GET_SHADOW_VCPU(r4)
 	bl	FUNC(kvmppc_copy_from_svcpu)
 	nop
 
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -82,7 +82,7 @@ static void kvmppc_core_vcpu_put_pr(stru
 #ifdef CONFIG_PPC_BOOK3S_64
 	struct kvmppc_book3s_shadow_vcpu *svcpu = svcpu_get(vcpu);
 	if (svcpu->in_use) {
-		kvmppc_copy_from_svcpu(vcpu, svcpu);
+		kvmppc_copy_from_svcpu(vcpu);
 	}
 	memcpy(to_book3s(vcpu)->slb_shadow, svcpu->slb, sizeof(svcpu->slb));
 	to_book3s(vcpu)->slb_shadow_max = svcpu->slb_max;
@@ -95,9 +95,10 @@ static void kvmppc_core_vcpu_put_pr(stru
 }
 
 /* Copy data needed by real-mode code from vcpu to shadow vcpu */
-void kvmppc_copy_to_svcpu(struct kvmppc_book3s_shadow_vcpu *svcpu,
-			  struct kvm_vcpu *vcpu)
+void kvmppc_copy_to_svcpu(struct kvm_vcpu *vcpu)
 {
+	struct kvmppc_book3s_shadow_vcpu *svcpu = svcpu_get(vcpu);
+
 	svcpu->gpr[0] = vcpu->arch.gpr[0];
 	svcpu->gpr[1] = vcpu->arch.gpr[1];
 	svcpu->gpr[2] = vcpu->arch.gpr[2];
@@ -121,17 +122,14 @@ void kvmppc_copy_to_svcpu(struct kvmppc_
 	svcpu->shadow_fscr = vcpu->arch.shadow_fscr;
 #endif
 	svcpu->in_use = true;
+
+	svcpu_put(svcpu);
 }
 
 /* Copy data touched by real-mode code from shadow vcpu back to vcpu */
-void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu,
-			    struct kvmppc_book3s_shadow_vcpu *svcpu)
+void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu)
 {
-	/*
-	 * vcpu_put would just call us again because in_use hasn't
-	 * been updated yet.
-	 */
-	preempt_disable();
+	struct kvmppc_book3s_shadow_vcpu *svcpu = svcpu_get(vcpu);
 
 	/*
 	 * Maybe we were already preempted and synced the svcpu from
@@ -169,7 +167,7 @@ void kvmppc_copy_from_svcpu(struct kvm_v
 	svcpu->in_use = false;
 
 out:
-	preempt_enable();
+	svcpu_put(svcpu);
 }
 
 static int kvmppc_core_check_requests_pr(struct kvm_vcpu *vcpu)
