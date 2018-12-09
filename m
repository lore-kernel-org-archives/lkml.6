Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BC0C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8674720661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8674720661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbeLIWOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:14:34 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38068 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728298AbeLIWO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:14:28 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73O-0002iY-Gp; Sun, 09 Dec 2018 21:55:58 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Z-0003Fs-NC; Sun, 09 Dec 2018 21:55:07 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Ross Lagerwall" <ross.lagerwall@citrix.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.936009164@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 047/328] xen-netfront: fix queue name setting
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Vitaly Kuznetsov <vkuznets@redhat.com>

commit 2d408c0d4574b01b9ed45e02516888bf925e11a9 upstream.

Commit f599c64fdf7d ("xen-netfront: Fix race between device setup and
open") changed the initialization order: xennet_create_queues() now
happens before we do register_netdev() so using netdev->name in
xennet_init_queue() is incorrect, we end up with the following in
/proc/interrupts:

 60:        139          0   xen-dyn    -event     eth%d-q0-tx
 61:        265          0   xen-dyn    -event     eth%d-q0-rx
 62:        234          0   xen-dyn    -event     eth%d-q1-tx
 63:          1          0   xen-dyn    -event     eth%d-q1-rx

and this looks ugly. Actually, using early netdev name (even when it's
already set) is also not ideal: nowadays we tend to rename eth devices
and queue name may end up not corresponding to the netdev name.

Use nodename from xenbus device for queue naming: this can't change in VM's
lifetime. Now /proc/interrupts looks like

 62:        202          0   xen-dyn    -event     device/vif/0-q0-tx
 63:        317          0   xen-dyn    -event     device/vif/0-q0-rx
 64:        262          0   xen-dyn    -event     device/vif/0-q1-tx
 65:         17          0   xen-dyn    -event     device/vif/0-q1-rx

Fixes: f599c64fdf7d ("xen-netfront: Fix race between device setup and open")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/xen-netfront.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1646,7 +1646,7 @@ static int xennet_init_queue(struct netf
 	queue->rx_refill_timer.function = rx_refill_timeout;
 
 	snprintf(queue->name, sizeof(queue->name), "%s-q%u",
-		 queue->info->netdev->name, queue->id);
+		 queue->info->xbdev->nodename, queue->id);
 
 	/* Initialise tx_skbs as a free chain containing every entry. */
 	queue->tx_skb_freelist = 0;

