Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966030AbeCAF0g (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 00:26:36 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:55019 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965953AbeCAF0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 00:26:34 -0500
X-Google-Smtp-Source: AG47ELs+MffQtFASV+aZOxXTBtY64FOHozlj8+s7z38SRPwjPFKd5VXHpGLm1ASDhmVVkkEInkVVMg==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: jwi@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v2] net: iucv: Free memory obtained by kzalloc
Date: Thu,  1 Mar 2018 10:55:52 +0530
Message-Id: <1519881952-6663-1-git-send-email-arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free memory, if afiucv_iucv_init is not successful. So calling
put_device() before kfree(). This will decrement the last reference.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2:
             Calling put_device() before kfree().

 net/iucv/af_iucv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 1e8cc7b..a07943f 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -2433,9 +2433,12 @@ static int afiucv_iucv_init(void)
 	af_iucv_dev->driver = &af_iucv_driver;
 	err = device_register(af_iucv_dev);
 	if (err)
-		goto out_driver;
+		goto out_iucv_dev;
 	return 0;
 
+out_iucv_dev:
+	put_device(af_iucv_dev);
+	kfree(af_iucv_dev);
 out_driver:
 	driver_unregister(&af_iucv_driver);
 out_iucv:
-- 
1.9.1
