Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E978C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57E220869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D57E220869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbeKLG1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:27:09 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49672 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730062AbeKLFsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:10 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsV-0000oG-I7; Sun, 11 Nov 2018 19:58:39 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsT-0001bS-BF; Sun, 11 Nov 2018 19:58:37 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Ross Lagerwall" <ross.lagerwall@citrix.com>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Juergen Gross" <jgross@suse.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.604401477@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 172/366] xen-netfront: Fix race between device setup
 and open
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

From: Ross Lagerwall <ross.lagerwall@citrix.com>

commit f599c64fdf7d9c108e8717fb04bc41c680120da4 upstream.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/xen-netfront.c | 46 ++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -369,6 +369,9 @@ static int xennet_open(struct net_device
 	unsigned int i = 0;
 	struct netfront_queue *queue = NULL;
 
+	if (!np->queues)
+		return -ENODEV;
+
 	for (i = 0; i < num_queues; ++i) {
 		queue = &np->queues[i];
 		napi_enable(&queue->napi);
@@ -1394,18 +1397,8 @@ static int netfront_probe(struct xenbus_
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
@@ -1779,8 +1772,6 @@ static void xennet_destroy_queues(struct
 {
 	unsigned int i;
 
-	rtnl_lock();
-
 	for (i = 0; i < info->netdev->real_num_tx_queues; i++) {
 		struct netfront_queue *queue = &info->queues[i];
 
@@ -1789,8 +1780,6 @@ static void xennet_destroy_queues(struct
 		netif_napi_del(&queue->napi);
 	}
 
-	rtnl_unlock();
-
 	kfree(info->queues);
 	info->queues = NULL;
 }
@@ -1806,8 +1795,6 @@ static int xennet_create_queues(struct n
 	if (!info->queues)
 		return -ENOMEM;
 
-	rtnl_lock();
-
 	for (i = 0; i < *num_queues; i++) {
 		struct netfront_queue *queue = &info->queues[i];
 
@@ -1816,7 +1803,7 @@ static int xennet_create_queues(struct n
 
 		ret = xennet_init_queue(queue);
 		if (ret < 0) {
-			dev_warn(&info->netdev->dev,
+			dev_warn(&info->xbdev->dev,
 				 "only created %d queues\n", i);
 			*num_queues = i;
 			break;
@@ -1830,10 +1817,8 @@ static int xennet_create_queues(struct n
 
 	netif_set_real_num_tx_queues(info->netdev, *num_queues);
 
-	rtnl_unlock();
-
 	if (*num_queues == 0) {
-		dev_err(&info->netdev->dev, "no queues\n");
+		dev_err(&info->xbdev->dev, "no queues\n");
 		return -EINVAL;
 	}
 	return 0;
@@ -1875,6 +1860,7 @@ static int talk_to_netback(struct xenbus
 		goto out;
 	}
 
+	rtnl_lock();
 	if (info->queues)
 		xennet_destroy_queues(info);
 
@@ -1885,6 +1871,7 @@ static int talk_to_netback(struct xenbus
 		info->queues = NULL;
 		goto out;
 	}
+	rtnl_unlock();
 
 	/* Create shared ring, alloc event channel -- for each queue */
 	for (i = 0; i < num_queues; ++i) {
@@ -1978,8 +1965,10 @@ abort_transaction_no_dev_fatal:
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
@@ -2015,6 +2004,15 @@ static int xennet_connect(struct net_dev
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
@@ -2284,10 +2282,14 @@ static int xennet_remove(struct xenbus_d
 
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

