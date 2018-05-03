Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751359AbeECSVL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 14:21:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37510 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751075AbeECSVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 14:21:09 -0400
To: LKML <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        axboe@kernel.dk
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] zram: fix printk formats in zram_drv.c
Cc: Nitin Gupta <ngupta@vflare.org>, Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Message-ID: <3652ccb1-96ef-0b0b-05d1-f661d7733dcc@infradead.org>
Date: Thu, 3 May 2018 11:21:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix printk format warnings (seen on i386 build):

../drivers/block/zram/zram_drv.c:678:4: warning: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘ssize_t’ [-Wformat=]
../drivers/block/zram/zram_drv.c:678:4: warning: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 5 has type ‘time64_t’ [-Wformat=]

time64_t is 64 bits (and signed), so printing it should use %lld,
not %ld.  %ld (long) is only 32 bits on several architectures.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Nitin Gupta <ngupta@vflare.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
---
 drivers/block/zram/zram_drv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20180503.orig/drivers/block/zram/zram_drv.c
+++ linux-next-20180503/drivers/block/zram/zram_drv.c
@@ -671,7 +671,7 @@ static ssize_t read_block_state(struct f
 
 		ts = ktime_to_timespec64(zram->table[index].ac_time);
 		copied = snprintf(kbuf + written, count,
-			"%12lu %12lu.%06lu %c%c%c\n",
+			"%12zd %12lld.%06lu %c%c%c\n",
 			index, ts.tv_sec, ts.tv_nsec / NSEC_PER_USEC,
 			zram_test_flag(zram, index, ZRAM_SAME) ? 's' : '.',
 			zram_test_flag(zram, index, ZRAM_WB) ? 'w' : '.',
