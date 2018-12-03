Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64ADC07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DAED21527
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jIfaRv/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DAED21527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbeLCROd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:14:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54086 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbeLCROd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:14:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qOGwfN564d/8jZd7unVDsHJjO19+Mf+tk7osEaJSg4M=; b=jIfaRv/+kgaS0BKN6vFxfhmFc5
        M2kNrOZhVKHcEvpYuGQgytch/hFbao2Q0BcYTQMJogZTNkBdNv8ZqKM2KJyh5g4PTlG8x/7+oj49l
        LZUsE8wxDViW28SYJ4ypuXhzxHi/gHPMBTsDeL8SOi0Nnof0YQ3faIPQNs2mq5+J/tFlOlEP4K1zN
        +OukivNGXRnjOsCj93gGIF+dPBhv9BCEhNvJb+C8Q+/5YKk6vm8ShBqVUAMnqaMFVXNegXUSzOqax
        vgmL/GvoebM44FoReS/7u5n9LboWXlFOQzhB8wttruWS+Ggo0IbBRJHHNtl0xjdn1z4RtHNNYBtGu
        yGIjzs0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTrni-00022Z-7o; Mon, 03 Dec 2018 17:14:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2B06A2029F4C9; Mon,  3 Dec 2018 18:14:26 +0100 (CET)
Message-Id: <20181203171043.493000228@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 03 Dec 2018 18:03:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     x86@kernel.org, Tom.StDenis@amd.com, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 07/10] x86/mm/cpa: Make cpa_data::numpages invariant
References: <20181203170343.054618965@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure __change_page_attr_set_clr() doesn't modify cpa->numpages.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/pageattr.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -1623,14 +1623,15 @@ static int cpa_process_alias(struct cpa_
 static int __change_page_attr_set_clr(struct cpa_data *cpa, int checkalias)
 {
 	unsigned long numpages = cpa->numpages;
-	int ret;
+	unsigned long rempages = numpages;
+	int ret = 0;
 
-	while (numpages) {
+	while (rempages) {
 		/*
 		 * Store the remaining nr of pages for the large page
 		 * preservation check.
 		 */
-		cpa->numpages = numpages;
+		cpa->numpages = rempages;
 		/* for array changes, we can't use large page */
 		if (cpa->flags & (CPA_ARRAY | CPA_PAGES_ARRAY))
 			cpa->numpages = 1;
@@ -1641,12 +1642,12 @@ static int __change_page_attr_set_clr(st
 		if (!debug_pagealloc_enabled())
 			spin_unlock(&cpa_lock);
 		if (ret)
-			return ret;
+			goto out;
 
 		if (checkalias) {
 			ret = cpa_process_alias(cpa);
 			if (ret)
-				return ret;
+				goto out;
 		}
 
 		/*
@@ -1654,11 +1655,15 @@ static int __change_page_attr_set_clr(st
 		 * CPA operation. Either a large page has been
 		 * preserved or a single page update happened.
 		 */
-		BUG_ON(cpa->numpages > numpages || !cpa->numpages);
-		numpages -= cpa->numpages;
+		BUG_ON(cpa->numpages > rempages || !cpa->numpages);
+		rempages -= cpa->numpages;
 		cpa->curpage += cpa->numpages;
 	}
-	return 0;
+
+out:
+	/* Restore the original numpages */
+	cpa->numpages = numpages;
+	return ret;
 }
 
 /*


