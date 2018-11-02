Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D00FC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6892084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLB1TE95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6892084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731394AbeKCEDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:03:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730441AbeKCEDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:03:38 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E76D12084A;
        Fri,  2 Nov 2018 18:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184922;
        bh=0swzUl5lIer0b7bgt9qv3YoIGYgHzAd6AmQwe2EeLaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jLB1TE95M2C+B/yawxXXzXGP6CrSlca8j5VT6xpMQIrzQuvsTaQ0BL7rN1O8jZ6Ck
         S2tdfznXx+MFIQ1nYCuTa5dge/wH/ZUP5bOVAYRW//Anl1YPkzAhGrS9yJB8gBwaqw
         gIAIWOLWXHvhWm/XGi2khTJ5SrAASPA79NTbzQ9M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ake Koomsin <ake@igel.co.jp>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 130/143] virtio_net: avoid using netif_tx_disable() for serializing tx routine
Date:   Fri,  2 Nov 2018 19:35:15 +0100
Message-Id: <20181102182908.210323264@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1872,8 +1872,9 @@ static void virtnet_freeze_down(struct v
 	/* Make sure no work handler is accessing the device */
 	flush_work(&vi->config_work);
 
+	netif_tx_lock_bh(vi->dev);
 	netif_device_detach(vi->dev);
-	netif_tx_disable(vi->dev);
+	netif_tx_unlock_bh(vi->dev);
 	cancel_delayed_work_sync(&vi->refill);
 
 	if (netif_running(vi->dev)) {
@@ -1909,7 +1910,9 @@ static int virtnet_restore_up(struct vir
 		}
 	}
 
+	netif_tx_lock_bh(vi->dev);
 	netif_device_attach(vi->dev);
+	netif_tx_unlock_bh(vi->dev);
 	return err;
 }
 


