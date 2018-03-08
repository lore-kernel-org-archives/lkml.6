Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965669AbeCHGYP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 01:24:15 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:37007 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965210AbeCHGYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 01:24:13 -0500
X-Google-Smtp-Source: AG47ELujlEOeTMKmB+4K1NapOA1o8WT+J+dZuJFZKaOBRAQbRwRpc/SfOFKHpHHbwAYJAru+XezkOA==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: m@bues.ch
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: [PATCH v3] ssb: use put_device() if device_register fail
Date: Thu,  8 Mar 2018 11:53:24 +0530
Message-Id: <1520490204-10411-1-git-send-email-arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Never directly free @dev after calling device_register(), even
if it returned an error! Always use put_device() to give up the
reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2:
             Removed kfree() call for @dev.
changes in v3:
             Add put_device() in place of kfree().

 drivers/ssb/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
index 65420a9..e732fd3 100644
--- a/drivers/ssb/main.c
+++ b/drivers/ssb/main.c
@@ -522,7 +522,7 @@ static int ssb_devices_register(struct ssb_bus *bus)
 			/* Set dev to NULL to not unregister
 			 * dev on error unwinding. */
 			sdev->dev = NULL;
-			kfree(devwrap);
+			put_device(dev);
 			goto error;
 		}
 		dev_idx++;
-- 
1.9.1
