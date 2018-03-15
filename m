Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752728AbeCOPH4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:07:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:2160 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752557AbeCOPHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:07:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,311,1517904000";
   d="scan'208";a="37684200"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] mm/thp: Do not wait for lock_page() in deferred_split_scan()
Date: Thu, 15 Mar 2018 18:07:47 +0300
Message-Id: <20180315150747.31945-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

deferred_split_scan() gets called from reclaim path. Waiting for page
lock may lead to deadlock there.

Replace lock_page() with trylock_page() and skip the page if we failed
to lock it. We will get to the page on the next scan.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/huge_memory.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 87ab9b8f56b5..529cf36b7edb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2783,11 +2783,13 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 
 	list_for_each_safe(pos, next, &list) {
 		page = list_entry((void *)pos, struct page, mapping);
-		lock_page(page);
+		if (!trylock_page(page))
+			goto next;
 		/* split_huge_page() removes page from list on success */
 		if (!split_huge_page(page))
 			split++;
 		unlock_page(page);
+next:
 		put_page(page);
 	}
 
-- 
2.16.1
