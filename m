Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbeBHOhC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:37:02 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:54294 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750961AbeBHOg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:36:59 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180208143657epoutp04425092afd888005cafece3d23525af67~RYHf0D2452521625216epoutp04A
X-AuditID: b6c32a39-467ff70000000fc5-35-5a7c6088ad84
From: Nitesh Shetty <nj.shetty@samsung.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Cc: linux-block@vger.kernel.org, axboe@fb.com,
        linux-nvme@lists.infradead.org, nj.shetty@samsung.com,
        joshi.k@samsung.com
Subject: [PATCH] blk: optimization for classic polling
Date: Sun, 30 May 2083 09:51:06 +0530
Message-id: <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsWy7bCmgW5HQk2UwbYllhb/9xxjszj6/y2b
        xd5b2hZ79p5ksbi8aw6bxfxlT9kttv2ez2xx/u9xVgcOj4nN79g9Ni+p9+jbsorR4/MmOY9N
        T94yBbBGcdmkpOZklqUW6dslcGW8nd7JWHBYomLRhn7WBsbPwl2MnBwSAiYSdyY0MYPYQgI7
        GCU2v+brYuQCsr8zStx9uosRpujTuXYWiMQGRonGYwsZIZx2Jonf9zrZuxg5ONgEtCVO/+cA
        aRARiJLY1naHESTMLFAtsfCCKkhYWMBMYt+sLrBqFgFViY4rSSBhXgEXidkvnzJBrJKTuHmu
        kxlkuoTAV1aJZ+e+sUMkXCQenfoKdY+wxKvjW8DmSAhIS1w6agtR380ocaN1NVTNFEaJGXP1
        IWx7iYt7/oItYBbgk3j3tYcVopdXoqNNCKLEQ2LRiQ5WCNtRYuH+Z0yQMImVeHZqLusERskF
        jAyrGMVSC4pz01OLDQtM9YoTc4tL89L1kvNzNzGCY0/LcgfjsXM+hxgFOBiVeHhfxNVECbEm
        lhVX5h5ilOBgVhLh3SMKFOJNSaysSi3Kjy8qzUktPsQozcGiJM4bEOASJSSQnliSmp2aWpBa
        BJNl4uCUamBcvu2pzmnjFOvzUvuE5vuebDt9aI9qUbbKzNMGXzcufnNSZ5Ln2aVpYSzijLdK
        736O26gcIiKxU0ny3KSJ13ST1Y/6bXh0X/2y8upJpvNrFhQsrmkJEb1iU9zkHC+Zs/qd9+Qn
        T66xB+f/rg8OWjc3b7t9SefrpyfOFoeeqZPz31n4tGX/E8f7SizFGYmGWsxFxYkAlHHv47kC
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCJMWRmVeSWpSXmKPExsVy+t9jQd32hJoog9PrdS3+7znGZnH0/1s2
        i723tC327D3JYnF51xw2i/nLnrJbbPs9n9ni/N/jrA4cHhOb37F7bF5S79G3ZRWjx+dNch6b
        nrxlCmCN4rJJSc3JLEst0rdL4Mp4O72TseCwRMWiDf2sDYyfhbsYOTkkBEwkPp1rZ+li5OIQ
        EljHKLHw2gY2CKeTSWJZ+1kgh4ODTUBb4vR/DpAGEYEoiYWfmllBwswC1RJn59SAhIUFzCT2
        zepiBwmzCKhKdFxJAgnzCrhIzH75lAlilZzEzXOdzBMYuRYwMqxilEwtKM5Nzy02KjDMSy3X
        K07MLS7NS9dLzs/dxAgMi22Htfp2MN5fEn+IUYCDUYmHd0JMTZQQa2JZcWXuIUYJDmYlEd49
        okAh3pTEyqrUovz4otKc1OJDjNIcLErivLfzjkUKCaQnlqRmp6YWpBbBZJk4OKUaGLeLiMfd
        07zcU77s9PtXX/8XuuguKAzfJ/zvzwGxrvxl11PPpG7191oyY4lxx47mm12V5abnE7oP6a1X
        TbwU7bMgp+LO2c5Vau80p5iJ9zhvMsu5yrU6d2fctNqzkwOvGX3SOTG5ReSFYM6740oqd7Z0
        veheO/N4ksShufkut/5f+//hzOoz2ZOUWIozEg21mIuKEwGv71ViBwIAAA==
