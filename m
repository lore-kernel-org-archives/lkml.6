Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53EEC46470
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 03:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E1C21785
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 03:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E1C21785
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbeHMFpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 01:45:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725849AbeHMFpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 01:45:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5DC8C402312B;
        Mon, 13 Aug 2018 03:05:33 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-183.pek2.redhat.com [10.72.12.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BDB592156712;
        Mon, 13 Aug 2018 03:05:29 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, jbrouer@redhat.com,
        mst@redhat.com, Jason Wang <jasowang@redhat.com>
Subject: [RFC PATCH net-next 3/5] macvlan: count the number of vlan in source mode
Date:   Mon, 13 Aug 2018 11:05:11 +0800
Message-Id: <1534129513-4845-4-git-send-email-jasowang@redhat.com>
In-Reply-To: <1534129513-4845-1-git-send-email-jasowang@redhat.com>
References: <1534129513-4845-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 13 Aug 2018 03:05:33 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 13 Aug 2018 03:05:33 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tries to count the number of vlans in source mode. This
will be used for implementing XDP rx handler for macvlan.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/macvlan.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index cfda146..b7c814d 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -53,6 +53,7 @@ struct macvlan_port {
 	struct hlist_head	vlan_source_hash[MACVLAN_HASH_SIZE];
 	DECLARE_BITMAP(mc_filter, MACVLAN_MC_FILTER_SZ);
 	unsigned char           perm_addr[ETH_ALEN];
+	unsigned long           source_count;
 };
 
 struct macvlan_source_entry {
@@ -1433,6 +1434,9 @@ int macvlan_common_newlink(struct net *src_net, struct net_device *dev,
 	if (err)
 		goto unregister_netdev;
 
+	if (vlan->mode == MACVLAN_MODE_SOURCE)
+		port->source_count++;
+
 	list_add_tail_rcu(&vlan->list, &port->vlans);
 	netif_stacked_transfer_operstate(lowerdev, dev);
 	linkwatch_fire_event(dev);
@@ -1477,6 +1481,7 @@ static int macvlan_changelink(struct net_device *dev,
 			      struct netlink_ext_ack *extack)
 {
 	struct macvlan_dev *vlan = netdev_priv(dev);
+	struct macvlan_port *port = vlan->port;
 	enum macvlan_mode mode;
 	bool set_mode = false;
 	enum macvlan_macaddr_mode macmode;
@@ -1491,8 +1496,10 @@ static int macvlan_changelink(struct net_device *dev,
 		    (vlan->mode == MACVLAN_MODE_PASSTHRU))
 			return -EINVAL;
 		if (vlan->mode == MACVLAN_MODE_SOURCE &&
-		    vlan->mode != mode)
+		    vlan->mode != mode) {
 			macvlan_flush_sources(vlan->port, vlan);
+			port->source_count--;
+		}
 	}
 
 	if (data && data[IFLA_MACVLAN_FLAGS]) {
@@ -1510,8 +1517,13 @@ static int macvlan_changelink(struct net_device *dev,
 		}
 		vlan->flags = flags;
 	}
-	if (set_mode)
+	if (set_mode) {
 		vlan->mode = mode;
+		if (mode == MACVLAN_MODE_SOURCE &&
+		    vlan->mode != mode) {
+			port->source_count++;
+		}
+	}
 	if (data && data[IFLA_MACVLAN_MACADDR_MODE]) {
 		if (vlan->mode != MACVLAN_MODE_SOURCE)
 			return -EINVAL;
-- 
2.7.4

