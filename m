Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3935C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4EB2411F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F4EB2411F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933482AbeFVLUH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 07:20:07 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35655 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751326AbeFVLTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 07:19:35 -0400
Received: by mail-wm0-f66.google.com with SMTP id j15-v6so2184807wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 04:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7q+SCyX9fRTSy1u3QcDJ7kGaY8FPsouPHIsB2fPXOb4=;
        b=Ha1G+5XjcxJG8ykzlNay4GrOEe5eCIrb5omjS7nEONgRibnmaGrTjCNiPkVoVO6I2n
         ENkfBbRF5vOIcGjWLmpT9hHvUAF4ML+7DnSOEZFBX/DrtgT6RJ6Rpj8agvlezA9IBst0
         dGh9aXQ3ALsaOtD46PmwaVPFlVclONPR6M0TOuQHMOPwqMUWrHizJysJUBQ6GIuyXp2B
         beB3sccMMzqqxUfk54pJJH9WGRy1y5MLhysoy0ze4z5rstRzjatZ1T8DScMILBJcEyDT
         FqLId+8bpKfIHTmXzR+qvphBxuytztVNXmPbiv6EhKLP7pnDn7TMrbFZnpdvSsxFl9gg
         NtFg==
X-Gm-Message-State: APt69E21xUpzsHMZkV4DUCRLLLgyZQ0ZJqW6N+RstdWp82SxH9c0t3it
        VY6wGLl3NCK8j38CF7/M71o=
X-Google-Smtp-Source: AAOMgpd42HpttVA8hG03bSeXzhT6wChbDY6q39LXnD6aNak9PQOOKpP0TfrGmyYAUfbKh5QTJnmfbg==
X-Received: by 2002:a1c:4787:: with SMTP id m7-v6mr1457715wmi.92.1529666373911;
        Fri, 22 Jun 2018 04:19:33 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id f18-v6sm11734839wro.1.2018.06.22.04.19.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 04:19:33 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id ECF2012375C;
        Fri, 22 Jun 2018 13:19:31 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, pasha.tatashin@oracle.com,
        Jonathan.Cameron@huawei.com, arbab@linux.vnet.ibm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 3/4] mm/memory_hotplug: Make register_mem_sect_under_node a cb of walk_memory_range
Date:   Fri, 22 Jun 2018 13:18:38 +0200
Message-Id: <20180622111839.10071-4-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180622111839.10071-1-osalvador@techadventures.net>
References: <20180622111839.10071-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

link_mem_sections() and walk_memory_range() share most of the code,
so we can use convert link_mem_sections() into a dummy function that calls
walk_memory_range() with a callback to register_mem_sect_under_node().

This patch converts register_mem_sect_under_node() in order to
match a walk_memory_range's callback, getting rid of the
check_nid argument and checking instead if the system is still
boothing, since we only have to check for the nid if the system
is in such state.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Suggested-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 drivers/base/node.c  | 44 ++++++--------------------------------------
 include/linux/node.h | 12 +++++++-----
 mm/memory_hotplug.c  |  5 +----
 3 files changed, 14 insertions(+), 47 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index a5e821d09656..845d5523812b 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -399,10 +399,9 @@ static int __ref get_nid_for_pfn(unsigned long pfn)
 }
 
 /* register memory section under specified node if it spans that node */
