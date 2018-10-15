Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1321C71132
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5FE0208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5FE0208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbeJOXQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 19:16:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41617 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbeJOXQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 19:16:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id x12-v6so21838868wru.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 08:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M/8yrxlW200FJawa7Woj1EViIDZtaPHRv0p62rhek+A=;
        b=qxA1Y4vafkXf9j+IiSk7hAoYFWbNKrmQQiP+XJiDkFvk79Oxj55qwANJUhptiSgGLx
         EwCSRcbDrsZnTZVlCjtPd1gXf02DLcLG0gymy0EkRHQkeUT6iAExLTO98lMbPwfP8Wnf
         oOa3V+7n+GBOHaGrdAgojaNatU3r396z4sO/trt/miayMU22iaxL5zHbhKdx76lGqBv6
         JZRsV9Dl+cfgbov9AwCRO9SVjzsnfZ4GZEimlQYWQs5VA7WbZkQGWyZNAEJbpQgZQ9r9
         sggtEEvYWc8TY13gfhChg14Gx/Mx6l0PqMI++QT+YX2qCFZ0uwr7D2E9W/kz0+G0ApmG
         LM4A==
X-Gm-Message-State: ABuFfoga81gnSaU9mvk9Sr9Of0GMB9MppH+Nl21dPaoDhFl7lo6HRAt7
        xjo8x8Lm/3mmpkkeFuNkEF4=
X-Google-Smtp-Source: ACcGV61Sm2BdNFDcCsz9hkSq0WPBtQuZFEC6+homGWRGv1XYJryBQrZu8b6IVh+k03STncx/NJ4Vow==
X-Received: by 2002:a05:6000:11c1:: with SMTP id i1mr15300270wrx.310.1539617453584;
        Mon, 15 Oct 2018 08:30:53 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id e133-v6sm11353053wma.42.2018.10.15.08.30.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 08:30:52 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 88CEF1259A6;
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
Subject: [PATCH 1/5] mm/memory_hotplug: Add nid parameter to arch_remove_memory
Date:   Mon, 15 Oct 2018 17:30:30 +0200
Message-Id: <20181015153034.32203-2-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181015153034.32203-1-osalvador@techadventures.net>
References: <20181015153034.32203-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

This patch is only a preparation for the following-up patches.
The idea of passing the nid is that will allow us to get rid
of the zone parameter in the patches that follow

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 arch/ia64/mm/init.c            | 2 +-
 arch/powerpc/mm/mem.c          | 3 ++-
 arch/s390/mm/init.c            | 2 +-
 arch/sh/mm/init.c              | 2 +-
 arch/x86/mm/init_32.c          | 2 +-
 arch/x86/mm/init_64.c          | 3 ++-
 include/linux/memory_hotplug.h | 2 +-
 kernel/memremap.c              | 4 +++-
 mm/hmm.c                       | 4 +++-
 mm/memory_hotplug.c            | 2 +-
 10 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index d5e12ff1d73c..904fe55e10fc 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -661,7 +661,7 @@ int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-int arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
+int arch_remove_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 5551f5870dcc..6db8f527babb 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -139,7 +139,8 @@ int __meminit arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-int __meminit arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
+int __meminit arch_remove_memory(int nid, u64 start, u64 size,
+					struct vmem_altmap *altmap)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 76d0708438e9..b7503f8b7725 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -242,7 +242,7 @@ int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-int arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
+int arch_remove_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap)
 {
 	/*
 	 * There is no hardware or firmware interface which could trigger a
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index c8c13c777162..a8e5c0e00fca 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -443,7 +443,7 @@ EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
 #endif
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-int arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
+int arch_remove_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap)
 {
 	unsigned long start_pfn = PFN_DOWN(start);
 	unsigned long nr_pages = size >> PAGE_SHIFT;
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 49ecf5ecf6d3..85c94f9a87f8 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -860,7 +860,7 @@ int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-int arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
+int arch_remove_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 5fab264948c2..449958da97a4 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1147,7 +1147,8 @@ kernel_physical_mapping_remove(unsigned long start, unsigned long end)
 	remove_pagetable(start, end, true, NULL);
 }
 
-int __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
+int __ref arch_remove_memory(int nid, u64 start, u64 size,
+				struct vmem_altmap *altmap)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 84e9ae205930..786cdfc9a974 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -107,7 +107,7 @@ static inline bool movable_node_is_enabled(void)
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-extern int arch_remove_memory(u64 start, u64 size,
+extern int arch_remove_memory(int nid, u64 start, u64 size,
 		struct vmem_altmap *altmap);
 extern int __remove_pages(struct zone *zone, unsigned long start_pfn,
 	unsigned long nr_pages, struct vmem_altmap *altmap);
diff --git a/kernel/memremap.c b/kernel/memremap.c
index 9eced2cc9f94..c95df6ed2d4a 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -87,6 +87,7 @@ static void devm_memremap_pages_release(void *data)
 	struct resource *res = &pgmap->res;
 	resource_size_t align_start, align_size;
 	unsigned long pfn;
+	int nid;
 
 	for_each_device_pfn(pfn, pgmap)
 		put_page(pfn_to_page(pfn));
@@ -100,9 +101,10 @@ static void devm_memremap_pages_release(void *data)
 	align_start = res->start & ~(SECTION_SIZE - 1);
 	align_size = ALIGN(res->start + resource_size(res), SECTION_SIZE)
 		- align_start;
+	nid = dev_to_node(dev);
 
 	mem_hotplug_begin();
-	arch_remove_memory(align_start, align_size, pgmap->altmap_valid ?
+	arch_remove_memory(nid, align_start, align_size, pgmap->altmap_valid ?
 			&pgmap->altmap : NULL);
 	kasan_remove_zero_shadow(__va(align_start), align_size);
 	mem_hotplug_done();
diff --git a/mm/hmm.c b/mm/hmm.c
index 774d684fa2b4..42d79bcc8aab 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -995,6 +995,7 @@ static void hmm_devmem_release(struct device *dev, void *data)
 	unsigned long start_pfn, npages;
 	struct zone *zone;
 	struct page *page;
+	int nid;
 
 	if (percpu_ref_tryget_live(&devmem->ref)) {
 		dev_WARN(dev, "%s: page mapping is still live!\n", __func__);
@@ -1007,12 +1008,13 @@ static void hmm_devmem_release(struct device *dev, void *data)
 
 	page = pfn_to_page(start_pfn);
 	zone = page_zone(page);
+	nid = zone->zone_pgdat->node_id;
 
 	mem_hotplug_begin();
 	if (resource->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY)
 		__remove_pages(zone, start_pfn, npages, NULL);
 	else
-		arch_remove_memory(start_pfn << PAGE_SHIFT,
+		arch_remove_memory(nid, start_pfn << PAGE_SHIFT,
 				   npages << PAGE_SHIFT, NULL);
 	mem_hotplug_done();
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index dbbb94547ad0..33d448314b3f 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1875,7 +1875,7 @@ void __ref __remove_memory(int nid, u64 start, u64 size)
 	memblock_free(start, size);
 	memblock_remove(start, size);
 
-	arch_remove_memory(start, size, NULL);
+	arch_remove_memory(nid, start, size, NULL);
 
 	try_offline_node(nid);
 
-- 
2.13.6

