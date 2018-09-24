Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2ED9C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F0020877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F0020877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbeIXSEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:04:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53692 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbeIXSEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:04:04 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 274B9D64;
        Mon, 24 Sep 2018 12:02:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 049/111] xen/netfront: fix waiting for xenbus state change
Date:   Mon, 24 Sep 2018 13:52:16 +0200
Message-Id: <20180924113109.907189618@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.337261320@linuxfoundation.org>
References: <20180924113103.337261320@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

commit 8edfe2e992b75aee3da9316e9697c531194c2f53 upstream.

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
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/xen-netfront.c |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -86,8 +86,7 @@ struct netfront_cb {
 /* IRQ name is queue name with "-tx" or "-rx" appended */
 #define IRQ_NAME_SIZE (QUEUE_NAME_SIZE + 3)
 
-static DECLARE_WAIT_QUEUE_HEAD(module_load_q);
-static DECLARE_WAIT_QUEUE_HEAD(module_unload_q);
+static DECLARE_WAIT_QUEUE_HEAD(module_wq);
 
 struct netfront_stats {
 	u64			packets;
@@ -1350,11 +1349,11 @@ static struct net_device *xennet_create_
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
@@ -2039,15 +2038,14 @@ static void netback_changed(struct xenbu
 
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
@@ -2063,12 +2061,10 @@ static void netback_changed(struct xenbu
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
@@ -2176,14 +2172,14 @@ static int xennet_remove(struct xenbus_d
 
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


