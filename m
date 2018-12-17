Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFCDC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1686920675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388780AbeLQSWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:22:48 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51859 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbeLQSWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:22:48 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBHIMOD82561342
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Dec 2018 10:22:24 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBHIMOdt2561339;
        Mon, 17 Dec 2018 10:22:24 -0800
Date:   Mon, 17 Dec 2018 10:22:24 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-98bfc9b038cde1ce108f69a50720e394fe774cb7@git.kernel.org>
Cc:     dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        peterz@infradead.org, riel@surriel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, bp@alien8.de
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, bp@alien8.de, torvalds@linux-foundation.org,
          hpa@zytor.com, luto@kernel.org, dave.hansen@linux.intel.com,
          peterz@infradead.org, riel@surriel.com
In-Reply-To: <20181203171043.295174892@infradead.org>
References: <20181203171043.295174892@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/cpa: Make cpa_data::vaddr invariant
Git-Commit-ID: 98bfc9b038cde1ce108f69a50720e394fe774cb7
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

Commit-ID:  98bfc9b038cde1ce108f69a50720e394fe774cb7
Gitweb:     https://git.kernel.org/tip/98bfc9b038cde1ce108f69a50720e394fe774cb7
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Mon, 3 Dec 2018 18:03:47 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Dec 2018 18:54:24 +0100

x86/mm/cpa: Make cpa_data::vaddr invariant

Currently __change_page_attr_set_clr() will modify cpa->vaddr when
!(CPA_ARRAY | CPA_PAGES_ARRAY), whereas in the array cases it will
increment cpa->curpage.

Change __cpa_addr() such that its @idx argument also works in the
!array case and use cpa->curpage increments for all cases.

NOTE: since cpa_data::numpages is 'unsigned long' so should cpa_data::curpage be.
NOTE: after this only cpa->numpages is still modified.

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
Link: http://lkml.kernel.org/r/20181203171043.295174892@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/pageattr.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 6e6900ebea30..ce8af3f08628 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -35,11 +35,11 @@ struct cpa_data {
 	pgprot_t	mask_set;
 	pgprot_t	mask_clr;
 	unsigned long	numpages;
-	int		flags;
+	unsigned long	curpage;
 	unsigned long	pfn;
-	unsigned	force_split		: 1,
+	unsigned int	flags;
+	unsigned int	force_split		: 1,
 			force_static_prot	: 1;
-	int		curpage;
 	struct page	**pages;
 };
 
@@ -228,7 +228,7 @@ static bool __cpa_pfn_in_highmap(unsigned long pfn)
 
 #endif
 
-static unsigned long __cpa_addr(struct cpa_data *cpa, int idx)
+static unsigned long __cpa_addr(struct cpa_data *cpa, unsigned long idx)
 {
 	if (cpa->flags & CPA_PAGES_ARRAY) {
 		struct page *page = cpa->pages[idx];
@@ -242,7 +242,7 @@ static unsigned long __cpa_addr(struct cpa_data *cpa, int idx)
 	if (cpa->flags & CPA_ARRAY)
 		return cpa->vaddr[idx];
 
-	return *cpa->vaddr;
+	return *cpa->vaddr + idx * PAGE_SIZE;
 }
 
 /*
@@ -1581,6 +1581,7 @@ static int cpa_process_alias(struct cpa_data *cpa)
 		alias_cpa = *cpa;
 		alias_cpa.vaddr = &laddr;
 		alias_cpa.flags &= ~(CPA_PAGES_ARRAY | CPA_ARRAY);
+		alias_cpa.curpage = 0;
 
 		ret = __change_page_attr_set_clr(&alias_cpa, 0);
 		if (ret)
@@ -1600,6 +1601,7 @@ static int cpa_process_alias(struct cpa_data *cpa)
 		alias_cpa = *cpa;
 		alias_cpa.vaddr = &temp_cpa_vaddr;
 		alias_cpa.flags &= ~(CPA_PAGES_ARRAY | CPA_ARRAY);
+		alias_cpa.curpage = 0;
 
 		/*
 		 * The high mapping range is imprecise, so ignore the
@@ -1648,11 +1650,7 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa, int checkalias)
 		 */
 		BUG_ON(cpa->numpages > numpages || !cpa->numpages);
 		numpages -= cpa->numpages;
-		if (cpa->flags & (CPA_PAGES_ARRAY | CPA_ARRAY))
-			cpa->curpage++;
-		else
-			*cpa->vaddr += cpa->numpages * PAGE_SIZE;
-
+		cpa->curpage += cpa->numpages;
 	}
 	return 0;
 }
