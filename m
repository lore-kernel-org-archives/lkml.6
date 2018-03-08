Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934744AbeCHC2A (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 21:28:00 -0500
Received: from gateway36.websitewelcome.com ([192.185.193.119]:35521 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933351AbeCHC17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 21:27:59 -0500
Date: Wed, 7 Mar 2018 20:27:56 -0600
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH v2] rtc: remove VLA usage
Message-ID: <20180308022756.GA28733@embeddedor.com>
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
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1etlHi-004KGo-DL
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.175.117.58]:39554
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wvla, remove VLA and replace it
with a fixed-length array instead.

>From a security viewpoint, the use of Variable Length Arrays can be
a vector for stack overflow attacks. Also, in general, as the code
evolves it is easy to lose track of how big a VLA can get. Thus, we
can end up having segfaults that are hard to debug.

Also, fixed as part of the directive to remove all VLAs from
the kernel: https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
Changes in v2:
 - Update changelog as per Alexandre Belloni request.
 - Update the code for rtc-bq32k driver based on Alexandre's feedback.

 drivers/rtc/rtc-bq32k.c  | 6 +++++-
 drivers/rtc/rtc-mcp795.c | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-bq32k.c b/drivers/rtc/rtc-bq32k.c
index e8698e9..ef52741 100644
--- a/drivers/rtc/rtc-bq32k.c
+++ b/drivers/rtc/rtc-bq32k.c
@@ -36,6 +36,10 @@
 #define BQ32K_CFG2		0x09	/* Trickle charger control */
 #define BQ32K_TCFE		BIT(6)	/* Trickle charge FET bypass */
 
+#define MAX_LEN			10	/* Maximum number of consecutive
+					 * register for this particular RTC.
+					 */
+
 struct bq32k_regs {
 	uint8_t		seconds;
 	uint8_t		minutes;
@@ -74,7 +78,7 @@ static int bq32k_read(struct device *dev, void *data, uint8_t off, uint8_t len)
 static int bq32k_write(struct device *dev, void *data, uint8_t off, uint8_t len)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	uint8_t buffer[len + 1];
+	uint8_t buffer[MAX_LEN + 1];
 
 	buffer[0] = off;
 	memcpy(&buffer[1], data, len);
diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
index 79e24ea..00e11c1 100644
--- a/drivers/rtc/rtc-mcp795.c
+++ b/drivers/rtc/rtc-mcp795.c
@@ -82,7 +82,7 @@ static int mcp795_rtcc_write(struct device *dev, u8 addr, u8 *data, u8 count)
 {
 	struct spi_device *spi = to_spi_device(dev);
 	int ret;
-	u8 tx[2 + count];
+	u8 tx[257];
 
 	tx[0] = MCP795_WRITE;
 	tx[1] = addr;
-- 
2.7.4
