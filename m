Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B812ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDCF920850
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDCF920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388132AbeGTRXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:23:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731554AbeGTRXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:23:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D5DF377890;
        Fri, 20 Jul 2018 16:34:02 +0000 (UTC)
Received: from vitty.brq.redhat.com (ovpn-204-189.brq.redhat.com [10.40.204.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 00FAF2156899;
        Fri, 20 Jul 2018 16:34:00 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     netdev@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>
Subject: [PATCH net-next] xen-netfront: fix queue name setting
Date:   Fri, 20 Jul 2018 18:33:59 +0200
Message-Id: <20180720163359.28187-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 20 Jul 2018 16:34:02 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 20 Jul 2018 16:34:02 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/net/xen-netfront.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index a57daecf1d57..1b40b648ed5c 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1604,7 +1604,7 @@ static int xennet_init_queue(struct netfront_queue *queue)
 	timer_setup(&queue->rx_refill_timer, rx_refill_timeout, 0);
 
 	snprintf(queue->name, sizeof(queue->name), "%s-q%u",
-		 queue->info->netdev->name, queue->id);
+		 queue->info->xbdev->nodename, queue->id);
 
 	/* Initialise tx_skbs as a free chain containing every entry. */
 	queue->tx_skb_freelist = 0;
-- 
2.14.4

