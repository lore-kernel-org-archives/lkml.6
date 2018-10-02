Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243D2C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA1420666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA1420666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbeJBVol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:44:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45285 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbeJBVok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:44:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id q5-v6so2591699wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 08:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9SeupK+KhOJ9JTSOt0AEzf3o4SV6rGMu7uHKPkHuPW8=;
        b=mluZoiY/kWcQqpfF0DF8fE5a1D4mDwghGyFey6eKoD0cFWL1U0pjhgmWhadSNPFN0i
         l9z23p2goDDZDtnOasvDAHd8cylZbM454eSRna+dBoyGMpcdljEJp0vltH6AebiUVP+G
         99bZX1g0qDbZHd+j6x6ZLrCYpJR376BFNnlCMM0YBFNMqblvKraC37e9X1wiWvO7p+FX
         sVIJn3gjfOyrL02zhod9yKViiyB5JiB6fKg3ImUD0KV5ACprwQDThFg9HXp/VvdEYrT/
         z3OOEGQwRlqwQmyDpjKxqrAASMq24svF3W+BPQ/U1Oa0Wx/+AReCHtdP/kvAw3I4i5eX
         TlwA==
X-Gm-Message-State: ABuFfoiI4b8RXLllJLHQTFzotYFEKNIrWkyBDn2lT0P40TPciTXga+4B
        Sc+VyobEJ5kuPI8GDBLtMwU=
X-Google-Smtp-Source: ACcGV60zkt5o1uNzAHLv6hE7KNYU2LEZm9OdUWFqaRjiEcyYI1/pgrPf+MRFrnk/nVw0U1B/W1zfAA==
X-Received: by 2002:a5d:4706:: with SMTP id y6-v6mr10462685wrq.256.1538492448577;
        Tue, 02 Oct 2018 08:00:48 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id j9-v6sm14427601wrt.32.2018.10.02.08.00.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 08:00:47 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 1D7CC125729;
        Tue,  2 Oct 2018 17:00:47 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     linux-mm@kvack.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, yasu.isimatu@gmail.com,
        rppt@linux.vnet.ibm.com, malat@debian.org,
        linux-kernel@vger.kernel.org, pavel.tatashin@microsoft.com,
        jglisse@redhat.com, Jonathan.Cameron@huawei.com, rafael@kernel.org,
        david@redhat.com, dave.jiang@intel.com,
        Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH v3 1/5] mm/memory_hotplug: Add nid parameter to arch_remove_memory
Date:   Tue,  2 Oct 2018 17:00:25 +0200
Message-Id: <20181002150029.23461-2-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181002150029.23461-1-osalvador@techadventures.net>
References: <20181002150029.23461-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

This patch is only a preparation for the following-up patches.
The idea of passing the nid is that will allow us to get rid
of the zone parameter in the patches that follow

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
 mm/memory_hotplug.c            | 2 +-
 9 files changed, 11 insertions(+), 9 deletions(-)

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
index 578cbb262c01..445fce705f91 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -138,7 +138,7 @@ int __meminit arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-int __meminit arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
+int __meminit arch_remove_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index e472cd763eb3..f705da1a085f 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -239,7 +239,7 @@ int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
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
index f2837e4c40b3..b2a698d87a0e 100644
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
index 5fab264948c2..c754d9543ae1 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1147,7 +1147,7 @@ kernel_physical_mapping_remove(unsigned long start, unsigned long end)
 	remove_pagetable(start, end, true, NULL);
 }
 
-int __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
+int __ref arch_remove_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index ffd9cd10fcf3..f9fc35819e65 100644
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
index e3036433ce4e..fe54bba2d7e2 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -121,6 +121,7 @@ static void devm_memremap_pages_release(void *data)
 	struct resource *res = &pgmap->res;
 	resource_size_t align_start, align_size;
 	unsigned long pfn;
+	int nid;
 
 	pgmap->kill(pgmap->ref);
 	for_each_device_pfn(pfn, pgmap)
@@ -130,6 +131,7 @@ static void devm_memremap_pages_release(void *data)
 	align_start = res->start & ~(SECTION_SIZE - 1);
 	align_size = ALIGN(res->start + resource_size(res), SECTION_SIZE)
 		- align_start;
+	nid = dev_to_node(dev);
 
 	mem_hotplug_begin();
 	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
@@ -137,7 +139,7 @@ static void devm_memremap_pages_release(void *data)
 		__remove_pages(page_zone(pfn_to_page(pfn)), pfn,
 				align_size >> PAGE_SHIFT, NULL);
 	} else {
-		arch_remove_memory(align_start, align_size,
+		arch_remove_memory(nid, align_start, align_size,
 				pgmap->altmap_valid ? &pgmap->altmap : NULL);
 		kasan_remove_zero_shadow(__va(align_start), align_size);
 	}
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index d4c7e42e46f3..11b7dcf83323 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1890,7 +1890,7 @@ void __ref __remove_memory(int nid, u64 start, u64 size)
 	memblock_free(start, size);
 	memblock_remove(start, size);
 
-	arch_remove_memory(start, size, NULL);
+	arch_remove_memory(nid, start, size, NULL);
 
 	try_offline_node(nid);
 
-- 
2.13.6

