Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F1AECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD7720673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD7720673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbeGTA4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:56:08 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:12514 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730369AbeGTA4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:56:08 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 495617F55FD633777F95;
        Fri, 20 Jul 2018 08:10:34 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w6K0AHLw046709;
        Fri, 20 Jul 2018 08:10:17 +0800 (GMT-8)
        (envelope-from jiang.biao2@zte.com.cn)
Received: from localhost.localdomain ([10.75.10.200])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018072008102510-1016577 ;
          Fri, 20 Jul 2018 08:10:25 +0800 
From:   Jiang Biao <jiang.biao2@zte.com.cn>
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, hpa@zytor.com,
        x86@kernel.org, albcamus@gmail.com, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, jiang.biao2@zte.com.cn
Subject: [PATCH v4 2/2] x86/pti: check the return value of pti_user_pagetable_walk_pmd
Date:   Fri, 20 Jul 2018 08:06:32 +0800
Message-Id: <1532045192-49622-2-git-send-email-jiang.biao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1532045192-49622-1-git-send-email-jiang.biao2@zte.com.cn>
References: <1532045192-49622-1-git-send-email-jiang.biao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-07-20 08:10:25,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-07-20 08:10:02,
        Serialize complete at 2018-07-20 08:10:02
X-MAIL: mse01.zte.com.cn w6K0AHLw046709
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check the return value of pti_user_pagetable_walk_pmd() to avoid
NULL pointer dereference. And add warning for fail allocation.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 arch/x86/mm/pti.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 8679c64..5cd7b82 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -205,7 +205,7 @@ static pmd_t *pti_user_pagetable_walk_pmd(unsigned long address)
 	BUILD_BUG_ON(p4d_large(*p4d) != 0);
 	if (p4d_none(*p4d)) {
 		unsigned long new_pud_page = __get_free_page(gfp);
-		if (!new_pud_page)
+		if (WARN_ON_ONCE(!new_pud_page))
 			return NULL;

 		set_p4d(p4d, __p4d(_KERNPG_TABLE | __pa(new_pud_page)));
@@ -219,7 +219,7 @@ static pmd_t *pti_user_pagetable_walk_pmd(unsigned long address)
 	}
 	if (pud_none(*pud)) {
 		unsigned long new_pmd_page = __get_free_page(gfp);
-		if (!new_pmd_page)
+		if (WARN_ON_ONCE(!new_pmd_page))
 			return NULL;

 		set_pud(pud, __pud(_KERNPG_TABLE | __pa(new_pmd_page)));
@@ -241,9 +241,13 @@ static pmd_t *pti_user_pagetable_walk_pmd(unsigned long address)
 static __init pte_t *pti_user_pagetable_walk_pte(unsigned long address)
 {
 	gfp_t gfp = (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
-	pmd_t *pmd = pti_user_pagetable_walk_pmd(address);
+	pmd_t *pmd;
 	pte_t *pte;

+	pmd = pti_user_pagetable_walk_pmd(address);
+	if (!pmd)
+		return NULL;
+
 	/* We can't do anything sensible if we hit a large mapping. */
 	if (pmd_large(*pmd)) {
 		WARN_ON(1);
--
2.7.4

