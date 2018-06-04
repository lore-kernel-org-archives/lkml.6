Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbeFDKeQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:34:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42729 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751814AbeFDKeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:34:14 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <kvalo@codeaurora.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] atmel: use memdup_user to simplify the code
Date: Mon, 4 Jun 2018 18:32:10 +0800
Message-ID: <20180604103210.23984-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use existing memdup_user() helper function instead of open-coding

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/wireless/atmel/atmel.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/atmel/atmel.c b/drivers/net/wireless/atmel/atmel.c
index d122386..30b479a 100644
--- a/drivers/net/wireless/atmel/atmel.c
+++ b/drivers/net/wireless/atmel/atmel.c
@@ -2657,14 +2657,9 @@ static int atmel_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 			break;
 		}
 
-		if (!(new_firmware = kmalloc(com.len, GFP_KERNEL))) {
-			rc = -ENOMEM;
-			break;
-		}
-
-		if (copy_from_user(new_firmware, com.data, com.len)) {
-			kfree(new_firmware);
-			rc = -EFAULT;
+		new_firmware = memdup_user(com.data, com.len);
+		if (IS_ERR(new_firmware)) {
+			rc = PTR_ERR(new_firmware);
 			break;
 		}
 
-- 
2.7.0
