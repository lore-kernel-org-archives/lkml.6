Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFE7C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D6220818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D6220818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbeKLFsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:12 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49700 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730066AbeKLFsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:10 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsW-0000l9-CQ; Sun, 11 Nov 2018 19:58:40 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsT-0001bI-8W; Sun, 11 Nov 2018 19:58:37 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Ross Lagerwall" <ross.lagerwall@citrix.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.580062072@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 170/366] xen-netfront: Improve error handling during
 initialization
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

commit e2e004acc7cbe3c531e752a270a74e95cde3ea48 upstream.

This fixes a crash when running out of grant refs when creating many
queues across many netdevs.

* If creating queues fails (i.e. there are no grant refs available),
call xenbus_dev_fatal() to ensure that the xenbus device is set to the
closed state.
* If no queues are created, don't call xennet_disconnect_backend as
netdev->real_num_tx_queues will not have been set correctly.
* If setup_netfront() fails, ensure that all the queues created are
cleaned up, not just those that have been set up.
* If any queues were set up and an error occurs, call
xennet_destroy_queues() to clean up the napi context.
* If any fatal error occurs, unregister and destroy the netdev to avoid
leaving around a half setup network device.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/xen-netfront.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1879,27 +1879,19 @@ static int talk_to_netback(struct xenbus
 		xennet_destroy_queues(info);
 
 	err = xennet_create_queues(info, &num_queues);
-	if (err < 0)
-		goto destroy_ring;
+	if (err < 0) {
+		xenbus_dev_fatal(dev, err, "creating queues");
+		kfree(info->queues);
+		info->queues = NULL;
+		goto out;
+	}
 
 	/* Create shared ring, alloc event channel -- for each queue */
 	for (i = 0; i < num_queues; ++i) {
 		queue = &info->queues[i];
 		err = setup_netfront(dev, queue, feature_split_evtchn);
-		if (err) {
-			/* setup_netfront() will tidy up the current
-			 * queue on error, but we need to clean up
-			 * those already allocated.
-			 */
-			if (i > 0) {
-				rtnl_lock();
-				netif_set_real_num_tx_queues(info->netdev, i);
-				rtnl_unlock();
-				goto destroy_ring;
-			} else {
-				goto out;
-			}
-		}
+		if (err)
+			goto destroy_ring;
 	}
 
 again:
@@ -1986,9 +1978,10 @@ abort_transaction_no_dev_fatal:
 	xenbus_transaction_end(xbt, 1);
  destroy_ring:
 	xennet_disconnect_backend(info);
-	kfree(info->queues);
-	info->queues = NULL;
+	xennet_destroy_queues(info);
  out:
+	unregister_netdev(info->netdev);
+	xennet_free_netdev(info->netdev);
 	return err;
 }
 

