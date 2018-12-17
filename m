Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2334BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000532146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388768AbeLQSWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:22:36 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35025 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbeLQSWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:22:36 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBHILDnt2561256
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Dec 2018 10:21:13 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBHILCrQ2561253;
        Mon, 17 Dec 2018 10:21:12 -0800
Date:   Mon, 17 Dec 2018 10:21:12 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-ecc729f1f47142ad31741549f400b611435c1af7@git.kernel.org>
Cc:     peterz@infradead.org, riel@surriel.com,
        torvalds@linux-foundation.org, bp@alien8.de, hpa@zytor.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        dave.hansen@linux.intel.com, luto@kernel.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          dave.hansen@linux.intel.com, luto@kernel.org, riel@surriel.com,
          peterz@infradead.org, torvalds@linux-foundation.org,
          bp@alien8.de, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20181203171043.162771364@infradead.org>
References: <20181203171043.162771364@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/cpa: Add ARRAY and PAGES_ARRAY selftests
Git-Commit-ID: ecc729f1f47142ad31741549f400b611435c1af7
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

Commit-ID:  ecc729f1f47142ad31741549f400b611435c1af7
Gitweb:     https://git.kernel.org/tip/ecc729f1f47142ad31741549f400b611435c1af7
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Mon, 3 Dec 2018 18:03:45 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Dec 2018 18:54:22 +0100

x86/mm/cpa: Add ARRAY and PAGES_ARRAY selftests

The current pageattr-test code only uses the regular range interface,
add code that also tests the array and pages interface.

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
Link: http://lkml.kernel.org/r/20181203171043.162771364@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/pageattr-test.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/pageattr-test.c b/arch/x86/mm/pageattr-test.c
index 08f8f76a4852..b6b6468530f1 100644
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
@@ -110,6 +111,9 @@ static int print_split(struct split_state *s)
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
