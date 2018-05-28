Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165071AbeE1Mxe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:53:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164369AbeE1Kza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:55:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 312/496] hv_netvsc: enable multicast if necessary
Date: Mon, 28 May 2018 12:01:37 +0200
Message-Id: <20180528100332.971270788@linuxfoundation.org>
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

[ Upstream commit f03dbb06dc380274e351ca4b1ee1587ed4529e62 ]

My recent change to netvsc drive in how receive flags are handled
broke multicast.  The Hyper-v/Azure virtual interface there is not a
multicast filter list, filtering is only all or none. The driver must
enable all multicast if any multicast address is present.

Fixes: 009f766ca238 ("hv_netvsc: filter multicast/broadcast")
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/rndis_filter.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -856,7 +856,7 @@ static void rndis_set_multicast(struct w
 	if (flags & IFF_PROMISC) {
 		filter = NDIS_PACKET_TYPE_PROMISCUOUS;
 	} else {
-		if (flags & IFF_ALLMULTI)
+		if (!netdev_mc_empty(rdev->ndev) || (flags & IFF_ALLMULTI))
 			filter |= NDIS_PACKET_TYPE_ALL_MULTICAST;
 		if (flags & IFF_BROADCAST)
 			filter |= NDIS_PACKET_TYPE_BROADCAST;
