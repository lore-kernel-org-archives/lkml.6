Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFDBC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768E2208A6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 768E2208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeHQSp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 14:45:29 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34775 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbeHQSp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 14:45:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id l2-v6so1741793wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 08:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iZlmTvhU0cDqGXWGlJNX2R9bE+JQXFCjRoVfJ72HKmY=;
        b=d7pdgASFkaDJgbJfQ+blYzw30tLBd+OYOOaEFvpUcBB6ot2/BvmfCSeLpV2XF+M29N
         AesMU+EgEfIsSaYN8eos+ni1W/UPKm03nQkLl8Adc4zBVNDkrvEsF83VIuHsxiG20axb
         4qhxcWCmquhZmGMpIopypzMEDPOHoH0/G2XjgVpVUHsDKcpaOdRcCVRsNeT6Qn7PgzX5
         xx5Y2vDzRR1JWddry6PrRzepaYWhOCyyuTHDvDUVJRKu+DggYtnXvrSDgwoJiunYsMAv
         WXFxVh38aY79tBe8qBdFAMPzw2hqUpSEfGjGtTgKeihgwrpZ20QEteYx2eBFS+TIPLoL
         1+jw==
X-Gm-Message-State: AOUpUlH++0PqjdDr6GM7cjtsp9zlNEOPzw0blU+rJejrWtIkQG8sLzhc
        4LHe12eFJPYcINmnGlqg8b0=
X-Google-Smtp-Source: AA+uWPwGAzXVAdxl0MbBEa+pyzwcBWyXqLOmn8lUAew8CjlWW+8t/S/FvxzRB5aA/kCLZxBk5afIWg==
X-Received: by 2002:a1c:415:: with SMTP id 21-v6mr20265611wme.128.1534520496388;
        Fri, 17 Aug 2018 08:41:36 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id v124-v6sm6166755wma.18.2018.08.17.08.41.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 08:41:35 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 2A53C12494F;
        Fri, 17 Aug 2018 17:41:34 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, jglisse@redhat.com,
        david@redhat.com, jonathan.cameron@huawei.com,
        Pavel.Tatashin@microsoft.com, yasu.isimatu@gmail.com,
        logang@deltatee.com, dave.jiang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [RFC v2 1/2] mm/memory_hotplug: Add nid parameter to arch_remove_memory
Date:   Fri, 17 Aug 2018 17:41:26 +0200
Message-Id: <20180817154127.28602-2-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180817154127.28602-1-osalvador@techadventures.net>
References: <20180817154127.28602-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

This patch is only a preparation for the following-up patches.
The idea of passing the nid is that will allow us to get rid
of the zone parameter in the patches that follow.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/ia64/mm/init.c            | 2 +-
 arch/powerpc/mm/mem.c          | 2 +-
 arch/s390/mm/init.c            | 2 +-
 arch/sh/mm/init.c              | 2 +-
 arch/x86/mm/init_32.c          | 2 +-
 arch/x86/mm/init_64.c          | 2 +-
 include/linux/memory_hotplug.h | 2 +-
 kernel/memremap.c              | 4 +++-
 mm/hmm.c                       | 4 +++-
 mm/memory_hotplug.c            | 2 +-
 10 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index 3b85c3ecac38..b54d0ee74b53 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -662,7 +662,7 @@ int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-int arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
+int arch_remove_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 5c8530d0c611..9e17d57a9948 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -139,7 +139,7 @@ int __meminit arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-int __meminit arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
+int __meminit arch_remove_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 3fa3e5323612..bc49b560625e 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -240,7 +240,7 @@ int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-int arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
+int arch_remove_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap)
 {
 	/*
 	 * There is no hardware or firmware interface which could trigger a
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 7713c084d040..5c91bb6abc35 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -444,7 +444,7 @@ EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
 #endif
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-int arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
+int arch_remove_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap)
 {
 	unsigned long start_pfn = PFN_DOWN(start);
 	unsigned long nr_pages = size >> PAGE_SHIFT;
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 979e0a02cbe1..9fa503f2f56c 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -861,7 +861,7 @@ int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-int arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
+int arch_remove_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index dd519f372169..f90fa077b0c4 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1148,7 +1148,7 @@ kernel_physical_mapping_remove(unsigned long start, unsigned long end)
 	remove_pagetable(start, end, true, NULL);
 }
 
-int __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
+int __ref arch_remove_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 34a28227068d..c68b03fd87bd 100644
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
index 5b8600d39931..7a832b844f24 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -121,6 +121,7 @@ static void devm_memremap_pages_release(void *data)
 	struct resource *res = &pgmap->res;
 	resource_size_t align_start, align_size;
 	unsigned long pfn;
+	int nid;
 
 	for_each_device_pfn(pfn, pgmap)
 		put_page(pfn_to_page(pfn));
@@ -134,9 +135,10 @@ static void devm_memremap_pages_release(void *data)
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
index c968e49f7a0c..21787e480b4a 100644
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
index 9eea6e809a4e..9bd629944c91 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1895,7 +1895,7 @@ void __ref remove_memory(int nid, u64 start, u64 size)
 	memblock_free(start, size);
 	memblock_remove(start, size);
 
-	arch_remove_memory(start, size, NULL);
+	arch_remove_memory(nid, start, size, NULL);
 
 	try_offline_node(nid);
 
-- 
2.13.6

