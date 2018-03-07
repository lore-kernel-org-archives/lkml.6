Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754397AbeCGNos (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 08:44:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59042 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbeCGNor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 08:44:47 -0500
From: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] Mark vmalloc and page-table pages
Date: Wed,  7 Mar 2018 05:44:39 -0800
Message-Id: <20180307134443.32646-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

This patch set changes how we use the _mapcount field in struct page
so that we can store an extra 20+ bits of information about why the
page was allocated.  We expose that information to userspace through
/proc/kpageflags to help diagnose memory usage.  It can also help
debugging if we know what a page was most recently allocated for.

Changes since v4:
 - Added Kirill's acks
 - Fixed spelling (Kirill)
 - Allow a few extra bits to be used in page_type.

Matthew Wilcox (4):
  s390: Use _refcount for pgtables
  mm: Split page_type out from _mapcount
  mm: Mark pages allocated through vmalloc
  mm: Mark pages in use for page tables

 arch/s390/mm/pgalloc.c                 | 21 +++++++------
 arch/tile/mm/pgtable.c                 |  3 ++
 fs/proc/page.c                         |  4 +++
 include/linux/mm.h                     |  2 ++
 include/linux/mm_types.h               | 13 +++++---
 include/linux/page-flags.h             | 57 ++++++++++++++++++++++------------
 include/uapi/linux/kernel-page-flags.h |  3 +-
 kernel/crash_core.c                    |  1 +
 mm/page_alloc.c                        | 13 +++-----
 mm/vmalloc.c                           |  2 ++
 scripts/tags.sh                        |  6 ++--
 tools/vm/page-types.c                  |  2 ++
 12 files changed, 82 insertions(+), 45 deletions(-)

-- 
2.16.1
