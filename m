Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCF8C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445912087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CHvJHY0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445912087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeLCROc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:14:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54064 "EHLO
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
        bh=2/VfXTq7jwJkos5+u0gvYTtn0QapejP+xKaA3A+MuoY=; b=CHvJHY0O7GVmWNFXNrz0Xz237C
        tD1j8lfAcedq6bWWRfJCkn+FKxTZ4gZJeGPhzhAL5Osn7IMb99rCfslbsqtvHa2wdqEPxumkgsEvD
        o5qkXLdhUxaptFtxU8Exxi9Ukxc2xi6hsof6chfcRcQ0gX846SxDjO6/IcuQ/nNreg/J4kGiS7YTO
        dc336dW4TRFHMCcuVp6Wnvj22wLFVoCY/us/4GYGnSNVTQz58XmLE9AjqtrAUwjGRL96T7ixSh2Xy
        zN0UF5SA5BrU0wPzyXBgSgGePhTr3aS1JlRZNmtg3xmtz8Q23X0BbqbndjWwsAXF9JYAp0vJ3calH
        DlhFucFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTrng-0001xQ-U7; Mon, 03 Dec 2018 17:14:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 11C9D2029FD6C; Mon,  3 Dec 2018 18:14:26 +0100 (CET)
Message-Id: <20181203171043.162771364@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 03 Dec 2018 18:03:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     x86@kernel.org, Tom.StDenis@amd.com, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 02/10] x86/mm/cpa: Add ARRAY and PAGES_ARRAY selftests
References: <20181203170343.054618965@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current pageattr-test code only uses the regular range interface,
add code that also tests the array and pages interface.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/pageattr-test.c |   28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

--- a/arch/x86/mm/pageattr-test.c
+++ b/arch/x86/mm/pageattr-test.c
@@ -23,7 +23,8 @@
 static __read_mostly int print = 1;
 
 enum {
-	NTEST			= 400,
+	NTEST			= 3 * 100,
+	NPAGES			= 100,
 #ifdef CONFIG_X86_64
 	LPS			= (1 << PMD_SHIFT),
 #elif defined(CONFIG_X86_PAE)
@@ -110,6 +111,9 @@ static int print_split(struct split_stat
 static unsigned long addr[NTEST];
 static unsigned int len[NTEST];
 
+static struct page *pages[NPAGES];
+static unsigned long addrs[NPAGES];
+
 /* Change the global bit on random pages in the direct mapping */
 static int pageattr_test(void)
 {
@@ -137,7 +141,7 @@ static int pageattr_test(void)
 		unsigned long pfn = prandom_u32() % max_pfn_mapped;
 
 		addr[i] = (unsigned long)__va(pfn << PAGE_SHIFT);
-		len[i] = prandom_u32() % 100;
+		len[i] = prandom_u32() % NPAGES;
 		len[i] = min_t(unsigned long, len[i], max_pfn_mapped - pfn - 1);
 
 		if (len[i] == 0)
@@ -167,14 +171,30 @@ static int pageattr_test(void)
 				break;
 			}
 			__set_bit(pfn + k, bm);
+			addrs[k] = addr[i] + k*PAGE_SIZE;
+			pages[k] = pfn_to_page(pfn + k);
 		}
 		if (!addr[i] || !pte || !k) {
 			addr[i] = 0;
 			continue;
 		}
 
-		test_addr = addr[i];
-		err = change_page_attr_set(&test_addr, len[i], PAGE_CPA_TEST, 0);
+		switch (i % 3) {
+		case 0:
+			test_addr = addr[i];
+			err = change_page_attr_set(&test_addr, len[i], PAGE_CPA_TEST, 0);
+			break;
+
+		case 1:
+			err = change_page_attr_set(addrs, len[1], PAGE_CPA_TEST, 1);
+			break;
+
+		case 2:
+			err = cpa_set_pages_array(pages, len[i], PAGE_CPA_TEST);
+			break;
+		}
+
+
 		if (err < 0) {
 			printk(KERN_ERR "CPA %d failed %d\n", i, err);
 			failed++;


