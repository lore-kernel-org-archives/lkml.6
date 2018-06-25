Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0619AC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBBE2551D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FBBE2551D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752472AbeFYH0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 03:26:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:48860 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751026AbeFYH03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 03:26:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D00EEACDB;
        Mon, 25 Jun 2018 07:26:27 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 1/1] r8152: napi hangup fix after disconnect
Date:   Mon, 25 Jun 2018 09:26:27 +0200
Message-Id: <20180625072627.9109-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/net/usb/r8152.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index c08c0d633407..1fd165090163 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -3964,7 +3964,8 @@ static int rtl8152_close(struct net_device *netdev)
 #ifdef CONFIG_PM_SLEEP
 	unregister_pm_notifier(&tp->pm_notifier);
 #endif
-	napi_disable(&tp->napi);
+	if (!test_bit(RTL8152_UNPLUG, &tp->flags))
+		napi_disable(&tp->napi);
 	clear_bit(WORK_ENABLE, &tp->flags);
 	usb_kill_urb(tp->intr_urb);
 	cancel_delayed_work_sync(&tp->schedule);
-- 
2.17.1

