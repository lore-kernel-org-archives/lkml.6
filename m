Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751774AbeCOHVr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 03:21:47 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:47005 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbeCOHVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 03:21:46 -0400
X-Google-Smtp-Source: AG47ELvriCLo9veW+ue9Bwx5z9KzJSoX3VGd+cONj+SvuFzgTtxEMGVyb3u1WBSx/8xui6LtNsfJWA==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@free-electrons.com, marek.vasut@gmail.com,
        richard@nod.at, cyrille.pitchen@wedev4u.fr, dedekind1@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH 2/2 v2] mtd: ubi: use put_device() if device_register fail
Date: Thu, 15 Mar 2018 12:50:31 +0530
Message-Id: <1521098431-29565-1-git-send-email-arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if device_register() returned an error! Always use put_device()
to give up the reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
change in v2:
        Fix use-after-free bug. move put_device() after cdev_del().

 drivers/mtd/ubi/vmt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
index 3fd8d7f..93c6163 100644
--- a/drivers/mtd/ubi/vmt.c
+++ b/drivers/mtd/ubi/vmt.c
@@ -610,6 +610,7 @@ int ubi_add_volume(struct ubi_device *ubi, struct ubi_volume *vol)
 
 out_cdev:
 	cdev_del(&vol->cdev);
+	put_device(&vol->dev);
 	return err;
 }
 
-- 
1.9.1
