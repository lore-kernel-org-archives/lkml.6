Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A12C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6810320661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6810320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965606AbeFSGPU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:15:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:62903 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965317AbeFSGPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:15:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 23:15:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,242,1526367600"; 
   d="scan'208";a="50079006"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007.jf.intel.com with ESMTP; 18 Jun 2018 23:15:17 -0700
Subject: [PATCH v3 8/8] mm: Fix exports that inadvertently make put_page()
 EXPORT_SYMBOL_GPL
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Joe Gorse <jhgorse@gmail.com>, John Hubbard <jhubbard@nvidia.com>,
        hch@lst.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Jun 2018 23:05:20 -0700
Message-ID: <152938832086.17797.4538943238207602944.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152938827880.17797.439879736804291936.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152938827880.17797.439879736804291936.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all producers of dev_pagemap instances in the kernel are
properly converted to EXPORT_SYMBOL_GPL, fix up implicit consumers that
interact with dev_pagemap owners via put_page(). To reiterate,
dev_pagemap producers are EXPORT_SYMBOL_GPL because they adopt and
modify core memory management interfaces such that the dev_pagemap owner
can interact with all other kernel infrastructure and sub-systems
(drivers, filesystems, etc...) that consume page structures.

Fixes: e76384884344 ("mm: introduce MEMORY_DEVICE_FS_DAX and CONFIG_DEV_PAGEMAP_OPS")
Reported-by: Joe Gorse <jhgorse@gmail.com>
Reported-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 kernel/memremap.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/memremap.c b/kernel/memremap.c
index 16141b608b63..ecee37b44aa1 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -330,7 +330,7 @@ EXPORT_SYMBOL_GPL(get_dev_pagemap);
 
 #ifdef CONFIG_DEV_PAGEMAP_OPS
 DEFINE_STATIC_KEY_FALSE(devmap_managed_key);
-EXPORT_SYMBOL_GPL(devmap_managed_key);
+EXPORT_SYMBOL(devmap_managed_key);
 static atomic_t devmap_enable;
 
 /*
@@ -371,5 +371,5 @@ void __put_devmap_managed_page(struct page *page)
 	} else if (!count)
 		__put_page(page);
 }
-EXPORT_SYMBOL_GPL(__put_devmap_managed_page);
+EXPORT_SYMBOL(__put_devmap_managed_page);
 #endif /* CONFIG_DEV_PAGEMAP_OPS */

