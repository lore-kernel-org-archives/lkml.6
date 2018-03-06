Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753223AbeCFKGa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 05:06:30 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:56221 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbeCFKG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 05:06:29 -0500
X-Google-Smtp-Source: AG47ELtqWfD2MSFOwKa4otXI5YCzVDUDxScONBkVuOaXQiPLbIklczL+r12RH4SndeX8mzxcO7Ns7A==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: tj@kernel.org, jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2] workqueue: use put_device() instead of kfree()
Date: Tue,  6 Mar 2018 15:35:43 +0530
Message-Id: <1520330743-20445-1-git-send-email-arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Never directly free @dev after calling device_register(), even
if it returned an error! Always use put_device() to give up the
reference initialized in this function instead.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2:
             Spell mistek in subject line "kfee -> kfree".

 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index bb9a519..ccd1080 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5337,7 +5337,7 @@ int workqueue_sysfs_register(struct workqueue_struct *wq)
 
 	ret = device_register(&wq_dev->dev);
 	if (ret) {
-		kfree(wq_dev);
+		put_device(&wq_dev->dev);
 		wq->wq_dev = NULL;
 		return ret;
 	}
-- 
1.9.1
