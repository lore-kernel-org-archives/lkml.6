Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbeDKCes (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 22:34:48 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38235 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbeDKCeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 22:34:46 -0400
X-Google-Smtp-Source: AIpwx49+Jad/mQ7lnmnylXBVzLKrlkmZdD/nCEu6v+fUNopKmAjGvj08mfXQ+0CZGjHaePQARGTj2Q==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: asun@darksunrising.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: sun: cassini: Replace GFP_ATOMIC with GFP_KERNEL in cas_check_invariants
Date: Wed, 11 Apr 2018 10:34:39 +0800
Message-Id: <1523414079-2452-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cas_check_invariants() is never called in atomic context.

cas_check_invariants() is only called by cas_init_one(), which is 
only set as ".probe" in struct pci_driver.

Despite never getting called from atomic context,
cas_check_invariants() calls alloc_pages() with GFP_ATOMIC,
which does not sleep for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
which can sleep and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/ethernet/sun/cassini.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sun/cassini.c b/drivers/net/ethernet/sun/cassini.c
index 382993c..4dd38e3 100644
--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -3412,7 +3412,7 @@ static int cas_check_invariants(struct cas *cp)
 #ifdef USE_PAGE_ORDER
 	if (PAGE_SHIFT < CAS_JUMBO_PAGE_SHIFT) {
 		/* see if we can allocate larger pages */
-		struct page *page = alloc_pages(GFP_ATOMIC,
+		struct page *page = alloc_pages(GFP_KERNEL,
 						CAS_JUMBO_PAGE_SHIFT -
 						PAGE_SHIFT);
 		if (page) {
-- 
1.9.1
