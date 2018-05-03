Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbeECTCn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 15:02:43 -0400
Received: from gateway20.websitewelcome.com ([192.185.61.9]:40398 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751181AbeECTCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 15:02:42 -0400
X-Authority-Reason: nr=8
Date: Thu, 3 May 2018 13:17:12 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Chas Williams <3chas3@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc: linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] atm: zatm: Fix potential Spectre v1
Message-ID: <20180503181712.GA7443@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.172.56.86
X-Source-L: No
X-Exim-ID: 1fEIn4-003nx7-7S
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.172.56.86]:42960
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pool can be indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

drivers/atm/zatm.c:1462 zatm_ioctl() warn: potential spectre issue
'zatm_dev->pool_info' (local cap)

Fix this by sanitizing pool before using it to index
zatm_dev->pool_info

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/atm/zatm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/atm/zatm.c b/drivers/atm/zatm.c
index 1ef67db..9c9a229 100644
--- a/drivers/atm/zatm.c
+++ b/drivers/atm/zatm.c
@@ -28,6 +28,7 @@
 #include <asm/io.h>
 #include <linux/atomic.h>
 #include <linux/uaccess.h>
+#include <linux/nospec.h>
 
 #include "uPD98401.h"
 #include "uPD98402.h"
@@ -1458,6 +1459,8 @@ static int zatm_ioctl(struct atm_dev *dev,unsigned int cmd,void __user *arg)
 					return -EFAULT;
 				if (pool < 0 || pool > ZATM_LAST_POOL)
 					return -EINVAL;
+				pool = array_index_nospec(pool,
+							  ZATM_LAST_POOL + 1);
 				spin_lock_irqsave(&zatm_dev->lock, flags);
 				info = zatm_dev->pool_info[pool];
 				if (cmd == ZATM_GETPOOLZ) {
-- 
2.7.4
