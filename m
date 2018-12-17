Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99287C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9D120675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388799AbeLQSXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:23:24 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51101 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbeLQSXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:23:23 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBHIN0wY2561412
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Dec 2018 10:23:00 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBHIN0HP2561409;
        Mon, 17 Dec 2018 10:23:00 -0800
Date:   Mon, 17 Dec 2018 10:23:00 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-5fe26b7a8f4693d532c7a3c3632e47e7d7016238@git.kernel.org>
Cc:     riel@surriel.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        luto@kernel.org, dave.hansen@linux.intel.com, hpa@zytor.com,
        torvalds@linux-foundation.org, bp@alien8.de, mingo@kernel.org,
        peterz@infradead.org
Reply-To: peterz@infradead.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, luto@kernel.org, riel@surriel.com,
          tglx@linutronix.de, dave.hansen@linux.intel.com,
          mingo@kernel.org, torvalds@linux-foundation.org, bp@alien8.de
In-Reply-To: <20181203171043.366619025@infradead.org>
References: <20181203171043.366619025@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/cpa: Simplify the code after making cpa->vaddr
 invariant
Git-Commit-ID: 5fe26b7a8f4693d532c7a3c3632e47e7d7016238
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

Commit-ID:  5fe26b7a8f4693d532c7a3c3632e47e7d7016238
Gitweb:     https://git.kernel.org/tip/5fe26b7a8f4693d532c7a3c3632e47e7d7016238
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Mon, 3 Dec 2018 18:03:48 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Dec 2018 18:54:25 +0100

x86/mm/cpa: Simplify the code after making cpa->vaddr invariant

Since cpa->vaddr is invariant, this means we can remove all
workarounds that deal with it changing.

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
Link: http://lkml.kernel.org/r/20181203171043.366619025@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/pageattr-test.c |  7 ++-----
 arch/x86/mm/pageattr.c      | 13 ++++---------
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/x86/mm/pageattr-test.c b/arch/x86/mm/pageattr-test.c
index b6b6468530f1..facce271e8b9 100644
--- a/arch/x86/mm/pageattr-test.c
+++ b/arch/x86/mm/pageattr-test.c
@@ -124,7 +124,6 @@ static int pageattr_test(void)
 	unsigned int level;
 	int i, k;
 	int err;
-	unsigned long test_addr;
 
 	if (print)
 		printk(KERN_INFO "CPA self-test:\n");
@@ -181,8 +180,7 @@ static int pageattr_test(void)
 
 		switch (i % 3) {
 		case 0:
-			test_addr = addr[i];
-			err = change_page_attr_set(&test_addr, len[i], PAGE_CPA_TEST, 0);
+			err = change_page_attr_set(&addr[i], len[i], PAGE_CPA_TEST, 0);
 			break;
 
 		case 1:
@@ -226,8 +224,7 @@ static int pageattr_test(void)
 			failed++;
 			continue;
 		}
-		test_addr = addr[i];
-		err = change_page_attr_clear(&test_addr, len[i], PAGE_CPA_TEST, 0);
+		err = change_page_attr_clear(&addr[i], len[i], PAGE_CPA_TEST, 0);
 		if (err < 0) {
 			printk(KERN_ERR "CPA reverting failed: %d\n", err);
 			failed++;
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index ce8af3f08628..afa98b7b6050 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -1908,15 +1908,13 @@ EXPORT_SYMBOL_GPL(set_memory_array_wt);
 int _set_memory_wc(unsigned long addr, int numpages)
 {
 	int ret;
-	unsigned long addr_copy = addr;
 
 	ret = change_page_attr_set(&addr, numpages,
 				   cachemode2pgprot(_PAGE_CACHE_MODE_UC_MINUS),
 				   0);
 	if (!ret) {
-		ret = change_page_attr_set_clr(&addr_copy, numpages,
-					       cachemode2pgprot(
-						_PAGE_CACHE_MODE_WC),
+		ret = change_page_attr_set_clr(&addr, numpages,
+					       cachemode2pgprot(_PAGE_CACHE_MODE_WC),
 					       __pgprot(_PAGE_CACHE_MASK),
 					       0, 0, NULL);
 	}
@@ -2064,7 +2062,6 @@ int set_memory_global(unsigned long addr, int numpages)
 static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 {
 	struct cpa_data cpa;
-	unsigned long start;
 	int ret;
 
 	/* Nothing to do if memory encryption is not active */
@@ -2075,8 +2072,6 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 	if (WARN_ONCE(addr & ~PAGE_MASK, "misaligned address: %#lx\n", addr))
 		addr &= PAGE_MASK;
 
-	start = addr;
-
 	memset(&cpa, 0, sizeof(cpa));
 	cpa.vaddr = &addr;
 	cpa.numpages = numpages;
@@ -2091,7 +2086,7 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 	/*
 	 * Before changing the encryption attribute, we need to flush caches.
 	 */
-	cpa_flush_range(start, numpages, 1);
+	cpa_flush_range(addr, numpages, 1);
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
 
@@ -2102,7 +2097,7 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 	 * in case TLB flushing gets optimized in the cpa_flush_range()
 	 * path use the same logic as above.
 	 */
-	cpa_flush_range(start, numpages, 0);
+	cpa_flush_range(addr, numpages, 0);
 
 	return ret;
 }
