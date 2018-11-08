Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5338ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F2520892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kjs69boJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F2520892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbeKIHgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:36:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:54046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729261AbeKIHgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:36:31 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C4C820818;
        Thu,  8 Nov 2018 21:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714342;
        bh=UIf7AzYqLiq8H0MOc8czjaVvqWU/7o+lM8RoXQt9TBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kjs69boJPvAJY/79s3OMMYYJwVKMbb2sXYJXFSrKLfZTbGKs9sWylP5HUkOrURdvT
         Jbhb95vJc4ngt/Hy8o39upiuFuEhAmR/fc20Sby62nvQe3G0l7IyFoSKU8jJ+WCUzY
         njNmzgref6Y/z3OENIUW4i/r+k7Hb6GK/0snKzxk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Waiman Long <waiman.long@hpe.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Theodore Tso <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Scott J Norton <scott.norton@hpe.com>,
        Douglas Hatch <doug.hatch@hpe.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 025/114] x86/mm/pat: Prevent hang during boot when mapping pages
Date:   Thu,  8 Nov 2018 13:50:40 -0800
Message-Id: <20181108215101.398014379@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit e535ec0899d1fe52ec3a84c9bc03457ac67ad6f7 ]

There's a mixture of signed 32-bit and unsigned 32-bit and 64-bit data
types used for keeping track of how many pages have been mapped.

This leads to hangs during boot when mapping large numbers of pages
(multiple terabytes, as reported by Waiman) because those values are
interpreted as being negative.

commit 742563777e8d ("x86/mm/pat: Avoid truncation when converting
cpa->numpages to address") fixed one of those bugs, but there is
another lurking in __change_page_attr_set_clr().

Additionally, the return value type for the populate_*() functions can
return negative values when a large number of pages have been mapped,
triggering the error paths even though no error occurred.

Consistently use 64-bit types on 64-bit platforms when counting pages.
Even in the signed case this gives us room for regions 8PiB
(pebibytes) in size whilst still allowing the usual negative value
error checking idiom.

Reported-by: Waiman Long <waiman.long@hpe.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
CC: Theodore Ts'o <tytso@mit.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Scott J Norton <scott.norton@hpe.com>
Cc: Douglas Hatch <doug.hatch@hpe.com>
Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/pageattr.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 0e1dd7d47f05..26598e08666c 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -955,11 +955,11 @@ static void populate_pte(struct cpa_data *cpa,
 	}
 }
 
-static int populate_pmd(struct cpa_data *cpa,
-			unsigned long start, unsigned long end,
-			unsigned num_pages, pud_t *pud, pgprot_t pgprot)
+static long populate_pmd(struct cpa_data *cpa,
+			 unsigned long start, unsigned long end,
+			 unsigned num_pages, pud_t *pud, pgprot_t pgprot)
 {
-	unsigned int cur_pages = 0;
+	long cur_pages = 0;
 	pmd_t *pmd;
 	pgprot_t pmd_pgprot;
 
@@ -1029,12 +1029,12 @@ static int populate_pmd(struct cpa_data *cpa,
 	return num_pages;
 }
 
-static int populate_pud(struct cpa_data *cpa, unsigned long start, pgd_t *pgd,
-			pgprot_t pgprot)
+static long populate_pud(struct cpa_data *cpa, unsigned long start, pgd_t *pgd,
+			 pgprot_t pgprot)
 {
 	pud_t *pud;
 	unsigned long end;
-	int cur_pages = 0;
+	long cur_pages = 0;
 	pgprot_t pud_pgprot;
 
 	end = start + (cpa->numpages << PAGE_SHIFT);
@@ -1090,7 +1090,7 @@ static int populate_pud(struct cpa_data *cpa, unsigned long start, pgd_t *pgd,
 
 	/* Map trailing leftover */
 	if (start < end) {
-		int tmp;
+		long tmp;
 
 		pud = pud_offset(pgd, start);
 		if (pud_none(*pud))
@@ -1116,7 +1116,7 @@ static int populate_pgd(struct cpa_data *cpa, unsigned long addr)
 	pgprot_t pgprot = __pgprot(_KERNPG_TABLE);
 	pud_t *pud = NULL;	/* shut up gcc */
 	pgd_t *pgd_entry;
-	int ret;
+	long ret;
 
 	pgd_entry = cpa->pgd + pgd_index(addr);
 
@@ -1351,7 +1351,8 @@ static int cpa_process_alias(struct cpa_data *cpa)
 
 static int __change_page_attr_set_clr(struct cpa_data *cpa, int checkalias)
 {
-	int ret, numpages = cpa->numpages;
+	unsigned long numpages = cpa->numpages;
+	int ret;
 
 	while (numpages) {
 		/*
-- 
2.17.1



