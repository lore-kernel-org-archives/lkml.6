Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A0AC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E552075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbfAIIFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 03:05:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbfAIIFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 03:05:44 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E1B4AE3E05;
        Wed,  9 Jan 2019 08:05:43 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-204.pek2.redhat.com [10.72.12.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68E5519940;
        Wed,  9 Jan 2019 08:05:41 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next V2 2/3] vhost_net: support in order feature
Date:   Wed,  9 Jan 2019 16:05:29 +0800
Message-Id: <20190109080530.18572-3-jasowang@redhat.com>
In-Reply-To: <20190109080530.18572-1-jasowang@redhat.com>
References: <20190109080530.18572-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 09 Jan 2019 08:05:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes vhost_net to support in order feature. This is as simple as
use datacopy path when it was negotiated. An alternative is not to
advertise in order when zerocopy is enabled which tends to be
suboptimal consider zerocopy may suffer from e.g HOL issues.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 36f3d0f49e60..0870f51a1c76 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -74,7 +74,8 @@ enum {
 	VHOST_NET_FEATURES = VHOST_FEATURES |
 			 (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
 			 (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
-			 (1ULL << VIRTIO_F_IOMMU_PLATFORM)
+			 (1ULL << VIRTIO_F_IOMMU_PLATFORM) |
+	                 (1ULL << VIRTIO_F_IN_ORDER)
 };
 
 enum {
@@ -977,7 +978,8 @@ static void handle_tx(struct vhost_net *net)
 	vhost_disable_notify(&net->dev, vq);
 	vhost_net_disable_vq(net, vq);
 
-	if (vhost_sock_zcopy(sock))
+	if (vhost_sock_zcopy(sock) &&
+	    !vhost_has_feature(vq, VIRTIO_F_IN_ORDER))
 		handle_tx_zerocopy(net, sock);
 	else
 		handle_tx_copy(net, sock);
-- 
2.17.1

