Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61088C5AE59
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 00:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E36232083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 00:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E36232083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937145AbeFSArI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 20:47:08 -0400
Received: from icp-osb-irony-out3.external.iinet.net.au ([203.59.1.153]:15176
        "EHLO icp-osb-irony-out3.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S937043AbeFSArH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 20:47:07 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CaAQAYUihb/zXSMGdcGwEBAQEDAQEBC?=
 =?us-ascii?q?QEBAYNJgU8SKIN5iASMUkYBAQEBAQaBP5RigXgeGAGEQIJhITQYAQIBAQEBAQE?=
 =?us-ascii?q?CbSiFUg8BRigNAhgOAmASgyWBcwyqaYIcGgKEP4NvgWiBC4dJgQyBB4hZgziCV?=
 =?us-ascii?q?QKZFggBjn6II4Ujkw44gVIzGggoCIJ+giEXjiktMHoBAY4KgkgBAQ?=
X-IPAS-Result: =?us-ascii?q?A2CaAQAYUihb/zXSMGdcGwEBAQEDAQEBCQEBAYNJgU8SKIN?=
 =?us-ascii?q?5iASMUkYBAQEBAQaBP5RigXgeGAGEQIJhITQYAQIBAQEBAQECbSiFUg8BRigNA?=
 =?us-ascii?q?hgOAmASgyWBcwyqaYIcGgKEP4NvgWiBC4dJgQyBB4hZgziCVQKZFggBjn6II4U?=
 =?us-ascii?q?jkw44gVIzGggoCIJ+giEXjiktMHoBAY4KgkgBAQ?=
X-IronPort-AV: E=Sophos;i="5.51,241,1526313600"; 
   d="scan'208";a="88388609"
Received: from unknown (HELO goober.digi.com) ([103.48.210.53])
  by icp-osb-irony-out3.iinet.net.au with ESMTP; 19 Jun 2018 08:47:04 +0800
From:   Greg Ungerer <gerg@linux-m68k.org>
To:     mawilcox@microsoft.com, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     geert@linux-m68k.org, Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCHv2] m68k: fix "bad page state" oops on ColdFire boot
Date:   Tue, 19 Jun 2018 10:46:59 +1000
Message-Id: <20180619004659.19864-1-gerg@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting a ColdFire m68k core with MMU enabled causes a "bad page state"
oops since commit 1d40a5ea01d5 ("mm: mark pages in use for page tables"):

 BUG: Bad page state in process sh  pfn:01ce2
 page:004fefc8 count:0 mapcount:-1024 mapping:00000000 index:0x0
 flags: 0x0()
 raw: 00000000 00000000 00000000 fffffbff 00000000 00000100 00000200 00000000
 raw: 039c4000
 page dumped because: nonzero mapcount
 Modules linked in:
 CPU: 0 PID: 22 Comm: sh Not tainted 4.17.0-07461-g1d40a5ea01d5 #13

Fix by calling pgtable_page_dtor() in our __pte_free_tlb() code path,
so that the PG_table flag is cleared before we free the pte page.

Note that I had to change the type of pte_free() to be static from
extern. Otherwise you get a lot of warnings like this:

./arch/m68k/include/asm/mcf_pgalloc.h:80:2: warning: ‘pgtable_page_dtor’ is static but used in inline function ‘pte_free’ which is not static
  pgtable_page_dtor(page);
  ^

And making it static is consistent with our use of this in the other
m68k pgalloc definitions of pte_free().

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
CC: Matthew Wilcox <mawilcox@microsoft.com>
---
 arch/m68k/include/asm/mcf_pgalloc.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

v2: add a call to pgtable_page_dtor() in pte_free() as well

diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
index 8b707c249026..12fe700632f4 100644
--- a/arch/m68k/include/asm/mcf_pgalloc.h
+++ b/arch/m68k/include/asm/mcf_pgalloc.h
@@ -44,6 +44,7 @@ extern inline pmd_t *pmd_alloc_kernel(pgd_t *pgd, unsigned long address)
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t page,
 				  unsigned long address)
 {
+	pgtable_page_dtor(page);
 	__free_page(page);
 }
 
@@ -74,8 +75,9 @@ static inline struct page *pte_alloc_one(struct mm_struct *mm,
 	return page;
 }
 
-extern inline void pte_free(struct mm_struct *mm, struct page *page)
+static inline void pte_free(struct mm_struct *mm, struct page *page)
 {
+	pgtable_page_dtor(page);
 	__free_page(page);
 }
 
-- 
2.17.1

