Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03982C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC78C20880
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yaBdCgkE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC78C20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbeJ3WVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:21:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbeJ3WVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:21:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B47D220838;
        Tue, 30 Oct 2018 13:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906093;
        bh=THqIHNOnTh8JTtqg7hU1GIGu15m4ZI+hDzB3FnC9LXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yaBdCgkEtjdMepvys6a6kF4E/Ux0MXww0rJYVo3NVra+0GIAym0UwcUHsDPfB5o/x
         jvEcJhs57ORCBRR8NmvfC1uhPptKXhiysiAIlzO40HLfRxko2fM1+iimzAMHmYtAga
         77oifhYZadCFQJI06CCKMNbYMV18droyYsvMMmmY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ake Koomsin <ake@igel.co.jp>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 28/33] virtio_net: avoid using netif_tx_disable() for serializing tx routine
Date:   Tue, 30 Oct 2018 09:26:52 -0400
Message-Id: <20181030132657.217970-28-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132657.217970-1-sashal@kernel.org>
References: <20181030132657.217970-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ake Koomsin <ake@igel.co.jp>

[ Upstream commit 05c998b738fdd3e5d6a257bcacc8f34b6284d795 ]

Commit 713a98d90c5e ("virtio-net: serialize tx routine during reset")
introduces netif_tx_disable() after netif_device_detach() in order to
avoid use-after-free of tx queues. However, there are two issues.

1) Its operation is redundant with netif_device_detach() in case the
   interface is running.
2) In case of the interface is not running before suspending and
   resuming, the tx does not get resumed by netif_device_attach().
   This results in losing network connectivity.

It is better to use netif_tx_lock_bh()/netif_tx_unlock_bh() instead for
serializing tx routine during reset. This also preserves the symmetry
of netif_device_detach() and netif_device_attach().

Fixes commit 713a98d90c5e ("virtio-net: serialize tx routine during reset")
Signed-off-by: Ake Koomsin <ake@igel.co.jp>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/virtio_net.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 2b6ec927809e..500e2d8f10bc 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2162,8 +2162,9 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device */
 	flush_work(&vi->config_work);
 
+	netif_tx_lock_bh(vi->dev);
 	netif_device_detach(vi->dev);
-	netif_tx_disable(vi->dev);
+	netif_tx_unlock_bh(vi->dev);
 	cancel_delayed_work_sync(&vi->refill);
 
 	if (netif_running(vi->dev)) {
@@ -2199,7 +2200,9 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 		}
 	}
 
+	netif_tx_lock_bh(vi->dev);
 	netif_device_attach(vi->dev);
+	netif_tx_unlock_bh(vi->dev);
 	return err;
 }
 
-- 
2.17.1

