Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CFBECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212E5208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212E5208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbeGQMU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:20:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34720 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbeGQMU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:20:28 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BAFABC19;
        Tue, 17 Jul 2018 11:48:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Tatashin <pasha.tatashin@oracle.com>,
        Matt Hart <matt@mattface.org>, Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.17 1/1] mm: dont do zero_resv_unavail if memmap is not allocated
Date:   Tue, 17 Jul 2018 13:48:00 +0200
Message-Id: <20180717114728.563227867@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180717114728.444937016@linuxfoundation.org>
References: <20180717114728.444937016@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Tatashin <pasha.tatashin@oracle.com>

commit d1b47a7c9efcf3c3384b70f6e3c8f1423b44d8c7 upstream.

Moving zero_resv_unavail before memmap_init_zone(), caused a regression on
x86-32.

The cause is that we access struct pages before they are allocated when
CONFIG_FLAT_NODE_MEM_MAP is used.

free_area_init_nodes()
  zero_resv_unavail()
    mm_zero_struct_page(pfn_to_page(pfn)); <- struct page is not alloced
  free_area_init_node()
    if CONFIG_FLAT_NODE_MEM_MAP
      alloc_node_mem_map()
        memblock_virt_alloc_node_nopanic() <- struct page alloced here

On the other hand memblock_virt_alloc_node_nopanic() zeroes all the memory
that it returns, so we do not need to do zero_resv_unavail() here.

Fixes: e181ae0c5db9 ("mm: zero unavailable pages before memmap init")
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Tested-by: Matt Hart <matt@mattface.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/mm.h |    2 +-
 mm/page_alloc.c    |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2081,7 +2081,7 @@ extern int __meminit __early_pfn_to_nid(
 					struct mminit_pfnnid_cache *state);
 #endif
 
-#ifdef CONFIG_HAVE_MEMBLOCK
+#if defined(CONFIG_HAVE_MEMBLOCK) && !defined(CONFIG_FLAT_NODE_MEM_MAP)
 void zero_resv_unavail(void);
 #else
 static inline void zero_resv_unavail(void) {}
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6377,7 +6377,7 @@ void __paginginit free_area_init_node(in
 	free_area_init_core(pgdat);
 }
 
-#ifdef CONFIG_HAVE_MEMBLOCK
+#if defined(CONFIG_HAVE_MEMBLOCK) && !defined(CONFIG_FLAT_NODE_MEM_MAP)
 /*
  * Only struct pages that are backed by physical memory are zeroed and
  * initialized by going through __init_single_page(). But, there are some
@@ -6415,7 +6415,7 @@ void __paginginit zero_resv_unavail(void
 	if (pgcnt)
 		pr_info("Reserved but unavailable: %lld pages", pgcnt);
 }
-#endif /* CONFIG_HAVE_MEMBLOCK */
+#endif /* CONFIG_HAVE_MEMBLOCK && !CONFIG_FLAT_NODE_MEM_MAP */
 
 #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
 


