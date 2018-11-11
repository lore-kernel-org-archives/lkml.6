Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570E8C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257D72080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257D72080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731601AbeKLF5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:57:25 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52220 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730938AbeKLF5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:57:25 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsy-0000lG-5t; Sun, 11 Nov 2018 19:59:08 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsT-0001cl-Tp; Sun, 11 Nov 2018 19:58:37 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Sven Eckelmann" <sven@narfation.org>,
        "Simon Wunderlich" <sw@simonwunderlich.de>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.885508560@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 188/366] batman-adv: Fix debugfs path for renamed softif
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

commit 6da7be7d24b2921f8215473ba7552796dff05fe1 upstream.

batman-adv is creating special debugfs directories in the init
net_namespace for each created soft-interface (batadv net_device). But it
is possible to rename a net_device to a completely different name then the
original one.

It can therefore happen that a user registers a new batadv net_device with
the name "bat0". batman-adv is then also adding a new directory under
$debugfs/batman-adv/ with the name "wlan0".

The user then decides to rename this device to "bat1" and registers a
different batadv device with the name "bat0". batman-adv will then try to
create a directory with the name "bat0" under $debugfs/batman-adv/ again.
But there already exists one with this name under this path and thus this
fails. batman-adv will detect a problem and rollback the registering of
this device.

batman-adv must therefore take care of renaming the debugfs directories for
soft-interfaces whenever it detects such a net_device rename.

Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/batman-adv/debugfs.c        | 20 +++++++++++++++++++
 net/batman-adv/debugfs.h        |  5 +++++
 net/batman-adv/hard-interface.c | 34 +++++++++++++++++++++++++++------
 3 files changed, 53 insertions(+), 6 deletions(-)

--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -560,6 +560,26 @@ out:
 	return -ENOMEM;
 }
 
+/**
+ * batadv_debugfs_rename_meshif() - Fix debugfs path for renamed softif
+ * @dev: net_device which was renamed
+ */
+void batadv_debugfs_rename_meshif(struct net_device *dev)
+{
+	struct batadv_priv *bat_priv = netdev_priv(dev);
+	const char *name = dev->name;
+	struct dentry *dir;
+	struct dentry *d;
+
+	dir = bat_priv->debug_dir;
+	if (!dir)
+		return;
+
+	d = debugfs_rename(dir->d_parent, dir, dir->d_parent, name);
+	if (!d)
+		pr_err("Can't rename debugfs dir to %s\n", name);
+}
+
 void batadv_debugfs_del_meshif(struct net_device *dev)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
--- a/net/batman-adv/debugfs.h
+++ b/net/batman-adv/debugfs.h
@@ -25,6 +25,7 @@
 void batadv_debugfs_init(void);
 void batadv_debugfs_destroy(void);
 int batadv_debugfs_add_meshif(struct net_device *dev);
+void batadv_debugfs_rename_meshif(struct net_device *dev);
 void batadv_debugfs_del_meshif(struct net_device *dev);
 int batadv_debugfs_add_hardif(struct batadv_hard_iface *hard_iface);
 void batadv_debugfs_rename_hardif(struct batadv_hard_iface *hard_iface);
@@ -45,6 +46,10 @@ static inline int batadv_debugfs_add_mes
 	return 0;
 }
 
+static inline void batadv_debugfs_rename_meshif(struct net_device *dev)
+{
+}
+
 static inline void batadv_debugfs_del_meshif(struct net_device *dev)
 {
 }
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -640,6 +640,32 @@ void batadv_hardif_remove_interfaces(voi
 	rtnl_unlock();
 }
 
+/**
+ * batadv_hard_if_event_softif() - Handle events for soft interfaces
+ * @event: NETDEV_* event to handle
+ * @net_dev: net_device which generated an event
+ *
+ * Return: NOTIFY_* result
+ */
+static int batadv_hard_if_event_softif(unsigned long event,
+				       struct net_device *net_dev)
+{
+	struct batadv_priv *bat_priv;
+
+	switch (event) {
+	case NETDEV_REGISTER:
+		batadv_sysfs_add_meshif(net_dev);
+		bat_priv = netdev_priv(net_dev);
+		batadv_softif_create_vlan(bat_priv, BATADV_NO_FLAGS);
+		break;
+	case NETDEV_CHANGENAME:
+		batadv_debugfs_rename_meshif(net_dev);
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
 static int batadv_hard_if_event(struct notifier_block *this,
 				unsigned long event, void *ptr)
 {
@@ -648,12 +674,8 @@ static int batadv_hard_if_event(struct n
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_priv *bat_priv;
 
-	if (batadv_softif_is_valid(net_dev) && event == NETDEV_REGISTER) {
-		batadv_sysfs_add_meshif(net_dev);
-		bat_priv = netdev_priv(net_dev);
-		batadv_softif_create_vlan(bat_priv, BATADV_NO_FLAGS);
-		return NOTIFY_DONE;
-	}
+	if (batadv_softif_is_valid(net_dev))
+		return batadv_hard_if_event_softif(event, net_dev);
 
 	hard_iface = batadv_hardif_get_by_netdev(net_dev);
 	if (!hard_iface && event == NETDEV_REGISTER)

