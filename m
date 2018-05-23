Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754017AbeEWFU3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 01:20:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:43642 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754004AbeEWFU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 01:20:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,431,1520924400";
   d="scan'208";a="230872848"
Subject: [PATCH v2 2/7] mm,
 devm_memremap_pages: Kill mapping "System RAM" support
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Cc: Christoph Hellwig <hch@lst.de>,
        =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date: Tue, 22 May 2018 22:10:28 -0700
Message-ID: <152705222840.21414.15768182848742318988.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152705221686.21414.771870778478134768.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152705221686.21414.771870778478134768.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given the fact that devm_memremap_pages() requires a percpu_ref that is
torn down by devm_memremap_pages_release() the current support for
mapping RAM is broken.

This has been broken since forever and there is no use case to map RAM
in this way, so just kill the support and make it an explicit error.

Cc: Christoph Hellwig <hch@lst.de>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 kernel/memremap.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/memremap.c b/kernel/memremap.c
index c614645227a7..dd11607671eb 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -355,15 +355,12 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 	is_ram = region_intersects(align_start, align_size,
 		IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE);
 
-	if (is_ram == REGION_MIXED) {
-		WARN_ONCE(1, "%s attempted on mixed region %pr\n",
-				__func__, res);
+	if (is_ram != REGION_DISJOINT) {
+		WARN_ONCE(1, "%s attempted on %s region %pr\n", __func__,
+				is_ram == REGION_MIXED ? "mixed" : "ram", res);
 		return ERR_PTR(-ENXIO);
 	}
 
-	if (is_ram == REGION_INTERSECTS)
-		return __va(res->start);
-
 	if (!pgmap->ref)
 		return ERR_PTR(-EINVAL);
 
