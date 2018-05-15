Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752729AbeEOI6h (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:58:37 -0400
Received: from exmail.andestech.com ([59.124.169.137]:13612 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752595AbeEOI6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:58:30 -0400
From: Vincent Chen <vincentc@andestech.com>
To: <linux-kernel@vger.kernel.org>, <green.hu@gmail.com>,
        <greentime@andestech.com>, <arnd@arndb.de>
CC: <deanbo422@gmail.com>, <vincentc@andestech.com>
Subject: [PATCH 3/3] nds32: Disable local irq before calling cpu_dcache_wb_page in copy_user_highpage
Date: Tue, 15 May 2018 16:46:03 +0800
Message-ID: <1526373963-12417-4-git-send-email-vincentc@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526373963-12417-1-git-send-email-vincentc@andestech.com>
References: <1526373963-12417-1-git-send-email-vincentc@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w4F8n1J1015407
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to ensure that all data in source page has been written back
to memory before copy_page, the local irq shall be disabled before
calling cpu_dcache_wb_page(). In addition, removing unneeded page
invalidation for 'to' page.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
---
 arch/nds32/mm/cacheflush.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/nds32/mm/cacheflush.c b/arch/nds32/mm/cacheflush.c
index acfdb45..c97caaf 100644
--- a/arch/nds32/mm/cacheflush.c
+++ b/arch/nds32/mm/cacheflush.c
@@ -156,11 +156,9 @@ void copy_user_highpage(struct page *to, struct page *from,
 	pto = page_to_phys(to);
 	pfrom = page_to_phys(from);
 
+	local_irq_save(flags);
 	if (aliasing(vaddr, (unsigned long)kfrom))
 		cpu_dcache_wb_page((unsigned long)kfrom);
-	if (aliasing(vaddr, (unsigned long)kto))
-		cpu_dcache_inval_page((unsigned long)kto);
-	local_irq_save(flags);
 	vto = kremap0(vaddr, pto);
 	vfrom = kremap1(vaddr, pfrom);
 	copy_page((void *)vto, (void *)vfrom);
-- 
1.7.1
