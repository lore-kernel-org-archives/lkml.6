Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F7FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0794B2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0794B2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733230AbeHWMSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:18:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51016 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732502AbeHWMSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:18:04 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B7AB0C74;
        Thu, 23 Aug 2018 08:49:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Soros <sorosj@gmail.com>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 097/324] batman-adv: Fix debugfs path for renamed hardif
Date:   Thu, 23 Aug 2018 09:52:43 +0200
Message-Id: <20180823075000.710460770@linuxfoundation.org>
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

[ Upstream commit 36dc621ceca1be3ec885aeade5fdafbbcc452a6d ]

batman-adv is creating special debugfs directories in the init
net_namespace for each valid hard-interface (net_device). But it is
possible to rename a net_device to a completely different name then the
original one.

It can therefore happen that a user registers a new net_device which gets
the name "wlan0" assigned by default. batman-adv is also adding a new
directory under $debugfs/batman-adv/ with the name "wlan0".

The user then decides to rename this device to "wl_pri" and registers a
different device. The kernel may now decide to use the name "wlan0" again
for this new device. batman-adv will detect it as a valid net_device and
tries to create a directory with the name "wlan0" under
$debugfs/batman-adv/. But there already exists one with this name under
this path and thus this fails. batman-adv will detect a problem and
rollback the registering of this device.

batman-adv must therefore take care of renaming the debugfs directories
for hard-interfaces whenever it detects such a net_device rename.

Fixes: 5bc7c1eb44f2 ("batman-adv: add debugfs structure for information per interface")
Reported-by: John Soros <sorosj@gmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/debugfs.c        |   20 ++++++++++++++++++++
 net/batman-adv/debugfs.h        |    6 ++++++
 net/batman-adv/hard-interface.c |    3 +++
 3 files changed, 29 insertions(+)

--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -19,6 +19,7 @@
 #include "debugfs.h"
 #include "main.h"
 
+#include <linux/dcache.h>
 #include <linux/debugfs.h>
 #include <linux/err.h>
 #include <linux/errno.h>
@@ -344,6 +345,25 @@ out:
 }
 
 /**
+ * batadv_debugfs_rename_hardif() - Fix debugfs path for renamed hardif
+ * @hard_iface: hard interface which was renamed
+ */
+void batadv_debugfs_rename_hardif(struct batadv_hard_iface *hard_iface)
+{
+	const char *name = hard_iface->net_dev->name;
+	struct dentry *dir;
+	struct dentry *d;
+
+	dir = hard_iface->debug_dir;
+	if (!dir)
+		return;
+
+	d = debugfs_rename(dir->d_parent, dir, dir->d_parent, name);
+	if (!d)
+		pr_err("Can't rename debugfs dir to %s\n", name);
+}
+
+/**
  * batadv_debugfs_del_hardif() - delete the base directory for a hard interface
  *  in debugfs.
  * @hard_iface: hard interface which is deleted.
--- a/net/batman-adv/debugfs.h
+++ b/net/batman-adv/debugfs.h
@@ -32,6 +32,7 @@ void batadv_debugfs_destroy(void);
 int batadv_debugfs_add_meshif(struct net_device *dev);
 void batadv_debugfs_del_meshif(struct net_device *dev);
 int batadv_debugfs_add_hardif(struct batadv_hard_iface *hard_iface);
+void batadv_debugfs_rename_hardif(struct batadv_hard_iface *hard_iface);
 void batadv_debugfs_del_hardif(struct batadv_hard_iface *hard_iface);
 
 #else
@@ -60,6 +61,11 @@ int batadv_debugfs_add_hardif(struct bat
 }
 
 static inline
+void batadv_debugfs_rename_hardif(struct batadv_hard_iface *hard_iface)
+{
+}
+
+static inline
 void batadv_debugfs_del_hardif(struct batadv_hard_iface *hard_iface)
 {
 }
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -1051,6 +1051,9 @@ static int batadv_hard_if_event(struct n
 		if (batadv_is_wifi_hardif(hard_iface))
 			hard_iface->num_bcasts = BATADV_NUM_BCASTS_WIRELESS;
 		break;
+	case NETDEV_CHANGENAME:
+		batadv_debugfs_rename_hardif(hard_iface);
+		break;
 	default:
 		break;
 	}


