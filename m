Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753300AbeCFKBw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 05:01:52 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:39866 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbeCFKBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 05:01:51 -0500
X-Google-Smtp-Source: AG47ELuV0Di0juXdWnrki+MaN3iduVd432ec2Ex5VDT1xY/vprG4Fo7IosLbE/PkYR62s+7usGouLQ==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: tj@kernel.org, jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] workqueue: use put_device() instead of kfee()
Date: Tue,  6 Mar 2018 15:31:03 +0530
Message-Id: <6ea392ae58fb06df5c1548ae804bb4d842dbd049.1520330391.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Never directly free @dev after calling device_register(), even
if it returned an error! Always use put_device() to give up the
reference initialized in this function instead.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
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
