Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54A1C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E5D20645
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E5D20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeK1Ldr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 06:33:47 -0500
Received: from mga18.intel.com ([134.134.136.126]:49268 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbeK1Ldr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 06:33:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 16:34:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,288,1539673200"; 
   d="scan'208";a="91641478"
Received: from rpedgeco-desk5.jf.intel.com ([10.54.75.128])
  by fmsmga007.fm.intel.com with ESMTP; 27 Nov 2018 16:34:06 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     akpm@linux-foundation.org, luto@kernel.org, will.deacon@arm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com,
        naveen.n.rao@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        jeyu@kernel.org, netdev@vger.kernel.org, ard.biesheuvel@linaro.org,
        jannh@google.com
Cc:     kristen@linux.intel.com, dave.hansen@intel.com,
        deneen.t.dock@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH 1/2] vmalloc: New flag for flush before releasing pages
Date:   Tue, 27 Nov 2018 16:07:53 -0800
Message-Id: <20181128000754.18056-2-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
References: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since vfree will lazily flush the TLB, but not lazily free the underlying pages,
it often leaves stale TLB entries to freed pages that could get re-used. This is
undesirable for cases where the memory being freed has special permissions such
as executable.

Having callers flush the TLB after calling vfree still leaves a window where
the pages are freed, but the TLB entry remains. Also the entire operation can be
deferred if the vfree is called from an interrupt and so a TLB flush after
calling vfree would miss the entire operation. So in order to support this use
case, a new flag VM_IMMEDIATE_UNMAP is added, that will cause the free operation
to take place like this:
        1. Unmap
        2. Flush TLB/Unmap aliases
        3. Free pages
In the deferred case these steps are all done by the work queue.

This implementation derives from two sketches from Dave Hansen and
Andy Lutomirski.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Suggested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 include/linux/vmalloc.h |  1 +
 mm/vmalloc.c            | 13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 398e9c95cd61..cca6b6b83cf0 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -21,6 +21,7 @@ struct notifier_block;		/* in notifier.h */
 #define VM_UNINITIALIZED	0x00000020	/* vm_struct is not fully initialized */
 #define VM_NO_GUARD		0x00000040      /* don't add guard page */
 #define VM_KASAN		0x00000080      /* has allocated kasan shadow memory */
+#define VM_IMMEDIATE_UNMAP	0x00000200	/* flush before releasing pages */
 /* bits [20..32] reserved for arch specific ioremap internals */
 
 /*
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 97d4b25d0373..68766651b5a7 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1516,6 +1516,14 @@ static void __vunmap(const void *addr, int deallocate_pages)
 	debug_check_no_obj_freed(area->addr, get_vm_area_size(area));
 
 	remove_vm_area(addr);
+
+	/*
+	 * Need to flush the TLB before freeing pages in the case of this flag.
+	 * As long as that's happening, unmap aliases.
+	 */
+	if (area->flags & VM_IMMEDIATE_UNMAP)
+		vm_unmap_aliases();
+
 	if (deallocate_pages) {
 		int i;
 
@@ -1925,8 +1933,9 @@ EXPORT_SYMBOL(vzalloc_node);
 
 void *vmalloc_exec(unsigned long size)
 {
-	return __vmalloc_node(size, 1, GFP_KERNEL, PAGE_KERNEL_EXEC,
-			      NUMA_NO_NODE, __builtin_return_address(0));
+	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
+			GFP_KERNEL, PAGE_KERNEL_EXEC, VM_IMMEDIATE_UNMAP,
+			NUMA_NO_NODE, __builtin_return_address(0));
 }
 
 #if defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA32)
-- 
2.17.1

