Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35ABFC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049C420869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049C420869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbeKLFsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:10 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49656 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730053AbeKLFsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:10 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsW-0000l8-Bh; Sun, 11 Nov 2018 19:58:40 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsT-0001bD-7q; Sun, 11 Nov 2018 19:58:37 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Chas Williams" <3chas3@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.254874524@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 169/366] net/xen-netfront: only clean up queues if
 present
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

From: Chas Williams <3chas3@gmail.com>

commit 9a873c71e91cabf4c10fd9bbd8358c22deaf6c9e upstream.

If you simply load and unload the module without starting the interfaces,
the queues are never created and you get a bad pointer dereference.

Signed-off-by: Chas Williams <3chas3@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/xen-netfront.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1422,7 +1422,7 @@ static void xennet_disconnect_backend(st
 
 	netif_carrier_off(info->netdev);
 
-	for (i = 0; i < num_queues; ++i) {
+	for (i = 0; i < num_queues && info->queues; ++i) {
 		struct netfront_queue *queue = &info->queues[i];
 
 		del_timer_sync(&queue->rx_refill_timer);
@@ -2294,7 +2294,8 @@ static int xennet_remove(struct xenbus_d
 
 	unregister_netdev(info->netdev);
 
-	xennet_destroy_queues(info);
+	if (info->queues)
+		xennet_destroy_queues(info);
 	xennet_free_netdev(info->netdev);
 
 	return 0;

