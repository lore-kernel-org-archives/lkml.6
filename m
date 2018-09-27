Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F29AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6CF21712
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRtYMZq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6CF21712
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeI0Ukm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:40:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727263AbeI0Ukl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:40:41 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80D312170B;
        Thu, 27 Sep 2018 14:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538058130;
        bh=Ys0f332m0S8tcH8XjlQ3vnXEb15BxBNOfpTDMlO1ZJQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oRtYMZq5e0CHq0zCp/WHPzrlI2aRmb8HdCMDf7TxBPQ/2aLQlGmW3EFVaQybVmRo+
         cE4hMPkhD996wZh2vDUqduOAayX4Bqd7w/B93a+hKDmHc2cZAN0/O/H09C1v5GgAsI
         uCrKzQiPCRd2XFq88cFKYcGC75LsPGjMWZ54+7o0=
Subject: [PATCH 3/3] resource: Fix find_next_iomem_res() iteration issue
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Lianbo Jiang <lijiang@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        baiyaowei@cmss.chinamobile.com, tiwai@suse.de, bp@suse.de,
        brijesh.singh@amd.com, dyoung@redhat.com, bhe@redhat.com
Date:   Thu, 27 Sep 2018 09:22:09 -0500
Message-ID: <153805812916.1157.177580438135143788.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <153805773703.1157.14773321497580233478.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <153805773703.1157.14773321497580233478.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Previously find_next_iomem_res() used "*res" as both an input parameter for
the range to search and the type of resource to search for, and an output
parameter for the resource we found, which makes the interface confusing.

The current callers use find_next_iomem_res() incorrectly because they
allocate a single struct resource and use it for repeated calls to
find_next_iomem_res().  When find_next_iomem_res() returns a resource, it
overwrites the start, end, flags, and desc members of the struct.  If we
call find_next_iomem_res() again, we must update or restore these fields.
The previous code restored res.start and res.end, but not res.flags or
res.desc.

Since the callers did not restore res.flags, if they searched for flags
IORESOURCE_MEM | IORESOURCE_BUSY and found a resource with flags
IORESOURCE_MEM | IORESOURCE_BUSY | IORESOURCE_SYSRAM, the next search would
incorrectly skip resources unless they were also marked as
IORESOURCE_SYSRAM.

Fix this by restructuring the interface so it takes explicit "start, end,
flags" parameters and uses "*res" only as an output parameter.

Original-patch: http://lore.kernel.org/lkml/20180921073211.20097-2-lijiang@redhat.com
Based-on-patch-by: Lianbo Jiang <lijiang@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 kernel/resource.c |   94 +++++++++++++++++++++++------------------------------
 1 file changed, 41 insertions(+), 53 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 155ec873ea4d..9891ea90cc8f 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -319,23 +319,26 @@ int release_resource(struct resource *old)
 EXPORT_SYMBOL(release_resource);
 
 /*
- * Finds the lowest iomem resource existing within [res->start..res->end].
- * The caller must specify res->start, res->end, res->flags, and optionally
- * desc.  If found, returns 0, res is overwritten, if not found, returns -1.
- * This function walks the whole tree and not just first level children until
- * and unless first_level_children_only is true.
+ * Finds the lowest iomem resource that covers part of [start..end].  The
+ * caller must specify start, end, flags, and desc (which may be
+ * IORES_DESC_NONE).
+ *
+ * If a resource is found, returns 0 and *res is overwritten with the part
+ * of the resource that's within [start..end]; if none is found, returns
+ * -1.
+ *
+ * This function walks the whole tree and not just first level children
+ * unless first_level_children_only is true.
  */
