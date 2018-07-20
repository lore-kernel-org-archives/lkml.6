Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53133ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 05:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D65220850
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 05:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D65220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbeGTF4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 01:56:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43709 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeGTF4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 01:56:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6K5ALAj2538379
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 22:10:21 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6K5ALV52538376;
        Thu, 19 Jul 2018 22:10:21 -0700
Date:   Thu, 19 Jul 2018 22:10:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiang Biao <tipbot@zytor.com>
Message-ID: <tip-8c934e01a7ce685d98e970880f5941d79272c654@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, jiang.biao2@zte.com.cn
Reply-To: linux-kernel@vger.kernel.org, jiang.biao2@zte.com.cn,
          hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <1532045192-49622-2-git-send-email-jiang.biao2@zte.com.cn>
References: <1532045192-49622-2-git-send-email-jiang.biao2@zte.com.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/pti: Check the return value of
 pti_user_pagetable_walk_pmd()
Git-Commit-ID: 8c934e01a7ce685d98e970880f5941d79272c654
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

Commit-ID:  8c934e01a7ce685d98e970880f5941d79272c654
Gitweb:     https://git.kernel.org/tip/8c934e01a7ce685d98e970880f5941d79272c654
Author:     Jiang Biao <jiang.biao2@zte.com.cn>
AuthorDate: Fri, 20 Jul 2018 08:06:32 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 07:07:39 +0200

x86/pti: Check the return value of pti_user_pagetable_walk_pmd()

pti_user_pagetable_walk_pmd() can return NULL, so the return value should
be checked to prevent a NULL pointer dereference.

Add the check and a warning when the PMD allocation fails.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: dave.hansen@linux.intel.com
Cc: luto@kernel.org
Cc: hpa@zytor.com
Cc: albcamus@gmail.com
Cc: zhong.weidong@zte.com.cn
Link: https://lkml.kernel.org/r/1532045192-49622-2-git-send-email-jiang.biao2@zte.com.cn

---
 arch/x86/mm/pti.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 001ee6b0619e..bcf35dac1920 100644
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
