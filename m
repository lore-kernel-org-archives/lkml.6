Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030260AbeCALcl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 06:32:41 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:36718 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967708AbeCALci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 06:32:38 -0500
X-Google-Smtp-Source: AG47ELtt+FXJmnCf37OTGf5upyPV0FpdSnmA8tsvHPlo7n0gXdj7V45yaE0SdMR0IbXLtNJe9DTYrg==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: jwi@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v3] net: iucv: Free memory obtained by kzalloc
Date: Thu,  1 Mar 2018 17:01:57 +0530
Message-Id: <1519903917-11575-1-git-send-email-arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free memory by calling put_device(), if afiucv_iucv_init is not
successful.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2:
             Calling put_device() before kfree().
changes in v3:
             No need to call kfree(). So removed kfree().

 net/iucv/af_iucv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 1e8cc7b..9e2643a 100644
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
+	put_device(af_iucv_dev);
 out_driver:
 	driver_unregister(&af_iucv_driver);
 out_iucv:
-- 
1.9.1
