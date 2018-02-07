Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932296AbeBGVUE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 16:20:04 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:56127 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932198AbeBGVTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 16:19:21 -0500
Date: Wed, 7 Feb 2018 13:19:18 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Mi <chrism@mellanox.com>
Subject: [PULL] IDR changes for 4.16
Message-ID: <20180207211918.GA11985@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Please pull the changes I've made to the IDR code.  DaveM said he'd
merge them as part of the net tree, since most of the changes are
to the new 'extended' IDR API, but it looks like the patches fell on
the floor somewhere.  The first three patches are for the test-suite;
the next fourteen replace the extended API by improving the normal API;
patch 18 will improve performance for IDRs which are 1-based rather than
0-based, and the final one improves the documentation.

I have a clean build report from 0day and, while these patches haven't
been in linux-next, I just checked a merge with your current HEAD and
find no problems.

The following changes since commit e237f98a9c134c3d600353f21e07db915516875b:

  Merge tag 'xfs-4.16-merge-5' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux (2018-02-05 13:35:56 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/willy/linux-dax.git idr-2018-02-06

for you to fetch changes up to ac665d9423474e64e64b34b0e2cea43601b50d7d:

  idr: Add documentation (2018-02-06 16:41:29 -0500)

----------------------------------------------------------------
Matthew Wilcox (19):
      radix tree test suite: Remove ARRAY_SIZE
      idr test suite: Fix ida_test_random()
      IDR test suite: Check handling negative end correctly
      idr: Delete idr_remove_ext function
      idr: Delete idr_replace_ext function
      idr: Delete idr_find_ext function
      idr: Add idr_alloc_u32 helper
      net sched actions: Convert to use idr_alloc_u32
      cls_api: Convert to idr_alloc_u32
      cls_basic: Convert to use idr_alloc_u32
      cls_bpf: Convert to use idr_alloc_u32
      cls_flower: Convert to idr_alloc_u32
      cls_u32: Reinstate cyclic allocation
      cls_u32: Convert to idr_alloc_u32
      idr: Remove idr_alloc_ext
      idr: Rename idr_for_each_entry_ext
      idr: Warn if old iterators see large IDs
      idr: Make 1-based IDRs more efficient
      idr: Add documentation

 Documentation/core-api/idr.rst          |  79 ++++++++++
 Documentation/core-api/index.rst        |   1 +
 Documentation/core-api/kernel-api.rst   |  12 --
 include/linux/idr.h                     | 174 ++++++++++------------
 include/linux/radix-tree.h              |  17 +--
 lib/idr.c                               | 255 ++++++++++++++++++++++++--------
 lib/radix-tree.c                        |   3 +-
 net/sched/act_api.c                     |  72 ++++-----
 net/sched/cls_api.c                     |   8 +-
 net/sched/cls_basic.c                   |  33 ++---
 net/sched/cls_bpf.c                     |  30 ++--
 net/sched/cls_flower.c                  |  34 ++---
 net/sched/cls_u32.c                     |  47 +++---
 tools/testing/radix-tree/idr-test.c     |  29 +++-
 tools/testing/radix-tree/linux/kernel.h |   2 -
 15 files changed, 471 insertions(+), 325 deletions(-)
 create mode 100644 Documentation/core-api/idr.rst
