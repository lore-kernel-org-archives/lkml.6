Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11260C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988DE20813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UaOdZvef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988DE20813
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbeJXEdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:33:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50634 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeJXEdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MgSOZbcgVTzvdHpw+M3YVbHWyoCvPtZWFiQFSQF1C7U=; b=UaOdZvefndL2r9Rk8ROPWkxs64
        D76l8VOviquv2atXeSWxFdhUF73mOZIlQkIIEurEIUJimkBnt+szrkS3ZbqNV5KPD1mVAp3V/69xk
        jxncPeNUhiEHM2/ToVgr9y0hu6VR4CUgS9U9lhrm7Vv1ZXkOLyv+T4J4um8BZA7SibQIFaag0U0hT
        MFajZqzhjTYqsey7uxAzafQOjlZYUyDzV1Pkjwr8qMnKljHzPdlfb2O6HDSxENHAyR0s+qzWR+KA5
        sBxZp7pEbj6cT9vp1B/qpSuWRsr5XZzygtK0qWF2GdazjCJWZBoJ6ctQFeZSh+ppZfbvknhTNpdyN
        KA/fEL+w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gF2yX-0007Kb-WE; Tue, 23 Oct 2018 20:08:26 +0000
Date:   Tue, 23 Oct 2018 13:08:25 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] XArray for 4.20
Message-ID: <20181023200825.GA25444@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider pulling the XArray patch set.  The XArray provides an
improved interface to the radix tree data structure, providing locking
as part of the API, specifying GFP flags at allocation time, eliminating
preloading, less re-walking the tree, more efficient iterations and not
exposing RCU-protected pointers to its users.

This patch set

1. Introduces the XArray implementation
2. Converts the pagecache to use it
3. Converts memremap to use it

The page cache is the most complex and important user of the radix tree,
so converting it was most important.  Converting the memremap code
removes the only other user of the multiorder code, which allows us to
remove the radix tree code that supported it.

I have 40+ followup patches to convert many other users of the radix tree
over to the XArray, but I'd like to get this part in first.  The other
conversions haven't been in linux-next and aren't suitable for applying
yet, but you can see them in the xarray-conv branch if you're interested.

In preparing this pull request, I realised I messed up and pushed a
rebase from two days ago to infradead.  There's no substantial change
from the version I pushed out to infradead for linux-next testing on
September 29th (mostly test suite and documentation cleanups).

The following changes since commit 291d0e5d81e101392379217b06251fe8c27f1f80:

  Merge tag 'for-linus-20180929' of git://git.kernel.dk/linux-block (2018-09-29 14:52:14 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/willy/linux-dax.git xarray

for you to fetch changes up to 3a08cd52c37c793ffc199f6fc2ecfc368e284b2d:

  radix tree: Remove multiorder support (2018-10-21 10:46:48 -0400)

