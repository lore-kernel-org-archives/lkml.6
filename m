Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B39C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5924D261B4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5924D261B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965527AbeF0OQt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:16:49 -0400
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:56418 "EHLO
        g9t5009.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965214AbeF0OPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:15:50 -0400
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id E799F51;
        Wed, 27 Jun 2018 14:15:48 +0000 (UTC)
Received: from misato.americas.hpqcorp.net (unknown [10.34.81.122])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 295AC47;
        Wed, 27 Jun 2018 14:15:48 +0000 (UTC)
From:   Toshi Kani <toshi.kani@hpe.com>
To:     mhocko@suse.com, akpm@linux-foundation.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com
Cc:     cpandya@codeaurora.org, linux-mm@kvack.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Toshi Kani <toshi.kani@hpe.com>,
        Joerg Roedel <joro@8bytes.org>, stable@vger.kernel.org
Subject: [PATCH v4 1/3] x86/mm: disable ioremap free page handling on x86-PAE
Date:   Wed, 27 Jun 2018 08:13:46 -0600
Message-Id: <20180627141348.21777-2-toshi.kani@hpe.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180627141348.21777-1-toshi.kani@hpe.com>
References: <20180627141348.21777-1-toshi.kani@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ioremap() supports pmd mappings on x86-PAE.  However, kernel's pmd
tables are not shared among processes on x86-PAE.  Therefore, any
update to sync'd pmd entries need re-syncing.  Freeing a pte page
also leads to a vmalloc fault and hits the BUG_ON in vmalloc_sync_one().

Disable free page handling on x86-PAE.  pud_free_pmd_page() and
pmd_free_pte_page() simply return 0 if a given pud/pmd entry is present.
This assures that ioremap() does not update sync'd pmd entries at the
cost of falling back to pte mappings.

Fixes: 28ee90fe6048 ("x86/mm: implement free pmd/pte page interfaces")
Reported-by: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: <stable@vger.kernel.org>
---
 arch/x86/mm/pgtable.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 47b5951e592b..1aeb7a5dbce5 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -719,6 +719,7 @@ int pmd_clear_huge(pmd_t *pmd)
 	return 0;
 }
 
+#ifdef CONFIG_X86_64
 /**
  * pud_free_pmd_page - Clear pud entry and free pmd page.
  * @pud: Pointer to a PUD.
@@ -766,4 +767,22 @@ int pmd_free_pte_page(pmd_t *pmd)
 
 	return 1;
 }
+
+#else /* !CONFIG_X86_64 */
+
+int pud_free_pmd_page(pud_t *pud)
+{
+	return pud_none(*pud);
+}
+
+/*
+ * Disable free page handling on x86-PAE. This assures that ioremap()
+ * does not update sync'd pmd entries. See vmalloc_sync_one().
+ */
+int pmd_free_pte_page(pmd_t *pmd)
+{
+	return pmd_none(*pmd);
+}
+
+#endif /* CONFIG_X86_64 */
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
