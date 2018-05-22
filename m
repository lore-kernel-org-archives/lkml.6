Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbeEVSmT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 14:42:19 -0400
Received: from a2nlsmtp01-04.prod.iad2.secureserver.net ([198.71.225.38]:53090
        "EHLO a2nlsmtp01-04.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751621AbeEVSmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 14:42:17 -0400
x-originating-ip: 107.180.71.197
From: Haiyang Zhang <haiyangz@linuxonhyperv.com>
To: davem@davemloft.net, netdev@vger.kernel.org
Cc: haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] hv_netvsc: Add handlers for ethtool get/set msg level
Date: Tue, 22 May 2018 11:29:34 -0700
Message-Id: <20180522182934.31515-1-haiyangz@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.0
Reply-To: haiyangz@microsoft.com
X-CMAE-Envelope: MS4wfHjOUQl2leqoEZLelNsy23isSNfyrwdfzVs4aXIVVrrE/FfylFSa5nACwmsadAxkaYbbwQsHYxsOIxBxfyTqua7Uwpp2CTHaZ3rvYwANRQwAiRZR66zV
 5ntu5Yt3jSJB74YBgeMkrrou7NPCSQydj+U70gnD9zeCuqmUWVWmPkDP4uFCJHm694VpN8BtsuZjYp0AdFUliAAAsk04UIqzwk2vusG4JrZv1XKVRrYEThPp
 JsH1ZwlCkY9jeVPTfRHAUP2RFm7yTzlB/kECz6B040WLjmU05L3WyPs//Ud0T0zkdwVCuUQ92sWu203DW3t/4hvido7ejWzc9Vx/+i/fBJC2y1E5Kchp2a9O
 9Bs55my6Ggj5HpOXuftdr6KM7oj6zpoh8VmhTZtB8NYbiO4WdSOYuzQEWqe0nbQ4gvztHfvileMyAKdoGkrOX3eMULoBl7gkz3Zzdy91NLTuPHds1uIja1V3
 rMujHCbENGQ8GlHKNWG7WRP15ZmQj2fII9fGkA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>

The handlers for ethtool get/set msg level are missing from netvsc.
This patch adds them.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/hyperv/netvsc_drv.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index da07ccdf84bf..60a5769ef5a1 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -1618,8 +1618,24 @@ static int netvsc_set_ringparam(struct net_device *ndev,
 	return ret;
 }
 
+static u32 netvsc_get_msglevel(struct net_device *ndev)
+{
+	struct net_device_context *ndev_ctx = netdev_priv(ndev);
+
+	return ndev_ctx->msg_enable;
+}
+
+static void netvsc_set_msglevel(struct net_device *ndev, u32 val)
+{
+	struct net_device_context *ndev_ctx = netdev_priv(ndev);
+
+	ndev_ctx->msg_enable = val;
+}
+
 static const struct ethtool_ops ethtool_ops = {
 	.get_drvinfo	= netvsc_get_drvinfo,
+	.get_msglevel	= netvsc_get_msglevel,
+	.set_msglevel	= netvsc_set_msglevel,
 	.get_link	= ethtool_op_get_link,
 	.get_ethtool_stats = netvsc_get_ethtool_stats,
 	.get_sset_count = netvsc_get_sset_count,
-- 
2.17.0
