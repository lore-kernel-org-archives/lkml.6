Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F013ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFEA2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEFEA2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbeGQH4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:56:54 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:7100 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbeGQH4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:56:54 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id CE42CD2247AF4BF092D3;
        Tue, 17 Jul 2018 15:25:40 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w6H7PBdx019271;
        Tue, 17 Jul 2018 15:25:11 +0800 (GMT-8)
        (envelope-from jiang.biao2@zte.com.cn)
Received: from localhost.localdomain ([10.75.10.200])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018071715251567-691894 ;
          Tue, 17 Jul 2018 15:25:15 +0800 
From:   Jiang Biao <jiang.biao2@zte.com.cn>
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, hpa@zytor.com,
        x86@kernel.org, albcamus@gmail.com, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, jiang.biao2@zte.com.cn
Subject: [PATCH v2 2/2] x86/pti: check the return value of pti_user_pagetable_walk_pmd
Date:   Tue, 17 Jul 2018 15:23:22 +0800
Message-Id: <1531812202-37778-2-git-send-email-jiang.biao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1531812202-37778-1-git-send-email-jiang.biao2@zte.com.cn>
References: <1531812202-37778-1-git-send-email-jiang.biao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-07-17 15:25:15,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-07-17 15:25:07,
        Serialize complete at 2018-07-17 15:25:07
X-MAIL: mse01.zte.com.cn w6H7PBdx019271
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check the return value of pti_user_pagetable_walk_pmd() to avoid
NULL pointer dereference. And add warning for fail allocation.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 arch/x86/mm/pti.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 7c402e9..3dba6a7 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -203,7 +203,7 @@ static pmd_t *pti_user_pagetable_walk_pmd(unsigned long address)
 	BUILD_BUG_ON(p4d_large(*p4d) != 0);
 	if (p4d_none(*p4d)) {
 		unsigned long new_pud_page = __get_free_page(gfp);
-		if (!new_pud_page)
+		if (WARN_ON(!new_pud_page))
 			return NULL;
 
 		set_p4d(p4d, __p4d(_KERNPG_TABLE | __pa(new_pud_page)));
@@ -217,7 +217,7 @@ static pmd_t *pti_user_pagetable_walk_pmd(unsigned long address)
 	}
 	if (pud_none(*pud)) {
 		unsigned long new_pmd_page = __get_free_page(gfp);
-		if (!new_pmd_page)
+		if (WARN_ON(!new_pmd_page))
 			return NULL;
 
 		set_pud(pud, __pud(_KERNPG_TABLE | __pa(new_pmd_page)));
@@ -239,8 +239,10 @@ static pmd_t *pti_user_pagetable_walk_pmd(unsigned long address)
 static __init pte_t *pti_user_pagetable_walk_pte(unsigned long address)
 {
 	gfp_t gfp = (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
-	pmd_t *pmd = pti_user_pagetable_walk_pmd(address);
 	pte_t *pte;
+	pmd_t *pmd = pti_user_pagetable_walk_pmd(address);
+	if (!pmd)
+		return NULL;
 
 	/* We can't do anything sensible if we hit a large mapping. */
 	if (pmd_large(*pmd)) {
-- 
2.7.4

