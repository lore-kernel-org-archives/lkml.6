Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88692C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABD12086B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvyOcEYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ABD12086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbeK2RHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:07:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:44760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728407AbeK2RHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:07:25 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE76E213A2;
        Thu, 29 Nov 2018 06:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471393;
        bh=+eNVb6X36Fifk8398kZ8oy+AFW0V25OH3U66FN/xkko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IvyOcEYvWxw+WCfS6RbI8R9ynBD/P0GYlvRjKtubJeIURqR/AeyGo9nagwGeMVycd
         OBl1OSWooZEVhpJ/vmkJMNxrhV1VvAedgFKAdcKgcmhZvaDMgMa5D6JAo/d8kOqgBl
         4IcGfc+tkhDkGWGfxvEVltVGDBFCvUducI36/7Zs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Pavel Popa <pashinho1990@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 31/35] virtio-net: disable guest csum during XDP set
Date:   Thu, 29 Nov 2018 01:01:05 -0500
Message-Id: <20181129060110.159878-31-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129060110.159878-1-sashal@kernel.org>
References: <20181129060110.159878-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>

[ Upstream commit e59ff2c49ae16e1d179de679aca81405829aee6c ]

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
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/virtio_net.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f528e9ac3413..2ffa7b290591 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -61,7 +61,8 @@ static const unsigned long guest_offloads[] = {
 	VIRTIO_NET_F_GUEST_TSO4,
 	VIRTIO_NET_F_GUEST_TSO6,
 	VIRTIO_NET_F_GUEST_ECN,
-	VIRTIO_NET_F_GUEST_UFO
+	VIRTIO_NET_F_GUEST_UFO,
+	VIRTIO_NET_F_GUEST_CSUM
 };
 
 struct virtnet_stats {
@@ -1939,9 +1940,6 @@ static int virtnet_clear_guest_offloads(struct virtnet_info *vi)
 	if (!vi->guest_offloads)
 		return 0;
 
-	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM))
-		offloads = 1ULL << VIRTIO_NET_F_GUEST_CSUM;
-
 	return virtnet_set_guest_offloads(vi, offloads);
 }
 
@@ -1951,8 +1949,6 @@ static int virtnet_restore_guest_offloads(struct virtnet_info *vi)
 
 	if (!vi->guest_offloads)
 		return 0;
-	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM))
-		offloads |= 1ULL << VIRTIO_NET_F_GUEST_CSUM;
 
 	return virtnet_set_guest_offloads(vi, offloads);
 }
-- 
2.17.1

