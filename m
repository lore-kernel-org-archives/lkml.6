Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752369AbeDJBQz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 21:16:55 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46789 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbeDJBQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 21:16:53 -0400
X-Google-Smtp-Source: AIpwx4+bP+244FHMqt28JnthMTe5JGgq4Y5TVNJoN0iC6Y/M1+yCT7keDxu09MxPxkV3jCNw0Wu65w==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: davem@davemloft.net, arnd@arndb.de, sam@mendozajonas.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH v2] net: nsci: Replace GFP_ATOMIC with GFP_KERNEL in ncsi_register_dev
Date: Tue, 10 Apr 2018 09:16:46 +0800
Message-Id: <1523323006-28010-1-git-send-email-baijiaju1990@gmail.com>
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
which does not sleep for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
which can sleep and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
v2:
* Modify the description of GFP_ATOMIC in v1.
  Thank Eric for good advice.
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
