Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4599C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBCF2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388766AbeLQSWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:22:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34717 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbeLQSWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:22:11 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBHILljW2561307
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Dec 2018 10:21:47 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBHILlM62561304;
        Mon, 17 Dec 2018 10:21:47 -0800
Date:   Mon, 17 Dec 2018 10:21:47 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-16ebf031e8ab73779a382c9f2b097891da6af923@git.kernel.org>
Cc:     tglx@linutronix.de, luto@kernel.org, torvalds@linux-foundation.org,
        bp@alien8.de, dave.hansen@linux.intel.com, mingo@kernel.org,
        riel@surriel.com, peterz@infradead.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: torvalds@linux-foundation.org, bp@alien8.de, mingo@kernel.org,
          dave.hansen@linux.intel.com, riel@surriel.com,
          peterz@infradead.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, luto@kernel.org
In-Reply-To: <20181203171043.229119497@infradead.org>
References: <20181203171043.229119497@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/cpa: Add __cpa_addr() helper
Git-Commit-ID: 16ebf031e8ab73779a382c9f2b097891da6af923
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

Commit-ID:  16ebf031e8ab73779a382c9f2b097891da6af923
Gitweb:     https://git.kernel.org/tip/16ebf031e8ab73779a382c9f2b097891da6af923
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Mon, 3 Dec 2018 18:03:46 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Dec 2018 18:54:23 +0100

x86/mm/cpa: Add __cpa_addr() helper

The code to compute the virtual address of a cpa_data is duplicated;
introduce a helper before more copies happen.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom.StDenis@amd.com
Cc: dave.hansen@intel.com
Link: http://lkml.kernel.org/r/20181203171043.229119497@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/pageattr.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index a1bcde35db4c..6e6900ebea30 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -228,6 +228,23 @@ static bool __cpa_pfn_in_highmap(unsigned long pfn)
 
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
@@ -1476,15 +1493,7 @@ static int __change_page_attr(struct cpa_data *cpa, int primary)
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
@@ -1565,16 +1574,7 @@ static int cpa_process_alias(struct cpa_data *cpa)
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
 
