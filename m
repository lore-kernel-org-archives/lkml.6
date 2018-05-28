Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163984AbeE1KwV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:52:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163748AbeE1KwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:52:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 213/496] hv_netvsc: filter multicast/broadcast
Date: Mon, 28 May 2018 11:59:58 +0200
Message-Id: <20180528100328.900915692@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Hemminger <stephen@networkplumber.org>

[ Upstream commit 009f766ca2383d8788acd65c2c36c51bbfb19470 ]

The netvsc driver was always enabling all multicast and broadcast
even if netdevice flag had not enabled it.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/rndis_filter.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -850,15 +850,19 @@ static void rndis_set_multicast(struct w
 {
 	struct rndis_device *rdev
 		= container_of(w, struct rndis_device, mcast_work);
+	u32 filter = NDIS_PACKET_TYPE_DIRECTED;
+	unsigned int flags = rdev->ndev->flags;
 
-	if (rdev->ndev->flags & IFF_PROMISC)
-		rndis_filter_set_packet_filter(rdev,
-					       NDIS_PACKET_TYPE_PROMISCUOUS);
-	else
-		rndis_filter_set_packet_filter(rdev,
-					       NDIS_PACKET_TYPE_BROADCAST |
-					       NDIS_PACKET_TYPE_ALL_MULTICAST |
-					       NDIS_PACKET_TYPE_DIRECTED);
+	if (flags & IFF_PROMISC) {
+		filter = NDIS_PACKET_TYPE_PROMISCUOUS;
+	} else {
+		if (flags & IFF_ALLMULTI)
+			flags |= NDIS_PACKET_TYPE_ALL_MULTICAST;
+		if (flags & IFF_BROADCAST)
+			flags |= NDIS_PACKET_TYPE_BROADCAST;
+	}
+
+	rndis_filter_set_packet_filter(rdev, filter);
 }
 
 void rndis_filter_update(struct netvsc_device *nvdev)
