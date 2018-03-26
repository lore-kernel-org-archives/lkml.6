Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752568AbeCZWqS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:46:18 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46006 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752157AbeCZWqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:46:16 -0400
X-Google-Smtp-Source: AG47ELsLy+zno8P2jtcxyI39p0LGE2HujYENipOtNwtsrDmMIMVaRbJR3vYNeOh2DIozg1T+r+2erA==
From: Wei Yang <richard.weiyang@gmail.com>
To: vgoyal@redhat.com, thomas.lendacky@amd.com, bp@suse.de
Cc: linux-kernel@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH] kernel/resource: refine find_next_iomem_res() a little
Date: Tue, 27 Mar 2018 06:46:06 +0800
Message-Id: <20180326224606.79666-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does several refine for find_next_iomem_res()

  * use first_level_children_only directly
  * remove some local variables
  * use resrouce_clip()

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 kernel/resource.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index e270b5048988..769109f20fb7 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -351,6 +351,15 @@ int release_resource(struct resource *old)
 
 EXPORT_SYMBOL(release_resource);
 
+static void resource_clip(struct resource *res, resource_size_t min,
+			  resource_size_t max)
+{
+	if (res->start < min)
+		res->start = min;
+	if (res->end > max)
+		res->end = max;
+}
+
 /*
  * Finds the lowest iomem resource existing within [res->start.res->end).
  * The caller must specify res->start, res->end, res->flags, and optionally
@@ -361,31 +370,24 @@ EXPORT_SYMBOL(release_resource);
 static int find_next_iomem_res(struct resource *res, unsigned long desc,
 			       bool first_level_children_only)
 {
-	resource_size_t start, end;
 	struct resource *p;
-	bool sibling_only = false;
 
 	BUG_ON(!res);
-
-	start = res->start;
-	end = res->end;
-	BUG_ON(start >= end);
-
-	if (first_level_children_only)
-		sibling_only = true;
+	BUG_ON(res->start >= res->end);
 
 	read_lock(&resource_lock);
 
-	for (p = iomem_resource.child; p; p = next_resource(p, sibling_only)) {
+	for (p = iomem_resource.child; p;
+		p = next_resource(p, first_level_children_only)) {
 		if ((p->flags & res->flags) != res->flags)
 			continue;
 		if ((desc != IORES_DESC_NONE) && (desc != p->desc))
 			continue;
-		if (p->start > end) {
+		if (p->start > res->end) {
 			p = NULL;
 			break;
 		}
-		if ((p->end >= start) && (p->start < end))
+		if ((p->end >= res->start) && (p->start < res->end))
 			break;
 	}
 
@@ -393,10 +395,7 @@ static int find_next_iomem_res(struct resource *res, unsigned long desc,
 	if (!p)
 		return -1;
 	/* copy data */
-	if (res->start < p->start)
-		res->start = p->start;
-	if (res->end > p->end)
-		res->end = p->end;
+	resource_clip(res, p->start, p->end);
 	res->flags = p->flags;
 	res->desc = p->desc;
 	return 0;
@@ -600,15 +599,6 @@ static resource_size_t simple_align_resource(void *data,
 	return avail->start;
 }
 
-static void resource_clip(struct resource *res, resource_size_t min,
-			  resource_size_t max)
-{
-	if (res->start < min)
-		res->start = min;
-	if (res->end > max)
-		res->end = max;
-}
-
 /*
  * Find empty slot in the resource tree with the given range and
  * alignment constraints
-- 
2.15.1
