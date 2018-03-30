Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeC3LoT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 07:44:19 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42028 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751941AbeC3LoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 07:44:16 -0400
X-Google-Smtp-Source: AIpwx4/v9LGLpD0//+qet0wmaIKQMm95aIpCib5D3MTOcGRQM+qZTURc7mVti9d9wF9oX9Fy80D9WQ==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH] PM / devfreq: use put_device() instead of kfree()
Date: Fri, 30 Mar 2018 17:14:03 +0530
Message-Id: <d8d8708d2283349c2c4f3e9f3c9fd5f47126d2bc.1522410143.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Never directly free @dev after calling device_register() or
device_unregister(), even if device_register() returned an error.
Always use put_device() to give up the reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/devfreq/devfreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index fe2af6a..a225b94 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -625,7 +625,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	err = device_register(&devfreq->dev);
 	if (err) {
 		mutex_unlock(&devfreq->lock);
-		goto err_dev;
+		put_device(&devfreq->dev);
+		goto err_out;
 	}
 
 	devfreq->trans_table =	devm_kzalloc(&devfreq->dev,
@@ -671,6 +672,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	mutex_unlock(&devfreq_list_lock);
 
 	device_unregister(&devfreq->dev);
+	devfreq = NULL;
 err_dev:
 	if (devfreq)
 		kfree(devfreq);
-- 
2.7.4
