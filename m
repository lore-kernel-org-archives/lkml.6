Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbeEVHJb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 03:09:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7727 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751124AbeEVHJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 03:09:28 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <ganeshgr@chelsio.com>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] cxgb4: Check for kvzalloc allocation failure
Date: Tue, 22 May 2018 15:07:18 +0800
Message-ID: <20180522070718.12864-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

t4_prep_fw doesn't check for card_fw pointer before store the read data,
which could lead to a NULL pointer dereference if kvzalloc failed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 130d1ee..019cffe 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -4135,6 +4135,10 @@ static int adap_init0(struct adapter *adap)
 		 * card
 		 */
 		card_fw = kvzalloc(sizeof(*card_fw), GFP_KERNEL);
+		if (!card_fw) {
+			ret = -ENOMEM;
+			goto bye;
+		}
 
 		/* Get FW from from /lib/firmware/ */
 		ret = request_firmware(&fw, fw_info->fw_mod_name,
-- 
2.7.0
