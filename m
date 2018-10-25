Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BB5C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9C620840
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="neYNSLCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C9C620840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbeJYWo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:44:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728157AbeJYWoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:44:25 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA49D2054F;
        Thu, 25 Oct 2018 14:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476690;
        bh=h1w5tdTsbdXfAsIibCjoy1TvzkcnIJqMT7N1lLwz2iw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=neYNSLCe7/Xb0mbQGzuh4yP0llLvLDDcXb7xhDWKoIKIFLsiWnJF9Uk/Z+OphjE53
         Z1nWMNBBxMfTEPxiIhsu0x6x6YgdYhfPUEQr+ecmdW7TsT9M4Sh6R9Optgcki5Osep
         tORa2IXqQrod5bGIeRp5GRGc/XacmjapDcKIZNvA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 25/46] sparc64: Fix regression in pmdp_invalidate().
Date:   Thu, 25 Oct 2018 10:10:32 -0400
Message-Id: <20181025141053.213330-25-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141053.213330-1-sashal@kernel.org>
References: <20181025141053.213330-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David S. Miller" <davem@davemloft.net>

[ Upstream commit cfb61b5e3e09f8b49bc4d685429df75f45127adc ]

pmdp_invalidate() was changed to update the pmd atomically
(to not lose dirty/access bits) and return the original pmd
value.

However, in doing so, we lost a lot of the essential work that
set_pmd_at() does, namely to update hugepage mapping counts and
queuing up the batched TLB flush entry.

Thus we were not flushing entries out of the TLB when making
such PMD changes.

Fix this by abstracting the accounting work of set_pmd_at() out into a
separate function, and call it from pmdp_establish().

Fixes: a8e654f01cb7 ("sparc64: update pmdp_invalidate() to return old pmd value")
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/mm/tlb.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index 847ddffbf38a..b5cfab711651 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -163,13 +163,10 @@ static void tlb_batch_pmd_scan(struct mm_struct *mm, unsigned long vaddr,
 	pte_unmap(pte);
 }
 
-void set_pmd_at(struct mm_struct *mm, unsigned long addr,
-		pmd_t *pmdp, pmd_t pmd)
-{
-	pmd_t orig = *pmdp;
-
-	*pmdp = pmd;
 
+static void __set_pmd_acct(struct mm_struct *mm, unsigned long addr,
+			   pmd_t orig, pmd_t pmd)
+{
 	if (mm == &init_mm)
 		return;
 
@@ -219,6 +216,15 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 	}
 }
 
+void set_pmd_at(struct mm_struct *mm, unsigned long addr,
+		pmd_t *pmdp, pmd_t pmd)
+{
+	pmd_t orig = *pmdp;
+
+	*pmdp = pmd;
+	__set_pmd_acct(mm, addr, orig, pmd);
+}
+
 static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 		unsigned long address, pmd_t *pmdp, pmd_t pmd)
 {
@@ -227,6 +233,7 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 	do {
 		old = *pmdp;
 	} while (cmpxchg64(&pmdp->pmd, old.pmd, pmd.pmd) != old.pmd);
+	__set_pmd_acct(vma->vm_mm, address, old, pmd);
 
 	return old;
 }
-- 
2.17.1

