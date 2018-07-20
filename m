Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC03ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7562C20673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7562C20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbeGTA4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:56:08 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:13526 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730382AbeGTA4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:56:08 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 4881047543D5DA96C95A;
        Fri, 20 Jul 2018 08:10:34 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w6K0AEJ2046705;
        Fri, 20 Jul 2018 08:10:14 +0800 (GMT-8)
        (envelope-from jiang.biao2@zte.com.cn)
Received: from localhost.localdomain ([10.75.10.200])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018072008102210-1016576 ;
          Fri, 20 Jul 2018 08:10:22 +0800 
From:   Jiang Biao <jiang.biao2@zte.com.cn>
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, hpa@zytor.com,
        x86@kernel.org, albcamus@gmail.com, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, jiang.biao2@zte.com.cn
Subject: [PATCH v4 1/2] x86/pti: check the return value of pti_user_pagetable_walk_p4d
Date:   Fri, 20 Jul 2018 08:06:31 +0800
Message-Id: <1532045192-49622-1-git-send-email-jiang.biao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-07-20 08:10:22,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-07-20 08:09:59,
        Serialize complete at 2018-07-20 08:09:59
X-MAIL: mse01.zte.com.cn w6K0AEJ2046705
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pti_user_pagetable_walk_p4d() may return NULL, we should check the
return value to avoid NULL pointer dereference. And add warning
for fail allocation where NULL returned.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 arch/x86/mm/pti.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 4d418e7..8679c64 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -176,7 +176,7 @@ static p4d_t *pti_user_pagetable_walk_p4d(unsigned long address)

 	if (pgd_none(*pgd)) {
 		unsigned long new_p4d_page = __get_free_page(gfp);
-		if (!new_p4d_page)
+		if (WARN_ON_ONCE(!new_p4d_page))
 			return NULL;

 		set_pgd(pgd, __pgd(_KERNPG_TABLE | __pa(new_p4d_page)));
@@ -195,9 +195,13 @@ static p4d_t *pti_user_pagetable_walk_p4d(unsigned long address)
 static pmd_t *pti_user_pagetable_walk_pmd(unsigned long address)
 {
 	gfp_t gfp = (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
-	p4d_t *p4d = pti_user_pagetable_walk_p4d(address);
+	p4d_t *p4d;
 	pud_t *pud;

+	p4d = pti_user_pagetable_walk_p4d(address);
+	if (!p4d)
+		return NULL;
+
 	BUILD_BUG_ON(p4d_large(*p4d) != 0);
 	if (p4d_none(*p4d)) {
 		unsigned long new_pud_page = __get_free_page(gfp);
@@ -354,6 +358,9 @@ static void __init pti_clone_p4d(unsigned long addr)
 	pgd_t *kernel_pgd;

 	user_p4d = pti_user_pagetable_walk_p4d(addr);
+	if (!user_p4d)
+		return;
+
 	kernel_pgd = pgd_offset_k(addr);
 	kernel_p4d = p4d_offset(kernel_pgd, addr);
 	*user_p4d = *kernel_p4d;
--
2.7.4

