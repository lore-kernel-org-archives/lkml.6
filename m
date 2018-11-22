Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F5FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48E820865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48E820865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392275AbeKVROt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:14:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38878 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729835AbeKVROs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:14:48 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6B5DA81F13;
        Thu, 22 Nov 2018 06:36:49 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-16.pek2.redhat.com [10.72.12.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC145608F4;
        Thu, 22 Nov 2018 06:36:44 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, davem@davemloft.net,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Pavel Popa <pashinho1990@gmail.com>,
        David Ahern <dsahern@gmail.com>
Subject: [PATCH net 2/2] virtio-net: fail XDP set if guest csum is negotiated
Date:   Thu, 22 Nov 2018 14:36:31 +0800
Message-Id: <20181122063631.14452-2-jasowang@redhat.com>
In-Reply-To: <20181122063631.14452-1-jasowang@redhat.com>
References: <20181122063631.14452-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 22 Nov 2018 06:36:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't support partial csumed packet since its metadata will be lost
or incorrect during XDP processing. So fail the XDP set if guest_csum
feature is negotiated.

Fixes: f600b6905015 ("virtio_net: Add XDP support")
Reported-by: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Pavel Popa <pashinho1990@gmail.com>
Cc: David Ahern <dsahern@gmail.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 9b5ace538824..cecfd77c9f3c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2361,8 +2361,9 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	    && (virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO4) ||
 	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
 	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
-		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO))) {
-		NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing LRO, disable LRO first");
+		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO) ||
+		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM))) {
+		NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing LRO/CSUM, disable LRO/CSUM first");
 		return -EOPNOTSUPP;
 	}
 
-- 
2.17.1

