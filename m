Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752346AbeCRHi4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 03:38:56 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40957 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750943AbeCRHiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 03:38:54 -0400
X-Google-Smtp-Source: AG47ELu1ml1x7L8Kl67i3Jhvxmmod0aWFlVBlkyxxPNVOKyQ1EJmp6XWZ2W1UQ89i3lD4YCIX+h9LA==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: mathieu.poirier@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] coresight: use put_device() instead of kfree()
Date: Sun, 18 Mar 2018 13:08:42 +0530
Message-Id: <d5a326b6c284f7389301b265716dc58fda492c98.1521358552.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Never directly free @dev after calling device_register(), even
if it returned an error. Always use put_device() to give up the
reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/hwtracing/coresight/coresight.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 389c4ba..132dfbc 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -1026,8 +1026,10 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	dev_set_name(&csdev->dev, "%s", desc->pdata->name);
 
 	ret = device_register(&csdev->dev);
-	if (ret)
-		goto err_device_register;
+	if (ret) {
+		put_device(&csdev->dev);
+		goto err_kzalloc_csdev;
+	}
 
 	mutex_lock(&coresight_mutex);
 
@@ -1038,8 +1040,6 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 
 	return csdev;
 
-err_device_register:
-	kfree(conns);
 err_kzalloc_conns:
 	kfree(refcnts);
 err_kzalloc_refcnts:
-- 
2.7.4
