Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752608AbeEOI7u (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:59:50 -0400
Received: from exmail.andestech.com ([59.124.169.137]:36700 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752583AbeEOI62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:58:28 -0400
From: Vincent Chen <vincentc@andestech.com>
To: <linux-kernel@vger.kernel.org>, <green.hu@gmail.com>,
        <greentime@andestech.com>, <arnd@arndb.de>
CC: <deanbo422@gmail.com>, <vincentc@andestech.com>
Subject: [PATCH 2/3] nds32: Flush the cache of the page at vmaddr instead of kaddr in flush_anon_page
Date: Tue, 15 May 2018 16:46:02 +0800
Message-ID: <1526373963-12417-3-git-send-email-vincentc@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526373963-12417-1-git-send-email-vincentc@andestech.com>
References: <1526373963-12417-1-git-send-email-vincentc@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w4F8mu7t015385
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Documentation/cachetlb.txt, the cache of the page at vmaddr
shall be flushed in flush_anon_page instead of the cache of the page at
page_address(page).

Signed-off-by: Vincent Chen <vincentc@andestech.com>
---
 arch/nds32/mm/cacheflush.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/nds32/mm/cacheflush.c b/arch/nds32/mm/cacheflush.c
index 288cf10..acfdb45 100644
--- a/arch/nds32/mm/cacheflush.c
+++ b/arch/nds32/mm/cacheflush.c
@@ -254,7 +254,7 @@ void copy_from_user_page(struct vm_area_struct *vma, struct page *page,
 void flush_anon_page(struct vm_area_struct *vma,
 		     struct page *page, unsigned long vaddr)
 {
-	unsigned long flags;
+	unsigned long kaddr, flags, ktmp;
 	if (!PageAnon(page))
 		return;
 
@@ -264,7 +264,12 @@ void flush_anon_page(struct vm_area_struct *vma,
 	local_irq_save(flags);
 	if (vma->vm_flags & VM_EXEC)
 		cpu_icache_inval_page(vaddr & PAGE_MASK);
-	cpu_dcache_wbinval_page((unsigned long)page_address(page));
+	kaddr = (unsigned long)page_address(page);
+	if (aliasing(vaddr, kaddr)) {
+		ktmp = kremap0(vaddr, page_to_phys(page));
+		cpu_dcache_wbinval_page(ktmp);
+		kunmap01(ktmp);
+	}
 	local_irq_restore(flags);
 }
 
-- 
1.7.1
