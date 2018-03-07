Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754362AbeCGLEP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 06:04:15 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:34095 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754330AbeCGLEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 06:04:09 -0500
X-Google-Smtp-Source: AG47ELvrUrx61DAEF1mC6C76cvrFtL9dFUTaJl4Nh8np8Pq0oo+xsLtsssRRW0+vOxh0+z5//Q9GdQ==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: ysato@users.sourceforge.jp, dalias@libc.org
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Subject: [PATCH 2/2] sh: superhyway: use put_device() if device_register fail
Date: Wed,  7 Mar 2018 16:33:14 +0530
Message-Id: <ea06f4581b63ebdbb7c9e8739780181f53a9c774.1520420267.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1520420267.git.arvind.yadav.cs@gmail.com>
References: <cover.1520420267.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <cover.1520420267.git.arvind.yadav.cs@gmail.com>
References: <cover.1520420267.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if device_register() returned an error! Always use put_device()
to give up the reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/sh/superhyway/superhyway.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/sh/superhyway/superhyway.c b/drivers/sh/superhyway/superhyway.c
index 348836b..98922e7 100644
--- a/drivers/sh/superhyway/superhyway.c
+++ b/drivers/sh/superhyway/superhyway.c
@@ -54,6 +54,7 @@ int superhyway_add_device(unsigned long base, struct superhyway_device *sdev,
 			  struct superhyway_bus *bus)
 {
 	struct superhyway_device *dev = sdev;
+	int ret;
 
 	if (!dev) {
 		dev = kzalloc(sizeof(struct superhyway_device), GFP_KERNEL);
@@ -87,7 +88,11 @@ int superhyway_add_device(unsigned long base, struct superhyway_device *sdev,
 
 	superhyway_devices++;
 
-	return device_register(&dev->dev);
+	ret = device_register(&dev->dev);
+	if (ret)
+		put_device(&dev->dev);
+
+	return ret;
 }
 
 int superhyway_add_devices(struct superhyway_bus *bus,
@@ -110,8 +115,10 @@ static int __init superhyway_init(void)
 	int ret;
 
 	ret = device_register(&superhyway_bus_device);
-	if (unlikely(ret))
+	if (unlikely(ret)) {
+		put_device(&superhyway_bus_device);
 		return ret;
+	}
 
 	for (bus = superhyway_channels; bus->ops; bus++)
 		ret |= superhyway_scan_bus(bus);
-- 
1.9.1
