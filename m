Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752516AbeB1MYH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 07:24:07 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39480 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752219AbeB1MYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 07:24:05 -0500
X-Google-Smtp-Source: AG47ELtqqSGRR6DTMIN8nULQ4e9tOk+2tt96LEi9Pc9FgIhSch9HY1ehibQ9JP7RmKKShwCADFYDGA==
From: Jason Andryuk <jandryuk@gmail.com>
To: xen-devel@lists.xenproject.org, netdev@vger.kernel.org
Cc: Jason Andryuk <jandryuk@gmail.com>, Eduardo Otubo <otubo@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] xen-netfront: Fix hang on device removal
Date: Wed, 28 Feb 2018 07:23:23 -0500
Message-Id: <20180228122323.3914-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A toolstack may delete the vif frontend and backend xenstore entries
while xen-netfront is in the removal code path.  In that case, the
checks for xenbus_read_driver_state would return XenbusStateUnknown, and
xennet_remove would hang indefinitely.  This hang prevents system
shutdown.

xennet_remove must be able to handle XenbusStateUnknown, and
netback_changed must also wake up the wake_queue for that state as well.

Fixes: 5b5971df3bc2 ("xen-netfront: remove warning when unloading module")

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
Cc: Eduardo Otubo <otubo@redhat.com>
---
 drivers/net/xen-netfront.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 8328d395e332..3127bc8633ca 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -2005,7 +2005,10 @@ static void netback_changed(struct xenbus_device *dev,
 	case XenbusStateInitialised:
 	case XenbusStateReconfiguring:
 	case XenbusStateReconfigured:
+		break;
+
 	case XenbusStateUnknown:
+		wake_up_all(&module_unload_q);
 		break;
 
 	case XenbusStateInitWait:
@@ -2136,7 +2139,9 @@ static int xennet_remove(struct xenbus_device *dev)
 		xenbus_switch_state(dev, XenbusStateClosing);
 		wait_event(module_unload_q,
 			   xenbus_read_driver_state(dev->otherend) ==
-			   XenbusStateClosing);
+			   XenbusStateClosing ||
+			   xenbus_read_driver_state(dev->otherend) ==
+			   XenbusStateUnknown);
 
 		xenbus_switch_state(dev, XenbusStateClosed);
 		wait_event(module_unload_q,
-- 
2.14.3
