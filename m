Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FDCC71132
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B755C2089E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B755C2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeJOXQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 19:16:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46927 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbeJOXQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 19:16:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id n11-v6so21769374wru.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 08:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LcedzQ9KbwO/uDel+s/QEII3xdfa0hfO6dWQDOtuNKg=;
        b=IjKl1EdbPlEkY4J9iYHmo5x12jB5fGMH8LYhts2zrxCGvhElpWGu0anpDXqtb22/6m
         qXHNl8b0POGaCPhpn6h2P3kwhb0fdJn1QOd1rUCN3NZqlojPttCmc5Rh4gZf+p5UqAYI
         BjuPLKiyW5qXKY8tQqrfQJbFJrgeeZt18dkM0JMjRd9+w7Q8RuSzN4hm4qcUC1L5KBgF
         +UlxLbQF8ZAyUDsa8uuy7WULdeezXnYg2gn98kZfiWSufYaCy4L0BRmjc6oJ6k/P1vv5
         JE4tT3IVCIk86p+Fm7rKkIDx1Fic++vaNvfovIR7zEVFB0Fmr4QTeaD+YrI7GhJr34gz
         NQGQ==
X-Gm-Message-State: ABuFfoj/Vzd2MYgP/sg3ijk3vtGXlHDk6W+zyBs5rgA3QhP8DUSypMk9
        dIPxbmFXaTAbZeo1eBSn2bY=
X-Google-Smtp-Source: ACcGV62VjkJMdZfzajn6NL4EUmCICXo7Qqlk5YGPd7/P8ID+nao/J70uqjwIO322xUcznzUwLmMJWA==
X-Received: by 2002:adf:c00e:: with SMTP id z14-v6mr14904281wre.268.1539617454236;
        Mon, 15 Oct 2018 08:30:54 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id e14-v6sm9812528wrt.76.2018.10.15.08.30.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 08:30:52 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id F3C211259A7;
        Mon, 15 Oct 2018 17:30:51 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, yasu.isimatu@gmail.com,
        rppt@linux.vnet.ibm.com, malat@debian.org,
        linux-kernel@vger.kernel.org, pavel.tatashin@microsoft.com,
        jglisse@redhat.com, Jonathan.Cameron@huawei.com, rafael@kernel.org,
        david@redhat.com, dave.jiang@intel.com, linux-mm@kvack.org,
        alexander.h.duyck@linux.intel.com,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 2/5] mm/memory_hotplug: Create add/del_device_memory functions
Date:   Mon, 15 Oct 2018 17:30:31 +0200
Message-Id: <20181015153034.32203-3-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181015153034.32203-1-osalvador@techadventures.net>
References: <20181015153034.32203-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

HMM/devm have a particular handling of memory-hotplug.
They do not go through the common path, and so, they do not
call either offline_pages() or online_pages().

The operations they perform are the following ones:

1) Create the linear mapping in case the memory is not private
2) Initialize the pages and add the sections
3) Move the pages to ZONE_DEVICE

Due to this particular handling of hot-add/remove memory from HMM/devm,
I think it would be nice to provide a helper function in order to
make this cleaner, and not populate other regions with code
that should belong to memory-hotplug.

The helpers are named:

del_device_memory
add_device_memory

The idea is that add_device_memory will be in charge of:

a) call either arch_add_memory() or add_pages(), depending on whether
   we want a linear mapping
b) online the memory sections that correspond to the pfn range
c) call move_pfn_range_to_zone() being zone ZONE_DEVICE to
   expand zone/pgdat spanned pages and initialize its pages

del_device_memory, on the other hand, will be in charge of:

a) offline the memory sections that correspond to the pfn range
b) call shrink_zone_pgdat_pages(), which shrinks node/zone spanned pages.
c) call either arch_remove_memory() or __remove_pages(), depending on
   whether we need to tear down the linear mapping or not

The reason behind step b) from add_device_memory() and step a)
from del_device_memory is that now find_smallest/biggest_section_pfn
will have to check for online sections, and not for valid sections as
they used to do, because we call offline_mem_sections() in
offline_pages().

