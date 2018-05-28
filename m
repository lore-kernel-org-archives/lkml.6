Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424960AbeE1LuZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:50:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423837AbeE1LJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:09:59 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 132/272] hv_netvsc: Fix the return status in RX path
Date: Mon, 28 May 2018 12:02:45 +0200
Message-Id: <20180528100252.200075226@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haiyang Zhang <haiyangz@microsoft.com>

[ Upstream commit 5c71dadbb45970a8f0544a27ae8f1cbd9750e516 ]

As defined in hyperv_net.h, the NVSP_STAT_SUCCESS is one not zero.
Some functions returns 0 when it actually means NVSP_STAT_SUCCESS.
This patch fixes them.

In netvsc_receive(), it puts the last RNDIS packet's receive status
for all packets in a vmxferpage which may contain multiple RNDIS
packets.
This patch puts NVSP_STAT_FAIL in the receive completion if one of
the packets in a vmxferpage fails.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/netvsc.c       |    8 ++++++--
 drivers/net/hyperv/netvsc_drv.c   |    2 +-
 drivers/net/hyperv/rndis_filter.c |    4 ++--
 3 files changed, 9 insertions(+), 5 deletions(-)

--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -1078,10 +1078,14 @@ static int netvsc_receive(struct net_dev
 		void *data = recv_buf
 			+ vmxferpage_packet->ranges[i].byte_offset;
 		u32 buflen = vmxferpage_packet->ranges[i].byte_count;
+		int ret;
 
 		/* Pass it to the upper layer */
-		status = rndis_filter_receive(ndev, net_device,
-					      channel, data, buflen);
+		ret = rndis_filter_receive(ndev, net_device,
+					   channel, data, buflen);
+
+		if (unlikely(ret != NVSP_STAT_SUCCESS))
+			status = NVSP_STAT_FAIL;
 	}
 
 	enq_receive_complete(ndev, net_device, q_idx,
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -831,7 +831,7 @@ int netvsc_recv_callback(struct net_devi
 	u64_stats_update_end(&rx_stats->syncp);
 
 	napi_gro_receive(&nvchan->napi, skb);
-	return 0;
+	return NVSP_STAT_SUCCESS;
 }
 
 static void netvsc_get_drvinfo(struct net_device *net,
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -434,10 +434,10 @@ int rndis_filter_receive(struct net_devi
 			"unhandled rndis message (type %u len %u)\n",
 			   rndis_msg->ndis_msg_type,
 			   rndis_msg->msg_len);
-		break;
+		return NVSP_STAT_FAIL;
 	}
 
-	return 0;
+	return NVSP_STAT_SUCCESS;
 }
 
 static int rndis_filter_query_device(struct rndis_device *dev,
