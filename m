Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A66C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C5721855
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864902;
	bh=tAbwMxcGkArG8wGT2odcNUqXpcapeF0Vf9JKPKjhACU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=07akRqzda2dgZoWE3J36f2YaoM1rQ19TqoVE2qBbdBF3QFb0lbdZOwHg0F4o7ipmN
	 vu6yZioCW1U5XgaZ56vQxivBAseyAIIUEssNlqC3XBtj7TTiFAXdikBKRh48vq8TW4
	 NdXugPC3KqcPqvx0cHnR0AWBqlSb0/NkCPJeXx8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfAGMlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:41:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:56860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727277AbfAGMle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:41:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43DB52183E;
        Mon,  7 Jan 2019 12:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864892;
        bh=tAbwMxcGkArG8wGT2odcNUqXpcapeF0Vf9JKPKjhACU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vqvx9AIBrqA43/BbQq696+VHS6agx1LR1ZdgUAhzjljkSkleGMM2xV0Q1H5n1/1tN
         BMam+ygFA5szAShPP5ayMIrXFu09La0jC8RFAfVRKepDf6Tnv9mkjX85min6wG6iAD
         e20tkH/dP108KhPJzKfFzJm3nAujf/GvYHdPUOqg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 4.20 058/145] KVM: PPC: Book3S HV: Fix race between kvm_unmap_hva_range and MMU mode switch
Date:   Mon,  7 Jan 2019 13:31:35 +0100
Message-Id: <20190107104444.886183565@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Mackerras <paulus@ozlabs.org>

commit 234ff0b729ad882d20f7996591a964965647addf upstream.

Testing has revealed an occasional crash which appears to be caused
by a race between kvmppc_switch_mmu_to_hpt and kvm_unmap_hva_range_hv.
The symptom is a NULL pointer dereference in __find_linux_pte() called
from kvm_unmap_radix() with kvm->arch.pgtable == NULL.

Looking at kvmppc_switch_mmu_to_hpt(), it does indeed clear
kvm->arch.pgtable (via kvmppc_free_radix()) before setting
kvm->arch.radix to NULL, and there is nothing to prevent
kvm_unmap_hva_range_hv() or the other MMU callback functions from
being called concurrently with kvmppc_switch_mmu_to_hpt() or
kvmppc_switch_mmu_to_radix().

This patch therefore adds calls to spin_lock/unlock on the kvm->mmu_lock
around the assignments to kvm->arch.radix, and makes sure that the
partition-scoped radix tree or HPT is only freed after changing
kvm->arch.radix.

This also takes the kvm->mmu_lock in kvmppc_rmap_reset() to make sure
that the clearing of each rmap array (one per memslot) doesn't happen
concurrently with use of the array in the kvm_unmap_hva_range_hv()
or the other MMU callbacks.

Fixes: 18c3640cefc7 ("KVM: PPC: Book3S HV: Add infrastructure for running HPT guests on radix host")
Cc: stable@vger.kernel.org # v4.15+
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kvm/book3s_64_mmu_hv.c |    3 +++
 arch/powerpc/kvm/book3s_hv.c        |   17 +++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -743,12 +743,15 @@ void kvmppc_rmap_reset(struct kvm *kvm)
 	srcu_idx = srcu_read_lock(&kvm->srcu);
 	slots = kvm_memslots(kvm);
 	kvm_for_each_memslot(memslot, slots) {
+		/* Mutual exclusion with kvm_unmap_hva_range etc. */
+		spin_lock(&kvm->mmu_lock);
 		/*
 		 * This assumes it is acceptable to lose reference and
 		 * change bits across a reset.
 		 */
 		memset(memslot->arch.rmap, 0,
 		       memslot->npages * sizeof(*memslot->arch.rmap));
+		spin_unlock(&kvm->mmu_lock);
 	}
 	srcu_read_unlock(&kvm->srcu, srcu_idx);
 }
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4532,12 +4532,15 @@ int kvmppc_switch_mmu_to_hpt(struct kvm
 {
 	if (nesting_enabled(kvm))
 		kvmhv_release_all_nested(kvm);
+	kvmppc_rmap_reset(kvm);
+	kvm->arch.process_table = 0;
+	/* Mutual exclusion with kvm_unmap_hva_range etc. */
+	spin_lock(&kvm->mmu_lock);
+	kvm->arch.radix = 0;
+	spin_unlock(&kvm->mmu_lock);
 	kvmppc_free_radix(kvm);
 	kvmppc_update_lpcr(kvm, LPCR_VPM1,
 			   LPCR_VPM1 | LPCR_UPRT | LPCR_GTSE | LPCR_HR);
-	kvmppc_rmap_reset(kvm);
-	kvm->arch.radix = 0;
-	kvm->arch.process_table = 0;
 	return 0;
 }
 
@@ -4549,12 +4552,14 @@ int kvmppc_switch_mmu_to_radix(struct kv
 	err = kvmppc_init_vm_radix(kvm);
 	if (err)
 		return err;
-
+	kvmppc_rmap_reset(kvm);
+	/* Mutual exclusion with kvm_unmap_hva_range etc. */
+	spin_lock(&kvm->mmu_lock);
+	kvm->arch.radix = 1;
+	spin_unlock(&kvm->mmu_lock);
 	kvmppc_free_hpt(&kvm->arch.hpt);
 	kvmppc_update_lpcr(kvm, LPCR_UPRT | LPCR_GTSE | LPCR_HR,
 			   LPCR_VPM1 | LPCR_UPRT | LPCR_GTSE | LPCR_HR);
-	kvmppc_rmap_reset(kvm);
-	kvm->arch.radix = 1;
 	return 0;
 }
 