-int register_mem_sect_under_node(struct memory_block *mem_blk, int nid,
-				 bool check_nid)
+int register_mem_sect_under_node(struct memory_block *mem_blk, void *arg)
 {
-	int ret;
+	int ret, nid = *(int *)arg;
 	unsigned long pfn, sect_start_pfn, sect_end_pfn;
 
 	if (!mem_blk)
@@ -433,7 +432,7 @@ int register_mem_sect_under_node(struct memory_block *mem_blk, int nid,
 		 * case, during hotplug we know that all pages in the memory
 		 * block belong to the same node.
 		 */
-		if (check_nid) {
+		if (system_state == SYSTEM_BOOTING) {
 			page_nid = get_nid_for_pfn(pfn);
 			if (page_nid < 0)
 				continue;
@@ -490,41 +489,10 @@ int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
 	return 0;
 }
 
-int link_mem_sections(int nid, unsigned long start_pfn, unsigned long nr_pages,
-		      bool check_nid)
+int link_mem_sections(int nid, unsigned long start_pfn, unsigned long end_pfn)
 {
-	unsigned long end_pfn = start_pfn + nr_pages;
-	unsigned long pfn;
-	struct memory_block *mem_blk = NULL;
-	int err = 0;
-
-	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
-		unsigned long section_nr = pfn_to_section_nr(pfn);
-		struct mem_section *mem_sect;
-		int ret;
-
-		if (!present_section_nr(section_nr))
-			continue;
-		mem_sect = __nr_to_section(section_nr);
-
-		/* same memblock ? */
-		if (mem_blk)
-			if ((section_nr >= mem_blk->start_section_nr) &&
-			    (section_nr <= mem_blk->end_section_nr))
-				continue;
-
-		mem_blk = find_memory_block_hinted(mem_sect, mem_blk);
-
-		ret = register_mem_sect_under_node(mem_blk, nid, check_nid);
-		if (!err)
-			err = ret;
-
-		/* discard ref obtained in find_memory_block() */
-	}
-
-	if (mem_blk)
-		kobject_put(&mem_blk->dev.kobj);
-	return err;
+	return walk_memory_range(start_pfn, end_pfn, (void *)&nid,
+					register_mem_sect_under_node);
 }
 
 #ifdef CONFIG_HUGETLBFS
diff --git a/include/linux/node.h b/include/linux/node.h
index 6d336e38d155..257bb3d6d014 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -33,10 +33,10 @@ typedef  void (*node_registration_func_t)(struct node *);
 
 #if defined(CONFIG_MEMORY_HOTPLUG_SPARSE) && defined(CONFIG_NUMA)
 extern int link_mem_sections(int nid, unsigned long start_pfn,
-			     unsigned long nr_pages, bool check_nid);
+			     unsigned long end_pfn);
 #else
 static inline int link_mem_sections(int nid, unsigned long start_pfn,
-				    unsigned long nr_pages, bool check_nid)
+				    unsigned long end_pfn)
 {
 	return 0;
 }
@@ -54,12 +54,14 @@ static inline int register_one_node(int nid)
 
 	if (node_online(nid)) {
 		struct pglist_data *pgdat = NODE_DATA(nid);
+		unsigned long start_pfn = pgdat->node_start_pfn;
+		unsigned long end_pfn = start_pfn + pgdat->node_spanned_pages;
 
 		error = __register_one_node(nid);
 		if (error)
 			return error;
 		/* link memory sections under this node */
-		error = link_mem_sections(nid, pgdat->node_start_pfn, pgdat->node_spanned_pages, true);
+		error = link_mem_sections(nid, start_pfn, end_pfn);
 	}
 
 	return error;
@@ -69,7 +71,7 @@ extern void unregister_one_node(int nid);
 extern int register_cpu_under_node(unsigned int cpu, unsigned int nid);
 extern int unregister_cpu_under_node(unsigned int cpu, unsigned int nid);
 extern int register_mem_sect_under_node(struct memory_block *mem_blk,
-						int nid, bool check_nid);
+						void *arg);
 extern int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
 					   unsigned long phys_index);
 
@@ -99,7 +101,7 @@ static inline int unregister_cpu_under_node(unsigned int cpu, unsigned int nid)
 	return 0;
 }
 static inline int register_mem_sect_under_node(struct memory_block *mem_blk,
-							int nid, bool check_nid)
+							void *arg)
 {
 	return 0;
 }
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index e2ed64b994e5..4eb6e824a80c 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1123,7 +1123,6 @@ int __ref add_memory_resource(int nid, struct resource *res, bool online)
 	u64 start, size;
 	bool new_node = false;
 	int ret;
-	unsigned long start_pfn, nr_pages;
 
 	start = res->start;
 	size = resource_size(res);
@@ -1164,9 +1163,7 @@ int __ref add_memory_resource(int nid, struct resource *res, bool online)
 	}
 
 	/* link memory sections under this node.*/
-	start_pfn = start >> PAGE_SHIFT;
-	nr_pages = size >> PAGE_SHIFT;
-	ret = link_mem_sections(nid, start_pfn, nr_pages, false);
+	ret = link_mem_sections(nid, PFN_DOWN(start), PFN_UP(start + size - 1));
 	BUG_ON(ret);
 
 	/* create new memmap entry */
-- 
2.13.6

