Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A5FC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4311926FB8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4311926FB8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933195AbeF1G3R (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 02:29:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932350AbeF1G3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 02:29:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E898401DE6D;
        Thu, 28 Jun 2018 06:29:15 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A80D2156880;
        Thu, 28 Jun 2018 06:29:10 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, pagupta@redhat.com,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@techadventures.net>
Cc:     linux-mm@kvack.org, kirill.shutemov@linux.intel.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v6 2/5] mm/sparsemem: Defer the ms->section_mem_map clearing
Date:   Thu, 28 Jun 2018 14:28:54 +0800
Message-Id: <20180628062857.29658-3-bhe@redhat.com>
In-Reply-To: <20180628062857.29658-1-bhe@redhat.com>
References: <20180628062857.29658-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 28 Jun 2018 06:29:15 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 28 Jun 2018 06:29:15 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sparse_init(), if CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y, system
will allocate one continuous memory chunk for mem maps on one node and
populate the relevant page tables to map memory section one by one. If
fail to populate for a certain mem section, print warning and its
->section_mem_map will be cleared to cancel the marking of being present.
Like this, the number of mem sections marked as present could become
less during sparse_init() execution.

Here just defer the ms->section_mem_map clearing if failed to populate
its page tables until the last for_each_present_section_nr() loop. This
is in preparation for later optimizing the mem map allocation.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 mm/sparse-vmemmap.c |  4 ----
 mm/sparse.c         | 15 ++++++++-------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index bd0276d5f66b..68bb65b2d34d 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -292,18 +292,14 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
 	}
 
 	for (pnum = pnum_begin; pnum < pnum_end; pnum++) {
-		struct mem_section *ms;
-
 		if (!present_section_nr(pnum))
 			continue;
 
 		map_map[pnum] = sparse_mem_map_populate(pnum, nodeid, NULL);
 		if (map_map[pnum])
 			continue;
-		ms = __nr_to_section(pnum);
 		pr_err("%s: sparsemem memory map backing failed some memory will not be available\n",
 		       __func__);
-		ms->section_mem_map = 0;
 	}
 
 	if (vmemmap_buf_start) {
diff --git a/mm/sparse.c b/mm/sparse.c
index 6314303130b0..6a706093307d 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -441,17 +441,13 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
 
 	/* fallback */
 	for (pnum = pnum_begin; pnum < pnum_end; pnum++) {
-		struct mem_section *ms;
-
 		if (!present_section_nr(pnum))
 			continue;
 		map_map[pnum] = sparse_mem_map_populate(pnum, nodeid, NULL);
 		if (map_map[pnum])
 			continue;
-		ms = __nr_to_section(pnum);
 		pr_err("%s: sparsemem memory map backing failed some memory will not be available\n",
 		       __func__);
-		ms->section_mem_map = 0;
 	}
 }
 #endif /* !CONFIG_SPARSEMEM_VMEMMAP */
@@ -479,7 +475,6 @@ static struct page __init *sparse_early_mem_map_alloc(unsigned long pnum)
 
 	pr_err("%s: sparsemem memory map backing failed some memory will not be available\n",
 	       __func__);
-	ms->section_mem_map = 0;
 	return NULL;
 }
 #endif
@@ -583,17 +578,23 @@ void __init sparse_init(void)
 #endif
 
 	for_each_present_section_nr(0, pnum) {
+		struct mem_section *ms;
+		ms = __nr_to_section(pnum);
 		usemap = usemap_map[pnum];
-		if (!usemap)
+		if (!usemap) {
+			ms->section_mem_map = 0;
 			continue;
+		}
 
 #ifdef CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
 		map = map_map[pnum];
 #else
 		map = sparse_early_mem_map_alloc(pnum);
 #endif
-		if (!map)
+		if (!map) {
+			ms->section_mem_map = 0;
 			continue;
+		}
 
 		sparse_init_one_section(__nr_to_section(pnum), pnum, map,
 								usemap);
-- 
2.13.6

