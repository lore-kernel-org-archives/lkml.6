Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725FEECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 05:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1822084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 05:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1822084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbeGTF4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 01:56:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53371 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeGTF4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 01:56:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6K59o2Q2538298
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 22:09:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6K59m8D2538290;
        Thu, 19 Jul 2018 22:09:48 -0700
Date:   Thu, 19 Jul 2018 22:09:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiang Biao <tipbot@zytor.com>
Message-ID: <tip-b2b7d986a89b6c94b1331a909de1217214fb08c1@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, jiang.biao2@zte.com.cn
Reply-To: jiang.biao2@zte.com.cn, linux-kernel@vger.kernel.org,
          hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <1532045192-49622-1-git-send-email-jiang.biao2@zte.com.cn>
References: <1532045192-49622-1-git-send-email-jiang.biao2@zte.com.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/pti: Check the return value of
 pti_user_pagetable_walk_p4d()
Git-Commit-ID: b2b7d986a89b6c94b1331a909de1217214fb08c1
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

Commit-ID:  b2b7d986a89b6c94b1331a909de1217214fb08c1
Gitweb:     https://git.kernel.org/tip/b2b7d986a89b6c94b1331a909de1217214fb08c1
Author:     Jiang Biao <jiang.biao2@zte.com.cn>
AuthorDate: Fri, 20 Jul 2018 08:06:31 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 07:07:39 +0200

x86/pti: Check the return value of pti_user_pagetable_walk_p4d()

pti_user_pagetable_walk_p4d() can return NULL, so the return value should
be checked to prevent a NULL pointer dereference.

Add the check and a warning when the P4D allocation fails.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: dave.hansen@linux.intel.com
Cc: luto@kernel.org
Cc: hpa@zytor.com
Cc: albcamus@gmail.com
Cc: zhong.weidong@zte.com.cn
Link: https://lkml.kernel.org/r/1532045192-49622-1-git-send-email-jiang.biao2@zte.com.cn

---
 arch/x86/mm/pti.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 7b1c85759005..001ee6b0619e 100644
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
@@ -359,6 +363,9 @@ static void __init pti_clone_p4d(unsigned long addr)
 	pgd_t *kernel_pgd;
 
 	user_p4d = pti_user_pagetable_walk_p4d(addr);
+	if (!user_p4d)
+		return;
+
 	kernel_pgd = pgd_offset_k(addr);
 	kernel_p4d = p4d_offset(kernel_pgd, addr);
 	*user_p4d = *kernel_p4d;
