Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932314AbeCFE6N (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 23:58:13 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38673 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932069AbeCFE6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 23:58:12 -0500
X-Google-Smtp-Source: AG47ELtsG8JEt4ZPS/DJu9VZPjNQ+dcaDLtJCp1ALxRSuc3DPzO9phu/wB0zOSi1dYDilD1CafydsA==
From: "Oliver O'Halloran" <oohall@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-nvdimm@lists.01.org, "Oliver O'Halloran" <oohall@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] kernel/memremap: Remove stale devres_free() call
Date: Tue,  6 Mar 2018 15:56:47 +1100
Message-Id: <20180306045647.7784-1-oohall@gmail.com>
X-Mailer: git-send-email 2.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_memremap_pages() was re-worked in e8d513483300 to take a caller
allocated struct dev_pagemap as a function parameter. A call to
devres_free() was left in the error cleanup path which results in
a kernel panic if the remap fails for some reason. Remove it
to fix the panic and let devm_memremap_pages() fail gracefully.

Fixes: e8d513483300 ("memremap: change devm_memremap_pages interface to use struct dev_pagemap")
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
Both in-tree users of devm_memremap_pages() embed dev_pagemap into other
structures so this shouldn't cause any leaks. Logan's p2p series does
add one usage that assumes pgmap will be freed on error so that'll
need fixing.
---
 kernel/memremap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/memremap.c b/kernel/memremap.c
index 4dd4274cabe2..895e6b76b25e 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -427,7 +427,6 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
  err_pfn_remap:
  err_radix:
 	pgmap_radix_release(res, pgoff);
-	devres_free(pgmap);
 	return ERR_PTR(error);
 }
 EXPORT_SYMBOL(devm_memremap_pages);
-- 
2.9.5
