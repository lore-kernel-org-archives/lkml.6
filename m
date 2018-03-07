Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754384AbeCGLiZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 06:38:25 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:43980 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751171AbeCGLiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 06:38:24 -0500
X-Google-Smtp-Source: AG47ELsj6+r793NCOl9G6Crk1dOUYXAxpB6J32y5fUoRqjrR2yh91WWVVIl3A7X5QDAWhOqnBj7rnA==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: lduncan@suse.com, cleech@redhat.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc: linux-kernel@vger.kernel.org, open-iscsi@googlegroups.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: scsi_transport_iscsi: use put_device() instead of kfree()
Date: Wed,  7 Mar 2018 17:07:33 +0530
Message-Id: <a77739e256b044c2e125e106165efc751ce4a0f6.1520422535.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Never directly free @dev after calling device_register(), even
if it returned an error! Always use put_device() to give up the
reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/scsi/scsi_transport_iscsi.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index f4b52b4..aacb7ab 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -221,8 +221,10 @@ struct iscsi_endpoint *
 	ep->dev.class = &iscsi_endpoint_class;
 	dev_set_name(&ep->dev, "ep-%llu", (unsigned long long) id);
 	err = device_register(&ep->dev);
-        if (err)
-                goto free_ep;
+	if (err) {
+		put_device(&ep->dev);
+		return NULL;
+	}
 
 	err = sysfs_create_group(&ep->dev.kobj, &iscsi_endpoint_group);
 	if (err)
@@ -235,10 +237,6 @@ struct iscsi_endpoint *
 unregister_dev:
 	device_unregister(&ep->dev);
 	return NULL;
-
-free_ep:
-	kfree(ep);
-	return NULL;
 }
 EXPORT_SYMBOL_GPL(iscsi_create_endpoint);
 
@@ -783,7 +781,7 @@ struct iscsi_iface *
 
 free_iface:
 	put_device(iface->dev.parent);
-	kfree(iface);
+	put_device(&iface->dev);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(iscsi_create_iface);
@@ -1260,7 +1258,7 @@ struct iscsi_bus_flash_session *
 	return fnode_sess;
 
 free_fnode_sess:
-	kfree(fnode_sess);
+	put_device(&fnode_sess->dev);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(iscsi_create_flashnode_sess);
@@ -1308,7 +1306,7 @@ struct iscsi_bus_flash_conn *
 	return fnode_conn;
 
 free_fnode_conn:
-	kfree(fnode_conn);
+	put_device(&fnode_conn->dev);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(iscsi_create_flashnode_conn);
@@ -2268,6 +2266,8 @@ struct iscsi_cls_conn *
 
 release_parent_ref:
 	put_device(&session->dev);
+	put_device(&conn->dev);
+	conn = NULL;
 free_conn:
 	kfree(conn);
 	return NULL;
@@ -4420,8 +4420,10 @@ struct scsi_transport_template *
 	priv->dev.class = &iscsi_transport_class;
 	dev_set_name(&priv->dev, "%s", tt->name);
 	err = device_register(&priv->dev);
-	if (err)
-		goto free_priv;
+	if (err) {
+		put_device(&priv->dev);
+		return NULL;
+	}
 
 	err = sysfs_create_group(&priv->dev.kobj, &iscsi_transport_group);
 	if (err)
@@ -4456,9 +4458,6 @@ struct scsi_transport_template *
 unregister_dev:
 	device_unregister(&priv->dev);
 	return NULL;
-free_priv:
-	kfree(priv);
-	return NULL;
 }
 EXPORT_SYMBOL_GPL(iscsi_register_transport);
 
-- 
1.9.1
