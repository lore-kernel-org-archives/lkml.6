Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4455C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2D421849
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388922AbeLQSZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:25:48 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57467 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbeLQSZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:25:48 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBHIPPAB2563375
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Dec 2018 10:25:25 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBHIPOC72563372;
        Mon, 17 Dec 2018 10:25:24 -0800
Date:   Mon, 17 Dec 2018 10:25:24 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-c38116bb940ae37f51fccd315b420ee5961dcb76@git.kernel.org>
Cc:     torvalds@linux-foundation.org, luto@kernel.org,
        dave.hansen@linux.intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        peterz@infradead.org, riel@surriel.com, bp@alien8.de
Reply-To: torvalds@linux-foundation.org, dave.hansen@linux.intel.com,
          mingo@kernel.org, luto@kernel.org, tglx@linutronix.de,
          hpa@zytor.com, linux-kernel@vger.kernel.org,
          peterz@infradead.org, riel@surriel.com, bp@alien8.de
In-Reply-To: <20181203171043.626999883@infradead.org>
References: <20181203171043.626999883@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/cpa: Better use CLFLUSHOPT
Git-Commit-ID: c38116bb940ae37f51fccd315b420ee5961dcb76
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

Commit-ID:  c38116bb940ae37f51fccd315b420ee5961dcb76
Gitweb:     https://git.kernel.org/tip/c38116bb940ae37f51fccd315b420ee5961dcb76
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Mon, 3 Dec 2018 18:03:52 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Dec 2018 18:54:29 +0100

x86/mm/cpa: Better use CLFLUSHOPT

Currently we issue an MFENCE before and after flushing a range. This
means that if we flush a bunch of single page ranges -- like with the
cpa array, we issue a whole bunch of superfluous MFENCEs.

Reorgainze the code a little to avoid this.

[ mingo: capitalize instructions, tweak changelog and comments. ]

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
Link: http://lkml.kernel.org/r/20181203171043.626999883@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/pageattr.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 85ef53b86fa0..7d05149995dc 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -251,15 +251,7 @@ static unsigned long __cpa_addr(struct cpa_data *cpa, unsigned long idx)
  * Flushing functions
  */
 
-/**
- * clflush_cache_range - flush a cache range with clflush
- * @vaddr:	virtual start address
- * @size:	number of bytes to flush
- *
- * clflushopt is an unordered instruction which needs fencing with mfence or
- * sfence to avoid ordering issues.
- */
-void clflush_cache_range(void *vaddr, unsigned int size)
+static void clflush_cache_range_opt(void *vaddr, unsigned int size)
 {
 	const unsigned long clflush_size = boot_cpu_data.x86_clflush_size;
 	void *p = (void *)((unsigned long)vaddr & ~(clflush_size - 1));
@@ -268,11 +260,22 @@ void clflush_cache_range(void *vaddr, unsigned int size)
 	if (p >= vend)
 		return;
 
-	mb();
-
 	for (; p < vend; p += clflush_size)
 		clflushopt(p);
+}
 
+/**
+ * clflush_cache_range - flush a cache range with clflush
+ * @vaddr:	virtual start address
+ * @size:	number of bytes to flush
+ *
+ * CLFLUSHOPT is an unordered instruction which needs fencing with MFENCE or
+ * SFENCE to avoid ordering issues.
+ */
+void clflush_cache_range(void *vaddr, unsigned int size)
+{
+	mb();
+	clflush_cache_range_opt(vaddr, size);
 	mb();
 }
 EXPORT_SYMBOL_GPL(clflush_cache_range);
@@ -333,6 +336,7 @@ static void cpa_flush(struct cpa_data *data, int cache)
 	if (!cache)
 		return;
 
+	mb();
 	for (i = 0; i < cpa->numpages; i++) {
 		unsigned long addr = __cpa_addr(cpa, i);
 		unsigned int level;
@@ -343,8 +347,9 @@ static void cpa_flush(struct cpa_data *data, int cache)
 		 * Only flush present addresses:
 		 */
 		if (pte && (pte_val(*pte) & _PAGE_PRESENT))
-			clflush_cache_range((void *)addr, PAGE_SIZE);
+			clflush_cache_range_opt((void *)addr, PAGE_SIZE);
 	}
+	mb();
 }
 
 static bool overlaps(unsigned long r1_start, unsigned long r1_end,
