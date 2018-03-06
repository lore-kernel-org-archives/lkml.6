Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932543AbeCFKL0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 05:11:26 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:40351 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753075AbeCFKLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 05:11:24 -0500
X-Google-Smtp-Source: AG47ELsSHaOX4xvCGWwBMP8oWlPUvAQK563No56Zm8eSG51vzVezlB3YoGFDv2yFAXfvfPttylMuMw==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: boris.ostrovsky@oracle.com, jgross@suse.com
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH] xen: xenbus: use put_device() instead of kfree()
Date: Tue,  6 Mar 2018 15:40:37 +0530
Message-Id: <46ec1b05b5643fd6c52ada8c6d8e4a9f1c3f1da8.1520330916.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Never directly free @dev after calling device_register(), even
if it returned an error! Always use put_device() to give up the
reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/xen/xenbus/xenbus_probe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 74888ca..ec9eb4f 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -466,8 +466,11 @@ int xenbus_probe_node(struct xen_bus_type *bus,
 
 	/* Register with generic device framework. */
 	err = device_register(&xendev->dev);
-	if (err)
+	if (err) {
+		put_device(&xendev->dev);
+		xendev = NULL;
 		goto fail;
+	}
 
 	return 0;
 fail:
-- 
1.9.1
