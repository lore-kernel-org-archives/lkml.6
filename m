Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5FAC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049982082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2024-bit key) header.d=lukas-braun.net header.i=@lukas-braun.net header.b="5kQGVRpi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049982082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=moshbit.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbeIDVM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 17:12:29 -0400
Received: from moshbit.net ([62.210.136.156]:39778 "EHLO mail.lukas-braun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbeIDVM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 17:12:28 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Sep 2018 17:12:27 EDT
Received: from mail.lukas-braun.net (localhost [127.0.0.1])
        by mail.lukas-braun.net (OpenSMTPD) with ESMTP id aa4180b1;
        Tue, 4 Sep 2018 16:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=lukas-braun.net; h=from
        :to:cc:subject:date:message-id; s=mail; bh=qSHZpv8YWtY1jjestNv3W
        IG/nQ/3IsUweG2B88ANe9Q=; b=5kQGVRpiRyZRQZW70yf5/DlIMDJr8Z91tvbx0
        mNCG942K0Mrdx1MpPDdMgUSSp0eXVAeH4QDoyv5qqJdYHgAJPF0MRbX8V0jFICTu
        zmAUCa/luT+6oysfz8Jjezg4IrgdDLODeL8ijdYhbqJN/C9QmzDR1/Cg5p2AxZdl
        FPLaNMrsi8911Ts3gdgMHydjm9UmKaLV1oDEnBx99RAO7/qWFTP9aM+GxH/Xnymg
        VQVhl+8nqOaOVW0SBzK1P2VTu05mzqvYE0W2/W4vKUb6YGI8wGiOZFmrbOy1jt79
        xW81Ruobur/MP8N3xxS5qzL38PCYCkg1y8tNEfedqC+AA==
Received: from localhost (hedge.moshbit.net [IPv6:2001:bc8:313e:101::1])
        by mail.lukas-braun.net (OpenSMTPD) with ESMTPSA id 9252d8ae (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 4 Sep 2018 16:39:50 +0000 (UTC)
From:   Lukas Braun <koomi@moshbit.net>
To:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     Ralph Palutke <ralph.palutke@fau.de>,
        Lukas Braun <koomi@moshbit.net>
Subject: [PATCH] KVM: arm/arm64: Check memslot bounds before mapping hugepages
Date:   Tue,  4 Sep 2018 18:39:36 +0200
Message-Id: <20180904163937.12759-1-koomi@moshbit.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace can create a memslot with memory backed by (transparent)
hugepages, but with bounds that do not align with hugepages.
In that case, we cannot map the entire region in the guest as hugepages
without exposing additional host memory to the guest and potentially
interfering with other memslots.
Consequently, this patch adds a bounds check when populating guest page
tables and forces the creation of regular PTEs if mapping an entire
hugepage would violate the memslots bounds.

Signed-off-by: Lukas Braun <koomi@moshbit.net>
---
 virt/kvm/arm/mmu.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index ed162a6c57c5..bdbec1d136a1 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1504,6 +1504,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		hugetlb = true;
 		gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
 	} else {
+		unsigned long pmd_fn_mask = PTRS_PER_PMD - 1;
+
 		/*
 		 * Pages belonging to memslots that don't have the same
 		 * alignment for userspace and IPA cannot be mapped using
@@ -1513,8 +1515,17 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		 * unmapping, updates, and splits of the THP or other pages
 		 * in the stage-2 block range.
 		 */
-		if ((memslot->userspace_addr & ~PMD_MASK) !=
-		    ((memslot->base_gfn << PAGE_SHIFT) & ~PMD_MASK))
+		int aligned = ((memslot->userspace_addr & ~PMD_MASK) ==
+			((memslot->base_gfn << PAGE_SHIFT) & ~PMD_MASK));
+
+		/*
+		 * We also can't map a huge page if it would violate the bounds
+		 * of the containing memslot.
+		 */
+		int in_bounds = ((memslot->base_gfn <= (gfn & ~pmd_fn_mask)) &&
+			((memslot->base_gfn + memslot->npages) > (gfn | pmd_fn_mask)));
+
+		if (!aligned || !in_bounds)
 			force_pte = true;
 	}
 	up_read(&current->mm->mmap_sem);
-- 
2.11.0

