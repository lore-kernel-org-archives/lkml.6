Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B43FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D204221841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217711;
	bh=7ZiFMw1oWMcKo5JsQal74LgtHTjT4MssxNse+xau43o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xBJgXAW0hbU3gegkykuddTVwoAehBTbogxWXBHGqTpxTOJ8u6Fe9B+OfrxKTvvu3k
	 FTWtGvMK2V69KbGjdJacAal9uXPPboHzWxSbKLbK3HRfgkZ7ZyUY7ir5Xvc98c+eYK
	 J0IPoOT3r58rdv3QM9Wlaoe3cflXtfl9NVVH/pAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404051AbfAKOlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:41:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:34542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404035AbfAKOlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:41:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D95262133F;
        Fri, 11 Jan 2019 14:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217706;
        bh=7ZiFMw1oWMcKo5JsQal74LgtHTjT4MssxNse+xau43o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jVN6tXTkUQ9K/phBm8jJ1Ik4UmIQNnIMx/RimirAocx2q6gWkWeiR9ZM1aUJ5k8uE
         bnUVJ7r5/AoOrQnYSD8tQEi/bxQ772Ew/2ED7m93muLC54tm3unABK1T2/4EAePqAa
         08N9/slh5fjHzVCGKl58N5r40PvdYUoC6zRo8YIw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.20 12/65] mm, devm_memremap_pages: add MEMORY_DEVICE_PRIVATE support
Date:   Fri, 11 Jan 2019 15:14:58 +0100
Message-Id: <20190111131058.081682210@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 69324b8f48339de2f90fdf2f774687fc6c47629a upstream.

In preparation for consolidating all ZONE_DEVICE enabling via
devm_memremap_pages(), teach it how to handle the constraints of
MEMORY_DEVICE_PRIVATE ranges.

[jglisse@redhat.com: call move_pfn_range_to_zone for MEMORY_DEVICE_PRIVATE]
Link: http://lkml.kernel.org/r/154275559036.76910.12434636179931292607.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
Acked-by: Christoph Hellwig <hch@lst.de>
Reported-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/memremap.c |   53 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 12 deletions(-)

--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -98,9 +98,15 @@ static void devm_memremap_pages_release(
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
@@ -187,17 +193,40 @@ void *devm_memremap_pages(struct device
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


