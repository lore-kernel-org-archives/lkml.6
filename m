Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C525C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6A32085A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbfAOKqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:46:04 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40075 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbfAOKqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:46:03 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0FAjtf62481713
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 15 Jan 2019 02:45:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0FAjspU2481710;
        Tue, 15 Jan 2019 02:45:54 -0800
Date:   Tue, 15 Jan 2019 02:45:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peng Hao <tipbot@zytor.com>
Message-ID: <tip-bf7d28c53453ea904584960de55e33e03b9d93b1@git.kernel.org>
Cc:     peng.hao2@zte.com.cn, thomas.lendacky@amd.com, tglx@linutronix.de,
        mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
          kirill.shutemov@linux.intel.com, peng.hao2@zte.com.cn,
          thomas.lendacky@amd.com, tglx@linutronix.de
In-Reply-To: <1546065252-97996-1-git-send-email-peng.hao2@zte.com.cn>
References: <1546065252-97996-1-git-send-email-peng.hao2@zte.com.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm/mem_encrypt: Fix erroneous sizeof()
Git-Commit-ID: bf7d28c53453ea904584960de55e33e03b9d93b1
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

Commit-ID:  bf7d28c53453ea904584960de55e33e03b9d93b1
Gitweb:     https://git.kernel.org/tip/bf7d28c53453ea904584960de55e33e03b9d93b1
Author:     Peng Hao <peng.hao2@zte.com.cn>
AuthorDate: Sat, 29 Dec 2018 14:34:12 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 15 Jan 2019 11:41:58 +0100

x86/mm/mem_encrypt: Fix erroneous sizeof()

Using sizeof(pointer) for determining the size of a memset() only works
when the size of the pointer and the size of type to which it points are
the same. For pte_t this is only true for 64bit and 32bit-NONPAE. On 32bit
PAE systems this is wrong as the pointer size is 4 byte but the PTE entry
is 8 bytes. It's actually not a real world issue as this code depends on
64bit, but it's wrong nevertheless.

Use sizeof(*p) for correctness sake.

Fixes: aad983913d77 ("x86/mm/encrypt: Simplify sme_populate_pgd() and sme_populate_pgd_large()")
Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: dave.hansen@linux.intel.com
Cc: peterz@infradead.org
Cc: luto@kernel.org
Link: https://lkml.kernel.org/r/1546065252-97996-1-git-send-email-peng.hao2@zte.com.cn

---
 arch/x86/mm/mem_encrypt_identity.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index a19ef1a416ff..4aa9b1480866 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -158,8 +158,8 @@ static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
 	pmd = pmd_offset(pud, ppd->vaddr);
 	if (pmd_none(*pmd)) {
 		pte = ppd->pgtable_area;
-		memset(pte, 0, sizeof(pte) * PTRS_PER_PTE);
-		ppd->pgtable_area += sizeof(pte) * PTRS_PER_PTE;
+		memset(pte, 0, sizeof(*pte) * PTRS_PER_PTE);
+		ppd->pgtable_area += sizeof(*pte) * PTRS_PER_PTE;
 		set_pmd(pmd, __pmd(PMD_FLAGS | __pa(pte)));
 	}
 
