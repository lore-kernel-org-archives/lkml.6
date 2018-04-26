Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756388AbeDZNPd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 09:15:33 -0400
Received: from gateway36.websitewelcome.com ([192.185.199.121]:31192 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755725AbeDZNPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 09:15:22 -0400
X-Authority-Reason: nr=8
Date: Thu, 26 Apr 2018 08:13:24 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Amitkumar Karwar <amit.karwar@redpinesignals.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] rsi_91x_usb: fix uninitialized variable
Message-ID: <20180426131324.GA982@embeddedor.com>
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
X-Source-IP: 189.145.33.162
X-Source-L: No
X-Exim-ID: 1fBgiG-00370h-B6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.145.33.162]:41440
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a potential execution path in which variable ret is returned
without being properly initialized previously.

Fix this by storing the value returned by function
rsi_usb_master_reg_write into _ret_.

Addresses-Coverity-ID: 1468407 ("Uninitialized scalar variable")
Fixes: 16d3bb7b2f37 ("rsi: disable fw watchdog timer during reset")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/wireless/rsi/rsi_91x_usb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_usb.c b/drivers/net/wireless/rsi/rsi_91x_usb.c
index b065438..6ce6b75 100644
--- a/drivers/net/wireless/rsi/rsi_91x_usb.c
+++ b/drivers/net/wireless/rsi/rsi_91x_usb.c
@@ -687,9 +687,10 @@ static int rsi_reset_card(struct rsi_hw *adapter)
 	 */
 	msleep(100);
 
-	if (rsi_usb_master_reg_write(adapter, SWBL_REGOUT,
-				     RSI_FW_WDT_DISABLE_REQ,
-				     RSI_COMMON_REG_SIZE) < 0) {
+	ret = rsi_usb_master_reg_write(adapter, SWBL_REGOUT,
+				       RSI_FW_WDT_DISABLE_REQ,
+				       RSI_COMMON_REG_SIZE);
+	if (ret < 0) {
 		rsi_dbg(ERR_ZONE, "Disabling firmware watchdog timer failed\n");
 		goto fail;
 	}
-- 
2.7.4
