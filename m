Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752537AbeFAMyW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 08:54:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39271 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752330AbeFAMyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 08:54:12 -0400
X-Google-Smtp-Source: ADUXVKKONhQlwlDQDej1JAkpFd/tzCs6K9IZCZwx40Tw7nL1AIYRt6gJTD0Un+qmQzf4hWnWr9CSBg==
From: osalvador@techadventures.net
To: akpm@linux-foundation.org
Cc: mhocko@suse.com, vbabka@suse.cz, pasha.tatashin@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 2/4] mm/memory_hotplug: Call register_mem_sect_under_node
Date: Fri,  1 Jun 2018 14:53:19 +0200
Message-Id: <20180601125321.30652-3-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180601125321.30652-1-osalvador@techadventures.net>
References: <20180601125321.30652-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

When hotpluging memory, it is possible that two calls are being made
to register_mem_sect_under_node().
One comes from __add_section()->hotplug_memory_register()
and the other from add_memory_resource()->link_mem_sections() if
we had to register a new node.

In case we had to register a new node, hotplug_memory_register()
will only handle/allocate the memory_block's since
register_mem_sect_under_node() will return right away because the
node it is not online yet.

I think it is better if we leave hotplug_memory_register() to
handle/allocate only memory_block's and make link_mem_sections()
to call register_mem_sect_under_node().

So this patch removes the call to register_mem_sect_under_node()
from hotplug_memory_register(), and moves the call to link_mem_sections()
out of the condition, so it will always be called.
In this way we only have one place where the memory sections
are registered.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 drivers/base/memory.c |  2 --
 mm/memory_hotplug.c   | 40 ++++++++++++++++++----------------------
 2 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index f5e560188a18..c8a1cb0b6136 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -736,8 +736,6 @@ int hotplug_memory_register(int nid, struct mem_section *section)
 		mem->section_count++;
 	}
 
-	if (mem->section_count == sections_per_block)
-		ret = register_mem_sect_under_node(mem, nid, false);
 out:
 	mutex_unlock(&mem_sysfs_mutex);
 	return ret;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 29a5fc89bdb1..f84ef96175ab 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1118,6 +1118,7 @@ int __ref add_memory_resource(int nid, struct resource *res, bool online)
 	u64 start, size;
 	bool new_node;
 	int ret;
+	unsigned long start_pfn, nr_pages;
 
 	start = res->start;
 	size = resource_size(res);
@@ -1147,34 +1148,21 @@ int __ref add_memory_resource(int nid, struct resource *res, bool online)
 	if (ret < 0)
 		goto error;
 
-	/* we online node here. we can't roll back from here. */
-	node_set_online(nid);
-
 	if (new_node) {
-		unsigned long start_pfn = start >> PAGE_SHIFT;
-		unsigned long nr_pages = size >> PAGE_SHIFT;
-
+		/* we online node here. we can't roll back from here. */
+		node_set_online(nid);
 		ret = __register_one_node(nid);
 		if (ret)
 			goto register_fail;
-
-		/*
-		 * link memory sections under this node. This is already
-		 * done when creatig memory section in register_new_memory
-		 * but that depends to have the node registered so offline
-		 * nodes have to go through register_node.
-		 * TODO clean up this mess.
-		 */
-		ret = link_mem_sections(nid, start_pfn, nr_pages, false);
-register_fail:
-		/*
-		 * If sysfs file of new node can't create, cpu on the node
-		 * can't be hot-added. There is no rollback way now.
-		 * So, check by BUG_ON() to catch it reluctantly..
-		 */
-		BUG_ON(ret);
 	}
 
+	/* link memory sections under this node.*/
+	start_pfn = start >> PAGE_SHIFT;
+	nr_pages = size >> PAGE_SHIFT;
+	ret = link_mem_sections(nid, start_pfn, nr_pages, false);
+	if (ret)
+		goto register_fail;
+
 	/* create new memmap entry */
 	firmware_map_add_hotplug(start, start + size, "System RAM");
 
@@ -1185,6 +1173,14 @@ int __ref add_memory_resource(int nid, struct resource *res, bool online)
 
 	goto out;
 
+register_fail:
+	/*
+	 * If sysfs file of new node can't create, cpu on the node
+	 * can't be hot-added. There is no rollback way now.
+	 * So, check by BUG_ON() to catch it reluctantly..
+	 */
+	BUG_ON(ret);
+
 error:
 	/* rollback pgdat allocation and others */
 	if (new_node)
-- 
2.13.6
