Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463A6C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0375426FB8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0375426FB8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933463AbeF1G3X (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 02:29:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932350AbeF1G3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 02:29:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B5509A5002;
        Thu, 28 Jun 2018 06:29:20 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40A412156880;
        Thu, 28 Jun 2018 06:29:15 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, pagupta@redhat.com,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@techadventures.net>
Cc:     linux-mm@kvack.org, kirill.shutemov@linux.intel.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v6 3/5] mm/sparse: Add a new parameter 'data_unit_size' for alloc_usemap_and_memmap
Date:   Thu, 28 Jun 2018 14:28:55 +0800
Message-Id: <20180628062857.29658-4-bhe@redhat.com>
In-Reply-To: <20180628062857.29658-1-bhe@redhat.com>
References: <20180628062857.29658-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 28 Jun 2018 06:29:20 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 28 Jun 2018 06:29:20 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_usemap_and_memmap() is passing in a "void *" that points to
usemap_map or memmap_map. In next patch we will change both of the
map allocation from taking 'NR_MEM_SECTIONS' as the length to taking
'nr_present_sections' as the length. After that, the passed in 'void*'
needs to update as things get consumed. But, it knows only the
quantity of objects consumed and not the type.  This effectively
tells it enough about the type to let it update the pointer as
objects are consumed.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 mm/sparse.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 6a706093307d..4458a23e5293 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -486,10 +486,12 @@ void __weak __meminit vmemmap_populate_print_last(void)
 /**
  *  alloc_usemap_and_memmap - memory alloction for pageblock flags and vmemmap
  *  @map: usemap_map for pageblock flags or mmap_map for vmemmap
+ *  @unit_size: size of map unit
  */
 static void __init alloc_usemap_and_memmap(void (*alloc_func)
 					(void *, unsigned long, unsigned long,
-					unsigned long, int), void *data)
+					unsigned long, int), void *data,
+					int data_unit_size)
 {
 	unsigned long pnum;
 	unsigned long map_count;
@@ -566,7 +568,8 @@ void __init sparse_init(void)
 	if (!usemap_map)
 		panic("can not allocate usemap_map\n");
 	alloc_usemap_and_memmap(sparse_early_usemaps_alloc_node,
-							(void *)usemap_map);
+				(void *)usemap_map,
+				sizeof(usemap_map[0]));
 
 #ifdef CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
 	size2 = sizeof(struct page *) * NR_MEM_SECTIONS;
@@ -574,7 +577,8 @@ void __init sparse_init(void)
 	if (!map_map)
 		panic("can not allocate map_map\n");
 	alloc_usemap_and_memmap(sparse_early_mem_maps_alloc_node,
-							(void *)map_map);
+				(void *)map_map,
+				sizeof(map_map[0]));
 #endif
 
 	for_each_present_section_nr(0, pnum) {
-- 
2.13.6

