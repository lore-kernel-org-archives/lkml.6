Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85009ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 04:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C402086E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 04:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C402086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeGPErh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 00:47:37 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:7808 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725736AbeGPErh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 00:47:37 -0400
X-Greylist: delayed 939 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Jul 2018 00:47:36 EDT
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 4286E2C023E4CECD85EA;
        Mon, 16 Jul 2018 12:06:50 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w6G46g51071154;
        Mon, 16 Jul 2018 12:06:42 +0800 (GMT-8)
        (envelope-from jiang.biao2@zte.com.cn)
Received: from localhost.localdomain ([10.75.10.200])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018071612064371-486060 ;
          Mon, 16 Jul 2018 12:06:43 +0800 
From:   Jiang Biao <jiang.biao2@zte.com.cn>
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, hpa@zytor.com,
        x86@kernel.org, albcamus@gmail.com, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, jiang.biao2@zte.com.cn
Subject: [PATCH 5/5] x86/pti: constify address parameters
Date:   Mon, 16 Jul 2018 12:03:40 +0800
Message-Id: <1531713820-24544-6-git-send-email-jiang.biao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1531713820-24544-1-git-send-email-jiang.biao2@zte.com.cn>
References: <1531713820-24544-1-git-send-email-jiang.biao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-07-16 12:06:43,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-07-16 12:06:41,
        Serialize complete at 2018-07-16 12:06:41
X-MAIL: mse01.zte.com.cn w6G46g51071154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Addresses passed in pti_user_pagetable_walk_*() are not supposed to
change at runtime, make them const to aviod future slipups.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 arch/x86/mm/pti.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index a368656..ac2cbdd 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -164,7 +164,7 @@ pgd_t __pti_set_user_pgd(pgd_t *pgdp, pgd_t pgd)
  *
  * Returns a pointer to a P4D on success, or NULL on failure.
  */
-static p4d_t *pti_user_pagetable_walk_p4d(unsigned long address)
+static p4d_t *pti_user_pagetable_walk_p4d(const unsigned long address)
 {
 	pgd_t *pgd = kernel_to_user_pgdp(pgd_offset_k(address));
 	gfp_t gfp = (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
@@ -192,7 +192,7 @@ static p4d_t *pti_user_pagetable_walk_p4d(unsigned long address)
  *
  * Returns a pointer to a PMD on success, or NULL on failure.
  */
-static pmd_t *pti_user_pagetable_walk_pmd(unsigned long address)
+static pmd_t *pti_user_pagetable_walk_pmd(const unsigned long address)
 {
 	gfp_t gfp = (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
 	pud_t *pud;
@@ -236,7 +236,7 @@ static pmd_t *pti_user_pagetable_walk_pmd(unsigned long address)
  *
  * Returns a pointer to a PTE on success, or NULL on failure.
  */
-static __init pte_t *pti_user_pagetable_walk_pte(unsigned long address)
+static __init pte_t *pti_user_pagetable_walk_pte(const unsigned long address)
 {
 	gfp_t gfp = (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
 	pte_t *pte;
-- 
2.7.4

