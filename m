Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752906AbeDPDbU (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 23:31:20 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35766 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752639AbeDPDbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 23:31:19 -0400
X-Google-Smtp-Source: AIpwx49m+QbB6Dp4FncxObas3Cf6iMByiiZ383yzXNuIUbZ97kkLq04VI1nKSqmJxgsNVn6uTSmT4g==
From: Minchan Kim <minchan@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v4 0/4] zram memory tracking
Date: Mon, 16 Apr 2018 12:31:06 +0900
Message-Id: <20180416033110.32361-1-minchan@kernel.org>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
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
      300    75.033841 .wh
      301    63.806904 s..
      302    63.806919 ..h

First column is zram's block index and 3rh one represents symbol
(s: same page w: written page to backing store h: huge page) of the
block state. Second column represents usec time unit of the block
was last accessed. So above example means the 300th block is accessed
at 75.033851 second and it was huge so it was written to the backing
store.

* from v3:
  * use depends on selecting DEBUG_FS - Greg KH
  * Add acked-by from Greg
  * Fix null ptr access at module unload - Sergey
  * warning fix from copy_to_user - Sergey

* From v2:
  * debugfs and Kconfig cleanup - Greg KH
  * Remove unnecesarry buffer - Sergey
  * Change timestamp from sec to usec

* From v1:
  * Do not propagate error number for debugfs fail - Greg KH
  * Add writeback and hugepage information - Sergey

Minchan Kim (4):
  zram: correct flag name of ZRAM_ACCESS
  zram: mark incompressible page as ZRAM_HUGE
  zram: record accessed second
  zram: introduce zram memory tracking

 Documentation/blockdev/zram.txt |  25 +++++
 drivers/block/zram/Kconfig      |  10 ++
 drivers/block/zram/zram_drv.c   | 173 +++++++++++++++++++++++++++++---
 drivers/block/zram/zram_drv.h   |  14 ++-
 4 files changed, 205 insertions(+), 17 deletions(-)

-- 
2.17.0.484.g0c8726318c-goog
