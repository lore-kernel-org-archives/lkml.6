Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752352AbeB1Jy7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 04:54:59 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:46403 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752082AbeB1Jy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 04:54:57 -0500
X-Google-Smtp-Source: AH8x227MOEjHLSj8tC/8rX5a/2lO37dl2ub4/Ztok3vn8rllrHd7fktYx6ZX8MEvsNBQHwF2qzrY4w==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: jwi@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH] net: iucv: Free memory obtained by kzalloc
Date: Wed, 28 Feb 2018 15:24:16 +0530
Message-Id: <6fbfc0b8aa75852c4eed4d05e4c165a493304ced.1519811528.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free memory, if afiucv_iucv_init is not successful and
removing a IUCV driver.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 net/iucv/af_iucv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 1e8cc7b..eb0995a 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -2433,9 +2433,11 @@ static int afiucv_iucv_init(void)
 	af_iucv_dev->driver = &af_iucv_driver;
 	err = device_register(af_iucv_dev);
 	if (err)
-		goto out_driver;
+		goto out_iucv_dev;
 	return 0;
 
+out_iucv_dev:
+	kfree(af_iucv_dev);
 out_driver:
 	driver_unregister(&af_iucv_driver);
 out_iucv:
@@ -2496,6 +2498,7 @@ static void __exit afiucv_exit(void)
 {
 	if (pr_iucv) {
 		device_unregister(af_iucv_dev);
+		kfree(af_iucv_dev);
 		driver_unregister(&af_iucv_driver);
 		pr_iucv->iucv_unregister(&af_iucv_handler, 0);
 		symbol_put(iucv_if);
-- 
1.9.1
