Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeBAI5k (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 03:57:40 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42647 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751509AbeBAI5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 03:57:31 -0500
X-Google-Smtp-Source: AH8x226SzA5W1Q+OFz87rd/pLxKuEGuhpzuUpWL4d+R+YMhBEVwGex07PoaueLaY+T8SLhLR2924MQ==
From: Oleksandr Andrushchenko <andr2000@gmail.com>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc: jgross@suse.com, david.vrabel@citrix.com, boris.ostrovsky@oracle.com,
        otubo@redhat.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH] xen: fix frontend driver disconnected from xenbus on removal
Date: Thu,  1 Feb 2018 10:57:19 +0200
Message-Id: <1517475439-10541-2-git-send-email-andr2000@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517475439-10541-1-git-send-email-andr2000@gmail.com>
References: <1517475439-10541-1-git-send-email-andr2000@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Current xenbus frontend driver removal flow first disconnects
the driver from xenbus and then calls driver's remove callback.
This makes it impossible for the driver to listen to backend's
state changes and synchronize the removal procedure.

Fix this by removing other end XenBus watches after the
driver's remove callback is called.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/xen/xenbus/xenbus_probe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 74888cacd0b0..9c63cd3f416b 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -258,11 +258,11 @@ int xenbus_dev_remove(struct device *_dev)
 
 	DPRINTK("%s", dev->nodename);
 
-	free_otherend_watch(dev);
-
 	if (drv->remove)
 		drv->remove(dev);
 
+	free_otherend_watch(dev);
+
 	free_otherend_details(dev);
 
 	xenbus_switch_state(dev, XenbusStateClosed);
-- 
2.7.4
