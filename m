Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2E8C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18168208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18168208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933667AbeFTWJe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 18:09:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:19370 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933249AbeFTWJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 18:09:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 15:09:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,249,1526367600"; 
   d="scan'208";a="66312710"
Received: from linksys13920.jf.intel.com (HELO rpedgeco-HP-Z240-Tower-Workstation.jf.intel.com) ([10.7.197.56])
  by orsmga001.jf.intel.com with ESMTP; 20 Jun 2018 15:09:31 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com
Cc:     kristen.c.accardi@intel.com, dave.hansen@intel.com,
        arjan.van.de.ven@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH 1/3] vmalloc: Add __vmalloc_node_try_addr function
Date:   Wed, 20 Jun 2018 15:09:28 -0700
Message-Id: <1529532570-21765-2-git-send-email-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529532570-21765-1-git-send-email-rick.p.edgecombe@intel.com>
References: <1529532570-21765-1-git-send-email-rick.p.edgecombe@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create __vmalloc_node_try_addr function that tries to allocate at a specific
address.  The implementation relies on __vmalloc_node_range for the bulk of the
work.  To keep this function from spamming the logs when an allocation failure
is fails, __vmalloc_node_range is changed to only warn when __GFP_NOWARN is not
set.  This behavior is consistent with this flags interpretation in
alloc_vmap_area.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 include/linux/vmalloc.h |  3 +++
 mm/vmalloc.c            | 41 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 398e9c9..6eaa896 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -82,6 +82,9 @@ extern void *__vmalloc_node_range(unsigned long size, unsigned long align,
 			unsigned long start, unsigned long end, gfp_t gfp_mask,
 			pgprot_t prot, unsigned long vm_flags, int node,
 			const void *caller);
+extern void *__vmalloc_node_try_addr(unsigned long addr, unsigned long size,
+			gfp_t gfp_mask,	pgprot_t prot, unsigned long vm_flags,
+			int node, const void *caller);
 #ifndef CONFIG_MMU
 extern void *__vmalloc_node_flags(unsigned long size, int node, gfp_t flags);
 static inline void *__vmalloc_node_flags_caller(unsigned long size, int node,
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index cfea25b..9e0820c9 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1710,6 +1710,42 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 }
 
 /**
+ *	__vmalloc_try_addr  -  try to alloc at a specific address
+ *	@addr:		address to try
+ *	@size:		size to try
+ *	@gfp_mask:	flags for the page level allocator
+ *	@prot:		protection mask for the allocated pages
+ *	@vm_flags:	additional vm area flags (e.g. %VM_NO_GUARD)
+ *	@node:		node to use for allocation or NUMA_NO_NODE
+ *	@caller:	caller's return address
+ *
+ *	Try to allocate at the specific address. If it succeeds the address is
+ *	returned. If it fails NULL is returned.  It may trigger TLB flushes.
+ */
+void *__vmalloc_node_try_addr(unsigned long addr, unsigned long size,
+			gfp_t gfp_mask,	pgprot_t prot, unsigned long vm_flags,
+			int node, const void *caller)
+{
+	unsigned long addr_end;
+	unsigned long vsize = PAGE_ALIGN(size);
+
+	if (!vsize || (vsize >> PAGE_SHIFT) > totalram_pages)
+		return NULL;
+
+	if (!(vm_flags & VM_NO_GUARD))
+		vsize += PAGE_SIZE;
+
+	addr_end = addr + vsize;
+
+	if (addr > addr_end)
+		return NULL;
+
+	return __vmalloc_node_range(size, 1, addr, addr_end,
+				gfp_mask | __GFP_NOWARN, prot, vm_flags, node,
+				caller);
+}
+
+/**
  *	__vmalloc_node_range  -  allocate virtually contiguous memory
  *	@size:		allocation size
  *	@align:		desired alignment
@@ -1759,8 +1795,9 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 	return addr;
 
 fail:
-	warn_alloc(gfp_mask, NULL,
-			  "vmalloc: allocation failure: %lu bytes", real_size);
+	if (!(gfp_mask & __GFP_NOWARN))
+		warn_alloc(gfp_mask, NULL,
+			"vmalloc: allocation failure: %lu bytes", real_size);
 	return NULL;
 }
 
-- 
2.7.4

