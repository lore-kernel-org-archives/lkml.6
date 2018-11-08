Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71113ECDE4C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F7120844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbuuI0hp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F7120844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731891AbeKIHnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:43:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:36134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730301AbeKIHng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:43:36 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D707520989;
        Thu,  8 Nov 2018 22:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714766;
        bh=aPPlqaPBiWBiWF1WZbYQY9k1vVhhRTDqq+Ai/l09pD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VbuuI0hpexSJLWbQw8cabNIT4+45AuNLT6JmIVG0Y+i/ucrLBYS3b2HLXT+phZAId
         7+QOa5e6rgsdmdRvNBkg0/VdaA4Ebr7bvzA4Q55TzvFms0H0xR6XvBQ2bInMNrrHEh
         r3g+JBiHe9Aa6lPesqiGPi6yil121GEiv7noUdXc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 115/171] sparc64: Fix regression in pmdp_invalidate().
Date:   Thu,  8 Nov 2018 13:51:25 -0800
Message-Id: <20181108215135.645303930@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index b2722ed31053..349cb83f7b5f 100644
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



