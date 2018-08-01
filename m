Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449B9C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15E620844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15E620844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406603AbeHATLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:11:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51160 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404840AbeHATLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:11:18 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4AEBCCC3;
        Wed,  1 Aug 2018 17:24:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiao Liang <xiliang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 239/246] xen-netfront: wait xenbus state change when load module manually
Date:   Wed,  1 Aug 2018 18:52:29 +0200
Message-Id: <20180801165023.182578979@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
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

From: Xiao Liang <xiliang@redhat.com>

[ Upstream commit 822fb18a82abaf4ee7058793d95d340f5dab7bfc ]

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
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/xen-netfront.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -87,6 +87,7 @@ struct netfront_cb {
 /* IRQ name is queue name with "-tx" or "-rx" appended */
 #define IRQ_NAME_SIZE (QUEUE_NAME_SIZE + 3)
 
+static DECLARE_WAIT_QUEUE_HEAD(module_load_q);
 static DECLARE_WAIT_QUEUE_HEAD(module_unload_q);
 
 struct netfront_stats {
@@ -1330,6 +1331,11 @@ static struct net_device *xennet_create_
 	netif_carrier_off(netdev);
 
 	xenbus_switch_state(dev, XenbusStateInitialising);
+	wait_event(module_load_q,
+			   xenbus_read_driver_state(dev->otherend) !=
+			   XenbusStateClosed &&
+			   xenbus_read_driver_state(dev->otherend) !=
+			   XenbusStateUnknown);
 	return netdev;
 
  exit:


