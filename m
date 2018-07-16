Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6BBECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 04:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57AFB2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 04:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AFB2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeGPErh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 00:47:37 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:16018 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbeGPErh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 00:47:37 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id DBE1357C184BBA45FAF7;
        Mon, 16 Jul 2018 12:06:37 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w6G46ZE0071034;
        Mon, 16 Jul 2018 12:06:35 +0800 (GMT-8)
        (envelope-from jiang.biao2@zte.com.cn)
Received: from localhost.localdomain ([10.75.10.200])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018071612063671-486044 ;
          Mon, 16 Jul 2018 12:06:36 +0800 
From:   Jiang Biao <jiang.biao2@zte.com.cn>
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, hpa@zytor.com,
        x86@kernel.org, albcamus@gmail.com, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, jiang.biao2@zte.com.cn
Subject: [PATCH 2/5] x86/pti: check the return value of pti_user_pagetable_walk_pmd
Date:   Mon, 16 Jul 2018 12:03:37 +0800
Message-Id: <1531713820-24544-3-git-send-email-jiang.biao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1531713820-24544-1-git-send-email-jiang.biao2@zte.com.cn>
References: <1531713820-24544-1-git-send-email-jiang.biao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-07-16 12:06:36,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-07-16 12:06:34,
        Serialize complete at 2018-07-16 12:06:34
X-MAIL: mse01.zte.com.cn w6G46ZE0071034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pti_user_pagetable_walk_pmd() may return NULL, we should check the
return value in pti_user_pagetable_walk_pte() to avoid NULL pointer
dereference like it is checked in pti_clone_pmds().

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 arch/x86/mm/pti.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index be9e5bc..bb6f608 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -239,8 +239,10 @@ static pmd_t *pti_user_pagetable_walk_pmd(unsigned long address)
 static __init pte_t *pti_user_pagetable_walk_pte(unsigned long address)
 {
 	gfp_t gfp = (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
-	pmd_t *pmd = pti_user_pagetable_walk_pmd(address);
 	pte_t *pte;
+	pmd_t *pmd = pti_user_pagetable_walk_pmd(address);
+	if (WARN_ON(!pmd))
+		return NULL;
 
 	/* We can't do anything sensible if we hit a large mapping. */
 	if (pmd_large(*pmd)) {
-- 
2.7.4

