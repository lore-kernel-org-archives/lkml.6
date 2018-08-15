Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2E9C46470
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22FD2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22FD2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbeHORfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 13:35:05 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53817 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729424AbeHORe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 13:34:58 -0400
Received: by mail-wm0-f65.google.com with SMTP id s9-v6so1606797wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 07:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I2UQDafRhlwWSGUrQN/8rcLHamOMjqaMdDg6JvlZSrA=;
        b=hl8LJEP/UmC1v1SLBKIQcP6eUKJzbWRT8FpvllBezo+GLmtHyM84oL4zWCKzspOZLl
         lJBOgWMTjOLKtLZjcSeWvJ2wZ+09xU+ltQgVp/Ty8GZrW9NLorT2ML7rW8iHORT4LmGP
         jMi2rM8A+seYMDaATB+//YhNsDjIzvozDTHHVoCK/6cn69aPy+jGH4gf0qtbjab5sOke
         iygANZoUhqUps9VOiZ7AQa7FBPvfNkmQkwAMEefTXwe9QaMkMDGn3bVsiYXqLCb1j9bD
         +6+VgxxXD0j7KY8SnCuVGfVnFB4GOoLQYM3AuoCar89d6xZb8uaalWs9CY+0S9m5RLQt
         VVlA==
X-Gm-Message-State: AOUpUlGqNvjkW5R0IHPFXakrOMBCa61PRGICom5dpV0e+WeKbOiFk7eu
        a92BilrIVPdAr68t6wUcJgQ=
X-Google-Smtp-Source: AA+uWPx/kdcTnwJNZ7FDSoD2iP1vX9rmS1W+o1C2niNfRK8QGiwxfKx89NWS11r1ua3TiOOwbTY7nA==
X-Received: by 2002:a1c:b84e:: with SMTP id i75-v6mr12853566wmf.158.1534344150952;
        Wed, 15 Aug 2018 07:42:30 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id d123-v6sm3189039wmd.9.2018.08.15.07.42.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 07:42:29 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 7C6CF1248A0;
        Wed, 15 Aug 2018 16:42:28 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, dan.j.williams@intel.com,
        yasu.isimatu@gmail.com, jonathan.cameron@huawei.com,
        david@redhat.com, Pavel.Tatashin@microsoft.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v3 3/4] mm/memory_hotplug: Refactor unregister_mem_sect_under_nodes
Date:   Wed, 15 Aug 2018 16:42:18 +0200
Message-Id: <20180815144219.6014-4-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180815144219.6014-1-osalvador@techadventures.net>
References: <20180815144219.6014-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

unregister_mem_sect_under_nodes() tries to allocate a nodemask_t
in order to check whithin the loop which nodes have already been unlinked,
so we do not repeat the operation on them.

NODEMASK_ALLOC calls kmalloc() if NODES_SHIFT > 8, otherwise
it just declares a nodemask_t variable whithin the stack.

Since kamlloc() can fail, we actually check whether NODEMASK_ALLOC failed
or not, and we return -ENOMEM accordingly.
remove_memory_section() does not check for the return value though.

The problem with this is that if we return -ENOMEM, it means that
unregister_mem_sect_under_nodes will not be able to remove the symlinks,
but since we do not check the return value, we go ahead and we call
unregister_memory(), which will remove all the mem_blks directories.

This will leave us with dangled symlinks.

The easiest way to overcome this is to fallback by calling
sysfs_remove_link() unconditionally in case NODEMASK_ALLOC failed.
This means that we will call sysfs_remove_link on nodes that have been
already unlinked, but nothing wrong happens as sysfs_remove_link()
backs off somewhere down the chain in case the link has already been
removed.

I think that this is better than

a) dangled symlinks
b) having to recovery from such error in remove_memory_section

Since from now on we will not need to care about return values, we can make
the function void.

As we have a safe fallback, one thing that could also be done is to add
__GFP_NORETRY in the flags when calling NODEMASK_ALLOC, so we do not retry.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 drivers/base/node.c  | 23 +++++++++++++++--------
 include/linux/node.h |  5 ++---
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index dd3bdab230b2..81b27b5b1f15 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -449,35 +449,42 @@ int register_mem_sect_under_node(struct memory_block *mem_blk, void *arg)
 }
 
 /* unregister memory section under all nodes that it spans */
-int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
+void unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
 				    unsigned long phys_index)
 {
 	NODEMASK_ALLOC(nodemask_t, unlinked_nodes, GFP_KERNEL);
 	unsigned long pfn, sect_start_pfn, sect_end_pfn;
 
-	if (!unlinked_nodes)
-		return -ENOMEM;
-	nodes_clear(*unlinked_nodes);
+	if (unlinked_nodes)
+		nodes_clear(*unlinked_nodes);
 
 	sect_start_pfn = section_nr_to_pfn(phys_index);
 	sect_end_pfn = sect_start_pfn + PAGES_PER_SECTION - 1;
 	for (pfn = sect_start_pfn; pfn <= sect_end_pfn; pfn++) {
-		int nid;
+		int nid = get_nid_for_pfn(pfn);
 
-		nid = get_nid_for_pfn(pfn);
 		if (nid < 0)
 			continue;
 		if (!node_online(nid))
 			continue;
-		if (node_test_and_set(nid, *unlinked_nodes))
+		/*
+		 * It is possible that NODEMASK_ALLOC fails due to memory
+		 * pressure.
+		 * If that happens, we fallback to call sysfs_remove_link
+		 * unconditionally.
+		 * Nothing wrong will happen as sysfs_remove_link will back off
+		 * somewhere down the chain in case the link has already been
+		 * removed.
+		 */
+		if (unlinked_nodes && node_test_and_set(nid, *unlinked_nodes))
 			continue;
+
 		sysfs_remove_link(&node_devices[nid]->dev.kobj,
 			 kobject_name(&mem_blk->dev.kobj));
 		sysfs_remove_link(&mem_blk->dev.kobj,
 			 kobject_name(&node_devices[nid]->dev.kobj));
 	}
 	NODEMASK_FREE(unlinked_nodes);
-	return 0;
 }
 
 int link_mem_sections(int nid, unsigned long start_pfn, unsigned long end_pfn)
diff --git a/include/linux/node.h b/include/linux/node.h
index 257bb3d6d014..1203378e596a 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -72,7 +72,7 @@ extern int register_cpu_under_node(unsigned int cpu, unsigned int nid);
 extern int unregister_cpu_under_node(unsigned int cpu, unsigned int nid);
 extern int register_mem_sect_under_node(struct memory_block *mem_blk,
 						void *arg);
-extern int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
+extern void unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
 					   unsigned long phys_index);
 
 #ifdef CONFIG_HUGETLBFS
@@ -105,10 +105,9 @@ static inline int register_mem_sect_under_node(struct memory_block *mem_blk,
 {
 	return 0;
 }
-static inline int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
+static inline void unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
 						  unsigned long phys_index)
 {
-	return 0;
 }
 
 static inline void register_hugetlbfs_with_node(node_registration_func_t reg,
-- 
2.13.6

