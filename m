Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECE6C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63342146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388742AbeLQSVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:21:04 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60995 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbeLQSVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:21:04 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBHIKcYZ2561019
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Dec 2018 10:20:39 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBHIKcWR2561016;
        Mon, 17 Dec 2018 10:20:38 -0800
Date:   Mon, 17 Dec 2018 10:20:38 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-721066dfd4d5c0fee5772c777d6930d0f423b4eb@git.kernel.org>
Cc:     dave.hansen@linux.intel.com, riel@surriel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, hpa@zytor.com, Tom.StDenis@amd.com,
        bp@alien8.de, mingo@kernel.org, luto@kernel.org
Reply-To: luto@kernel.org, mingo@kernel.org, Tom.StDenis@amd.com,
          bp@alien8.de, linux-kernel@vger.kernel.org, riel@surriel.com,
          tglx@linutronix.de, dave.hansen@linux.intel.com, hpa@zytor.com,
          torvalds@linux-foundation.org, peterz@infradead.org
In-Reply-To: <20181203171043.089868285@infradead.org>
References: <20181203171043.089868285@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/cpa: Fix cpa_flush_array() TLB invalidation
Git-Commit-ID: 721066dfd4d5c0fee5772c777d6930d0f423b4eb
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

Commit-ID:  721066dfd4d5c0fee5772c777d6930d0f423b4eb
Gitweb:     https://git.kernel.org/tip/721066dfd4d5c0fee5772c777d6930d0f423b4eb
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Mon, 3 Dec 2018 18:03:44 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Dec 2018 18:48:09 +0100

x86/mm/cpa: Fix cpa_flush_array() TLB invalidation

In commit:

  a7295fd53c39 ("x86/mm/cpa: Use flush_tlb_kernel_range()")

I misread the CAP array code and incorrectly used
tlb_flush_kernel_range(), resulting in missing TLB flushes and
consequent failures.

Instead do a full invalidate in this case -- for now.

Reported-by: StDenis, Tom <Tom.StDenis@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dave.hansen@intel.com
Fixes: a7295fd53c39 ("x86/mm/cpa: Use flush_tlb_kernel_range()")
Link: http://lkml.kernel.org/r/20181203171043.089868285@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/pageattr.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index db7a10082238..a1bcde35db4c 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -285,20 +285,16 @@ static void cpa_flush_all(unsigned long cache)
 	on_each_cpu(__cpa_flush_all, (void *) cache, 1);
 }
 
-static bool __cpa_flush_range(unsigned long start, int numpages, int cache)
+static bool __inv_flush_all(int cache)
 {
 	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
 
-	WARN_ON(PAGE_ALIGN(start) != start);
-
 	if (cache && !static_cpu_has(X86_FEATURE_CLFLUSH)) {
 		cpa_flush_all(cache);
 		return true;
 	}
 
-	flush_tlb_kernel_range(start, start + PAGE_SIZE * numpages);
-
-	return !cache;
+	return false;
 }
 
 static void cpa_flush_range(unsigned long start, int numpages, int cache)
@@ -306,7 +302,14 @@ static void cpa_flush_range(unsigned long start, int numpages, int cache)
 	unsigned int i, level;
 	unsigned long addr;
 
-	if (__cpa_flush_range(start, numpages, cache))
+	WARN_ON(PAGE_ALIGN(start) != start);
+
+	if (__inv_flush_all(cache))
+		return;
+
+	flush_tlb_kernel_range(start, start + PAGE_SIZE * numpages);
+
+	if (!cache)
 		return;
 
 	/*
@@ -332,7 +335,12 @@ static void cpa_flush_array(unsigned long baddr, unsigned long *start,
 {
 	unsigned int i, level;
 
-	if (__cpa_flush_range(baddr, numpages, cache))
+	if (__inv_flush_all(cache))
+		return;
+
+	flush_tlb_all();
+
+	if (!cache)
 		return;
 
 	/*