-static int find_next_iomem_res(struct resource *res, unsigned long desc,
-			       bool first_level_children_only)
+static int find_next_iomem_res(resource_size_t start, resource_size_t end,
+			       unsigned long flags, unsigned long desc,
+			       bool first_level_children_only,
+			       struct resource *res)
 {
-	resource_size_t start, end;
 	struct resource *p;
 	bool sibling_only = false;
 
 	BUG_ON(!res);
-
-	start = res->start;
-	end = res->end;
 	BUG_ON(start >= end);
 
 	if (first_level_children_only)
@@ -344,7 +347,7 @@ static int find_next_iomem_res(struct resource *res, unsigned long desc,
 	read_lock(&resource_lock);
 
 	for (p = iomem_resource.child; p; p = next_resource(p, sibling_only)) {
-		if ((p->flags & res->flags) != res->flags)
+		if ((p->flags & flags) != flags)
 			continue;
 		if ((desc != IORES_DESC_NONE) && (desc != p->desc))
 			continue;
@@ -359,32 +362,31 @@ static int find_next_iomem_res(struct resource *res, unsigned long desc,
 	read_unlock(&resource_lock);
 	if (!p)
 		return -1;
+
 	/* copy data */
-	if (res->start < p->start)
-		res->start = p->start;
-	if (res->end > p->end)
-		res->end = p->end;
+	res->start = max(start, p->start);
+	res->end = min(end, p->end);
 	res->flags = p->flags;
 	res->desc = p->desc;
 	return 0;
 }
 
-static int __walk_iomem_res_desc(struct resource *res, unsigned long desc,
-				 bool first_level_children_only,
-				 void *arg,
+static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
+				 unsigned long flags, unsigned long desc,
+				 bool first_level_children_only, void *arg,
 				 int (*func)(struct resource *, void *))
 {
-	u64 orig_end = res->end;
+	struct resource res;
 	int ret = -1;
 
-	while ((res->start < res->end) &&
-	       !find_next_iomem_res(res, desc, first_level_children_only)) {
-		ret = (*func)(res, arg);
+	while (start < end &&
+	       !find_next_iomem_res(start, end, flags, desc,
+				    first_level_children_only, &res)) {
+		ret = (*func)(&res, arg);
 		if (ret)
 			break;
 
-		res->start = res->end + 1;
-		res->end = orig_end;
+		start = res.end + 1;
 	}
 
 	return ret;
@@ -407,13 +409,7 @@ static int __walk_iomem_res_desc(struct resource *res, unsigned long desc,
 int walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start,
 		u64 end, void *arg, int (*func)(struct resource *, void *))
 {
-	struct resource res;
-
-	res.start = start;
-	res.end = end;
-	res.flags = flags;
-
-	return __walk_iomem_res_desc(&res, desc, false, arg, func);
+	return __walk_iomem_res_desc(start, end, flags, desc, false, arg, func);
 }
 EXPORT_SYMBOL_GPL(walk_iomem_res_desc);
 
@@ -427,13 +423,9 @@ EXPORT_SYMBOL_GPL(walk_iomem_res_desc);
 int walk_system_ram_res(u64 start, u64 end, void *arg,
 				int (*func)(struct resource *, void *))
 {
-	struct resource res;
-
-	res.start = start;
-	res.end = end;
-	res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+	unsigned long flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
 
-	return __walk_iomem_res_desc(&res, IORES_DESC_NONE, true,
+	return __walk_iomem_res_desc(start, end, flags, IORES_DESC_NONE, true,
 				     arg, func);
 }
 
@@ -444,13 +436,9 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
 int walk_mem_res(u64 start, u64 end, void *arg,
 		 int (*func)(struct resource *, void *))
 {
-	struct resource res;
-
-	res.start = start;
-	res.end = end;
-	res.flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+	unsigned long flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 
-	return __walk_iomem_res_desc(&res, IORES_DESC_NONE, true,
+	return __walk_iomem_res_desc(start, end, flags, IORES_DESC_NONE, true,
 				     arg, func);
 }
 
@@ -464,25 +452,25 @@ int walk_mem_res(u64 start, u64 end, void *arg,
 int walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
 		void *arg, int (*func)(unsigned long, unsigned long, void *))
 {
+	resource_size_t start, end;
+	unsigned long flags;
 	struct resource res;
 	unsigned long pfn, end_pfn;
-	u64 orig_end;
 	int ret = -1;
 
-	res.start = (u64) start_pfn << PAGE_SHIFT;
-	res.end = ((u64)(start_pfn + nr_pages) << PAGE_SHIFT) - 1;
-	res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
-	orig_end = res.end;
-	while ((res.start < res.end) &&
-		(find_next_iomem_res(&res, IORES_DESC_NONE, true) >= 0)) {
+	start = (u64) start_pfn << PAGE_SHIFT;
+	end = ((u64)(start_pfn + nr_pages) << PAGE_SHIFT) - 1;
+	flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+	while (start < end &&
+	       !find_next_iomem_res(start, end, flags, IORES_DESC_NONE,
+				    true, &res)) {
 		pfn = (res.start + PAGE_SIZE - 1) >> PAGE_SHIFT;
 		end_pfn = (res.end + 1) >> PAGE_SHIFT;
 		if (end_pfn > pfn)
 			ret = (*func)(pfn, end_pfn - pfn, arg);
 		if (ret)
 			break;
-		res.start = res.end + 1;
-		res.end = orig_end;
+		start = res.end + 1;
 	}
 	return ret;
 }

