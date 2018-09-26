Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8DDC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658FA214FE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2024-bit key) header.d=lukas-braun.net header.i=@lukas-braun.net header.b="YHb5ZttA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 658FA214FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=moshbit.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbeIZVZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:25:37 -0400
Received: from moshbit.net ([62.210.136.156]:41344 "EHLO mail.lukas-braun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbeIZVZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:25:37 -0400
Received: from mail.lukas-braun.net (localhost [127.0.0.1])
        by mail.lukas-braun.net (OpenSMTPD) with ESMTP id 1c2e202c;
        Wed, 26 Sep 2018 15:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=lukas-braun.net; h=from
        :to:cc:subject:date:message-id; s=mail; bh=eHoeeShUBVl3/CXlAqrL0
        P4Gv/OSdUnhOLHArNrsYro=; b=YHb5ZttALM+2fVKPzxJj5eaiWQzjeEmNnmmXV
        bXhBaA2iUZLkG0b6vo1vgogNQ17DVtuJBCQ1FJd/WloIAxcn1XRp/Ml77LtEiY4T
        9kn0qBWEJ7qfDMlsFB1iWXxTEljLAmfuXlDzkYXJgPwhGsXPaprGAiQCBj/ELDxP
        NKlKqCQE5HArQl9JgNdtGinX4mEFQsIbMvswt1XZUlacYx3fkPL77m5VnFVQvIs2
        BVsmm9cuK/eGmvM07iMiye72qyDnTAxoKRZBxcc8AWnt/pLpCWVWnppzU9+9kzqT
        POJaoM6SrI1XEh3xce09huE6BbUqNTSg3v2SAQ93BtBzg==
Received: from localhost (hedge.moshbit.net [IPv6:2001:bc8:313e:101::1])
        by mail.lukas-braun.net (OpenSMTPD) with ESMTPSA id 144e2e30 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Wed, 26 Sep 2018 15:12:09 +0000 (UTC)
From:   Lukas Braun <koomi@moshbit.net>
To:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     Ralph Palutke <ralph.palutke@fau.de>,
        Lukas Braun <koomi@moshbit.net>
Subject: [PATCH v2] KVM: arm/arm64: Check memslot bounds before mapping hugepages
Date:   Wed, 26 Sep 2018 17:11:35 +0200
Message-Id: <20180926151135.16083-1-koomi@moshbit.net>
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

Hi everyone,

for v2, in addition to writing the condition the way Marc suggested, I
moved the whole check so it also catches the problem when the hugepage
was allocated explicitly, not only for THPs. The second line is quite
long, but splitting it up would make things rather ugly IMO, so I left
it as it is.

Regards,
Lukas


 virt/kvm/arm/mmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index ed162a6c57c5..ba77339e23ec 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1500,7 +1500,11 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		return -EFAULT;
 	}
 
-	if (vma_kernel_pagesize(vma) == PMD_SIZE && !logging_active) {
+	if ((fault_ipa & S2_PMD_MASK) < (memslot->base_gfn << PAGE_SHIFT) ||
+	    ALIGN(fault_ipa, S2_PMD_SIZE) >= ((memslot->base_gfn + memslot->npages) << PAGE_SHIFT)) {
+		/* PMD entry would map something outside of the memslot */
+		force_pte = true;
+	} else if (vma_kernel_pagesize(vma) == PMD_SIZE && !logging_active) {
 		hugetlb = true;
 		gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
 	} else {
-- 
2.11.0