----------------------------------------------------------------
Matthew Wilcox (90):
      Update email address
      idr: Permit any valid kernel pointer to be stored
      xarray: Replace exceptional entries
      xarray: Change definition of sibling entries
      xarray: Add definition of struct xarray
      xarray: Define struct xa_node
      xarray: Add documentation
      xarray: Add XArray load operation
      xarray: Add XArray marks
      xarray: Add XArray unconditional store operations
      xarray: Add XArray conditional store operations
      xarray: Add XArray iterators
      xarray: Extract entries from an XArray
      xarray: Destroy an XArray
      xarray: Step through an XArray
      xarray: Add xas_for_each_conflict
      xarray: Add xas_create_range
      xarray: Add xa_reserve and xa_release
      xarray: Add MAINTAINERS entry
      xarray: Track free entries in an XArray
      ida: Convert to XArray
      page cache: Rearrange address_space
      page cache: Convert hole search to XArray
      page cache: Add and replace pages using the XArray
      page cache: Convert page deletion to XArray
      page cache: Convert find_get_entry to XArray
      page cache: Convert find_get_entries to XArray
      page cache: Convert find_get_pages_range to XArray
      page cache: Convert find_get_pages_contig to XArray
      page cache; Convert find_get_pages_range_tag to XArray
      page cache: Convert find_get_entries_tag to XArray
      page cache: Convert filemap_map_pages to XArray
      radix tree test suite: Convert regression1 to XArray
      page cache: Convert delete_batch to XArray
      page cache: Remove stray radix comment
      page cache: Convert filemap_range_has_page to XArray
      mm: Convert page-writeback to XArray
      mm: Convert workingset to XArray
      mm: Convert truncate to XArray
      mm: Convert add_to_swap_cache to XArray
      mm: Convert delete_from_swap_cache to XArray
      mm: Convert __do_page_cache_readahead to XArray
      mm: Convert page migration to XArray
      mm: Convert huge_memory to XArray
      mm: Convert collapse_shmem to XArray
      mm: Convert khugepaged_scan_shmem to XArray
      mm: Convert is_page_cache_freeable to XArray
      pagevec: Use xa_mark_t
      shmem: Convert shmem_radix_tree_replace to XArray
      shmem: Convert shmem_confirm_swap to XArray
      shmem: Convert find_swap_entry to XArray
      shmem: Convert shmem_add_to_page_cache to XArray
      shmem: Convert shmem_alloc_hugepage to XArray
      shmem: Convert shmem_free_swap to XArray
      shmem: Convert shmem_partial_swap_usage to XArray
      memfd: Convert memfd_wait_for_pins to XArray
      memfd: Convert memfd_tag_pins to XArray
      shmem: Comment fixups
      btrfs: Convert page cache to XArray
      fs: Convert buffer to XArray
      fs: Convert writeback to XArray
      nilfs2: Convert to XArray
      f2fs: Convert to XArray
      dax: Rename some functions
      dax: Hash on XArray instead of mapping
      dax: Convert dax_insert_pfn_mkwrite to XArray
      dax: Convert dax_layout_busy_page to XArray
      dax: Convert __dax_invalidate_entry to XArray
      dax: Convert dax writeback to XArray
      dax: Convert dax_lock_mapping_entry to XArray
      dax: Convert page fault handlers to XArray
      page cache: Finish XArray conversion
      radix tree: Remove radix_tree_update_node_t
      radix tree: Remove split/join code
      radix tree: Remove radix_tree_maybe_preload_order
      radix tree: Remove radix_tree_clear_tags
      radix tree test suite: Convert tag_tagged_items to XArray
      radix tree test suite: Convert iteration test to XArray
      xarray: Move multiorder account test in-kernel
      xarray: Move multiorder_shrink to kernel tests
      xarray: Move multiorder_check to in-kernel tests
      xarray: Add range store functionality
      memremap: Convert to XArray
      radix tree test suite: Remove __item_insert
      radix tree test suite: Remove multiorder benchmarking
      radix tree tests: Move item_insert_order
      radix tree tests: Convert item_kill_tree to XArray
      radix tree tests: Convert item_delete_rcu to XArray
      radix tree test: Convert multiorder tests to XArray
      radix tree: Remove multiorder support

 .clang-format                                 |    1 -
 .mailmap                                      |    7 +
 Documentation/core-api/index.rst              |    1 +
 Documentation/core-api/xarray.rst             |  435 ++++++
 MAINTAINERS                                   |   17 +-
 arch/parisc/kernel/syscall.S                  |    2 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h  |    4 +-
 arch/powerpc/include/asm/nohash/64/pgtable.h  |    4 +-
 drivers/gpu/drm/i915/i915_gem.c               |   17 +-
 drivers/input/keyboard/hilkbd.c               |    2 +-
 drivers/pci/hotplug/acpiphp.h                 |    2 +-
 drivers/pci/hotplug/acpiphp_core.c            |    4 +-
 drivers/pci/hotplug/acpiphp_glue.c            |    2 +-
 drivers/staging/erofs/utils.c                 |   18 +-
 fs/btrfs/compression.c                        |    6 +-
 fs/btrfs/extent_io.c                          |   12 +-
 fs/buffer.c                                   |   14 +-
 fs/dax.c                                      |  907 +++++------
 fs/ext4/inode.c                               |    2 +-
 fs/f2fs/data.c                                |    6 +-
 fs/f2fs/dir.c                                 |    2 +-
 fs/f2fs/f2fs.h                                |    2 +-
 fs/f2fs/inline.c                              |    2 +-
 fs/f2fs/node.c                                |    6 +-
 fs/fs-writeback.c                             |   25 +-
 fs/gfs2/aops.c                                |    2 +-
 fs/inode.c                                    |    2 +-
 fs/isofs/dir.c                                |    2 +-
 fs/nfs/blocklayout/blocklayout.c              |    2 +-
 fs/nilfs2/btnode.c                            |   26 +-
 fs/nilfs2/page.c                              |   29 +-
 fs/proc/task_mmu.c                            |    2 +-
 include/linux/fs.h                            |   63 +-
 include/linux/idr.h                           |   18 +-
 include/linux/pagemap.h                       |   10 +-
 include/linux/pagevec.h                       |    8 +-
 include/linux/radix-tree.h                    |  178 +--
 include/linux/swap.h                          |   22 +-
 include/linux/swapops.h                       |   19 +-
 include/linux/xarray.h                        | 1293 +++++++++++++++-
 kernel/memremap.c                             |   76 +-
 lib/Kconfig                                   |    5 +-
 lib/Kconfig.debug                             |    3 +
 lib/Makefile                                  |    3 +-
 lib/idr.c                                     |  401 ++---
 lib/radix-tree.c                              |  834 ++--------
 lib/test_xarray.c                             | 1238 +++++++++++++++
 lib/xarray.c                                  | 2036 +++++++++++++++++++++++++
 mm/Kconfig                                    |    4 +-
 mm/filemap.c                                  |  724 ++++-----
 mm/huge_memory.c                              |   17 +-
 mm/khugepaged.c                               |  178 +--
 mm/madvise.c                                  |    2 +-
 mm/memcontrol.c                               |    2 +-
 mm/memfd.c                                    |  105 +-
 mm/migrate.c                                  |   48 +-
 mm/mincore.c                                  |    2 +-
 mm/page-writeback.c                           |   72 +-
 mm/readahead.c                                |   10 +-
 mm/shmem.c                                    |  193 +--
 mm/swap.c                                     |    6 +-
 mm/swap_state.c                               |  119 +-
 mm/truncate.c                                 |   27 +-
 mm/vmscan.c                                   |   10 +-
 mm/workingset.c                               |   70 +-
 tools/include/asm-generic/bitops.h            |    1 +
 tools/include/asm-generic/bitops/atomic.h     |    9 -
 tools/include/asm-generic/bitops/non-atomic.h |  109 ++
 tools/include/linux/bitmap.h                  |    1 +
 tools/include/linux/kernel.h                  |    1 +
 tools/include/linux/spinlock.h                |   12 +-
 tools/testing/radix-tree/.gitignore           |    1 +
 tools/testing/radix-tree/Makefile             |   11 +-
 tools/testing/radix-tree/benchmark.c          |  141 +-
 tools/testing/radix-tree/bitmap.c             |   23 +
 tools/testing/radix-tree/generated/autoconf.h |    2 +-
 tools/testing/radix-tree/idr-test.c           |   71 +-
 tools/testing/radix-tree/iteration_check.c    |  109 +-
 tools/testing/radix-tree/linux/bug.h          |    1 +
 tools/testing/radix-tree/linux/kconfig.h      |    1 +
 tools/testing/radix-tree/linux/kernel.h       |    5 +
 tools/testing/radix-tree/linux/lockdep.h      |   11 +
 tools/testing/radix-tree/linux/radix-tree.h   |    1 -
 tools/testing/radix-tree/linux/rcupdate.h     |    2 +
 tools/testing/radix-tree/main.c               |   66 +-
 tools/testing/radix-tree/multiorder.c         |  609 +-------
 tools/testing/radix-tree/regression1.c        |   75 +-
 tools/testing/radix-tree/regression2.c        |    8 +-
 tools/testing/radix-tree/regression3.c        |   23 -
 tools/testing/radix-tree/tag_check.c          |   33 +-
 tools/testing/radix-tree/test.c               |  131 +-
 tools/testing/radix-tree/test.h               |   13 +-
 tools/testing/radix-tree/xarray.c             |   35 +
 93 files changed, 7054 insertions(+), 3812 deletions(-)
 create mode 100644 Documentation/core-api/xarray.rst
 create mode 100644 lib/test_xarray.c
 create mode 100644 lib/xarray.c
 create mode 100644 tools/include/asm-generic/bitops/non-atomic.h
 create mode 100644 tools/testing/radix-tree/bitmap.c
 create mode 100644 tools/testing/radix-tree/linux/kconfig.h
 create mode 100644 tools/testing/radix-tree/linux/lockdep.h
 create mode 100644 tools/testing/radix-tree/xarray.c


