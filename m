Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752598AbeFAMyY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 08:54:24 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41495 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752354AbeFAMyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 08:54:13 -0400
X-Google-Smtp-Source: ADUXVKJPRTAwi7hEbAz9WPkDig++7ntRUGUDvT90HCK7/BFo6HZxcXmTMZwTVKnbQbRHRsPE2FPhIg==
From: osalvador@techadventures.net
To: akpm@linux-foundation.org
Cc: mhocko@suse.com, vbabka@suse.cz, pasha.tatashin@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 4/4] mm/memory_hotplug: Drop unnecessary checks from register_mem_sect_under_node
Date: Fri,  1 Jun 2018 14:53:21 +0200
Message-Id: <20180601125321.30652-5-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180601125321.30652-1-osalvador@techadventures.net>
References: <20180601125321.30652-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

Callers of register_mem_sect_under_node() are always passing a valid
memory_block (not NULL), so we can safely drop the check for NULL.

In the same way, register_mem_sect_under_node() is only called in case
the node is online, so we can safely remove that check as well.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 drivers/base/node.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 248c712e8de5..681be04351bc 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -415,12 +415,7 @@ int register_mem_sect_under_node(struct memory_block *mem_blk, int nid,
 	int ret;
 	unsigned long pfn, sect_start_pfn, sect_end_pfn;
 
-	if (!mem_blk)
-		return -EFAULT;
-
 	mem_blk->nid = nid;
-	if (!node_online(nid))
-		return 0;
 
 	sect_start_pfn = section_nr_to_pfn(mem_blk->start_section_nr);
 	sect_end_pfn = section_nr_to_pfn(mem_blk->end_section_nr);
-- 
2.13.6
