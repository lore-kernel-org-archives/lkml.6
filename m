Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C4AC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E356725763
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E356725763
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030854AbeGARse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:48:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35380 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030756AbeGAQdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:33:24 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5EA0292B;
        Sun,  1 Jul 2018 16:33:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.14 093/157] mm: fix __gup_device_huge vs unmap
Date:   Sun,  1 Jul 2018 18:22:45 +0200
Message-Id: <20180701160857.212121960@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit a9b6de77b1a3ff729f7bfc54b2e17711776a416c upstream.

get_user_pages_fast() for device pages is missing the typical validation
that all page references have been taken while the mapping was valid.
Without this validation truncate operations can not reliably coordinate
against new page reference events like O_DIRECT.

Cc: <stable@vger.kernel.org>
Fixes: 3565fce3a659 ("mm, x86: get_user_pages() for dax mappings")
Reported-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/gup.c |   36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1469,32 +1469,48 @@ static int __gup_device_huge(unsigned lo
 	return 1;
 }
 
-static int __gup_device_huge_pmd(pmd_t pmd, unsigned long addr,
+static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 		unsigned long end, struct page **pages, int *nr)
 {
 	unsigned long fault_pfn;
+	int nr_start = *nr;
 
-	fault_pfn = pmd_pfn(pmd) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
-	return __gup_device_huge(fault_pfn, addr, end, pages, nr);
+	fault_pfn = pmd_pfn(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
+	if (!__gup_device_huge(fault_pfn, addr, end, pages, nr))
+		return 0;
+
+	if (unlikely(pmd_val(orig) != pmd_val(*pmdp))) {
+		undo_dev_pagemap(nr, nr_start, pages);
+		return 0;
+	}
+	return 1;
 }
 
-static int __gup_device_huge_pud(pud_t pud, unsigned long addr,
+static int __gup_device_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 		unsigned long end, struct page **pages, int *nr)
 {
 	unsigned long fault_pfn;
+	int nr_start = *nr;
 
-	fault_pfn = pud_pfn(pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
-	return __gup_device_huge(fault_pfn, addr, end, pages, nr);
+	fault_pfn = pud_pfn(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
+	if (!__gup_device_huge(fault_pfn, addr, end, pages, nr))
+		return 0;
+
+	if (unlikely(pud_val(orig) != pud_val(*pudp))) {
+		undo_dev_pagemap(nr, nr_start, pages);
+		return 0;
+	}
+	return 1;
 }
 #else
-static int __gup_device_huge_pmd(pmd_t pmd, unsigned long addr,
+static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 		unsigned long end, struct page **pages, int *nr)
 {
 	BUILD_BUG();
 	return 0;
 }
 
-static int __gup_device_huge_pud(pud_t pud, unsigned long addr,
+static int __gup_device_huge_pud(pud_t pud, pud_t *pudp, unsigned long addr,
 		unsigned long end, struct page **pages, int *nr)
 {
 	BUILD_BUG();
@@ -1512,7 +1528,7 @@ static int gup_huge_pmd(pmd_t orig, pmd_
 		return 0;
 
 	if (pmd_devmap(orig))
-		return __gup_device_huge_pmd(orig, addr, end, pages, nr);
+		return __gup_device_huge_pmd(orig, pmdp, addr, end, pages, nr);
 
 	refs = 0;
 	page = pmd_page(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
@@ -1550,7 +1566,7 @@ static int gup_huge_pud(pud_t orig, pud_
 		return 0;
 
 	if (pud_devmap(orig))
-		return __gup_device_huge_pud(orig, addr, end, pages, nr);
+		return __gup_device_huge_pud(orig, pudp, addr, end, pages, nr);
 
 	refs = 0;
 	page = pud_page(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);


