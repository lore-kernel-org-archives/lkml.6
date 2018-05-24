Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965398AbeEXI14 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:27:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:61449 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965350AbeEXI1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:27:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,436,1520924400";
   d="scan'208";a="43824549"
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        stable@vger.kernel.org
Subject: [GIT PULL 2/2] intel_th: Use correct device when freeing buffers
Date: Thu, 24 May 2018 11:27:27 +0300
Message-Id: <20180524082727.28990-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524082727.28990-1-alexander.shishkin@linux.intel.com>
References: <20180524082727.28990-1-alexander.shishkin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d5c435df4a890 ("intel_th: msu: Use the real device in case of IOMMU
domain allocation") changes dma buffer allocation to use the actual
underlying device, but forgets to change the deallocation path, which leads
to (if you've got CAP_SYS_RAWIO):

> # echo 0,0 > /sys/bus/intel_th/devices/0-msc0/nr_pages
> ------------[ cut here ]------------
> kernel BUG at ../linux/drivers/iommu/intel-iommu.c:3670!
> CPU: 3 PID: 231 Comm: sh Not tainted 4.17.0-rc1+ #2729
> RIP: 0010:intel_unmap+0x11e/0x130
...
> Call Trace:
>  intel_free_coherent+0x3e/0x60
>  msc_buffer_win_free+0x100/0x160 [intel_th_msu]

This patch fixes the buffer deallocation code to use the correct device.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Fixes: d5c435df4a890 ("intel_th: msu: Use the real device in case of IOMMU domain allocation")
Reported-by: Baofeng Tian <baofeng.tian@intel.com>
CC: stable@vger.kernel.org # v4.14+
---
 drivers/hwtracing/intel_th/msu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index ede388309376..634f58042c77 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -733,8 +733,8 @@ static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_blocks)
 		/* Reset the page to write-back before releasing */
 		set_memory_wb((unsigned long)win->block[i].bdesc, 1);
 #endif
-		dma_free_coherent(msc_dev(msc), size, win->block[i].bdesc,
-				  win->block[i].addr);
+		dma_free_coherent(msc_dev(msc)->parent->parent, size,
+				  win->block[i].bdesc, win->block[i].addr);
 	}
 	kfree(win);
 
@@ -769,7 +769,7 @@ static void msc_buffer_win_free(struct msc *msc, struct msc_window *win)
 		/* Reset the page to write-back before releasing */
 		set_memory_wb((unsigned long)win->block[i].bdesc, 1);
 #endif
-		dma_free_coherent(msc_dev(win->msc), PAGE_SIZE,
+		dma_free_coherent(msc_dev(win->msc)->parent->parent, PAGE_SIZE,
 				  win->block[i].bdesc, win->block[i].addr);
 	}
 
-- 
2.17.0
