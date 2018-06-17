Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D487DC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 01:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CBF20863
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 01:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qX3JtNA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85CBF20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933445AbeFQBZs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 21:25:48 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41204 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933336AbeFQBZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 21:25:45 -0400
Received: by mail-oi0-f67.google.com with SMTP id a141-v6so11974630oii.8;
        Sat, 16 Jun 2018 18:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+gtNKPT+bZO7jD+2t1LvKXOtSoC2Pq0EVTmO8wKQx14=;
        b=qX3JtNA08u/tpelsrdmVc5ZrDUhWhxl0Un1YIbXRursimfj6T48N0b6bSmAASiz+Aa
         k4/B3ShBwg7Hoj3IEihfrsP0i0k2muAgUor6mDnn9pVVFYyIXnXLJXc/Chv/Dts/5VKm
         R6gHreRIrRNyAr2Iqnpit6cbe/ZzU7CAyQkZi6jyMyurMqZkZUUekHaU908i9Nj6Szio
         cxVmx/T5KavukTISNtKlIGvbRzP2js6U19StnSPeARn6v0ZJTTPh2iAbB/H5S/aBdtx3
         9dCJRJJgXFJTq4U9d6/2B7VWqawFSYETN8Y32h0R/cKKa+SKYbQRm9E4nkp2A88VESXx
         cgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+gtNKPT+bZO7jD+2t1LvKXOtSoC2Pq0EVTmO8wKQx14=;
        b=hZZOcUMBZ8g+jEBNkIyCmxMdndQe4BIfUhETPPx+/OnpLo9SD2Oq0BWsRUxgENE/Ej
         o20DWLoKG4VcV0G/nP7LqE0owgCCPzfSsGvHnPuCChnS/5Wwqf3jJbbG1nHpivRo8PGw
         4CRuLOqaz4ELH1UDH+VJ90I2tYad/FDpEu3mcfkOYyikWQuQyaUhAx9CQnisTGnKicsT
         A024F81eHxl/GSDFWeaq8d1WoLj1hrQQB6TQmyawlyLcxu+FONP722EkZIEPh5PhjUKd
         fVCRMuwGJG5vwKBAwNLmz025J453iKX5nN3z8S/AqBcZ+98FKVf5MwGkcD7zM0Cq+Azd
         5bYQ==
X-Gm-Message-State: APt69E2VRQyMXMB4uafmDjWK+K7EMEB4b424BiJO7pMVwsS4pbkmMG1+
        1MhRRX+bq1I1LMywfJ5F17A=
X-Google-Smtp-Source: ADUXVKLxMyZrmV2Xj93iQ/zdlpteM8LuyfuGDjvcisEsqDhRUaL92laD5k9VGL/hE876UGXhZa76tw==
X-Received: by 2002:aca:38c3:: with SMTP id f186-v6mr3795139oia.310.1529198744374;
        Sat, 16 Jun 2018 18:25:44 -0700 (PDT)
Received: from sandstorm.nvidia.com ([2600:1700:43b0:3120:feaa:14ff:fe9e:34cb])
        by smtp.gmail.com with ESMTPSA id u13-v6sm4666912oiv.18.2018.06.16.18.25.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Jun 2018 18:25:43 -0700 (PDT)
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
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 2/2] mm: set PG_dma_pinned on get_user_pages*()
Date:   Sat, 16 Jun 2018 18:25:10 -0700
Message-Id: <20180617012510.20139-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180617012510.20139-1-jhubbard@nvidia.com>
References: <20180617012510.20139-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

This fixes a few problems that come up when using devices (NICs, GPUs,
for example) that want to have direct access to a chunk of system (CPU)
memory, so that they can DMA to/from that memory. Problems [1] come up
if that memory is backed by persistence storage; for example, an ext4
file system. I've been working on several customer bugs that are hitting
this, and this patchset fixes those bugs.

The bugs happen via:

1) get_user_pages() on some ext4-backed pages
2) device does DMA for a while to/from those pages

    a) Somewhere in here, some of the pages get disconnected from the
       file system, via try_to_unmap() and eventually drop_buffers()

3) device is all done, device driver calls set_page_dirty_lock(), then
   put_page()

And then at some point, we see a this BUG():

    kernel BUG at /build/linux-fQ94TU/linux-4.4.0/fs/ext4/inode.c:1899!
    backtrace:
        ext4_writepage
        __writepage
        write_cache_pages
        ext4_writepages
        do_writepages
        __writeback_single_inode
        writeback_sb_inodes
        __writeback_inodes_wb
        wb_writeback
        wb_workfn
        process_one_work
        worker_thread
        kthread
        ret_from_fork

...which is due to the file system asserting that there are still buffer
heads attached:

	({							            \
		BUG_ON(!PagePrivate(page));			\
		((struct buffer_head *)page_private(page));	\
	})

How to fix this:
----------------
Introduce a new page flag: PG_dma_pinned, and set this flag on
all pages that are returned by the get_user_pages*() family of
functions. Leave it set nearly forever: until the page is freed.

Then, check this flag before attempting to unmap pages. This will
cause a very early return from try_to_unmap_one(), and will avoid
doing things such as, notably, removing page buffers via drop_buffers().

This uses a new struct page flag, but only on 64-bit systems.

Obviously, this is heavy-handed, but given the long, broken history of
get_user_pages in combination with file-backed memory, and given the
problems with alternative designs, it's a reasonable fix for now: small,
simple, and easy to revert if and when a more comprehensive design solution
is chosen.

Some alternatives, and why they were not taken:

