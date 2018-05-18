Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbeERHxv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:53:51 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38834 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752243AbeERHuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:50:07 -0400
X-Google-Smtp-Source: AB8JxZp0yqBKvY4Lg7CVP7fdHYZSpGZl2wnJm9VQ0mQ/1lp38N2toLETml7fcxC6UlH5M4JXi67jjw==
From: Kent Overstreet <kent.overstreet@gmail.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com, jbacik@fb.com,
        viro@zeniv.linux.org.uk, willy@infradead.org, peterz@infradead.org
Subject: [PATCH 05/10] don't use spin_lock_irqsave() unnecessarily
Date: Fri, 18 May 2018 03:49:08 -0400
Message-Id: <20180518074918.13816-11-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518074918.13816-1-kent.overstreet@gmail.com>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 mm/page-writeback.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 586f31261c..17ccc294c9 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2460,20 +2460,19 @@ int __set_page_dirty_nobuffers(struct page *page)
 	lock_page_memcg(page);
 	if (!TestSetPageDirty(page)) {
 		struct address_space *mapping = page_mapping(page);
-		unsigned long flags;
 
 		if (!mapping) {
 			unlock_page_memcg(page);
 			return 1;
 		}
 
-		spin_lock_irqsave(&mapping->tree_lock, flags);
+		spin_lock_irq(&mapping->tree_lock);
 		BUG_ON(page_mapping(page) != mapping);
 		WARN_ON_ONCE(!PagePrivate(page) && !PageUptodate(page));
 		account_page_dirtied(page, mapping);
 		radix_tree_tag_set(&mapping->page_tree, page_index(page),
 				   PAGECACHE_TAG_DIRTY);
-		spin_unlock_irqrestore(&mapping->tree_lock, flags);
+		spin_unlock_irq(&mapping->tree_lock);
 		unlock_page_memcg(page);
 
 		if (mapping->host) {
-- 
2.17.0
