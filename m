Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDEFC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC112080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC112080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbeKLF4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:56:02 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51984 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728675AbeKLF4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:56:02 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsz-0000oN-0O; Sun, 11 Nov 2018 19:59:09 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsT-0001ca-Qu; Sun, 11 Nov 2018 19:58:37 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Markus Pargmann" <mpa@pengutronix.de>,
        "Marek Lindner" <mareklindner@neomailbox.ch>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.467314376@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 186/366] batman-adv: debugfs, avoid compiling for
 !DEBUG_FS
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

From: Markus Pargmann <mpa@pengutronix.de>

commit 9bb218828c8f4fa6587af93e248903c96ce469d0 upstream.

Normally the debugfs framework will return error pointer with -ENODEV
for function calls when DEBUG_FS is not set.

batman does not notice this error code and continues trying to create
debugfs files and executes more code. We can avoid this code execution
by disabling compiling debugfs.c when DEBUG_FS is not set.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/batman-adv/Makefile  |  2 +-
 net/batman-adv/debugfs.c |  8 --------
 net/batman-adv/debugfs.h | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 9 deletions(-)

--- a/net/batman-adv/Makefile
+++ b/net/batman-adv/Makefile
@@ -20,7 +20,7 @@ obj-$(CONFIG_BATMAN_ADV) += batman-adv.o
 batman-adv-y += bat_iv_ogm.o
 batman-adv-y += bitarray.o
 batman-adv-$(CONFIG_BATMAN_ADV_BLA) += bridge_loop_avoidance.o
-batman-adv-y += debugfs.o
+batman-adv-$(CONFIG_DEBUG_FS) += debugfs.o
 batman-adv-$(CONFIG_BATMAN_ADV_DAT) += distributed-arp-table.o
 batman-adv-y += fragmentation.o
 batman-adv-y += gateway_client.o
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -482,11 +482,7 @@ rem_attr:
 	debugfs_remove_recursive(hard_iface->debug_dir);
 	hard_iface->debug_dir = NULL;
 out:
-#ifdef CONFIG_DEBUG_FS
 	return -ENOMEM;
-#else
-	return 0;
-#endif /* CONFIG_DEBUG_FS */
 }
 
 /**
@@ -541,11 +537,7 @@ rem_attr:
 	debugfs_remove_recursive(bat_priv->debug_dir);
 	bat_priv->debug_dir = NULL;
 out:
-#ifdef CONFIG_DEBUG_FS
 	return -ENOMEM;
-#else
-	return 0;
-#endif /* CONFIG_DEBUG_FS */
 }
 
 void batadv_debugfs_del_meshif(struct net_device *dev)
--- a/net/batman-adv/debugfs.h
+++ b/net/batman-adv/debugfs.h
@@ -20,6 +20,8 @@
 
 #define BATADV_DEBUGFS_SUBDIR "batman_adv"
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+
 void batadv_debugfs_init(void);
 void batadv_debugfs_destroy(void);
 int batadv_debugfs_add_meshif(struct net_device *dev);
@@ -27,4 +29,36 @@ void batadv_debugfs_del_meshif(struct ne
 int batadv_debugfs_add_hardif(struct batadv_hard_iface *hard_iface);
 void batadv_debugfs_del_hardif(struct batadv_hard_iface *hard_iface);
 
+#else
+
+static inline void batadv_debugfs_init(void)
+{
+}
+
+static inline void batadv_debugfs_destroy(void)
+{
+}
+
+static inline int batadv_debugfs_add_meshif(struct net_device *dev)
+{
+	return 0;
+}
+
+static inline void batadv_debugfs_del_meshif(struct net_device *dev)
+{
+}
+
+static inline
+int batadv_debugfs_add_hardif(struct batadv_hard_iface *hard_iface)
+{
+	return 0;
+}
+
+static inline
+void batadv_debugfs_del_hardif(struct batadv_hard_iface *hard_iface)
+{
+}
+
+#endif
+
 #endif /* _NET_BATMAN_ADV_DEBUGFS_H_ */

