Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3D8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5EB021104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3L+ChHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5EB021104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbeK2RFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:05:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:40036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727643AbeK2RFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:05:05 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3124208E7;
        Thu, 29 Nov 2018 06:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471253;
        bh=he1XmOJ1rGvgv4k9hpfvi/2O81JQzhIxBw+ckFgCn8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g3L+ChHduh1at1hDFtneo8qn9w7DBLEX2qZ+CG7bNKN9NzZkEVQh+cz3Ms0oTHI04
         P71zJAQJzOLcmcUEkhG5pz90L99qMhjqk/rAv91PblIVSBs/g54GulAzTfSXsDPjjy
         njM16ah1X1DHAnb6W7NHAYtVp2ocz5JiZZBm6hXI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Pavel Popa <pashinho1990@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 64/68] virtio-net: fail XDP set if guest csum is negotiated
Date:   Thu, 29 Nov 2018 00:55:55 -0500
Message-Id: <20181129055559.159228-64-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>

[ Upstream commit 18ba58e1c234ea1a2d9835ac8c1735d965ce4640 ]

We don't support partial csumed packet since its metadata will be lost
or incorrect during XDP processing. So fail the XDP set if guest_csum
feature is negotiated.

Fixes: f600b6905015 ("virtio_net: Add XDP support")
Reported-by: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Pavel Popa <pashinho1990@gmail.com>
Cc: David Ahern <dsahern@gmail.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/virtio_net.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 9cc51517e16f..c2ca6cd3fbe0 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2312,8 +2312,9 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
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

