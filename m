Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753733AbeEWCst (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 22:48:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7731 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753441AbeEWCss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 22:48:48 -0400
From: Pengcheng Li <lipengcheng8@huawei.com>
To: <amira@ti.com>, <pavan_savoy@ti.com>, <x0153368@ti.com>,
        <gigi.joseph@ti.com>, <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>, <guodong.xu@linaro.org>,
        <john.stultz@linaro.org>, <dimitrysh@google.com>,
        <linux-kernel@vger.kernel.org>
CC: <lipengcheng8@huawei.com>, <yaobaofeng@huawei.com>,
        <lijiangxiong@hisilicon.com>, <kongfei@hisilicon.com>
Subject: [PATCH] misc: st_core: Fix skb double free corruption
Date: Wed, 23 May 2018 10:39:51 +0800
Message-ID: <1527043191-23610-1-git-send-email-lipengcheng8@huawei.com>
X-Mailer: git-send-email 2.8.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.181.43]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

St_gdata->list[chnl_id]->recv function pointer to hci_recv_frame interface,
hci_recv_frame interface releases skb buffer in case of exception.

Signed-off-by: Li Pengcheng <lipengcheng8@huawei.com>
Signed-off-by: Yao Baofeng <yaobaofeng@huawei.com>
Signed-off-by: Li Jiangxiong <lijiangxiong@hisilicon.com>
---
 drivers/misc/ti-st/st_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index 0005159..f4ce211 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -124,7 +124,6 @@ static void st_send_frame(unsigned char chnl_id, struct st_data_s *st_gdata)
 			(st_gdata->list[chnl_id]->priv_data, st_gdata->rx_skb)
 			     != 0)) {
 			pr_err(" proto stack %d's ->recv failed", chnl_id);
-			kfree_skb(st_gdata->rx_skb);
 			return;
 		}
 	} else {
-- 
2.8.0
