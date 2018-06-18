Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A11C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C362208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C362208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754821AbeFRGGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 02:06:25 -0400
Received: from icp-osb-irony-out7.external.iinet.net.au ([203.59.1.107]:5715
        "EHLO icp-osb-irony-out7.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754488AbeFRGGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 02:06:23 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ArAgAJSydb/zXSMGdbHAEBAQQBAQoBA?=
 =?us-ascii?q?YNIYm0SKIt9jFJGAQEBAQEGgT+UYIF4HgwMAYRAglUhNBgBAgEBAQEBAQJtHAy?=
 =?us-ascii?q?GKCgncBKDJQKBcgwQrAYaAoQ/g2eBYwWIVIEMgQeHF4dPApkWCAGFfIkCiCOFI?=
 =?us-ascii?q?gGKEoh8OIFSMxoIKAiCfh+CAheIWYVQLTB6AQGPWwEB?=
X-IPAS-Result: =?us-ascii?q?A2ArAgAJSydb/zXSMGdbHAEBAQQBAQoBAYNIYm0SKIt9jFJ?=
 =?us-ascii?q?GAQEBAQEGgT+UYIF4HgwMAYRAglUhNBgBAgEBAQEBAQJtHAyGKCgncBKDJQKBc?=
 =?us-ascii?q?gwQrAYaAoQ/g2eBYwWIVIEMgQeHF4dPApkWCAGFfIkCiCOFIgGKEoh8OIFSMxo?=
 =?us-ascii?q?IKAiCfh+CAheIWYVQLTB6AQGPWwEB?=
X-IronPort-AV: E=Sophos;i="5.51,238,1526313600"; 
   d="scan'208";a="90009903"
Received: from unknown (HELO goober.digi.com) ([103.48.210.53])
  by icp-osb-irony-out7.iinet.net.au with ESMTP; 18 Jun 2018 14:05:00 +0800
From:   Greg Ungerer <gerg@linux-m68k.org>
To:     mawilcox@microsoft.com, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCH] m68k: fix "bad page state" oops on ColdFire boot
Date:   Mon, 18 Jun 2018 16:04:26 +1000
Message-Id: <20180618060426.24497-1-gerg@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
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

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
CC: Matthew Wilcox <mawilcox@microsoft.com>
---
 arch/m68k/include/asm/mcf_pgalloc.h | 1 +
 1 file changed, 1 insertion(+)

Matthew: I came across this thread at https://lkml.org/lkml/2018/6/17/163
         about a similar problem with openrisc. Based on that I came up
         with this fix for m68k/ColdFire. Fixes the issue for me.

diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
index 8b707c249026..8c441eb57b80 100644
--- a/arch/m68k/include/asm/mcf_pgalloc.h
+++ b/arch/m68k/include/asm/mcf_pgalloc.h
@@ -44,6 +44,7 @@ extern inline pmd_t *pmd_alloc_kernel(pgd_t *pgd, unsigned long address)
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t page,
 				  unsigned long address)
 {
+	pgtable_page_dtor(page);
 	__free_page(page);
 }
 
-- 
2.17.1

