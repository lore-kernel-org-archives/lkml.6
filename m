Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287A9C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC19F2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC19F2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbeIGRCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:02:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:50526 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727679AbeIGRCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:02:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E1C44AD24;
        Fri,  7 Sep 2018 12:21:32 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        netdev@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, davem@davemloft.net,
        Juergen Gross <jgross@suse.com>, stable@vger.kernel.org
Subject: [PATCH] xen/netfront: fix waiting for xenbus state change
Date:   Fri,  7 Sep 2018 14:21:30 +0200
Message-Id: <20180907122130.30810-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 822fb18a82aba ("xen-netfront: wait xenbus state change when load
module manually") added a new wait queue to wait on for a state change
when the module is loaded manually. Unfortunately there is no wakeup
anywhere to stop that waiting.

Instead of introducing a new wait queue rename the existing
module_unload_q to module_wq and use it for both purposes (loading and
unloading).

As any state change of the backend might be intended to stop waiting
do the wake_up_all() in any case when netback_changed() is called.

Fixes: 822fb18a82aba ("xen-netfront: wait xenbus state change when load module manually")
Cc: <stable@vger.kernel.org> #4.18
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/net/xen-netfront.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 73f596a90c69..9407acbd19a9 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -87,8 +87,7 @@ struct netfront_cb {
 /* IRQ name is queue name with "-tx" or "-rx" appended */
 #define IRQ_NAME_SIZE (QUEUE_NAME_SIZE + 3)
 
-static DECLARE_WAIT_QUEUE_HEAD(module_load_q);
-static DECLARE_WAIT_QUEUE_HEAD(module_unload_q);
+static DECLARE_WAIT_QUEUE_HEAD(module_wq);
 
 struct netfront_stats {
 	u64			packets;
@@ -1332,11 +1331,11 @@ static struct net_device *xennet_create_dev(struct xenbus_device *dev)
 	netif_carrier_off(netdev);
 
 	xenbus_switch_state(dev, XenbusStateInitialising);
-	wait_event(module_load_q,
-			   xenbus_read_driver_state(dev->otherend) !=
-			   XenbusStateClosed &&
-			   xenbus_read_driver_state(dev->otherend) !=
-			   XenbusStateUnknown);
+	wait_event(module_wq,
+		   xenbus_read_driver_state(dev->otherend) !=
+		   XenbusStateClosed &&
+		   xenbus_read_driver_state(dev->otherend) !=
+		   XenbusStateUnknown);
 	return netdev;
 
  exit:
@@ -2010,15 +2009,14 @@ static void netback_changed(struct xenbus_device *dev,
 
 	dev_dbg(&dev->dev, "%s\n", xenbus_strstate(backend_state));
 
+	wake_up_all(&module_wq);
+
 	switch (backend_state) {
 	case XenbusStateInitialising:
 	case XenbusStateInitialised:
 	case XenbusStateReconfiguring:
 	case XenbusStateReconfigured:
-		break;
-
 	case XenbusStateUnknown:
-		wake_up_all(&module_unload_q);
 		break;
 
 	case XenbusStateInitWait:
@@ -2034,12 +2032,10 @@ static void netback_changed(struct xenbus_device *dev,
 		break;
 
 	case XenbusStateClosed:
-		wake_up_all(&module_unload_q);
 		if (dev->state == XenbusStateClosed)
 			break;
 		/* Missed the backend's CLOSING state -- fallthrough */
 	case XenbusStateClosing:
-		wake_up_all(&module_unload_q);
 		xenbus_frontend_closed(dev);
 		break;
 	}
@@ -2147,14 +2143,14 @@ static int xennet_remove(struct xenbus_device *dev)
 
 	if (xenbus_read_driver_state(dev->otherend) != XenbusStateClosed) {
 		xenbus_switch_state(dev, XenbusStateClosing);
-		wait_event(module_unload_q,
+		wait_event(module_wq,
 			   xenbus_read_driver_state(dev->otherend) ==
 			   XenbusStateClosing ||
 			   xenbus_read_driver_state(dev->otherend) ==
 			   XenbusStateUnknown);
 
 		xenbus_switch_state(dev, XenbusStateClosed);
-		wait_event(module_unload_q,
+		wait_event(module_wq,
 			   xenbus_read_driver_state(dev->otherend) ==
 			   XenbusStateClosed ||
 			   xenbus_read_driver_state(dev->otherend) ==
-- 
2.16.4

