Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeCVT6b (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 15:58:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36356 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbeCVT61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 15:58:27 -0400
From: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>,
        Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH 0/4] Add free() function
Date: Thu, 22 Mar 2018 12:58:15 -0700
Message-Id: <20180322195819.24271-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Today, kfree_rcu() can only free objects allocated using kmalloc().
There have been attempts to extend that to kvfree(), but I think we
should take it even further and allow freeing as many different objects
as possible.

It turns out many different kinds of memory allocations can be detected
from the address.  vmalloc() and percpu_alloc() can be detected by being
in a particular range.  kmalloc() and kmem_cache_alloc() can be detected
from the struct page.  __get_free_pages() and page_frag_alloc() are both
freeable just by decrementing the refcount on the page.

This allows us to delete many dozens of tiny rcu callbacks throughout
the kernel, much as was done when kfree_rcu was added.

Matthew Wilcox (4):
  decompression: Rename malloc and free
  Rename 'free' functions
  mm: Add free()
  rcu: Switch to using free() instead of kfree()

 crypto/lrw.c                  |  4 ++--
 crypto/xts.c                  |  4 ++--
 include/linux/decompress/mm.h | 10 ++++++----
 include/linux/kernel.h        |  2 ++
 include/linux/rcupdate.h      | 40 +++++++++++++++++++---------------------
 include/linux/rcutiny.h       |  2 +-
 include/linux/rcutree.h       |  2 +-
 include/trace/events/rcu.h    |  8 ++++----
 kernel/rcu/rcu.h              |  8 +++-----
 kernel/rcu/tree.c             | 11 +++++------
 mm/util.c                     | 39 +++++++++++++++++++++++++++++++++++++++
 11 files changed, 84 insertions(+), 46 deletions(-)

-- 
2.16.2
