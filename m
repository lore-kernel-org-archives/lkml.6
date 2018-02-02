Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751713AbeBBPTX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:19:23 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:47513 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751472AbeBBPTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:19:16 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Ganesh Goudar <ganeshgr@chelsio.com>
Cc: Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        Kumar Sanghvi <kumaras@chelsio.com>, Harsh Jain <harsh@chelsio.com>,
        Atul Gupta <atul.gupta@chelsio.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: cxgb4: avoid memcpy beyond end of source buffer
Date: Fri,  2 Feb 2018 16:18:37 +0100
Message-Id: <20180202151849.808610-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:aQgj518KjoKGduzq+UOYDCkSZ1m8qyeYGkhVaxQOoA+4sqJ1fic
 0PX+eJYqPj1RCCvPm4bO+uDCLtdKz6P4tahNv9DhZe0/8MRGeDwzVTzIojXeOQZmisojWvz
 OzzCYWeV67NiEZhayQdHCAR8EqmVOdfsr3pptJ/cdx2ozQuBkS/FRZbw6P6Dpx1kmKvnbb6
 8RpOyO8bWLzMGhcp5J1DQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nI749I8mSz8=:5n6SiV2dcHaMu8CCrqnlAv
 TJ8ZbQzZwrxHZXYzuRNBzus7HE2sBfu0zUHCXkaM3m9bCw2C3xBBGMp4fTxQh5tTAZnyskykT
 8soH1WQSrIsXnLsr1ExZS0C1o3zrMf7vTAQpABvQanOWfXwA3dy5nOvAdheuakJnHD4X9XP6F
 uFHVbKr6Usr/30iHIHpD/hXSmVFQN1ukMWiWMCqrTzkTDMKxpn6VsPFSXFGWzRgKKQ/GBPWfv
 8sU0JX87JQePJOVovYy+I+7ZpkER/FjDvd7uUzX2OQTKAY3zBYZjbfD4IIu2budqZjiPW+yoJ
 I7pfaq5piqpSxTaT3hOwhDCMsnpO2idu4Hl77NH7Vq/Y3YU+LzCJv5Z8z1MV1Z6wcxgeWsxZd
 Sn3vPhddS6ZsDWWlfxxqcPK/dN4AJD4N30NP1BkKP8+vT/C5AxyyOHXE07Ve+deRRkQQtaEuh
 sBg0Vw3M6rdhZwQDvB2gAh6WMiJhb9ApSPDMICr1MKfc/MUNPpGBaLP766w6Zu47iFtb+6J+4
 2uvlxuQ0T7PpzZwaPDz+d6pDOW32wrspDF4Gx7SxJdkwDwT6P68Xgcv/r+JTnhmz6NDirjjks
 tYiRVuMh962yD55vKZGzqlx4GDG0u5yiu8lSoUMov19EzB7nV8CskGwLgYQyiz17wFNW4Gw8k
 taqZLNRGxzv8ICFTQX3Qt8Xw7gsGmIW15fHt4x7VcSrJ6o+j63L0smHNkmS26SKYa7eCAwrpX
 kMnaKe19kohJKVRDH4Qgo8B2eV9hOy/5cz+1PA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with link-time-optimizations revealed that the cxgb4 driver does
a fixed-size memcpy() from a variable-length constant string into the
network interface name:

In function 'memcpy',
    inlined from 'cfg_queues_uld.constprop' at drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c:335:2,
    inlined from 'cxgb4_register_uld.constprop' at drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c:719:9:
include/linux/string.h:350:3: error: call to '__read_overflow2' declared with attribute error: detected read beyond size of object passed as 2nd parameter
   __read_overflow2();
   ^

I can see two equally workable solutions: either we use a strncpy() instead
of the memcpy() to stop at the end of the input, or we make the source buffer
fixed length as well. This implements the latter.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h
index 1d37672902da..a14e8db51cdc 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h
@@ -355,7 +355,7 @@ struct cxgb4_lld_info {
 };
 
 struct cxgb4_uld_info {
-	const char *name;
+	char name[IFNAMSIZ];
 	void *handle;
 	unsigned int nrxq;
 	unsigned int rxq_size;
-- 
2.9.0
