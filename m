Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968998AbeE1OjV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:39:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161295AbeE1Kb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:31:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ross Lagerwall <ross.lagerwall@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 086/329] xen-netfront: Fix race between device setup and open
Date: Mon, 28 May 2018 12:00:15 +0200
Message-Id: <20180528100249.961243045@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ross Lagerwall <ross.lagerwall@citrix.com>

[ Upstream commit f599c64fdf7d9c108e8717fb04bc41c680120da4 ]

When a netfront device is set up it registers a netdev fairly early on,
before it has set up the queues and is actually usable. A userspace tool
like NetworkManager will immediately try to open it and access its state
as soon as it appears. The bug can be reproduced by hotplugging VIFs
until the VM runs out of grant refs. It registers the netdev but fails
to set up any queues (since there are no more grant refs). In the
meantime, NetworkManager opens the device and the kernel crashes trying
to access the queues (of which there are none).

Fix this in two ways:
* For initial setup, register the netdev much later, after the queues
are setup. This avoids the race entirely.
* During a suspend/resume cycle, the frontend reconnects to the backend
and the queues are recreated. It is possible (though highly unlikely) to
race with something opening the device and accessing the queues after
they have been destroyed but before they have been recreated. Extend the
region covered by the rtnl semaphore to protect against this race. There
is a possibility that we fail to recreate the queues so check for this
in the open function.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/xen-netfront.c |   46 +++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -350,6 +350,9 @@ static int xennet_open(struct net_device
 	unsigned int i = 0;
 	struct netfront_queue *queue = NULL;
 
+	if (!np->queues)
+		return -ENODEV;
+
 	for (i = 0; i < num_queues; ++i) {
 		queue = &np->queues[i];
 		napi_enable(&queue->napi);
@@ -1377,18 +1380,8 @@ static int netfront_probe(struct xenbus_
 #ifdef CONFIG_SYSFS
 	info->netdev->sysfs_groups[0] = &xennet_dev_group;
 #endif
-	err = register_netdev(info->netdev);
-	if (err) {
-		pr_warn("%s: register_netdev err=%d\n", __func__, err);
-		goto fail;
-	}
 
 	return 0;
-
- fail:
-	xennet_free_netdev(netdev);
-	dev_set_drvdata(&dev->dev, NULL);
-	return err;
 }
 
 static void xennet_end_access(int ref, void *page)
@@ -1757,8 +1750,6 @@ static void xennet_destroy_queues(struct
 {
 	unsigned int i;
 
-	rtnl_lock();
-
 	for (i = 0; i < info->netdev->real_num_tx_queues; i++) {
 		struct netfront_queue *queue = &info->queues[i];
 
@@ -1767,8 +1758,6 @@ static void xennet_destroy_queues(struct
 		netif_napi_del(&queue->napi);
 	}
 
-	rtnl_unlock();
-
 	kfree(info->queues);
 	info->queues = NULL;
 }
@@ -1784,8 +1773,6 @@ static int xennet_create_queues(struct n
 	if (!info->queues)
 		return -ENOMEM;
 
-	rtnl_lock();
-
 	for (i = 0; i < *num_queues; i++) {
 		struct netfront_queue *queue = &info->queues[i];
 
@@ -1794,7 +1781,7 @@ static int xennet_create_queues(struct n
 
 		ret = xennet_init_queue(queue);
 		if (ret < 0) {
-			dev_warn(&info->netdev->dev,
+			dev_warn(&info->xbdev->dev,
 				 "only created %d queues\n", i);
 			*num_queues = i;
 			break;
@@ -1808,10 +1795,8 @@ static int xennet_create_queues(struct n
 
 	netif_set_real_num_tx_queues(info->netdev, *num_queues);
 
-	rtnl_unlock();
-
 	if (*num_queues == 0) {
-		dev_err(&info->netdev->dev, "no queues\n");
+		dev_err(&info->xbdev->dev, "no queues\n");
 		return -EINVAL;
 	}
 	return 0;
@@ -1853,6 +1838,7 @@ static int talk_to_netback(struct xenbus
 		goto out;
 	}
 
+	rtnl_lock();
 	if (info->queues)
 		xennet_destroy_queues(info);
 
@@ -1863,6 +1849,7 @@ static int talk_to_netback(struct xenbus
 		info->queues = NULL;
 		goto out;
 	}
+	rtnl_unlock();
 
 	/* Create shared ring, alloc event channel -- for each queue */
 	for (i = 0; i < num_queues; ++i) {
@@ -1959,8 +1946,10 @@ abort_transaction_no_dev_fatal:
 	xenbus_transaction_end(xbt, 1);
  destroy_ring:
 	xennet_disconnect_backend(info);
+	rtnl_lock();
 	xennet_destroy_queues(info);
  out:
+	rtnl_unlock();
 	device_unregister(&dev->dev);
 	return err;
 }
@@ -1996,6 +1985,15 @@ static int xennet_connect(struct net_dev
 	netdev_update_features(dev);
 	rtnl_unlock();
 
+	if (dev->reg_state == NETREG_UNINITIALIZED) {
+		err = register_netdev(dev);
+		if (err) {
+			pr_warn("%s: register_netdev err=%d\n", __func__, err);
+			device_unregister(&np->xbdev->dev);
+			return err;
+		}
+	}
+
 	/*
 	 * All public and private state should now be sane.  Get
 	 * ready to start sending and receiving packets and give the driver
@@ -2186,10 +2184,14 @@ static int xennet_remove(struct xenbus_d
 
 	xennet_disconnect_backend(info);
 
-	unregister_netdev(info->netdev);
+	if (info->netdev->reg_state == NETREG_REGISTERED)
+		unregister_netdev(info->netdev);
 
-	if (info->queues)
+	if (info->queues) {
+		rtnl_lock();
 		xennet_destroy_queues(info);
+		rtnl_unlock();
+	}
 	xennet_free_netdev(info->netdev);
 
 	return 0;
