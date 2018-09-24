Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D1FECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC8420C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC8420C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732261AbeIXSS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:18:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55802 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730180AbeIXSS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:18:26 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A9AE910A5;
        Mon, 24 Sep 2018 12:16:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 060/173] xen-netfront: fix queue name setting
Date:   Mon, 24 Sep 2018 13:51:34 +0200
Message-Id: <20180924113120.433439519@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vitaly Kuznetsov <vkuznets@redhat.com>

[ Upstream commit 2d408c0d4574b01b9ed45e02516888bf925e11a9 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/xen-netfront.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1611,7 +1611,7 @@ static int xennet_init_queue(struct netf
 		    (unsigned long)queue);
 
 	snprintf(queue->name, sizeof(queue->name), "%s-q%u",
-		 queue->info->netdev->name, queue->id);
+		 queue->info->xbdev->nodename, queue->id);
 
 	/* Initialise tx_skbs as a free chain containing every entry. */
 	queue->tx_skb_freelist = 0;


