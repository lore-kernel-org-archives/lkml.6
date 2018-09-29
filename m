Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8525C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5333206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5333206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbeI3E3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:29:42 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51640 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728041AbeI3ESY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:24 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N63-0000H9-D1; Sat, 29 Sep 2018 22:48:19 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5z-0006y2-AB; Sat, 29 Sep 2018 22:48:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jan Beulich" <JBeulich@suse.com>,
        "Michal Hocko" <mhocko@suse.cz>, "Michal Hocko" <mhocko@suse.com>,
        "Guenter Roeck" <linux@roeck-us.net>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.931651031@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 114/131] x86/speculation/l1tf: Fix up pte->pfn
 conversion for PAE
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Hocko <mhocko@suse.cz>

commit e14d7dfb41f5807a0c1c26a13f2b8ef16af24935 upstream.

Jan has noticed that pte_pfn and co. resp. pfn_pte are incorrect for
CONFIG_PAE because phys_addr_t is wider than unsigned long and so the
pte_val reps. shift left would get truncated. Fix this up by using proper
types.

[dwmw2: Backport to 4.9]

Fixes: 6b28baca9b1f ("x86/speculation/l1tf: Protect PROT_NONE PTEs against speculation")
Reported-by: Jan Beulich <JBeulich@suse.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: Adjust context.  Also restore the fix to pfn_pud().]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/pgtable.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -147,21 +147,21 @@ static inline u64 protnone_mask(u64 val)
 
 static inline unsigned long pte_pfn(pte_t pte)
 {
-	unsigned long pfn = pte_val(pte);
+	phys_addr_t pfn = pte_val(pte);
 	pfn ^= protnone_mask(pfn);
 	return (pfn & PTE_PFN_MASK) >> PAGE_SHIFT;
 }
 
 static inline unsigned long pmd_pfn(pmd_t pmd)
 {
-	unsigned long pfn = pmd_val(pmd);
+	phys_addr_t pfn = pmd_val(pmd);
 	pfn ^= protnone_mask(pfn);
 	return (pfn & PTE_PFN_MASK) >> PAGE_SHIFT;
 }
 
 static inline unsigned long pud_pfn(pud_t pud)
 {
-	unsigned long pfn = pud_val(pud);
+	phys_addr_t pfn = pud_val(pud);
 	pfn ^= protnone_mask(pfn);
 	return (pfn & PTE_PFN_MASK) >> PAGE_SHIFT;
 }
@@ -371,7 +371,7 @@ static inline pgprotval_t massage_pgprot
 
 static inline pte_t pfn_pte(unsigned long page_nr, pgprot_t pgprot)
 {
-	phys_addr_t pfn = page_nr << PAGE_SHIFT;
+	phys_addr_t pfn = (phys_addr_t)page_nr << PAGE_SHIFT;
 	pfn ^= protnone_mask(pgprot_val(pgprot));
 	pfn &= PTE_PFN_MASK;
 	return __pte(pfn | massage_pgprot(pgprot));
@@ -379,7 +379,7 @@ static inline pte_t pfn_pte(unsigned lon
 
 static inline pmd_t pfn_pmd(unsigned long page_nr, pgprot_t pgprot)
 {
-	phys_addr_t pfn = page_nr << PAGE_SHIFT;
+	phys_addr_t pfn = (phys_addr_t)page_nr << PAGE_SHIFT;
 	pfn ^= protnone_mask(pgprot_val(pgprot));
 	pfn &= PTE_PFN_MASK;
 	return __pmd(pfn | massage_pgprot(pgprot));
@@ -387,7 +387,7 @@ static inline pmd_t pfn_pmd(unsigned lon
 
 static inline pud_t pfn_pud(unsigned long page_nr, pgprot_t pgprot)
 {
-	phys_addr_t pfn = page_nr << PAGE_SHIFT;
+	phys_addr_t pfn = (phys_addr_t)page_nr << PAGE_SHIFT;
 	pfn ^= protnone_mask(pgprot_val(pgprot));
 	pfn &= PTE_PFN_MASK;
 	return __pud(pfn | massage_pgprot(pgprot));

