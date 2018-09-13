Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD6DC070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5353A20882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5353A20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeIMHlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:41:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:54833 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbeIMHlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:41:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2018 19:33:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,367,1531810800"; 
   d="scan'208";a="70448393"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga008.fm.intel.com with ESMTP; 12 Sep 2018 19:33:53 -0700
Subject: [PATCH v5 2/7] mm,
 devm_memremap_pages: Kill mapping "System RAM" support
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Christoph Hellwig <hch@lst.de>,
        =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        alexander.h.duyck@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 12 Sep 2018 19:22:11 -0700
Message-ID: <153680533172.453305.5701902165148172434.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <153680531988.453305.8080706591516037706.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153680531988.453305.8080706591516037706.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given the fact that devm_memremap_pages() requires a percpu_ref that is
torn down by devm_memremap_pages_release() the current support for
mapping RAM is broken.

Support for remapping "System RAM" has been broken since the beginning
and there is no existing user of this this code path, so just kill the
support and make it an explicit error.

This cleanup also simplifies a follow-on patch to fix the error path
when setting a devm release action for devm_memremap_pages_release()
fails.

Cc: Christoph Hellwig <hch@lst.de>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 kernel/memremap.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/memremap.c b/kernel/memremap.c
index f95c7833db6d..92e838127767 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -202,15 +202,12 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
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
 

