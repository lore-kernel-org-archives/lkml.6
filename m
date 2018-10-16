Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31F2C070C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840AA2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1KOzjt9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840AA2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbeJPMCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:02:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729132AbeJPMCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:02:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEB3F21480;
        Tue, 16 Oct 2018 04:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663258;
        bh=MVDFGPWpiCUbM8AepxT504T9IP1nkkq+OdXQufTCqC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F1KOzjt9BuvRqnxkJ/0bxg1iWOSa45JS+pf4eo+kZaOJni93AsxS8bW4zRI9CFU/0
         QKJ+j8PZTo09xmP0ml05K4s6Hctul000iagsUlT0L1Njb9nMJrB5MC2vDQKuVUX308
         cXGqBPacEiwjUIslzQ0AWJsfSduWhQPw9D3fKMVY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Steve Capper <steve.capper@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 15/61] arm64: hugetlb: Fix handling of young ptes
Date:   Tue, 16 Oct 2018 00:13:17 -0400
Message-Id: <20181016041403.135678-15-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041403.135678-1-sashal@kernel.org>
References: <20181016041403.135678-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve Capper <steve.capper@arm.com>

[ Upstream commit 469ed9d823b7d240d6b9574f061ded7c3834c167 ]

In the contiguous bit hugetlb break-before-make code we assume that all
hugetlb pages are young.

In fact, remove_migration_pte is able to place an old hugetlb pte so
this assumption is not valid.

This patch fixes the contiguous hugetlb scanning code to preserve young
ptes.

Fixes: d8bdcff28764 ("arm64: hugetlb: Add break-before-make logic for contiguous entries")
Signed-off-by: Steve Capper <steve.capper@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/mm/hugetlbpage.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 6cb0fa92a651..9f6ae9686dac 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -118,11 +118,14 @@ static pte_t get_clear_flush(struct mm_struct *mm,
 
 		/*
 		 * If HW_AFDBM is enabled, then the HW could turn on
-		 * the dirty bit for any page in the set, so check
-		 * them all.  All hugetlb entries are already young.
+		 * the dirty or accessed bit for any page in the set,
+		 * so check them all.
 		 */
 		if (pte_dirty(pte))
 			orig_pte = pte_mkdirty(orig_pte);
+
+		if (pte_young(pte))
+			orig_pte = pte_mkyoung(orig_pte);
 	}
 
 	if (valid)
@@ -347,10 +350,13 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	if (!pte_same(orig_pte, pte))
 		changed = 1;
 
-	/* Make sure we don't lose the dirty state */
+	/* Make sure we don't lose the dirty or young state */
 	if (pte_dirty(orig_pte))
 		pte = pte_mkdirty(pte);
 
+	if (pte_young(orig_pte))
+		pte = pte_mkyoung(pte);
+
 	hugeprot = pte_pgprot(pte);
 	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize, pfn += dpfn)
 		set_pte_at(vma->vm_mm, addr, ptep, pfn_pte(pfn, hugeprot));
-- 
2.17.1

