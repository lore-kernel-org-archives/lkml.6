Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB36FC6786C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C79F20873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C79F20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeLMCx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 21:53:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbeLMCxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 21:53:52 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7AF4A80F93;
        Thu, 13 Dec 2018 02:53:52 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-167.pek2.redhat.com [10.72.12.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C44C15D70A;
        Thu, 13 Dec 2018 02:53:49 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Tonghao Zhang <xiangxia.m.yue@gmail.com>
Subject: [PATCH net V3 2/3] vhost_net: switch to use mutex_trylock() in vhost_net_busy_poll()
Date:   Thu, 13 Dec 2018 10:53:38 +0800
Message-Id: <20181213025339.14023-3-jasowang@redhat.com>
In-Reply-To: <20181213025339.14023-1-jasowang@redhat.com>
References: <20181213025339.14023-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 13 Dec 2018 02:53:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to hold the mutex of paired virtqueue in
vhost_net_busy_poll(). But this will results an inconsistent lock
order which may cause deadlock if we try to bring back the protection
of device IOTLB with vq mutex that requires to hold mutex of all
virtqueues at the same time.

Fix this simply by switching to use mutex_trylock(), when fail just
skip the busy polling. This can happen when device IOTLB is under
updating which should be rare.

Fixes: commit 78139c94dc8c ("net: vhost: lock the vqs one by one")
Cc: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index ab11b2bee273..ad7a6f475a44 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -513,7 +513,13 @@ static void vhost_net_busy_poll(struct vhost_net *net,
 	struct socket *sock;
 	struct vhost_virtqueue *vq = poll_rx ? tvq : rvq;
 
-	mutex_lock_nested(&vq->mutex, poll_rx ? VHOST_NET_VQ_TX: VHOST_NET_VQ_RX);
+	/* Try to hold the vq mutex of the paired virtqueue. We can't
+	 * use mutex_lock() here since we could not guarantee a
+	 * consistenet lock ordering.
+	 */
+	if (!mutex_trylock(&vq->mutex))
+		return;
+
 	vhost_disable_notify(&net->dev, vq);
 	sock = rvq->private_data;
 
-- 
2.17.1

