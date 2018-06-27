Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCCAC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC17726906
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC17726906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964870AbeF0Bbg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 21:31:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39182 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934710AbeF0Bbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 21:31:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B3D04400B455;
        Wed, 27 Jun 2018 01:31:33 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F25E4111764C;
        Wed, 27 Jun 2018 01:31:29 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, pagupta@redhat.com
Cc:     linux-mm@kvack.org, kirill.shutemov@linux.intel.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 2/4] mm/sparsemem: Defer the ms->section_mem_map clearing
Date:   Wed, 27 Jun 2018 09:31:14 +0800
Message-Id: <20180627013116.12411-3-bhe@redhat.com>
In-Reply-To: <20180627013116.12411-1-bhe@redhat.com>
References: <20180627013116.12411-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 27 Jun 2018 01:31:33 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 27 Jun 2018 01:31:33 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
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
---
 mm/sparse-vmemmap.c |  1 -
 mm/sparse.c         | 12 ++++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index bd0276d5f66b..640e68f8324b 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -303,7 +303,6 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
 		ms = __nr_to_section(pnum);
 		pr_err("%s: sparsemem memory map backing failed some memory will not be available\n",
 		       __func__);
-		ms->section_mem_map = 0;
 	}
 
 	if (vmemmap_buf_start) {
diff --git a/mm/sparse.c b/mm/sparse.c
index 6314303130b0..71ad53da2cd1 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -451,7 +451,6 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
 		ms = __nr_to_section(pnum);
 		pr_err("%s: sparsemem memory map backing failed some memory will not be available\n",
 		       __func__);
-		ms->section_mem_map = 0;
 	}
 }
 #endif /* !CONFIG_SPARSEMEM_VMEMMAP */
@@ -479,7 +478,6 @@ static struct page __init *sparse_early_mem_map_alloc(unsigned long pnum)
 
 	pr_err("%s: sparsemem memory map backing failed some memory will not be available\n",
 	       __func__);
-	ms->section_mem_map = 0;
 	return NULL;
 }
 #endif
@@ -583,17 +581,23 @@ void __init sparse_init(void)
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

