Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752126AbeBJSFo (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 13:05:44 -0500
Received: from mga11.intel.com ([192.55.52.93]:9474 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751115AbeBJSFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 13:05:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,490,1511856000";
   d="scan'208";a="30422781"
From: Alexey Skidanov <alexey.skidanov@intel.com>
To: chris@chris-wilson.co.uk
Cc: linux-kernel@vger.kernel.org,
        Alexey Skidanov <alexey.skidanov@intel.com>
Subject: [PATCH] lib/scatterlist: Make sg_page_count() accessible to other modules
Date: Sat, 10 Feb 2018 20:06:04 +0200
Message-Id: <1518285964-31657-1-git-send-email-alexey.skidanov@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, sg_page_count() may be used only inside the scatterlist.c file.

However, the same calculation is done outside of scatterlist.c file
causing to code duplication.

To fix this, we move the sg_page_count() to the scatterlist.h file, making it
accessible to other modules.

Signed-off-by: Alexey Skidanov <alexey.skidanov@intel.com>
---
 include/linux/scatterlist.h | 5 +++++
 lib/scatterlist.c           | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index b7c8325..fe28148 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -248,6 +248,11 @@ static inline void *sg_virt(struct scatterlist *sg)
 	return page_address(sg_page(sg)) + sg->offset;
 }
 
+static inline int sg_page_count(struct scatterlist *sg)
+{
+	return PAGE_ALIGN(sg->offset + sg->length) >> PAGE_SHIFT;
+}
+
 int sg_nents(struct scatterlist *sg);
 int sg_nents_for_len(struct scatterlist *sg, u64 len);
 struct scatterlist *sg_next(struct scatterlist *);
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 7c1c55f..4a59131 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -486,11 +486,6 @@ void __sg_page_iter_start(struct sg_page_iter *piter,
 }
 EXPORT_SYMBOL(__sg_page_iter_start);
 
-static int sg_page_count(struct scatterlist *sg)
-{
-	return PAGE_ALIGN(sg->offset + sg->length) >> PAGE_SHIFT;
-}
-
 bool __sg_page_iter_next(struct sg_page_iter *piter)
 {
 	if (!piter->__nents || !piter->sg)
-- 
2.7.4
