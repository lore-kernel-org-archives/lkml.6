Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1EFC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D3A20894
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D3A20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbeG0LRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:17:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34046 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729539AbeG0LRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:17:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DEDDD402346C;
        Fri, 27 Jul 2018 09:56:28 +0000 (UTC)
Received: from dhcp-2-242.nay.redhat.com (dhcp-2-242.nay.redhat.com [10.66.2.242])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F3C602026D74;
        Fri, 27 Jul 2018 09:56:25 +0000 (UTC)
From:   Xiao Liang <xiliang@redhat.com>
To:     netdev@vger.kernel.org, xen-devel@lists.xenproject.org,
        davem@davemloft.net, jgross@suse.com, boris.ostrovsky@oracle.com
Cc:     linux-kernel@vger.kernel.org, Xiao Liang <xiliang@redhat.com>
Subject: [PATCH] xen-netfront: wait xenbus state change when load module manually
Date:   Fri, 27 Jul 2018 17:56:08 +0800
Message-Id: <20180727095608.25210-1-xiliang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 27 Jul 2018 09:56:28 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 27 Jul 2018 09:56:28 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'xiliang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When loading module manually, after call xenbus_switch_state to initializes
the state of the netfront device, the driver state did not change so fast
that may lead no dev created in latest kernel. This patch adds wait to make
sure xenbus knows the driver is not in closed/unknown state.

Current state:
[vm]# ethtool eth0
Settings for eth0:
	Link detected: yes
[vm]# modprobe -r xen_netfront
[vm]# modprobe  xen_netfront
[vm]# ethtool eth0
Settings for eth0:
Cannot get device settings: No such device
Cannot get wake-on-lan settings: No such device
Cannot get message level: No such device
Cannot get link status: No such device
No data available

With the patch installed.
[vm]# ethtool eth0
Settings for eth0:
	Link detected: yes
[vm]# modprobe -r xen_netfront
[vm]# modprobe xen_netfront
[vm]# ethtool eth0
Settings for eth0:
	Link detected: yes

Signed-off-by: Xiao Liang <xiliang@redhat.com>
---
 drivers/net/xen-netfront.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index a57daecf1d57..2d8812dd1534 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -87,6 +87,7 @@ struct netfront_cb {
 /* IRQ name is queue name with "-tx" or "-rx" appended */
 #define IRQ_NAME_SIZE (QUEUE_NAME_SIZE + 3)
 
+static DECLARE_WAIT_QUEUE_HEAD(module_load_q);
 static DECLARE_WAIT_QUEUE_HEAD(module_unload_q);
 
 struct netfront_stats {
@@ -1330,6 +1331,11 @@ static struct net_device *xennet_create_dev(struct xenbus_device *dev)
 	netif_carrier_off(netdev);
 
 	xenbus_switch_state(dev, XenbusStateInitialising);
+	wait_event(module_load_q,
+			   xenbus_read_driver_state(dev->otherend) !=
+			   XenbusStateClosed &&
+			   xenbus_read_driver_state(dev->otherend) !=
+			   XenbusStateUnknown);
 	return netdev;
 
  exit:
-- 
2.17.1

