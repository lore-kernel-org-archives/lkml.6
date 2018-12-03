Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16EDC07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B9B20848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GK3KtDCn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B9B20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbeLCRPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:15:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54078 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeLCROc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EkOnlpyWymR4eBDz4Zf4LKWAUCpS+ahpknQ+lsJJUwg=; b=GK3KtDCncjDMtqqF/CmCtddNLb
        PmxMbtUqtGeSSSlvjrz7v85zuKbMv0f4YR2AxOPk35ligvB94qOjdV7BpAtPwVUhHOyX+OlrQyOAu
        tfpNAXhCnZZ0PNwDVhqYHw3zDPT9sMFpyNTV2li9NfuaJEIRKqeNcr9XD01XMnArVJNW29FOD4hHB
        T4HYeXzZyJ5rspSZOPIJirDNKIe1AavXtexcEkJhgSP/TxExq6/1n9LVv3YlZI6yh568Qcj/i5Pdi
        V/afs29UGUaxJa2JnRL5z0C8D8BKlAwXP/UCGo3HGCmSORdKROVkqPc24mEQC3+KZskBE1toygMiR
        z2OkouuQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTrng-0001xl-Gs; Mon, 03 Dec 2018 17:14:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 16FCA2029FD74; Mon,  3 Dec 2018 18:14:26 +0100 (CET)
Message-Id: <20181203171043.229119497@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 03 Dec 2018 18:03:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     x86@kernel.org, Tom.StDenis@amd.com, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 03/10] x86/mm/cpa: Add __cpa_addr() helper
References: <20181203170343.054618965@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code to compute the virtual address of a cpa_data is duplicated;
introduce a helper before more copies happen.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/pageattr.c |   38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -228,6 +228,23 @@ static bool __cpa_pfn_in_highmap(unsigne
 
 #endif
 
+static unsigned long __cpa_addr(struct cpa_data *cpa, int idx)
+{
+	if (cpa->flags & CPA_PAGES_ARRAY) {
+		struct page *page = cpa->pages[idx];
+
+		if (unlikely(PageHighMem(page)))
+			return 0;
+
+		return (unsigned long)page_address(page);
+	}
+
+	if (cpa->flags & CPA_ARRAY)
+		return cpa->vaddr[idx];
+
+	return *cpa->vaddr;
+}
+
 /*
  * Flushing functions
  */
@@ -1468,15 +1485,7 @@ static int __change_page_attr(struct cpa
 	unsigned int level;
 	pte_t *kpte, old_pte;
 
-	if (cpa->flags & CPA_PAGES_ARRAY) {
-		struct page *page = cpa->pages[cpa->curpage];
-		if (unlikely(PageHighMem(page)))
-			return 0;
-		address = (unsigned long)page_address(page);
-	} else if (cpa->flags & CPA_ARRAY)
-		address = cpa->vaddr[cpa->curpage];
-	else
-		address = *cpa->vaddr;
+	address = __cpa_addr(cpa, cpa->curpage);
 repeat:
 	kpte = _lookup_address_cpa(cpa, address, &level);
 	if (!kpte)
@@ -1557,16 +1566,7 @@ static int cpa_process_alias(struct cpa_
 	 * No need to redo, when the primary call touched the direct
 	 * mapping already:
 	 */
-	if (cpa->flags & CPA_PAGES_ARRAY) {
-		struct page *page = cpa->pages[cpa->curpage];
-		if (unlikely(PageHighMem(page)))
-			return 0;
-		vaddr = (unsigned long)page_address(page);
-	} else if (cpa->flags & CPA_ARRAY)
-		vaddr = cpa->vaddr[cpa->curpage];
-	else
-		vaddr = *cpa->vaddr;
-
+	vaddr = __cpa_addr(cpa, cpa->curpage);
 	if (!(within(vaddr, PAGE_OFFSET,
 		    PAGE_OFFSET + (max_pfn_mapped << PAGE_SHIFT)))) {
 


