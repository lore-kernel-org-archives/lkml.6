Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10265ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4EB1206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4EB1206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388955AbeGTNXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:23:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42882 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387816AbeGTNXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:23:19 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 51EE4C9D;
        Fri, 20 Jul 2018 12:33:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 42/92] r8152: napi hangup fix after disconnect
Date:   Fri, 20 Jul 2018 14:13:46 +0200
Message-Id: <20180720121420.449376995@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121417.206337808@linuxfoundation.org>
References: <20180720121417.206337808@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Slaby <jslaby@suse.cz>

[ Upstream commit 0ee1f4734967af8321ecebaf9c74221ace34f2d5 ]

When unplugging an r8152 adapter while the interface is UP, the NIC
becomes unusable.  usb->disconnect (aka rtl8152_disconnect) deletes
napi. Then, rtl8152_disconnect calls unregister_netdev and that invokes
netdev->ndo_stop (aka rtl8152_close). rtl8152_close tries to
napi_disable, but the napi is already deleted by disconnect above. So
the first while loop in napi_disable never finishes. This results in
complete deadlock of the network layer as there is rtnl_mutex held by
unregister_netdev.

So avoid the call to napi_disable in rtl8152_close when the device is
already gone.

The other calls to usb_kill_urb, cancel_delayed_work_sync,
netif_stop_queue etc. seem to be fine. The urb and netdev is not
destroyed yet.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: linux-usb@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/r8152.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -3959,7 +3959,8 @@ static int rtl8152_close(struct net_devi
 #ifdef CONFIG_PM_SLEEP
 	unregister_pm_notifier(&tp->pm_notifier);
 #endif
-	napi_disable(&tp->napi);
+	if (!test_bit(RTL8152_UNPLUG, &tp->flags))
+		napi_disable(&tp->napi);
 	clear_bit(WORK_ENABLE, &tp->flags);
 	usb_kill_urb(tp->intr_urb);
 	cancel_delayed_work_sync(&tp->schedule);