X-CMS-MailID: 20180208143655epcas1p444bf34705526b7839a5a135f82761aad
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180208143655epcas1p444bf34705526b7839a5a135f82761aad
X-RootMTR: 20180208143655epcas1p444bf34705526b7839a5a135f82761aad
References: <CGME20180208143655epcas1p444bf34705526b7839a5a135f82761aad@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the dependency on interrupts to wake up task. Set task
state as TASK_RUNNING, if need_resched() returns true,
while polling for IO completion.
Earlier, polling task used to sleep, relying on interrupt to wake it up.
This made some IO take very long when interrupt-coalescing is enabled in
NVMe.

Reference:
http://lists.infradead.org/pipermail/linux-nvme/2018-February/015435.html
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 fs/block_dev.c | 16 ++++++++++++----
 fs/direct-io.c |  8 ++++++--
 fs/iomap.c     | 10 +++++++---
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 4a181fc..a87d8b7 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -236,9 +236,13 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		if (!READ_ONCE(bio.bi_private))
 			break;
-		if (!(iocb->ki_flags & IOCB_HIPRI) ||
-		    !blk_poll(bdev_get_queue(bdev), qc))
+		if (!(iocb->ki_flags & IOCB_HIPRI))
 			io_schedule();
+		else if (!blk_poll(bdev_get_queue(bdev), qc)) {
+			if (need_resched())
+				set_current_state(TASK_RUNNING);
+			io_schedule();
+		}
 	}
 	__set_current_state(TASK_RUNNING);
 
@@ -401,9 +405,13 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		if (!READ_ONCE(dio->waiter))
 			break;
 
-		if (!(iocb->ki_flags & IOCB_HIPRI) ||
-		    !blk_poll(bdev_get_queue(bdev), qc))
+		if (!(iocb->ki_flags & IOCB_HIPRI))
 			io_schedule();
+		else if (!blk_poll(bdev_get_queue(bdev), qc)) {
+			if (need_resched())
+				set_current_state(TASK_RUNNING);
+			io_schedule();
+		}
 	}
 	__set_current_state(TASK_RUNNING);
 
diff --git a/fs/direct-io.c b/fs/direct-io.c
index a0ca9e4..c815ac9 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -518,9 +518,13 @@ static struct bio *dio_await_one(struct dio *dio)
 		__set_current_state(TASK_UNINTERRUPTIBLE);
 		dio->waiter = current;
 		spin_unlock_irqrestore(&dio->bio_lock, flags);
-		if (!(dio->iocb->ki_flags & IOCB_HIPRI) ||
-		    !blk_poll(dio->bio_disk->queue, dio->bio_cookie))
+		if (!(dio->iocb->ki_flags & IOCB_HIPRI))
 			io_schedule();
+		else if (!blk_poll(dio->bio_disk->queue, dio->bio_cookie)) {
+			if (need_resched())
+				__set_current_state(TASK_RUNNING);
+			io_schedule();
+		}
 		/* wake up sets us TASK_RUNNING */
 		spin_lock_irqsave(&dio->bio_lock, flags);
 		dio->waiter = NULL;
diff --git a/fs/iomap.c b/fs/iomap.c
index afd1635..b51569d 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1072,10 +1072,14 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 				break;
 
 			if (!(iocb->ki_flags & IOCB_HIPRI) ||
-			    !dio->submit.last_queue ||
-			    !blk_poll(dio->submit.last_queue,
-					 dio->submit.cookie))
+			    !dio->submit.last_queue)
 				io_schedule();
+			else if (!blk_poll(dio->submit.last_queue,
+					 dio->submit.cookie)) {
+				if (need_resched())
+					set_current_state(TASK_RUNNING);
+				io_schedule();
+			}
 		}
 		__set_current_state(TASK_RUNNING);
 	}
-- 
2.7.4
