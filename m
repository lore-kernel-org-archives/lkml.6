Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D21C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6C921727
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6C921727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732827AbeHNU0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:26:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58328 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbeHNU0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:26:35 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8A72CD7D;
        Tue, 14 Aug 2018 17:38:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 100/104] x86/speculation/l1tf: Make pmd/pud_mknotpresent() invert
Date:   Tue, 14 Aug 2018 19:17:54 +0200
Message-Id: <20180814171521.535930667@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171515.270692185@linuxfoundation.org>
References: <20180814171515.270692185@linuxfoundation.org>
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

From: Andi Kleen <ak@linux.intel.com>

commit 0768f91530ff46683e0b372df14fd79fe8d156e5 upstream

Some cases in THP like:
  - MADV_FREE
  - mprotect
  - split

mark the PMD non present for temporarily to prevent races. The window for
an L1TF attack in these contexts is very small, but it wants to be fixed
for correctness sake.

Use the proper low level functions for pmd/pud_mknotpresent() to address
this.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/pgtable.h |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -410,11 +410,6 @@ static inline pmd_t pmd_mkwrite(pmd_t pm
 	return pmd_set_flags(pmd, _PAGE_RW);
 }
 
-static inline pmd_t pmd_mknotpresent(pmd_t pmd)
-{
-	return pmd_clear_flags(pmd, _PAGE_PRESENT | _PAGE_PROTNONE);
-}
-
 static inline pud_t pud_set_flags(pud_t pud, pudval_t set)
 {
 	pudval_t v = native_pud_val(pud);
@@ -469,11 +464,6 @@ static inline pud_t pud_mkwrite(pud_t pu
 	return pud_set_flags(pud, _PAGE_RW);
 }
 
-static inline pud_t pud_mknotpresent(pud_t pud)
-{
-	return pud_clear_flags(pud, _PAGE_PRESENT | _PAGE_PROTNONE);
-}
-
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
 static inline int pte_soft_dirty(pte_t pte)
 {
@@ -560,6 +550,18 @@ static inline pud_t pfn_pud(unsigned lon
 	return __pud(pfn | massage_pgprot(pgprot));
 }
 
+static inline pmd_t pmd_mknotpresent(pmd_t pmd)
+{
+	return pfn_pmd(pmd_pfn(pmd),
+		      __pgprot(pmd_flags(pmd) & ~(_PAGE_PRESENT|_PAGE_PROTNONE)));
+}
+
+static inline pud_t pud_mknotpresent(pud_t pud)
+{
+	return pfn_pud(pud_pfn(pud),
+	      __pgprot(pud_flags(pud) & ~(_PAGE_PRESENT|_PAGE_PROTNONE)));
+}
+
 static inline u64 flip_protnone_guard(u64 oldval, u64 val, u64 mask);
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)


