Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C26BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A46F2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A46F2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731535AbeKLF5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:57:10 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52180 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731517AbeKLF5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:57:09 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsy-0000lM-VG; Sun, 11 Nov 2018 19:59:09 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsT-0001cf-SL; Sun, 11 Nov 2018 19:58:37 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Sven Eckelmann" <sven@narfation.org>,
        "John Soros" <sorosj@gmail.com>,
        "Simon Wunderlich" <sw@simonwunderlich.de>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.80978181@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 187/366] batman-adv: Fix debugfs path for renamed hardif
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

commit 36dc621ceca1be3ec885aeade5fdafbbcc452a6d upstream.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/batman-adv/debugfs.c        | 20 ++++++++++++++++++++
 net/batman-adv/debugfs.h        |  6 ++++++
 net/batman-adv/hard-interface.c |  3 +++
 3 files changed, 29 insertions(+)

--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -17,6 +17,7 @@
 
 #include "main.h"
 
+#include <linux/dcache.h>
 #include <linux/debugfs.h>
 
 #include "debugfs.h"
@@ -486,6 +487,25 @@ out:
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
  * batadv_debugfs_del_hardif - delete the base directory for a hard interface
  *  in debugfs.
  * @hard_iface: hard interface which is deleted.
--- a/net/batman-adv/debugfs.h
+++ b/net/batman-adv/debugfs.h
@@ -27,6 +27,7 @@ void batadv_debugfs_destroy(void);
 int batadv_debugfs_add_meshif(struct net_device *dev);
 void batadv_debugfs_del_meshif(struct net_device *dev);
 int batadv_debugfs_add_hardif(struct batadv_hard_iface *hard_iface);
+void batadv_debugfs_rename_hardif(struct batadv_hard_iface *hard_iface);
 void batadv_debugfs_del_hardif(struct batadv_hard_iface *hard_iface);
 
 #else
@@ -55,6 +56,11 @@ int batadv_debugfs_add_hardif(struct bat
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
@@ -695,6 +695,9 @@ static int batadv_hard_if_event(struct n
 		if (hard_iface == primary_if)
 			batadv_primary_if_update_addr(bat_priv, NULL);
 		break;
+	case NETDEV_CHANGENAME:
+		batadv_debugfs_rename_hardif(hard_iface);
+		break;
 	default:
 		break;
 	}