In order to split up better the patches and ease the review,
this patch will only make a) case work for add_device_memory(),
and case c) for del_device_memory.

The other cases will be added in the next patch.

These two functions have to be called from devm/HMM code:

dd_device_memory:
        - devm_memremap_pages()
        - hmm_devmem_pages_create()

del_device_memory:
        - hmm_devmem_release
        - devm_memremap_pages_release

One thing I do not know is whether we can move kasan calls out of the
hotplug lock or not.
If we can, we could move the hotplug lock within add/del_device_memory().

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/memory_hotplug.h | 11 +++++++++++
 kernel/memremap.c              | 11 ++++-------
 mm/hmm.c                       | 33 +++++++++++++++++----------------
 mm/memory_hotplug.c            | 41 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 73 insertions(+), 23 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 786cdfc9a974..cf014d5edbb2 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -111,8 +111,19 @@ extern int arch_remove_memory(int nid, u64 start, u64 size,
 		struct vmem_altmap *altmap);
 extern int __remove_pages(struct zone *zone, unsigned long start_pfn,
 	unsigned long nr_pages, struct vmem_altmap *altmap);
+
+#ifdef CONFIG_ZONE_DEVICE
+extern int del_device_memory(int nid, unsigned long start, unsigned long size,
+				struct vmem_altmap *altmap, bool private_mem);
+#endif
+
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
+#ifdef CONFIG_ZONE_DEVICE
+extern int add_device_memory(int nid, unsigned long start, unsigned long size,
+				struct vmem_altmap *altmap, bool private_mem);
+#endif
+
 /* reasonably generic interface to expand the physical pages */
 extern int __add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
 		struct vmem_altmap *altmap, bool want_memblock);
diff --git a/kernel/memremap.c b/kernel/memremap.c
index c95df6ed2d4a..b86bba8713b9 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -86,6 +86,8 @@ static void devm_memremap_pages_release(void *data)
 	struct device *dev = pgmap->dev;
 	struct resource *res = &pgmap->res;
 	resource_size_t align_start, align_size;
+	struct vmem_altmap *altmap = pgmap->altmap_valid ?
+					&pgmap->altmap : NULL;
 	unsigned long pfn;
 	int nid;
 
@@ -104,8 +106,7 @@ static void devm_memremap_pages_release(void *data)
 	nid = dev_to_node(dev);
 
 	mem_hotplug_begin();
-	arch_remove_memory(nid, align_start, align_size, pgmap->altmap_valid ?
-			&pgmap->altmap : NULL);
+	del_device_memory(nid, align_start, align_size, altmap, true);
 	kasan_remove_zero_shadow(__va(align_start), align_size);
 	mem_hotplug_done();
 
@@ -204,11 +205,7 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 		goto err_kasan;
 	}
 
-	error = arch_add_memory(nid, align_start, align_size, altmap, false);
-	if (!error)
-		move_pfn_range_to_zone(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
-					align_start >> PAGE_SHIFT,
-					align_size >> PAGE_SHIFT, altmap);
+	error = add_device_memory(nid, align_start, align_size, altmap, true);
 	mem_hotplug_done();
 	if (error)
 		goto err_add_memory;
diff --git a/mm/hmm.c b/mm/hmm.c
index 42d79bcc8aab..d3e52ae71bd9 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -996,6 +996,7 @@ static void hmm_devmem_release(struct device *dev, void *data)
 	struct zone *zone;
 	struct page *page;
 	int nid;
