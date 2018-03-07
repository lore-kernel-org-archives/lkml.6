Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754400AbeCGLE2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 06:04:28 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:53366 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbeCGLEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 06:04:06 -0500
X-Google-Smtp-Source: AG47ELuNYBCTz0BAXd8ZMCOym/c9bKqbZM5tHhle87sg3tzgCDbyVT4b0/JJbHqEZAtIrEAAijuqkg==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: ysato@users.sourceforge.jp, dalias@libc.org
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Subject: [PATCH 1/2] sh: maple: use put_device() instead of kfree()
Date: Wed,  7 Mar 2018 16:33:13 +0530
Message-Id: <ca808c5980d1ceaab59b5798e46e994a9c150b24.1520420267.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1520420267.git.arvind.yadav.cs@gmail.com>
References: <cover.1520420267.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <cover.1520420267.git.arvind.yadav.cs@gmail.com>
References: <cover.1520420267.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Never directly free @dev after calling device_register(), even
if it returned an error! Always use put_device() to give up the
reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/sh/maple/maple.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
index 7525039..28674fe 100644
--- a/drivers/sh/maple/maple.c
+++ b/drivers/sh/maple/maple.c
@@ -393,7 +393,7 @@ static void maple_attach_driver(struct maple_device *mdev)
 		dev_warn(&mdev->dev, "could not register device at"
 			" (%d, %d), with error 0x%X\n", mdev->unit,
 			mdev->port, error);
-		maple_free_dev(mdev);
+		put_device(&mdev->dev);
 		mdev = NULL;
 		return;
 	}
@@ -886,6 +886,7 @@ static int __init maple_bus_init(void)
 
 cleanup:
 	printk(KERN_ERR "Maple bus registration failed\n");
+	put_device(&maple_bus);
 	return retval;
 }
 /* Push init to later to ensure hardware gets detected */
-- 
1.9.1
