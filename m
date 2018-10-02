Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81614C64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2782089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2782089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbeJBVoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:44:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39473 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729201AbeJBVom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:44:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id 61-v6so1876197wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 08:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PhCT3TBAUk3AvVLhiqqr/i+tBqrnuE7S7sAJRx6RsvU=;
        b=W7UG4bzRCBDM+5sSqHITZZZvCiLcVb8JkHnf8tryfpmlJ3u5+TSYTpAPTkLhaoNM36
         YArc6daKO2BRe4z448CHKFEWhl3xFvLIUQkYpF7mjGqnC6YuyctbncLe5l396DWhSq+N
         4aOSm7g9z8GSabl1Xo1GbbinJYe3p5OtPyY0pQliAfoYS6xFuZVj5iyatZxZxk4j+7OI
         uKEieDADc88Nkt5WaRsFPnmTMeS350ErNOdn16p+y6HGldGEUAtzXrBPqxLIY62bZ/EN
         mInVBeUJkJ22PNAMdhYVNKYnByhueL1bSQC4vMbJZDb5uuv3t6kz2O2YymrjqlrHjPCE
         pmzQ==
X-Gm-Message-State: ABuFfojLscHahsLMD6mKeaQBl9yBct7VuwOkcKebqwaS4zDWbJc/Is0/
        cs8yymtJc6Rpfa0lPHsBl6I=
X-Google-Smtp-Source: ACcGV62GC8tXsIt/wBzYRBj5U9Ujpuc1DEAM6x8ZaIfds4Yu9bzQsN3D+oR0SbAJPePtnFPKBG1bkw==
X-Received: by 2002:adf:9c12:: with SMTP id f18-v6mr11165017wrc.93.1538492451294;
        Tue, 02 Oct 2018 08:00:51 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id q200-v6sm14232186wmd.2.2018.10.02.08.00.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 08:00:50 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 444CE12572C;
        Tue,  2 Oct 2018 17:00:48 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     linux-mm@kvack.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, yasu.isimatu@gmail.com,
        rppt@linux.vnet.ibm.com, malat@debian.org,
        linux-kernel@vger.kernel.org, pavel.tatashin@microsoft.com,
        jglisse@redhat.com, Jonathan.Cameron@huawei.com, rafael@kernel.org,
        david@redhat.com, dave.jiang@intel.com,
        Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH v3 5/5] mm/memory-hotplug: Rework unregister_mem_sect_under_nodes
Date:   Tue,  2 Oct 2018 17:00:29 +0200
Message-Id: <20181002150029.23461-6-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181002150029.23461-1-osalvador@techadventures.net>
References: <20181002150029.23461-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

This tries to address another issue about accessing
unitiliazed pages.

Jonathan reported a problem [1] where we can access steal pages
in case we hot-remove memory without onlining it first.

This time is in unregister_mem_sect_under_nodes.
This function tries to get the nid from the pfn and then
tries to remove the symlink between mem_blk <-> nid and vice versa.

Since we already know the nid in remove_memory(), we can pass
it down the chain to unregister_mem_sect_under_nodes.
There we can just remove the symlinks without the need
to look into the pages.

[1] https://www.spinics.net/lists/linux-mm/msg161316.html

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 drivers/base/memory.c  |  9 ++++-----
 drivers/base/node.c    | 38 +++++++-------------------------------
 include/linux/memory.h |  2 +-
 include/linux/node.h   |  7 ++-----
 mm/memory_hotplug.c    |  2 +-
 5 files changed, 15 insertions(+), 43 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 0e5985682642..3d8c65d84bea 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -744,8 +744,7 @@ unregister_memory(struct memory_block *memory)
 	device_unregister(&memory->dev);
 }
 
