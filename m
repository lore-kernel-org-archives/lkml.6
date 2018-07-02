Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B2DC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FBDB22B69
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSdPzP3b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FBDB22B69
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932652AbeGBA7X (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 20:59:23 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34917 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932221AbeGBA5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 20:57:39 -0400
Received: by mail-oi0-f67.google.com with SMTP id i12-v6so8934847oik.2;
        Sun, 01 Jul 2018 17:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HhAI7TUKIO2hMbI+QxZbnwxaMd8iJDubr9ysaPy3gts=;
        b=FSdPzP3b4zyl0MoJzhrKQDe0Uyo3SWPEII5s4mx81SFxdpwfjw9FN3lF3+GKY63ZKK
         ru0St8YCkjsuPOA40xebBZfVNW13yjNzOG9hPIFZHEqxPDOTOL4hhZNkHAYPDeA5bxma
         xhiJaZkKleVA9owbIm1sIta+2S8eUajOd/lBF6YwmuvcpbNL9m9Urbps9I5utsM20dKh
         Ar/4yybqZR+1n33By6VmJkDVtuX+MKDEsbsxqNhulgoZ1H9fCDy/SP+cG6yZKk2ZX0Sj
         MeBvLS6F0mNqHAjPvz1LC2Dk6Rvu5pHzOXcO/m9jWU4CvjlAGy1gt2qC/g+bqtisKUb5
         l0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HhAI7TUKIO2hMbI+QxZbnwxaMd8iJDubr9ysaPy3gts=;
        b=BnwS+uFwydcH0EbNp+BC/w/UEIBJaA8UtI0rmHij+qIW7pFrLlfAsuDTsI14u+XJOJ
         0/HjOdTAqfK9z3etgwvk33+icr+AYgEha4Kq2dNQCF9o+YI+MMsWpCmPylT4RF6NfZsG
         IRMIdKFtZTAokErN5X0gNRFQmPRA/oL1+9o7cRyRScUOBZJD6XURJgTUnVHRiD55mjxD
         GAfCcuufmXrZl1jKv/3UG4UueIQOYny/qbuXB7fpIK28G2jQHMVsu5VKmWpMAK/nBwC7
         TipMwk/+ihHUCdFgt1ZQd3MkkoGTWz/+QpPpHO31NAwtc5EMrkyyh/3WuVvYkoBv5M6x
         Oa/A==
X-Gm-Message-State: APt69E0QWvIshNQWiBva66k+G1axL37S8qDN3EFIzwhPiUDCPDWfkukh
        WWo6suXVy/5zaLWJG/fAsmU=
X-Google-Smtp-Source: AAOMgpeOHdZ8c5huIMbyyi2b0wJScRjvHaEa0FN1K+jHrdo8oBCwYrOAqMMOPOsGHvpYLkt/EDmm0Q==
X-Received: by 2002:aca:5d86:: with SMTP id r128-v6mr140774oib.243.1530493058580;
        Sun, 01 Jul 2018 17:57:38 -0700 (PDT)
Received: from sandstorm.nvidia.com ([2600:1700:43b0:3120:feaa:14ff:fe9e:34cb])
        by smtp.gmail.com with ESMTPSA id v6-v6sm4111672oix.30.2018.07.01.17.57.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jul 2018 17:57:37 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 2/6] mm: introduce page->dma_pinned_flags, _count
Date:   Sun,  1 Jul 2018 17:56:50 -0700
Message-Id: <20180702005654.20369-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180702005654.20369-1-jhubbard@nvidia.com>
References: <20180702005654.20369-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Add two struct page fields that, combined, are unioned with
struct page->lru. There is no change in the size of
struct page. These new fields are for type safety and clarity.

Also add page flag accessors to test, set and clear the new
page->dma_pinned_flags field.

The page->dma_pinned_count field will be used in upcoming
patches

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm_types.h   | 22 ++++++++++++-----
 include/linux/page-flags.h | 50 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 99ce070e7dcb..0ecd29dcd642 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -78,12 +78,22 @@ struct page {
 	 */
 	union {
 		struct {	/* Page cache and anonymous pages */
-			/**
-			 * @lru: Pageout list, eg. active_list protected by
-			 * zone_lru_lock.  Sometimes used as a generic list
-			 * by the page owner.
-			 */
-			struct list_head lru;
+			union {
+				/**
+				 * @lru: Pageout list, eg. active_list protected
+				 * by zone_lru_lock.  Sometimes used as a
+				 * generic list by the page owner.
+				 */
+				struct list_head lru;
+				/* Used by get_user_pages*(). Pages may not be
+				 * on an LRU while these dma_pinned_* fields
+				 * are in use.
+				 */
+				struct {
+					unsigned long dma_pinned_flags;
+					atomic_t      dma_pinned_count;
+				};
+			};
 			/* See page-flags.h for PAGE_MAPPING_FLAGS */
 			struct address_space *mapping;
 			pgoff_t index;		/* Our offset within mapping. */
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 901943e4754b..b694a1a3bdf3 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -420,6 +420,56 @@ static __always_inline int __PageMovable(struct page *page)
 				PAGE_MAPPING_MOVABLE;
 }
 
+/*
+ * page->dma_pinned_flags is protected by the zone_gup_lock, plus the
+ * page->dma_pinned_count field as well.
+ *
+ * Because page->dma_pinned_flags is unioned with page->lru, any page that
+ * uses these flags must NOT be on an LRU. That's partly enforced by
+ * ClearPageDmaPinned, which gives the page back to LRU.
+ *
+ * Because PageDmaPinned also corresponds to PageTail (the lowest bit in
+ * the first union of struct page), and this flag is checked without knowing
+ * whether it is a tail page or a PageDmaPinned page, start the flags at
+ * bit 1 (0x2), rather than bit 0.
+ */
+#define PAGE_DMA_PINNED		0x2
+#define PAGE_DMA_PINNED_FLAGS	(PAGE_DMA_PINNED)
+
+/*
+ * Because these flags are read outside of a lock, ensure visibility between
+ * different threads, by using READ|WRITE_ONCE.
+ */
+static __always_inline int PageDmaPinnedFlags(struct page *page)
+{
+	VM_BUG_ON(page != compound_head(page));
+	return (READ_ONCE(page->dma_pinned_flags) & PAGE_DMA_PINNED_FLAGS) != 0;
+}
+
+static __always_inline int PageDmaPinned(struct page *page)
+{
+	VM_BUG_ON(page != compound_head(page));
+	return (READ_ONCE(page->dma_pinned_flags) & PAGE_DMA_PINNED) != 0;
+}
+
+static __always_inline void SetPageDmaPinned(struct page *page)
+{
+	VM_BUG_ON(page != compound_head(page));
+	WRITE_ONCE(page->dma_pinned_flags, PAGE_DMA_PINNED);
+}
+
+static __always_inline void ClearPageDmaPinned(struct page *page)
+{
+	VM_BUG_ON(page != compound_head(page));
+	VM_BUG_ON_PAGE(!PageDmaPinnedFlags(page), page);
+
+	/* This does a WRITE_ONCE to the lru.next, which is also the
+	 * page->dma_pinned_flags field. So in addition to restoring page->lru,
+	 * this provides visibility to other threads.
+	 */
+	INIT_LIST_HEAD(&page->lru);
+}
+
 #ifdef CONFIG_KSM
 /*
  * A KSM page is one of those write-protected "shared pages" or "merged pages"
-- 
2.18.0

