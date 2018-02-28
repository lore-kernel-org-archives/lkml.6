Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935487AbeB1WcL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 17:32:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44376 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935151AbeB1WcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 17:32:08 -0500
From: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] Split page_type out from mapcount
Date: Wed, 28 Feb 2018 14:31:53 -0800
Message-Id: <20180228223157.9281-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

I want to use the _mapcount field to record what a page is in use as.
This can help with debugging and we can also expose that information to
userspace through /proc/kpageflags to help diagnose memory usage (not
included as part of this patch set).

First, we need s390 to stop using _mapcount for its own purposes;
Martin, I hope you have time to look at this patch.  I must confess I
don't quite understand what the different bits are used for in the upper
nybble of the _mapcount, but I tried to replicate what you were doing
faithfully.

Matthew Wilcox (4):
  s390: Use _refcount for pgtables
  mm: Split page_type out from _map_count
  mm: Mark pages allocated through vmalloc
  mm: Mark pages in use for page tables

 arch/s390/mm/pgalloc.c     | 21 +++++++++--------
 fs/proc/page.c             |  2 +-
 include/linux/mm.h         |  2 ++
 include/linux/mm_types.h   | 13 +++++++----
 include/linux/page-flags.h | 57 ++++++++++++++++++++++++++++++----------------
 kernel/crash_core.c        |  1 +
 mm/page_alloc.c            | 13 ++++-------
 mm/vmalloc.c               |  2 ++
 scripts/tags.sh            |  6 ++---
 9 files changed, 72 insertions(+), 45 deletions(-)

-- 
2.16.1
