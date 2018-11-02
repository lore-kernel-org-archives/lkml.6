Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D314FC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59F320837
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7LesYKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59F320837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730704AbeKCD5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:57:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728280AbeKCD5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:57:47 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CDD220837;
        Fri,  2 Nov 2018 18:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184572;
        bh=wLN85fRG4904OqZ3inN731Ro1yyR9MbM3y17KaDlIUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q7LesYKTgx+V3+gDocN/maIEC418y+TN3T9t/K1wFWjSuwxl1QMXEHy8Ye961LCMY
         C2j33CJ0Rv5cJX03beYuG6DfOgMNKBqUqv9/CMKrz/J3DISwJT+7giCeE+K2xn2bKq
         mc8sa2es8/T6cBHzQqP6UcBXjd/ffjc6i4Ellm+E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve Capper <steve.capper@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 015/143] arm64: hugetlb: Fix handling of young ptes
Date:   Fri,  2 Nov 2018 19:33:20 +0100
Message-Id: <20181102182858.309982426@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
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



