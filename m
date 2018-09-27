Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160D7C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFCC21710
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCFCC21710
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbeI1BOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:14:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37189 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeI1BOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:14:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RIrdYw130190
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 11:53:39 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RIrcBi130187;
        Thu, 27 Sep 2018 11:53:38 -0700
Date:   Thu, 27 Sep 2018 11:53:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-a7295fd53c39ce781a9792c9dd2c8747bf274160@git.kernel.org>
Cc:     peterz@infradead.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, tglx@linutronix.de, mingo@kernel.org,
        mark.gross@intel.com, bin.yang@intel.com
Reply-To: mark.gross@intel.com, mingo@kernel.org, tglx@linutronix.de,
          bin.yang@intel.com, linux-kernel@vger.kernel.org,
          dave.hansen@intel.com, peterz@infradead.org, hpa@zytor.com
In-Reply-To: <20180919085947.985193217@infradead.org>
References: <20180919085947.985193217@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/cpa: Use flush_tlb_kernel_range()
Git-Commit-ID: a7295fd53c39ce781a9792c9dd2c8747bf274160
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a7295fd53c39ce781a9792c9dd2c8747bf274160
Gitweb:     https://git.kernel.org/tip/a7295fd53c39ce781a9792c9dd2c8747bf274160
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Wed, 19 Sep 2018 10:50:20 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 27 Sep 2018 20:39:41 +0200

x86/mm/cpa: Use flush_tlb_kernel_range()

Both cpa_flush_range() and cpa_flush_array() have a well specified
range, use that to do a range based TLB invalidate.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Cc: Bin Yang <bin.yang@intel.com>
Cc: Mark Gross <mark.gross@intel.com>
Link: https://lkml.kernel.org/r/20180919085947.985193217@infradead.org

---
 arch/x86/mm/pageattr.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index bd9b0ac07352..02eb18403594 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -293,7 +293,7 @@ static void cpa_flush_range(unsigned long start, int numpages, int cache)
 	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
 	WARN_ON(PAGE_ALIGN(start) != start);
 
-	flush_tlb_all();
+	flush_tlb_kernel_range(start, start + PAGE_SIZE * numpages);
 
 	if (!cache)
 		return;
@@ -315,14 +315,15 @@ static void cpa_flush_range(unsigned long start, int numpages, int cache)
 	}
 }
 
-static void cpa_flush_array(unsigned long *start, int numpages, int cache,
+static void cpa_flush_array(unsigned long baddr, unsigned long *start,
+			    int numpages, int cache,
 			    int in_flags, struct page **pages)
 {
 	unsigned int i, level;
 
 	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
 
-	flush_tlb_all();
+	flush_tlb_kernel_range(baddr, baddr + PAGE_SIZE * numpages);
 
 	if (!cache)
 		return;
@@ -1757,7 +1758,7 @@ static int change_page_attr_set_clr(unsigned long *addr, int numpages,
 	 */
 	if (!ret && boot_cpu_has(X86_FEATURE_CLFLUSH)) {
 		if (cpa.flags & (CPA_PAGES_ARRAY | CPA_ARRAY)) {
-			cpa_flush_array(addr, numpages, cache,
+			cpa_flush_array(baddr, addr, numpages, cache,
 					cpa.flags, pages);
 		} else
 			cpa_flush_range(baddr, numpages, cache);
