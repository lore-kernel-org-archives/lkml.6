Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752535AbeDIOLP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 10:11:15 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33560 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751550AbeDIOLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 10:11:13 -0400
X-Google-Smtp-Source: AIpwx4/26YvKg2E5dnzB5scoiDg801x5BBD+RbrWl+zhPFM1EJE5ur982gEiFvErYRLx9du34k3vbA==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: davem@davemloft.net, arnd@arndb.de, sam@mendozajonas.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: nsci: Replace GFP_ATOMIC with GFP_KERNEL in ncsi_register_dev
Date: Mon,  9 Apr 2018 22:11:07 +0800
Message-Id: <1523283067-25697-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ncsi_register_dev() is never called in atomic context.
This function is only called by ftgmac100_probe() in 
drivers/net/ethernet/faraday/ftgmac100.c.
And ftgmac100_probe() is only set as ".probe" in "struct platform_driver".

Despite never getting called from atomic context,
ncsi_register_dev() calls kzalloc() with GFP_ATOMIC,
which waits busily for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
to avoid busy waiting and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 net/ncsi/ncsi-manage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 3fd3c39..6b5b5a0 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1508,7 +1508,7 @@ struct ncsi_dev *ncsi_register_dev(struct net_device *dev,
 		return nd;
 
 	/* Create NCSI device */
-	ndp = kzalloc(sizeof(*ndp), GFP_ATOMIC);
+	ndp = kzalloc(sizeof(*ndp), GFP_KERNEL);
 	if (!ndp)
 		return NULL;
 
-- 
1.9.1
