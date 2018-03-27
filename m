Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751374AbeC0Gup (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 02:50:45 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43628 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750907AbeC0Guo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 02:50:44 -0400
X-Google-Smtp-Source: AIpwx4+o4Q2LFrAFIDic4LGF7UlMnNF/REqJVe3NCBZivUij2BTlKFUdpS61bLU3sInTrJKqbK52Hg==
From: Minchan Kim <minchan@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2 0/4] zram memory tracking
Date: Tue, 27 Mar 2018 15:50:29 +0900
Message-Id: <20180327065033.181819-1-minchan@kernel.org>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f067-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zRam as swap is useful for small memory device. However, swap means
those pages on zram are mostly cold pages due to VM's LRU algorithm.
Especially, once init data for application are touched for launching,
they tend to be not accessed any more and finally swapped out.
zRAM can store such cold pages as compressed form but it's pointless
to keep in memory. As well, it's pointless to store incompressible
pages to zram so better idea is app developers manages them directly
like free or mlock rather than remaining them on heap.

This patch provides a debugfs /sys/kernel/debug/zram/zram0/block_state
to represent each block's state so admin can investigate what memory is
cold|incompressible|same page with using pagemap once the pages are
swapped out.

The output is as follows,

   25064    .wh       100
   25065    s..       9
   25067    ..h       15

First column is zram's block index and second one represents symbol
(s: same page w: written page to backing store h: huge page) of the 
block state. Last one means number of seconds elapsed since the block
was last accessed. So above example means the 25064th block is accessed
100 second ago and it was huge so it was written to the backing store.

* From v1:
  * Do not propagate error number for debugfs fail - Greg KH
  * Add writeback and hugepage information - Sergey

Minchan Kim (4):
  zram: correct flag name of ZRAM_ACCESS
  zram: mark incompressible page as ZRAM_HUGE
  zram: record accessed second
  zram: introduce zram memory tracking

 Documentation/blockdev/zram.txt |   1 +
 drivers/block/zram/Kconfig      |  10 ++
 drivers/block/zram/zram_drv.c   | 157 +++++++++++++++++++++++++++++---
 drivers/block/zram/zram_drv.h   |  12 ++-
 4 files changed, 163 insertions(+), 17 deletions(-)

-- 
2.17.0.rc0.231.g781580f067-goog
