Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757548AbeD0Hg4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 03:36:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46850 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757153AbeD0Hgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 03:36:55 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <richardcochran@gmail.com>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] ptp_pch: use helpers function for converting between ns and timespec
Date: Fri, 27 Apr 2018 15:36:18 +0800
Message-ID: <20180427073618.12036-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use ns_to_timespec64() and timespec64_to_ns() instead of open coding

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/ptp/ptp_pch.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/ptp/ptp_pch.c b/drivers/ptp/ptp_pch.c
index b328517..78ccf93 100644
--- a/drivers/ptp/ptp_pch.c
+++ b/drivers/ptp/ptp_pch.c
@@ -452,7 +452,6 @@ static int ptp_pch_adjtime(struct ptp_clock_info *ptp, s64 delta)
 static int ptp_pch_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
 {
 	u64 ns;
-	u32 remainder;
 	unsigned long flags;
 	struct pch_dev *pch_dev = container_of(ptp, struct pch_dev, caps);
 	struct pch_ts_regs __iomem *regs = pch_dev->regs;
@@ -461,8 +460,7 @@ static int ptp_pch_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
 	ns = pch_systime_read(regs);
 	spin_unlock_irqrestore(&pch_dev->register_lock, flags);
 
-	ts->tv_sec = div_u64_rem(ns, 1000000000, &remainder);
-	ts->tv_nsec = remainder;
+	*ts = ns_to_timespec64(ns);
 	return 0;
 }
 
@@ -474,8 +472,7 @@ static int ptp_pch_settime(struct ptp_clock_info *ptp,
 	struct pch_dev *pch_dev = container_of(ptp, struct pch_dev, caps);
 	struct pch_ts_regs __iomem *regs = pch_dev->regs;
 
-	ns = ts->tv_sec * 1000000000ULL;
-	ns += ts->tv_nsec;
+	ns = timespec64_to_ns(ts);
 
 	spin_lock_irqsave(&pch_dev->register_lock, flags);
 	pch_systime_write(regs, ns);
-- 
2.7.0
