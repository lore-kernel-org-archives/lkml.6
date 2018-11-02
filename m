Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EC2C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93BE20843
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zainsS3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93BE20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbeKCDyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:54:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729136AbeKCDyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:54:39 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D356F20837;
        Fri,  2 Nov 2018 18:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184385;
        bh=yz689L0jE42DIUvEchb1Az4F9bCCKOpUhbibQoGCE/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zainsS3Hf32oiLttWS+ffN1Jw7RiR56kcxgBRK9ZKtsjfP5oXAGsJ1K9xlI6WZ3db
         Sdc/5WcSiW9kjay1vUJzLRG/mhIMjfzvju9Zqsk1k+E39VcAdkMyhrfz0Jnbepn8Uz
         H7sCUPLKufilTqrAJyere1yAvZU4JdZgZ8lgexJk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ake Koomsin <ake@igel.co.jp>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 121/150] virtio_net: avoid using netif_tx_disable() for serializing tx routine
Date:   Fri,  2 Nov 2018 19:34:43 +0100
Message-Id: <20181102182911.402342725@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2162,8 +2162,9 @@ static void virtnet_freeze_down(struct v
 	/* Make sure no work handler is accessing the device */
 	flush_work(&vi->config_work);
 
+	netif_tx_lock_bh(vi->dev);
 	netif_device_detach(vi->dev);
-	netif_tx_disable(vi->dev);
+	netif_tx_unlock_bh(vi->dev);
 	cancel_delayed_work_sync(&vi->refill);
 
 	if (netif_running(vi->dev)) {
@@ -2199,7 +2200,9 @@ static int virtnet_restore_up(struct vir
 		}
 	}
 
+	netif_tx_lock_bh(vi->dev);
 	netif_device_attach(vi->dev);
+	netif_tx_unlock_bh(vi->dev);
 	return err;
 }
 


