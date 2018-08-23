Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3AEC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31352086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31352086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387433AbeHWMSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:18:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51296 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbeHWMSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:18:40 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D97AABE0;
        Thu, 23 Aug 2018 08:50:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 098/324] batman-adv: Fix debugfs path for renamed softif
Date:   Thu, 23 Aug 2018 09:52:44 +0200
Message-Id: <20180823075000.767895263@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

[ Upstream commit 6da7be7d24b2921f8215473ba7552796dff05fe1 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/debugfs.c        |   20 ++++++++++++++++++++
 net/batman-adv/debugfs.h        |    5 +++++
 net/batman-adv/hard-interface.c |   34 ++++++++++++++++++++++++++++------
 3 files changed, 53 insertions(+), 6 deletions(-)

--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -434,6 +434,26 @@ out:
 }
 
 /**
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
+/**
  * batadv_debugfs_del_meshif() - Remove interface dependent debugfs entries
  * @dev: netdev struct of the soft interface
  */
--- a/net/batman-adv/debugfs.h
+++ b/net/batman-adv/debugfs.h
@@ -30,6 +30,7 @@ struct net_device;
 void batadv_debugfs_init(void);
 void batadv_debugfs_destroy(void);
 int batadv_debugfs_add_meshif(struct net_device *dev);
+void batadv_debugfs_rename_meshif(struct net_device *dev);
 void batadv_debugfs_del_meshif(struct net_device *dev);
 int batadv_debugfs_add_hardif(struct batadv_hard_iface *hard_iface);
 void batadv_debugfs_rename_hardif(struct batadv_hard_iface *hard_iface);
@@ -50,6 +51,10 @@ static inline int batadv_debugfs_add_mes
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
@@ -989,6 +989,32 @@ void batadv_hardif_remove_interfaces(voi
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
@@ -997,12 +1023,8 @@ static int batadv_hard_if_event(struct n
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
 	if (!hard_iface && (event == NETDEV_REGISTER ||


