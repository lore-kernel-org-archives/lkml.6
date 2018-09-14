Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DBCFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CC920833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0CC920833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeINU23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:28:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44741 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbeINU22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:28:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8EFCtS43459405
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Sep 2018 08:12:56 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8EFCswc3459401;
        Fri, 14 Sep 2018 08:12:54 -0700
Date:   Fri, 14 Sep 2018 08:12:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-61a6bd83abf2f14b2a917b6a0279c88d299267af@git.kernel.org>
Cc:     bp@alien8.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
        mingo@kernel.org, aarcange@redhat.com,
        torvalds@linux-foundation.org, dave.hansen@intel.com,
        luto@kernel.org, mroos@linux.ee, tglx@linutronix.de,
        jroedel@suse.de
Reply-To: tglx@linutronix.de, jroedel@suse.de, mroos@linux.ee,
          luto@kernel.org, dave.hansen@intel.com, aarcange@redhat.com,
          torvalds@linux-foundation.org, mingo@kernel.org, hpa@zytor.com,
          bp@alien8.de, linux-kernel@vger.kernel.org
In-Reply-To: <1536922754-31379-1-git-send-email-joro@8bytes.org>
References: <1536922754-31379-1-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] Revert "x86/mm/legacy: Populate the user
 page-table with user pgd's"
Git-Commit-ID: 61a6bd83abf2f14b2a917b6a0279c88d299267af
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

Commit-ID:  61a6bd83abf2f14b2a917b6a0279c88d299267af
Gitweb:     https://git.kernel.org/tip/61a6bd83abf2f14b2a917b6a0279c88d299267af
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Fri, 14 Sep 2018 12:59:14 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 14 Sep 2018 17:08:45 +0200

Revert "x86/mm/legacy: Populate the user page-table with user pgd's"

This reverts commit 1f40a46cf47c12d93a5ad9dccd82bd36ff8f956a.

It turned out that this patch is not sufficient to enable PTI on 32 bit
systems with legacy 2-level page-tables. In this paging mode the huge-page
PTEs are in the top-level page-table directory, where also the mirroring to
the user-space page-table happens. So every huge PTE exits twice, in the
kernel and in the user page-table.

That means that accessed/dirty bits need to be fetched from two PTEs in
this mode to be safe, but this is not trivial to implement because it needs
changes to generic code just for the sake of enabling PTI with 32-bit
legacy paging. As all systems that need PTI should support PAE anyway,
remove support for PTI when 32-bit legacy paging is used.

Fixes: 7757d607c6b3 ('x86/pti: Allow CONFIG_PAGE_TABLE_ISOLATION for x86_32')
Reported-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: hpa@zytor.com
Cc: linux-mm@kvack.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Link: https://lkml.kernel.org/r/1536922754-31379-1-git-send-email-joro@8bytes.org

---
 arch/x86/include/asm/pgtable-2level.h | 9 ---------
 security/Kconfig                      | 2 +-
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/pgtable-2level.h b/arch/x86/include/asm/pgtable-2level.h
index 24c6cf5f16b7..60d0f9015317 100644
--- a/arch/x86/include/asm/pgtable-2level.h
+++ b/arch/x86/include/asm/pgtable-2level.h
@@ -19,9 +19,6 @@ static inline void native_set_pte(pte_t *ptep , pte_t pte)
 
 static inline void native_set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
-	pmd.pud.p4d.pgd = pti_set_user_pgtbl(&pmdp->pud.p4d.pgd, pmd.pud.p4d.pgd);
-#endif
 	*pmdp = pmd;
 }
 
@@ -61,9 +58,6 @@ static inline pte_t native_ptep_get_and_clear(pte_t *xp)
 #ifdef CONFIG_SMP
 static inline pmd_t native_pmdp_get_and_clear(pmd_t *xp)
 {
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
-	pti_set_user_pgtbl(&xp->pud.p4d.pgd, __pgd(0));
-#endif
 	return __pmd(xchg((pmdval_t *)xp, 0));
 }
 #else
@@ -73,9 +67,6 @@ static inline pmd_t native_pmdp_get_and_clear(pmd_t *xp)
 #ifdef CONFIG_SMP
 static inline pud_t native_pudp_get_and_clear(pud_t *xp)
 {
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
-	pti_set_user_pgtbl(&xp->p4d.pgd, __pgd(0));
-#endif
 	return __pud(xchg((pudval_t *)xp, 0));
 }
 #else
diff --git a/security/Kconfig b/security/Kconfig
index 27d8b2688f75..d9aa521b5206 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -57,7 +57,7 @@ config SECURITY_NETWORK
 config PAGE_TABLE_ISOLATION
 	bool "Remove the kernel mapping in user mode"
 	default y
-	depends on X86 && !UML
+	depends on (X86_64 || X86_PAE) && !UML
 	help
 	  This feature reduces the number of hardware side channels by
 	  ensuring that the majority of kernel addresses are not mapped