-static int remove_memory_section(unsigned long node_id,
-			       struct mem_section *section, int phys_device)
+static int remove_memory_section(unsigned long nid, struct mem_section *section)
 {
 	struct memory_block *mem;
 
@@ -759,7 +758,7 @@ static int remove_memory_section(unsigned long node_id,
 	if (!mem)
 		goto out_unlock;
 
-	unregister_mem_sect_under_nodes(mem, __section_nr(section));
+	unregister_mem_sect_under_nodes(nid, mem);
 
 	mem->section_count--;
 	if (mem->section_count == 0)
@@ -772,12 +771,12 @@ static int remove_memory_section(unsigned long node_id,
 	return 0;
 }
 
-int unregister_memory_section(struct mem_section *section)
+int unregister_memory_section(int nid, struct mem_section *section)
 {
 	if (!present_section(section))
 		return -EINVAL;
 
-	return remove_memory_section(0, section, 0);
+	return remove_memory_section(nid, section);
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 86d6cd92ce3d..65bc5920bd3d 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -453,40 +453,16 @@ int register_mem_sect_under_node(struct memory_block *mem_blk, void *arg)
 	return 0;
 }
 
-/* unregister memory section under all nodes that it spans */
-int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
-				    unsigned long phys_index)
+/*
+ * This mem_blk is going to be removed, so let us remove the link
+ * to the node and vice versa
+ */
+void unregister_mem_sect_under_nodes(int nid, struct memory_block *mem_blk)
 {
-	NODEMASK_ALLOC(nodemask_t, unlinked_nodes, GFP_KERNEL);
-	unsigned long pfn, sect_start_pfn, sect_end_pfn;
-
-	if (!mem_blk) {
-		NODEMASK_FREE(unlinked_nodes);
-		return -EFAULT;
-	}
-	if (!unlinked_nodes)
-		return -ENOMEM;
-	nodes_clear(*unlinked_nodes);
-
-	sect_start_pfn = section_nr_to_pfn(phys_index);
-	sect_end_pfn = sect_start_pfn + PAGES_PER_SECTION - 1;
-	for (pfn = sect_start_pfn; pfn <= sect_end_pfn; pfn++) {
-		int nid;
-
-		nid = get_nid_for_pfn(pfn);
-		if (nid < 0)
-			continue;
-		if (!node_online(nid))
-			continue;
-		if (node_test_and_set(nid, *unlinked_nodes))
-			continue;
-		sysfs_remove_link(&node_devices[nid]->dev.kobj,
+	sysfs_remove_link(&node_devices[nid]->dev.kobj,
 			 kobject_name(&mem_blk->dev.kobj));
-		sysfs_remove_link(&mem_blk->dev.kobj,
+	sysfs_remove_link(&mem_blk->dev.kobj,
 			 kobject_name(&node_devices[nid]->dev.kobj));
-	}
-	NODEMASK_FREE(unlinked_nodes);
-	return 0;
 }
 
 int link_mem_sections(int nid, unsigned long start_pfn, unsigned long end_pfn)
diff --git a/include/linux/memory.h b/include/linux/memory.h
index a6ddefc60517..d75ec88ca09d 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -113,7 +113,7 @@ extern int register_memory_isolate_notifier(struct notifier_block *nb);
 extern void unregister_memory_isolate_notifier(struct notifier_block *nb);
 int hotplug_memory_register(int nid, struct mem_section *section);
 #ifdef CONFIG_MEMORY_HOTREMOVE
-extern int unregister_memory_section(struct mem_section *);
+extern int unregister_memory_section(int nid, struct mem_section *);
 #endif
 extern int memory_dev_init(void);
 extern int memory_notify(unsigned long val, void *v);
diff --git a/include/linux/node.h b/include/linux/node.h
index 257bb3d6d014..e8aa9e6d95f9 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -72,8 +72,7 @@ extern int register_cpu_under_node(unsigned int cpu, unsigned int nid);
 extern int unregister_cpu_under_node(unsigned int cpu, unsigned int nid);
 extern int register_mem_sect_under_node(struct memory_block *mem_blk,
 						void *arg);
-extern int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
-					   unsigned long phys_index);
+extern void unregister_mem_sect_under_nodes(int nid, struct memory_block *mem_blk);
 
 #ifdef CONFIG_HUGETLBFS
 extern void register_hugetlbfs_with_node(node_registration_func_t doregister,
@@ -105,10 +104,8 @@ static inline int register_mem_sect_under_node(struct memory_block *mem_blk,
 {
 	return 0;
 }
-static inline int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
-						  unsigned long phys_index)
+static inline void unregister_mem_sect_under_nodes(int nid, struct memory_block *mem_blk)
 {
-	return 0;
 }
 
 static inline void register_hugetlbfs_with_node(node_registration_func_t reg,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 1f71aebd598b..e7a38471fdc2 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -528,7 +528,7 @@ static int __remove_section(int nid, struct mem_section *ms,
 	if (!valid_section(ms))
 		return ret;
 
-	ret = unregister_memory_section(ms);
+	ret = unregister_memory_section(nid, ms);
 	if (ret)
 		return ret;
 
-- 
2.13.6

