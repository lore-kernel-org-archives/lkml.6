Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60022C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD0220685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD0220685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389597AbeKVROn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:14:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729835AbeKVROn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:14:43 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 25E5980F7A;
        Thu, 22 Nov 2018 06:36:44 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-16.pek2.redhat.com [10.72.12.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10C77608E7;
        Thu, 22 Nov 2018 06:36:33 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, davem@davemloft.net,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Pavel Popa <pashinho1990@gmail.com>,
        David Ahern <dsahern@gmail.com>
Subject: [PATCH net 1/2] virtio-net: disable guest csum during XDP set
Date:   Thu, 22 Nov 2018 14:36:30 +0800
Message-Id: <20181122063631.14452-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 22 Nov 2018 06:36:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't disable VIRTIO_NET_F_GUEST_CSUM if XDP was set. This means we
can receive partial csumed packets with metadata kept in the
vnet_hdr. This may have several side effects:

- It could be overridden by header adjustment, thus is might be not
  correct after XDP processing.
- There's no way to pass such metadata information through
  XDP_REDIRECT to another driver.
- XDP does not support checksum offload right now.

So simply disable guest csum if possible in this the case of XDP.

Fixes: 3f93522ffab2d ("virtio-net: switch off offloads on demand if possible on XDP set")
Reported-by: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Pavel Popa <pashinho1990@gmail.com>
Cc: David Ahern <dsahern@gmail.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3e2c041d76ac..9b5ace538824 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -70,7 +70,8 @@ static const unsigned long guest_offloads[] = {
 	VIRTIO_NET_F_GUEST_TSO4,
 	VIRTIO_NET_F_GUEST_TSO6,
 	VIRTIO_NET_F_GUEST_ECN,
-	VIRTIO_NET_F_GUEST_UFO
+	VIRTIO_NET_F_GUEST_UFO,
+	VIRTIO_NET_F_GUEST_CSUM
 };
 
 struct virtnet_stat_desc {
@@ -2334,9 +2335,6 @@ static int virtnet_clear_guest_offloads(struct virtnet_info *vi)
 	if (!vi->guest_offloads)
 		return 0;
 
-	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM))
-		offloads = 1ULL << VIRTIO_NET_F_GUEST_CSUM;
-
 	return virtnet_set_guest_offloads(vi, offloads);
 }
 
@@ -2346,8 +2344,6 @@ static int virtnet_restore_guest_offloads(struct virtnet_info *vi)
 
 	if (!vi->guest_offloads)
 		return 0;
-	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM))
-		offloads |= 1ULL << VIRTIO_NET_F_GUEST_CSUM;
 
 	return virtnet_set_guest_offloads(vi, offloads);
 }
-- 
2.17.1

