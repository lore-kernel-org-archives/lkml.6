Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbeEOI60 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:58:26 -0400
Received: from exmail.andestech.com ([59.124.169.137]:27508 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752404AbeEOI6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:58:25 -0400
From: Vincent Chen <vincentc@andestech.com>
To: <linux-kernel@vger.kernel.org>, <green.hu@gmail.com>,
        <greentime@andestech.com>, <arnd@arndb.de>
CC: <deanbo422@gmail.com>, <vincentc@andestech.com>
Subject: [PATCH 1/3] nds32: Correct flush_dcache_page function
Date: Tue, 15 May 2018 16:46:01 +0800
Message-ID: <1526373963-12417-2-git-send-email-vincentc@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526373963-12417-1-git-send-email-vincentc@andestech.com>
References: <1526373963-12417-1-git-send-email-vincentc@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w4F8mptq015369
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Disable local irq before d-cache write-back and invalidate.
   The cpu_dcache_wbinval_page function is composed of d-cache
write-back and invalidate. If the local irq is enabled when calling
cpu_dcache_wbinval_page, the content of d-cache is possibly updated
between write-back and invalidate. In this case, the updated data will
be dropped due to the following d-cache invalidation. Therefore, we
disable the local irq before calling cpu_dcache_wbinval_page.

2. Correct the data write-back for page aliasing case.
   Only the page whose (page->index << PAGE_SHIFT) is located at the
same page color as page_address(page) needs to execute data write-back
in flush_dcache_page function.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
---
 arch/nds32/mm/cacheflush.c |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/nds32/mm/cacheflush.c b/arch/nds32/mm/cacheflush.c
index 6eb786a..288cf10 100644
--- a/arch/nds32/mm/cacheflush.c
+++ b/arch/nds32/mm/cacheflush.c
@@ -198,17 +198,20 @@ void flush_dcache_page(struct page *page)
 	if (mapping && !mapping_mapped(mapping))
 		set_bit(PG_dcache_dirty, &page->flags);
 	else {
-		int i, pc;
-		unsigned long vto, kaddr, flags;
+		unsigned long kaddr, flags;
+
 		kaddr = (unsigned long)page_address(page);
-		cpu_dcache_wbinval_page(kaddr);
-		pc = CACHE_SET(DCACHE) * CACHE_LINE_SIZE(DCACHE) / PAGE_SIZE;
 		local_irq_save(flags);
-		for (i = 0; i < pc; i++) {
-			vto =
-			    kremap0(kaddr + i * PAGE_SIZE, page_to_phys(page));
-			cpu_dcache_wbinval_page(vto);
-			kunmap01(vto);
+		cpu_dcache_wbinval_page(kaddr);
+		if (mapping) {
+			unsigned long vaddr, kto;
+
+			vaddr = page->index << PAGE_SHIFT;
+			if (aliasing(vaddr, kaddr)) {
+				kto = kremap0(vaddr, page_to_phys(page));
+				cpu_dcache_wbinval_page(kto);
+				kunmap01(kto);
+			}
 		}
 		local_irq_restore(flags);
 	}
-- 
1.7.1
