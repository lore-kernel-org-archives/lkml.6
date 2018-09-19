Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB06C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A0021529
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LN3HkmDK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A0021529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731136AbeISOhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:37:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36982 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbeISOhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=N+U+rBvrw/MiVGa4YM7UVfBkYCtdi8ILTxTXJ95cG7k=; b=LN3HkmDKZ8ezgdFkhmKzu+hM1H
        FqHImcJ7DoLUBQkbk9IE/CW8teVS3PGH50qFCc0P3kmx9kqXI7au0Zr/xenyh/Q2iF4TJm05JA02y
        CMEWRkhUCi/DNRLhkG+WO2BmsHLclSllOuztgWmN+u6Bh0DadrugoZBZr5Jvx1Wbz8zgu2oljpQoj
        yEBx+KhnAmfuqyn44bTn0nAEo2aTc9IIK02+t4JO++z+VB+2MukKo2N1QHbc3SAZ3IHfH9ZoozVAU
        2zK1ng7Fh+Yl+laiTDNbsormiALRl3JsuE4KEcziwBHEPGN0bwBMhps1GFUuomo7zlSBroIxNjpuy
        xY1Ebwow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2YLS-0007d1-JN; Wed, 19 Sep 2018 09:00:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B3D29202E4E50; Wed, 19 Sep 2018 11:00:14 +0200 (CEST)
Message-ID: <20180919085948.087848187@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 19 Sep 2018 10:50:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Bin Yang <bin.yang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Gross <mark.gross@intel.com>
Subject: [PATCH 6/8] x86/mm/cpa: Move CLFLUSH test into cpa_flush_array()
References: <20180919085016.164552924@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than guarding cpa_flush_array() users with a CLFLUSH test, put
it inside.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/pageattr.c |   29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -328,6 +328,11 @@ static void cpa_flush_array(unsigned lon
 
 	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
 
+	if (!static_cpu_has(X86_FEATURE_CLFLUSH)) {
+		cpa_flush_all(cache);
+		return;
+	}
+
 	flush_tlb_kernel_range(baddr, baddr + PAGE_SIZE * numpages);
 
 	if (!cache)
@@ -1753,19 +1758,19 @@ static int change_page_attr_set_clr(unsi
 	cache = !!pgprot2cachemode(mask_set);
 
 	/*
-	 * On success we use CLFLUSH, when the CPU supports it to
-	 * avoid the WBINVD. If the CPU does not support it and in the
-	 * error case we fall back to cpa_flush_all (which uses
-	 * WBINVD):
-	 */
-	if (!ret && boot_cpu_has(X86_FEATURE_CLFLUSH)) {
-		if (cpa.flags & (CPA_PAGES_ARRAY | CPA_ARRAY)) {
-			cpa_flush_array(baddr, addr, numpages, cache,
-					cpa.flags, pages);
-		} else
-			cpa_flush_range(baddr, numpages, cache);
-	} else
+	 * On error; flush everything to be sure.
+	 */
+	if (ret) {
 		cpa_flush_all(cache);
+		goto out;
+	}
+
+	if (cpa.flags & (CPA_PAGES_ARRAY | CPA_ARRAY)) {
+		cpa_flush_array(baddr, addr, numpages, cache,
+				cpa.flags, pages);
+	} else {
+		cpa_flush_range(baddr, numpages, cache);
+	}
 
 out:
 	return ret;


