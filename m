Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753920AbeFDHHb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:07:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753769AbeFDHEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:04:36 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Baofeng Tian <baofeng.tian@intel.com>
Subject: [PATCH 4.16 42/47] intel_th: Use correct device when freeing buffers
Date: Mon,  4 Jun 2018 08:58:54 +0200
Message-Id: <20180604065551.253932513@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065549.468488465@linuxfoundation.org>
References: <20180604065549.468488465@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit 0ed2424b911f3a058dfea01b78817abed767433d upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/intel_th/msu.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -741,8 +741,8 @@ err_nomem:
 		/* Reset the page to write-back before releasing */
 		set_memory_wb((unsigned long)win->block[i].bdesc, 1);
 #endif
-		dma_free_coherent(msc_dev(msc), size, win->block[i].bdesc,
-				  win->block[i].addr);
+		dma_free_coherent(msc_dev(msc)->parent->parent, size,
+				  win->block[i].bdesc, win->block[i].addr);
 	}
 	kfree(win);
 
@@ -777,7 +777,7 @@ static void msc_buffer_win_free(struct m
 		/* Reset the page to write-back before releasing */
 		set_memory_wb((unsigned long)win->block[i].bdesc, 1);
 #endif
-		dma_free_coherent(msc_dev(win->msc), PAGE_SIZE,
+		dma_free_coherent(msc_dev(win->msc)->parent->parent, PAGE_SIZE,
 				  win->block[i].bdesc, win->block[i].addr);
 	}
 
