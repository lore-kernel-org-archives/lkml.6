Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AF7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C972089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsrEDMRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C972089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbeKZV7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:59:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:45670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729543AbeKZV7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:59:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2EDA20645;
        Mon, 26 Nov 2018 11:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230347;
        bh=02ejY+3BXnQQcbLFwF+mz30rnx+XlqPdJ+dLH0bdpR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OsrEDMRwnOF8Q5HrXTmjXY87qSTIf7ZWz6fUmHVN2wZs82kQTaIlFG3rzsXLuZPfW
         h4vtSF2OjxHe3LPHk92MUfxS/j5gQfBS+vasZ38WDKqgwaSOIbbXrv7WywrcwTx84+
         JEWxH5RzbsR3CUKCqMQfX2f0ezz2qXxsHSPJCsZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.19 101/118] can: kvaser_usb: Fix accessing freed memory in kvaser_usb_start_xmit()
Date:   Mon, 26 Nov 2018 11:51:35 +0100
Message-Id: <20181126105105.755262742@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jimmy Assarsson <jimmyassarsson@gmail.com>

commit e13fb9b37cc00616b90df2d620f30345b5ada6ff upstream.

The call to can_put_echo_skb() may result in the skb being freed. The skb
is later used in the call to dev->ops->dev_frame_to_cmd().

This is avoided by moving the call to can_put_echo_skb() after
dev->ops->dev_frame_to_cmd().

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -528,7 +528,6 @@ static netdev_tx_t kvaser_usb_start_xmit
 			context = &priv->tx_contexts[i];
 
 			context->echo_index = i;
-			can_put_echo_skb(skb, netdev, context->echo_index);
 			++priv->active_tx_contexts;
 			if (priv->active_tx_contexts >= (int)dev->max_tx_urbs)
 				netif_stop_queue(netdev);
@@ -553,7 +552,6 @@ static netdev_tx_t kvaser_usb_start_xmit
 		dev_kfree_skb(skb);
 		spin_lock_irqsave(&priv->tx_contexts_lock, flags);
 
-		can_free_echo_skb(netdev, context->echo_index);
 		context->echo_index = dev->max_tx_urbs;
 		--priv->active_tx_contexts;
 		netif_wake_queue(netdev);
@@ -564,6 +562,8 @@ static netdev_tx_t kvaser_usb_start_xmit
 
 	context->priv = priv;
 
+	can_put_echo_skb(skb, netdev, context->echo_index);
+
 	usb_fill_bulk_urb(urb, dev->udev,
 			  usb_sndbulkpipe(dev->udev,
 					  dev->bulk_out->bEndpointAddress),


