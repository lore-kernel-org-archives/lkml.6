Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B172C00449
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 02:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B8D2086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 02:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B8D2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeJIJVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 05:21:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbeJIJVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 05:21:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 43AE9307D910;
        Tue,  9 Oct 2018 02:06:33 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-62.pek2.redhat.com [10.72.12.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5E226F949;
        Tue,  9 Oct 2018 02:06:28 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, davem@davemloft.net
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next V3] virtio_net: ethtool tx napi configuration
Date:   Tue,  9 Oct 2018 10:06:26 +0800
Message-Id: <20181009020626.31723-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 09 Oct 2018 02:06:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement ethtool .set_coalesce (-C) and .get_coalesce (-c) handlers.
Interrupt moderation is currently not supported, so these accept and
display the default settings of 0 usec and 1 frame.

Toggle tx napi through setting tx-frames. So as to not interfere
with possible future interrupt moderation, value 1 means tx napi while
value 0 means not.

Only allow the switching when device is down for simplicity.

Link: https://patchwork.ozlabs.org/patch/948149/
Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes from V2:
- only allow the switching when device is done
- remove unnecessary global variable and initialization
Changes from V1:
- try to synchronize with datapath to allow changing mode when
  interface is up.
- use tx-frames 0 as to disable tx napi while tx-frames 1 to enable tx napi
---
 drivers/net/virtio_net.c | 50 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 765920905226..751f385f4e0a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2181,6 +2181,54 @@ static int virtnet_get_link_ksettings(struct net_device *dev,
 	return 0;
 }
 
+static int virtnet_set_coalesce(struct net_device *dev,
+				struct ethtool_coalesce *ec)
+{
+	struct ethtool_coalesce ec_default = {
+		.cmd = ETHTOOL_SCOALESCE,
+		.rx_max_coalesced_frames = 1,
+	};
+	struct virtnet_info *vi = netdev_priv(dev);
+	int i, napi_weight;
+	bool running = netif_running(dev);
+
+	if (ec->tx_max_coalesced_frames > 1)
+		return -EINVAL;
+
+	ec_default.tx_max_coalesced_frames = ec->tx_max_coalesced_frames;
+	napi_weight = ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0;
+
+	/* disallow changes to fields not explicitly tested above */
+	if (memcmp(ec, &ec_default, sizeof(ec_default)))
+		return -EINVAL;
+
+	if (napi_weight ^ vi->sq[0].napi.weight) {
+		if (dev->flags & IFF_UP)
+			return -EBUSY;
+		for (i = 0; i < vi->max_queue_pairs; i++)
+			vi->sq[i].napi.weight = napi_weight;
+	}
+
+	return 0;
+}
+
+static int virtnet_get_coalesce(struct net_device *dev,
+				struct ethtool_coalesce *ec)
+{
+	struct ethtool_coalesce ec_default = {
+		.cmd = ETHTOOL_GCOALESCE,
+		.rx_max_coalesced_frames = 1,
+	};
+	struct virtnet_info *vi = netdev_priv(dev);
+
+	memcpy(ec, &ec_default, sizeof(ec_default));
+
+	if (vi->sq[0].napi.weight)
+		ec->tx_max_coalesced_frames = 1;
+
+	return 0;
+}
+
 static void virtnet_init_settings(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -2219,6 +2267,8 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_ts_info = ethtool_op_get_ts_info,
 	.get_link_ksettings = virtnet_get_link_ksettings,
 	.set_link_ksettings = virtnet_set_link_ksettings,
+	.set_coalesce = virtnet_set_coalesce,
+	.get_coalesce = virtnet_get_coalesce,
 };
 
 static void virtnet_freeze_down(struct virtio_device *vdev)
-- 
2.17.1

