Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E3FC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCE42189A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CCE42189A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbeHMS3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 14:29:41 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36544 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729584AbeHMS3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 14:29:40 -0400
Received: by mail-wm0-f65.google.com with SMTP id w24-v6so9285515wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 08:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IB5W08PwRnoqD1j6A2k+r5VZM221mRLqKiPSCZVq6fA=;
        b=fgfvPcDBI6jVA+x+yOqKl73ZLRR+DrE/8PYK6O3M1HoFrEU/wKgI4+qBfN0rdLRhNP
         Ko5wqS/ba3XoV5zsYKjFG9ORGb87i48BOLKHPnfszRirJoGBXrfuDKH+62mfIjnZpQOt
         yWFmn2fsCHufAdTi4BZXmhLP0zYnC9+3XXpaAk6aXR86OPUFE5xSIuSazEQODBHL5yUI
         W+EVxID7sI4b6SAUYcwuvJV0Nl6yR+Zeas3u4P7zppB+KSM+Mmbx7pOTSWaDYJrjGFed
         ecPUxqE/MzHgRgNAizr7fLREuVMXfsOAq4KD/tF/yHUFG2Kc9V29eYrTfB4nVDZrGxWp
         Pupw==
X-Gm-Message-State: AOUpUlHFjnfAuBGGxPqnfakEMr6rFo+2aXq1Z3PQa/mP3lUvzE4SHQCq
        21MMLMam+JRp5hbEzJU+ZDo=
X-Google-Smtp-Source: AA+uWPzMA2PvUY8i1r5SW2wkOyWuIfKfLLL95ZgemXZAAnKsGp68R673Wz3lCcQ2K36YkaElSEfQ4Q==
X-Received: by 2002:a1c:be13:: with SMTP id o19-v6mr7927383wmf.1.1534175211653;
        Mon, 13 Aug 2018 08:46:51 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id t6-v6sm11123934wmf.8.2018.08.13.08.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 08:46:50 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 0165412485F;
        Mon, 13 Aug 2018 17:46:48 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, jglisse@redhat.com,
        rafael@kernel.org, david@redhat.com, yasu.isimatu@gmail.com,
        logang@deltatee.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 3/3] mm/memory_hotplug: Refactor unregister_mem_sect_under_nodes
Date:   Mon, 13 Aug 2018 17:46:39 +0200
Message-Id: <20180813154639.19454-4-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180813154639.19454-1-osalvador@techadventures.net>
References: <20180813154639.19454-1-osalvador@techadventures.net>
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

Since kamlloc() can fail, we actually check whether NODEMASK_ALLOC failed or
not, and we return -ENOMEM accordingly.
remove_memory_section() does not check for the return value though.

The problem with this is that if we return -ENOMEM, it means that
unregister_mem_sect_under_nodes will not be able to remove the symlinks,
but since we do not check the return value, we go ahead and we call unregister_memory(),
which will remove all the mem_blks directories.

This will leave us with dangled symlinks.

The easiest way to overcome this is to fallback by calling sysfs_remove_link()
unconditionally in case NODEMASK_ALLOC failed.
This means that we will call sysfs_remove_link on nodes that have been already unlinked,
but nothing wrong happens as sysfs_remove_link() backs off somewhere down the chain in case
the link has already been removed.

I think that this is better than

a) dangled symlinks
b) having to recovery from such error in remove_memory_section

Since from now on we will not need to take care about return values, we can make the function void.

While at it, we can also drop the node_online() check, as a node can only be
offline if all the memory/cpus associated with it have been removed.

As we have a safe fallback, one thing that could also be done is to add __GFP_NORETRY
in the flags when calling NODEMASK_ALLOC, so we do not retry.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 drivers/base/node.c  | 26 +++++++++++++++-----------
 include/linux/node.h |  5 ++---
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index dd3bdab230b2..0a3ca62687ea 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -449,35 +449,39 @@ int register_mem_sect_under_node(struct memory_block *mem_blk, void *arg)
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
+		int nid = get_nid_for_pfn(pfn);;
 
-		nid = get_nid_for_pfn(pfn);
 		if (nid < 0)
 			continue;
-		if (!node_online(nid))
-			continue;
-		if (node_test_and_set(nid, *unlinked_nodes))
+		/*
+		 * It is possible that NODEMASK_ALLOC fails due to memory pressure.
+		 * If that happens, we fallback to call sysfs_remove_link unconditionally.
+		 * Nothing wrong will happen as sysfs_remove_link will back off
+		 * somewhere down the chain in case the link has already been removed.
+		 */
+		if (unlinked_nodes && node_test_and_set(nid, *unlinked_nodes))
 			continue;
+
 		sysfs_remove_link(&node_devices[nid]->dev.kobj,
 			 kobject_name(&mem_blk->dev.kobj));
 		sysfs_remove_link(&mem_blk->dev.kobj,
 			 kobject_name(&node_devices[nid]->dev.kobj));
 	}
-	NODEMASK_FREE(unlinked_nodes);
-	return 0;
+
+	if (unlinked_nodes)
+		NODEMASK_FREE(unlinked_nodes);
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

