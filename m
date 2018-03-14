Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbeCNQgp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:36:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751353AbeCNQgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:36:43 -0400
From: Jonathan Toppins <jtoppins@redhat.com>
To: netdev@vger.kernel.org
Cc: Andy Gospodarek <andy@greyhouse.net>,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net] tg3: prevent scheduling while atomic splat
Date: Wed, 14 Mar 2018 12:36:25 -0400
Message-Id: <f439051c3964c6bb5342e25fb5327e0cdeba001e.1521045132.git.jtoppins@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem was introduced in commit
506b0a395f26 ("[netdrv] tg3: APE heartbeat changes"). The bug occurs
because tp->lock spinlock is held which is obtained in tg3_start
by way of tg3_full_lock(), line 11571. The documentation for usleep_range()
specifically states it cannot be used inside a spinlock.

Fixes: 506b0a395f26 ("[netdrv] tg3: APE heartbeat changes")
Signed-off-by: Jonathan Toppins <jtoppins@redhat.com>
---

Notes:
    The thing I need reviewed from Broadcom is if the udelay should be 20
    instead of 10, due to any timing changes introduced by the offending
    patch.

 drivers/net/ethernet/broadcom/tg3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index c1841db1b500..f2593978ae75 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -820,7 +820,7 @@ static int tg3_ape_event_lock(struct tg3 *tp, u32 timeout_us)
 
 		tg3_ape_unlock(tp, TG3_APE_LOCK_MEM);
 
-		usleep_range(10, 20);
+		udelay(10);
 		timeout_us -= (timeout_us > 10) ? 10 : timeout_us;
 	}
 
-- 
2.13.6
