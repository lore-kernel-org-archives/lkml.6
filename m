Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8537FC43615
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370D7218A8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370D7218A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbeHQMDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:03:01 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54261 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeHQMDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:03:01 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so6893467wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 02:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HgGRrJWJGXklKxYx7FB74hjJfmuXFq2Z33rZBcVarRg=;
        b=QhL/dzH/Ms8Cb2u0U9t3spjpNuJr4TS49FjOjuLG7TQYrKZxRj8flwXzP9ZtFKvmyi
         xMxo2QOgB4zLfC1CKaS76XneNma8KhUNZOSSvGEFisYTXaz5nXfLNL7/lszRfin0Yb1O
         heAA+vgbuyHoaJF7kRq4z4JAqXiKOhcRUXMsaMuoBQibb9v77qmkwt02S+EhGAOGc/x8
         Mh6dofiaBn7mmmQpoDJvy24yE9VjHDvC5+/5wnxOpTeZ4yw2igaptQaqFr0y810ESTuw
         qYuX6EypwNhMWY6BBm32XlPyKGdrX1PpdOLxXzV1Q96AmH6QfJmYKtJBMmkmD208gb1V
         aAmg==
X-Gm-Message-State: AOUpUlERaHZ3Ls/usN1i+0beTRqbiVqbE8HEC0A235aQzxiVewSpw7Km
        YWCCg5CaTtCpfnl9Rx1e8yo=
X-Google-Smtp-Source: AA+uWPwWDnj2UfVUO0MHbRYcXJg/4nGX6MeIsQVdZF4viPYrzfyjZVuVUBwywZRBReLBe1pXaXxdMA==
X-Received: by 2002:a1c:8952:: with SMTP id l79-v6mr17261749wmd.7.1534496424962;
        Fri, 17 Aug 2018 02:00:24 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id 199-v6sm8209192wmp.37.2018.08.17.02.00.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 02:00:23 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 76CE7124937;
        Fri, 17 Aug 2018 11:00:21 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, dan.j.williams@intel.com,
        yasu.isimatu@gmail.com, jonathan.cameron@huawei.com,
        david@redhat.com, Pavel.Tatashin@microsoft.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v4 3/4] mm/memory_hotplug: Define nodemask_t as a stack variable
Date:   Fri, 17 Aug 2018 11:00:16 +0200
Message-Id: <20180817090017.17610-4-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180817090017.17610-1-osalvador@techadventures.net>
References: <20180817090017.17610-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

Currently, unregister_mem_sect_under_nodes() tries to allocate a nodemask_t
in order to check whithin the loop which nodes have already been unlinked,
so we do not repeat the operation on them.

NODEMASK_ALLOC calls kmalloc() if NODES_SHIFT > 8, otherwise
it just declares a nodemask_t variable whithin the stack.

Since kmalloc() can fail, we actually check whether NODEMASK_ALLOC failed
or not, and we return -ENOMEM accordingly.
remove_memory_section() does not check for the return value though.
It is pretty rare that such a tiny allocation can fail, but if it does,
we will be left with dangled symlinks under /sys/devices/system/node/,
since the mem_blk's directories will be removed no matter what
unregister_mem_sect_under_nodes() returns.

One way to solve this is to check whether unlinked_nodes is NULL or not.
In the case it is not, we can just use it as before, but if it is NULL,
we can just skip the node_test_and_set check, and call sysfs_remove_link()
unconditionally.
This is harmless as sysfs_remove_link() backs off somewhere down the chain
in case the link has already been removed.
This method was presented in v3 of the path [1].

But since the maximum number of nodes we can have is 1024,
when NODES_SHIFT = 10, that gives us a nodemask_t of 128 bytes.
Although everything depends on how deep the stack is, I think we can afford
to define the nodemask_t variable whithin the stack.

That simplifies the code, and we do not need to worry about untested error
code paths.

If we see that this causes troubles with the stack, we can always return to [1].

[1] https://patchwork.kernel.org/patch/10566673/

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 drivers/base/node.c  | 16 ++++++----------
 include/linux/node.h |  5 ++---
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index dd3bdab230b2..6b8c9b4537c9 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -449,35 +449,31 @@ int register_mem_sect_under_node(struct memory_block *mem_blk, void *arg)
 }
 
 /* unregister memory section under all nodes that it spans */
-int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
+void unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
 				    unsigned long phys_index)
 {
-	NODEMASK_ALLOC(nodemask_t, unlinked_nodes, GFP_KERNEL);
+	nodemask_t unlinked_nodes;
 	unsigned long pfn, sect_start_pfn, sect_end_pfn;
 
-	if (!unlinked_nodes)
-		return -ENOMEM;
-	nodes_clear(*unlinked_nodes);
+	nodes_clear(unlinked_nodes);
 
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
+		if (node_test_and_set(nid, unlinked_nodes))
 			continue;
+
 		sysfs_remove_link(&node_devices[nid]->dev.kobj,
 			 kobject_name(&mem_blk->dev.kobj));
 		sysfs_remove_link(&mem_blk->dev.kobj,
 			 kobject_name(&node_devices[nid]->dev.kobj));
 	}
-	NODEMASK_FREE(unlinked_nodes);
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

