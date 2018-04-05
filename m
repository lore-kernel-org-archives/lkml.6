Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752372AbeDEQUM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 12:20:12 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.194]:42608 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751469AbeDEQUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 12:20:11 -0400
Date: Thu, 5 Apr 2018 11:20:06 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Xue Liu <liuxuenetmail@gmail.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ieee802154: mcr20a: Fix memory leak in mcr20a_probe
Message-ID: <20180405162006.GA2199@embeddedor.com>
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
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1f47cN-000QR3-O5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.145.54.187]:41978
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free allocated memory for pdata before return.

Addresses-Coverity-ID: 1466096 ("Resource leak")
Fixes: 8c6ad9cc5157 ("ieee802154: Add NXP MCR20A IEEE 802.15.4 transceiver driver")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ieee802154/mcr20a.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
index 55a22c7..944470d 100644
--- a/drivers/net/ieee802154/mcr20a.c
+++ b/drivers/net/ieee802154/mcr20a.c
@@ -1267,7 +1267,7 @@ mcr20a_probe(struct spi_device *spi)
 	ret = mcr20a_get_platform_data(spi, pdata);
 	if (ret < 0) {
 		dev_crit(&spi->dev, "mcr20a_get_platform_data failed.\n");
-		return ret;
+		goto free_pdata;
 	}
 
 	/* init reset gpio */
@@ -1275,7 +1275,7 @@ mcr20a_probe(struct spi_device *spi)
 		ret = devm_gpio_request_one(&spi->dev, pdata->rst_gpio,
 					    GPIOF_OUT_INIT_HIGH, "reset");
 		if (ret)
-			return ret;
+			goto free_pdata;
 	}
 
 	/* reset mcr20a */
@@ -1291,7 +1291,8 @@ mcr20a_probe(struct spi_device *spi)
 	hw = ieee802154_alloc_hw(sizeof(*lp), &mcr20a_hw_ops);
 	if (!hw) {
 		dev_crit(&spi->dev, "ieee802154_alloc_hw failed\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto free_pdata;
 	}
 
 	/* init mcr20a local data */
@@ -1366,6 +1367,8 @@ mcr20a_probe(struct spi_device *spi)
 
 free_dev:
 	ieee802154_free_hw(lp->hw);
+free_pdata:
+	kfree(pdata);
 
 	return ret;
 }
-- 
2.7.4