+	bool mapping;
 
 	if (percpu_ref_tryget_live(&devmem->ref)) {
 		dev_WARN(dev, "%s: page mapping is still live!\n", __func__);
@@ -1010,12 +1011,15 @@ static void hmm_devmem_release(struct device *dev, void *data)
 	zone = page_zone(page);
 	nid = zone->zone_pgdat->node_id;
 
-	mem_hotplug_begin();
 	if (resource->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY)
-		__remove_pages(zone, start_pfn, npages, NULL);
+		mapping = false;
 	else
-		arch_remove_memory(nid, start_pfn << PAGE_SHIFT,
-				   npages << PAGE_SHIFT, NULL);
+		mapping = true;
+
+	mem_hotplug_begin();
+	del_device_memory(nid, start_pfn << PAGE_SHIFT, npages << PAGE_SHIFT,
+								NULL,
+								mapping);
 	mem_hotplug_done();
 
 	hmm_devmem_radix_release(resource);
@@ -1026,6 +1030,7 @@ static int hmm_devmem_pages_create(struct hmm_devmem *devmem)
 	resource_size_t key, align_start, align_size, align_end;
 	struct device *device = devmem->device;
 	int ret, nid, is_ram;
+	bool mapping;
 
 	align_start = devmem->resource->start & ~(PA_SECTION_SIZE - 1);
 	align_size = ALIGN(devmem->resource->start +
@@ -1084,7 +1089,6 @@ static int hmm_devmem_pages_create(struct hmm_devmem *devmem)
 	if (nid < 0)
 		nid = numa_mem_id();
 
-	mem_hotplug_begin();
 	/*
 	 * For device private memory we call add_pages() as we only need to
 	 * allocate and initialize struct page for the device memory. More-
@@ -1096,20 +1100,17 @@ static int hmm_devmem_pages_create(struct hmm_devmem *devmem)
 	 * want the linear mapping and thus use arch_add_memory().
 	 */
 	if (devmem->pagemap.type == MEMORY_DEVICE_PUBLIC)
-		ret = arch_add_memory(nid, align_start, align_size, NULL,
-				false);
+		mapping = true;
 	else
-		ret = add_pages(nid, align_start >> PAGE_SHIFT,
-				align_size >> PAGE_SHIFT, NULL, false);
-	if (ret) {
-		mem_hotplug_done();
-		goto error_add_memory;
-	}
-	move_pfn_range_to_zone(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
-				align_start >> PAGE_SHIFT,
-				align_size >> PAGE_SHIFT, NULL);
+		mapping = false;
+
+	mem_hotplug_begin();
+	ret = add_device_memory(nid, align_start, align_size, NULL, mapping);
 	mem_hotplug_done();
 
+	if (ret)
+		goto error_add_memory;
+
 	/*
 	 * Initialization of the pages has been deferred until now in order
 	 * to allow us to do the work while not holding the hotplug lock.
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 33d448314b3f..5874aceb81ac 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1889,4 +1889,45 @@ void remove_memory(int nid, u64 start, u64 size)
 	unlock_device_hotplug();
 }
 EXPORT_SYMBOL_GPL(remove_memory);
+
+#ifdef CONFIG_ZONE_DEVICE
+int del_device_memory(int nid, unsigned long start, unsigned long size,
+				struct vmem_altmap *altmap, bool mapping)
+{
+	int ret;
+	unsigned long start_pfn = PHYS_PFN(start);
+	unsigned long nr_pages = size >> PAGE_SHIFT;
+	struct zone *zone = page_zone(pfn_to_page(pfn));
+
+	if (mapping)
+		ret = arch_remove_memory(nid, start, size, altmap);
+	else
+		ret = __remove_pages(zone, start_pfn, nr_pages, altmap);
+
+	return ret;
+}
+#endif
 #endif /* CONFIG_MEMORY_HOTREMOVE */
+
+#ifdef CONFIG_ZONE_DEVICE
+int add_device_memory(int nid, unsigned long start, unsigned long size,
+				struct vmem_altmap *altmap, bool mapping)
+{
+	int ret;
+	unsigned long start_pfn = PHYS_PFN(start);
+	unsigned long nr_pages = size >> PAGE_SHIFT;
+
+	if (mapping)
+		ret = arch_add_memory(nid, start, size, altmap, false);
+	else
+		ret = add_pages(nid, start_pfn, nr_pages, altmap, false);
+
+	if (!ret) {
+		struct zone *zone = &NODE_DATA(nid)->node_zones[ZONE_DEVICE];
+
+		move_pfn_range_to_zone(zone, start_pfn, nr_pages, altmap);
+	}
+
+	return ret;
+}
+#endif
-- 
2.13.6