1. It would be better, if possible, to clear PG_dma_pinned, once all
get_user_pages callers returned the page (via something more specific than
put_page), but that would significantly change the usage for get_user_pages
callers. That's too intrusive for such a widely used and old API, so let's
leave it alone.

Also, such a design would require a new counter that would be associated
with each page. There's no room in struct page, so it would require
separate tracking, which is not acceptable for general page management.

2. There are other more complicated approaches[2], but these depend on
trying to solve very specific call paths that, in the end, are just
downstream effects of the root cause. And so these did not actually fix the
customer bugs that I was working on.

References:

[1] https://lwn.net/Articles/753027/ : "The trouble with get_user_pages()"

[2] https://marc.info/?l=linux-mm&m=<20180521143830.GA25109@bombadil.infradead.org>
   (Matthew Wilcox listed two ideas here)

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/page-flags.h     |  9 +++++++++
 include/trace/events/mmflags.h |  9 ++++++++-
 mm/gup.c                       | 11 +++++++++--
 mm/rmap.c                      |  2 ++
 4 files changed, 28 insertions(+), 3 deletions(-)

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/page-flags.h     |  9 +++++++++
 include/trace/events/mmflags.h |  9 ++++++++-
 mm/gup.c                       | 11 +++++++++--
 mm/page_alloc.c                |  1 +
 mm/rmap.c                      |  2 ++
 5 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 901943e4754b..ad65a2af069a 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -100,6 +100,9 @@ enum pageflags {
 #if defined(CONFIG_IDLE_PAGE_TRACKING) && defined(CONFIG_64BIT)
 	PG_young,
 	PG_idle,
+#endif
+#if defined(CONFIG_64BIT)
+	PG_dma_pinned,
 #endif
 	__NR_PAGEFLAGS,
 
@@ -381,6 +384,12 @@ TESTCLEARFLAG(Young, young, PF_ANY)
 PAGEFLAG(Idle, idle, PF_ANY)
 #endif
 
+#if defined(CONFIG_64BIT)
+PAGEFLAG(DmaPinned, dma_pinned, PF_ANY)
+#else
+PAGEFLAG_FALSE(DmaPinned)
+#endif
+
 /*
  * On an anonymous page mapped into a user virtual memory area,
  * page->mapping points to its anon_vma, not to a struct address_space;
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index a81cffb76d89..f62fd150b0d4 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -79,6 +79,12 @@
 #define IF_HAVE_PG_IDLE(flag,string)
 #endif
 
+#if defined(CONFIG_64BIT)
+#define IF_HAVE_PG_DMA_PINNED(flag,string) ,{1UL << flag, string}
+#else
+#define IF_HAVE_PG_DMA_PINNED(flag,string)
+#endif
+
 #define __def_pageflag_names						\
 	{1UL << PG_locked,		"locked"	},		\
 	{1UL << PG_waiters,		"waiters"	},		\
@@ -104,7 +110,8 @@ IF_HAVE_PG_MLOCK(PG_mlocked,		"mlocked"	)		\
 IF_HAVE_PG_UNCACHED(PG_uncached,	"uncached"	)		\
 IF_HAVE_PG_HWPOISON(PG_hwpoison,	"hwpoison"	)		\
 IF_HAVE_PG_IDLE(PG_young,		"young"		)		\
-IF_HAVE_PG_IDLE(PG_idle,		"idle"		)
+IF_HAVE_PG_IDLE(PG_idle,		"idle"		)		\
+IF_HAVE_PG_DMA_PINNED(PG_dma_pinned,	"dma_pinned"	)
 
 #define show_page_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",				\
diff --git a/mm/gup.c b/mm/gup.c
index 73f0b3316fa7..fd6c77f33c16 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -659,7 +659,7 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		unsigned int gup_flags, struct page **pages,
 		struct vm_area_struct **vmas, int *nonblocking)
 {
-	long i = 0;
+	long i = 0, j;
 	int err = 0;
 	unsigned int page_mask;
 	struct vm_area_struct *vma = NULL;
@@ -764,6 +764,10 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 	} while (nr_pages);
 
 out:
+	if (pages)
+		for (j = 0; j < i; j++)
+			SetPageDmaPinned(pages[j]);
+
 	return i ? i : err;
 }
 
@@ -1843,7 +1847,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 			struct page **pages)
 {
 	unsigned long addr, len, end;
-	int nr = 0, ret = 0;
+	int nr = 0, ret = 0, i;
 
 	start &= PAGE_MASK;
 	addr = start;
@@ -1864,6 +1868,9 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 		ret = nr;
 	}
 
+	for (i = 0; i < nr; i++)
+		SetPageDmaPinned(pages[i]);
+
 	if (nr < nr_pages) {
 		/* Try to get the remaining pages with get_user_pages */
 		start += nr << PAGE_SHIFT;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1521100f1e63..a96a7b20037c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1898,6 +1898,7 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 {
 	set_page_private(page, 0);
 	set_page_refcounted(page);
+	ClearPageDmaPinned(page);
 
 	arch_alloc_page(page, order);
 	kernel_map_pages(page, 1 << order, 1);
diff --git a/mm/rmap.c b/mm/rmap.c
index 6db729dc4c50..37576f0a4645 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1360,6 +1360,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 				flags & TTU_SPLIT_FREEZE, page);
 	}
 
+	if (PageDmaPinned(page))
+		return false;
 	/*
 	 * We have to assume the worse case ie pmd for invalidation. Note that
 	 * the page can not be free in this function as call of try_to_unmap()
-- 
2.17.1

