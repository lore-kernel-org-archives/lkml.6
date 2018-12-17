Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D269C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359682133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388868AbeLQSYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:24:36 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42919 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387657AbeLQSYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:24:35 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBHIOBPc2563217
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Dec 2018 10:24:11 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBHIOBr02563214;
        Mon, 17 Dec 2018 10:24:11 -0800
Date:   Mon, 17 Dec 2018 10:24:11 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-83b4e39146aa70913580966e0f2b78b7c3492760@git.kernel.org>
Cc:     riel@surriel.com, peterz@infradead.org, hpa@zytor.com,
        torvalds@linux-foundation.org, bp@alien8.de, tglx@linutronix.de,
        dave.hansen@linux.intel.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: hpa@zytor.com, torvalds@linux-foundation.org, riel@surriel.com,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          mingo@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
          bp@alien8.de, tglx@linutronix.de
In-Reply-To: <20181203171043.493000228@infradead.org>
References: <20181203171043.493000228@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/cpa: Make cpa_data::numpages invariant
Git-Commit-ID: 83b4e39146aa70913580966e0f2b78b7c3492760
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

Commit-ID:  83b4e39146aa70913580966e0f2b78b7c3492760
Gitweb:     https://git.kernel.org/tip/83b4e39146aa70913580966e0f2b78b7c3492760
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Mon, 3 Dec 2018 18:03:50 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Dec 2018 18:54:27 +0100

x86/mm/cpa: Make cpa_data::numpages invariant

Make sure __change_page_attr_set_clr() doesn't modify cpa->numpages.

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
Link: http://lkml.kernel.org/r/20181203171043.493000228@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/pageattr.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 351874259a71..12b69263e501 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -1625,14 +1625,15 @@ static int cpa_process_alias(struct cpa_data *cpa)
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
@@ -1643,12 +1644,12 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa, int checkalias)
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
@@ -1656,11 +1657,15 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa, int checkalias)
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
