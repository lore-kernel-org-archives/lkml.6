Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397F1C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25A32133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E25A32133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbeISCIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 22:08:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38014 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730248AbeISCIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 22:08:52 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 985A6C025D03;
        Tue, 18 Sep 2018 20:34:35 +0000 (UTC)
Received: from redhat.com (ovpn-124-13.rdu2.redhat.com [10.10.124.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B68830912F4;
        Tue, 18 Sep 2018 20:34:34 +0000 (UTC)
Date:   Tue, 18 Sep 2018 16:34:32 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Christoph Hellwig <hch@lst.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        alexander.h.duyck@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/7] mm, devm_memremap_pages: Add
 MEMORY_DEVICE_PRIVATE support
Message-ID: <20180918203432.GD14689@redhat.com>
References: <153680531988.453305.8080706591516037706.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153680534246.453305.10522027577023444732.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <153680534246.453305.10522027577023444732.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 18 Sep 2018 20:34:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is v2 of this patch with v2 it works properly:


From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 12 Sep 2018 19:22:22 -0700
Subject: [PATCH] mm, devm_memremap_pages: Add MEMORY_DEVICE_PRIVATE support v2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In preparation for consolidating all ZONE_DEVICE enabling via
devm_memremap_pages(), teach it how to handle the constraints of
MEMORY_DEVICE_PRIVATE ranges.

Changed since v1:
    - move_pfn_range_to_zone() for private device memory too

Cc: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
Reported-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 kernel/memremap.c | 53 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/kernel/memremap.c b/kernel/memremap.c
index 5b3b6f23fd35..adba623a25f4 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -132,9 +132,15 @@ static void devm_memremap_pages_release(void *data)
 		- align_start;
 
 	mem_hotplug_begin();
-	arch_remove_memory(align_start, align_size, pgmap->altmap_valid ?
-			&pgmap->altmap : NULL);
-	kasan_remove_zero_shadow(__va(align_start), align_size);
+	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
+		pfn = align_start >> PAGE_SHIFT;
+		__remove_pages(page_zone(pfn_to_page(pfn)), pfn,
+				align_size >> PAGE_SHIFT, NULL);
+	} else {
+		arch_remove_memory(align_start, align_size,
+				pgmap->altmap_valid ? &pgmap->altmap : NULL);
+		kasan_remove_zero_shadow(__va(align_start), align_size);
+	}
 	mem_hotplug_done();
 
 	untrack_pfn(NULL, PHYS_PFN(align_start), align_size);
@@ -234,17 +240,40 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap,
 		goto err_pfn_remap;
 
 	mem_hotplug_begin();
-	error = kasan_add_zero_shadow(__va(align_start), align_size);
-	if (error) {
-		mem_hotplug_done();
-		goto err_kasan;
+
+	/*
+	 * For device private memory we call add_pages() as we only need to
+	 * allocate and initialize struct page for the device memory. More-
+	 * over the device memory is un-accessible thus we do not want to
+	 * create a linear mapping for the memory like arch_add_memory()
+	 * would do.
+	 *
+	 * For all other device memory types, which are accessible by
+	 * the CPU, we do want the linear mapping and thus use
+	 * arch_add_memory().
+	 */
+	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
+		error = add_pages(nid, align_start >> PAGE_SHIFT,
+				align_size >> PAGE_SHIFT, NULL, false);
+	} else {
+		error = kasan_add_zero_shadow(__va(align_start), align_size);
+		if (error) {
+			mem_hotplug_done();
+			goto err_kasan;
+		}
+
+		error = arch_add_memory(nid, align_start, align_size, altmap,
+				false);
+	}
+
+	if (!error) {
+		struct zone *zone;
+
+		zone = &NODE_DATA(nid)->node_zones[ZONE_DEVICE];
+		move_pfn_range_to_zone(zone, align_start >> PAGE_SHIFT,
+				align_size >> PAGE_SHIFT, altmap);
 	}
 
-	error = arch_add_memory(nid, align_start, align_size, altmap, false);
-	if (!error)
-		move_pfn_range_to_zone(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
-					align_start >> PAGE_SHIFT,
-					align_size >> PAGE_SHIFT, altmap);
 	mem_hotplug_done();
 	if (error)
 		goto err_add_memory;
-- 
2.17.1

